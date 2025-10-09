# TODO:
# If a qualification plan is input
# Use getProjectsFromQualification to update current project list from snapshot IDs
# -> All data in the union default style
# -> Data from snapshots not in Union = Removed -> Red color
# -> Data from quali not in Union = New -> Green color ?
#   -> Data includes, projects, observed data sets, simulations, simulation outputs, simulation observed data
# Use quali data to fill remaining Excel sheets

#' @title excelUI
#' @param fileName Character string. Name of the Excel file to be created.
#' @param snapshotPaths
#' Named list of project snapshots given by their URL or relative path.
#' @param observedDataPaths
#' Named list of observed data sets (which are not included into the projects)
#' given by their URL or relative path.
#' @param excelTemplate
#' Character string. Path to an Excel template file (only captions and lookup tables).
#' If `NULL`, uses the default template from the package.
#' @param qualificationPlan
#' Character string. Path, URL, or JSON string of an existing qualification plan.
#' If `NULL`, at least 1 project must be included in the snapshotPaths.
#' @return Invisibly returns `NULL`. Side effect: creates an Excel file at the specified path.
#' @import openxlsx
#' @import jsonlite
#' @export
excelUI <- function(fileName = "qualification.xlsx",
                    snapshotPaths,
                    observedDataPaths,
                    excelTemplate = NULL,
                    qualificationPlan = NULL) {
  ospsuite.utils::validateIsFileExtension(fileName, "xlsx")
  excelTemplate <- excelTemplate %||%
    system.file("Qualification-Template.xlsx", package = "ospsuite.qualificationplaneditor")
  ospsuite.utils::validateIsFileExtension(excelTemplate, "xlsx")
  if(!file.exists(excelTemplate)){
    cli::cli_abort("excelTemplate: {.file {excelTemplate}} does not exist")
  }
  
  # Copy template to output file
  fileCopied <- file.copy(from = excelTemplate, to = fileName, overwrite = TRUE)
  if (!fileCopied) {
    cli::cli_abort("Failed to copy template {.file {excelTemplate}} to {.file {fileName}}")
  }
  
  # Load workbook with error handling
  excelObject <- tryCatch(
    openxlsx::loadWorkbook(fileName),
    error = function(e) {
      cli::cli_abort("Cannot load workbook {.file {fileName}}: {e$message}")
    }
  )
  useQualification <- !is.null(qualificationPlan)

  # MetaInfo ?

  # Projects
  projectData <- getProjectsFromList(snapshotPaths)
  # Qualification Plan provided
  qualificationProjects <- NULL
  if (useQualification) {
    qualificationContent <- tryCatch(
      jsonlite::fromJSON(qualificationPlan, simplifyVector = FALSE),
      error = function(e) {
        cli::cli_abort("Cannot parse qualification plan: {e$message}")
      }
    )
    qualificationProjectData <- getProjectsFromQualification(qualificationContent)
    qualificationObservedData <- getObsDataFromQualification(qualificationContent)
    qualificationBBData <- getBBDataFromQualification(qualificationContent)

    qualificationProjects <- qualificationProjectData$ID
    commonProjects <- intersect(projectData$ID, qualificationProjects)
    # Merge to project data
    projectData <- merge.data.frame(projectData, qualificationProjectData, by = c("ID", "Path"), all = TRUE)
    projectStyles <- getQualificationStyles(
      data = projectData,
      commonProjects = commonProjects,
      qualificationProjects = qualificationProjects,
      projectVariable = "ID"
    )
  }

  writeDataToSheet(data = projectData, sheetName = "Projects", excelObject = excelObject)
  if (useQualification) {
    styleQualificationCells(
      qualificationStyles = projectStyles,
      columnIndices = seq_len(ncol(projectData)),
      sheetName = "Projects",
      excelObject = excelObject
    )
  }

  # Simulation Ouptuts
  simulationsOutputs <- getSimulationsOutputsFromProjects(projectData)
  writeDataToSheet(data = simulationsOutputs, sheetName = "Simulations_Outputs", excelObject = excelObject)
  if (useQualification) {
    simulationsOutputStyles <- getQualificationStyles(
      data = simulationsOutputs,
      commonProjects = commonProjects,
      qualificationProjects = qualificationProjects
    )
    styleQualificationCells(
      qualificationStyles = simulationsOutputStyles,
      columnIndices = seq_len(ncol(simulationsOutputs)),
      sheetName = "Simulations_Outputs",
      excelObject = excelObject
    )
  }

  # Simulations ObsData
  simulationsObsData <- getSimulationsObsDataFromProjects(projectData)
  writeDataToSheet(data = simulationsObsData, sheetName = "Simulations_ObsData", excelObject = excelObject)
  if (useQualification) {
    simulationsObsDataStyles <- getQualificationStyles(
      data = simulationsObsData,
      commonProjects = commonProjects,
      qualificationProjects = qualificationProjects
    )
    styleQualificationCells(
      qualificationStyles = simulationsObsDataStyles,
      columnIndices = seq_len(ncol(simulationsObsData)),
      sheetName = "Simulations_ObsData",
      excelObject = excelObject
    )
  }

  # Obs Data
  observedData <- getObsDataFromList(observedDataPaths)
  # Qualification Plan provided
  if (useQualification) {
    commonObsData <- intersect(observedData$ID, qualificationObservedData$ID)
    # Merge to observed data data
    observedData <- merge.data.frame(observedData, qualificationObservedData, by = c("ID", "Path", "Type"), all = TRUE)
    obsDataStyles <- getQualificationStyles(
      data = observedData,
      commonProjects = commonObsData,
      qualificationProjects = qualificationObservedData$ID,
      projectVariable = "ID"
    )
  }
  writeDataToSheet(data = observedData, sheetName = "ObsData", excelObject = excelObject)
  # Type column uses a drop down list
  ospsuite.utils::validateIsIncluded("Type", names(observedData))
  typeColIndex <- which(names(observedData) == "Type")
  openxlsx::dataValidation(
    excelObject,
    sheet = "ObsData",
    cols = typeColIndex,
    rows = 1 + seq_len(nrow(observedData)),
    type = "list",
    value = "'Lookup'!$L$2:$L$4"
  )

  # BB
  bbData <- getBBDataFromProjects(projectData, qualificationProjects)
  if (useQualification) {
    bbData <- merge.data.frame(
      bbData,
      qualificationBBData,
      by = c("Project", "BB-Type", "BB-Name", "Parent-Project"),
      all = TRUE
    )
  }
  writeDataToSheet(data = bbData, sheetName = "BB", excelObject = excelObject)
  # Parent-Project column uses a drop down list
  ospsuite.utils::validateIsIncluded("Parent-Project", names(bbData))
  parentProjectColIndex <- which(names(bbData) == "Parent-Project")
  openxlsx::dataValidation(
    excelObject,
    sheet = "BB",
    cols = parentProjectColIndex,
    rows = 1 + seq_len(nrow(bbData)),
    type = "list",
    value = paste0("'Projects'!$A$2:$A$", 1 + nrow(projectData))
  )
  if (useQualification) {
    bbDataStyles <- getQualificationStyles(
      data = bbData,
      commonProjects = commonProjects,
      qualificationProjects = qualificationProjects
    )
    styleQualificationCells(
      qualificationStyles = bbDataStyles,
      columnIndices = seq_len(ncol(bbData)),
      sheetName = "BB",
      excelObject = excelObject
    )
  }

  # Following only applies if Qualification Plan is provided
  if (useQualification) {
    # Sim Param
    # writeDataToSheet(
    #  data = getQualificationSimParam(qualificationContent),
    #  sheetName = "SimParam",
    #  excelObject = excelObject
    # )

    # Comparison Time (CT) Profile
    writeDataToSheet(
      data = getQualificationCTProfile(qualificationContent),
      sheetName = "CT_Profile",
      excelObject = excelObject
    )

    # CT Mapping
    ctMapping <- getQualificationCTMapping(qualificationContent)
    writeDataToSheet(
      data = ctMapping,
      sheetName = "CT_Mapping",
      excelObject = excelObject
    )
    # Color CT Mapping
    ospsuite.utils::validateIsIncluded("Color", names(ctMapping))
    colorColIndex <- which(names(ctMapping) == "Color")
    for (ctIndex in seq_along(ctMapping$Color)) {
      openxlsx::addStyle(
        excelObject,
        sheet = "CT_Mapping",
        style = openxlsx::createStyle(
          fgFill = ctMapping$Color[ctIndex],
          fontColour = ctMapping$Color[ctIndex]
        ),
        rows = 1 + ctIndex,
        cols = colorColIndex
      )
    }

    # DDI Ratio
    ddiRatio <- getQualificationDDIRatio(qualificationContent)
    writeDataToSheet(data = ddiRatio, sheetName = "DDI_Ratio", excelObject = excelObject)
    # TODO: handle dataValidation
    # Color DDI Ratios
    ospsuite.utils::validateIsIncluded("Group Color", names(ddiRatio))
    groupColorColIndex <- which(names(ddiRatio) == "Group Color")
    for (ddiIndex in seq_along(ddiRatio[["Group Color"]])) {
      openxlsx::addStyle(
        excelObject,
        sheet = "DDI_Ratio",
        style = openxlsx::createStyle(
          fgFill = ddiRatio[["Group Color"]][ddiIndex],
          fontColour = ddiRatio[["Group Color"]][ddiIndex]
        ),
        rows = 1 + ddiIndex,
        cols = groupColorColIndex
      )
    }

    # DDI Ratio Mapping
    writeDataToSheet(
      data = getQualificationDDIRatioMapping(qualificationContent),
      sheetName = "DDI_Ratio_Mapping",
      excelObject = excelObject
    )

    # Sections
    writeDataToSheet(
      data = getQualificationSections(qualificationContent),
      sheetName = "Sections",
      excelObject = excelObject
    )

    # Inputs
    writeDataToSheet(
      data = data.frame(
        Project = NA,
        "BB-Type" = NA,
        "BB-Name" = NA,
        "Section Reference" = NA,
        check.names = FALSE
      ),
      sheetName = "Inputs",
      excelObject = excelObject
    )

    # Global Plot Settings
    globalPlotSettings <- formatPlotSettings(qualificationContent$Plots$PlotSettings)
    writeDataToSheet(
      data = globalPlotSettings,
      sheetName = "GlobalPlotSettings",
      excelObject = excelObject
    )

    # GlobalAxes DDI PreVsObs
    # TODO: check if this is required for all AxesSettings
    ddiAxesSettings <- lapply(qualificationContent$Plots$AxesSettings$DDIRatioPlotsPredictedVsObserved, as.data.frame)
    ddiAxesSettings <- do.call("rbind", ddiAxesSettings)
    writeDataToSheet(
      data = ddiAxesSettings,
      sheetName = "GlobalAxes_DDI_PredVsObs",
      excelObject = excelObject
    )
  }
  # Save the final workbook
  openxlsx::saveWorkbook(excelObject, file = fileName, overwrite = TRUE)
  return(invisible())
}


#' @title writeDataToSheet
#' @description
#' Write a data.frame to a specific sheet in an Excel file
#' @param data A data.frame to write to the sheet
#' @param sheetName Character string. Name of the sheet to write to
#' @param excelObject An openxlsx workbook object
#' @return Invisibly returns `NULL`. Side effect: mutates the workbook by writing data and freezing the header row.
#' @import openxlsx
#' @keywords internal
writeDataToSheet <- function(data, sheetName, excelObject) {
  # Input validation
  ospsuite.utils::validateIsOfType(data, "data.frame")
  ospsuite.utils::validateIsCharacter(sheetName)
  ospsuite.utils::validateIsOfLength(sheetName, 1)
  ospsuite.utils::validateIsIncluded(sheetName, names(excelObject))
  
  openxlsx::writeDataTable(
    excelObject,
    sheet = sheetName,
    x = data,
    headerStyle = EXCEL_OPTIONS$headerStyle,
    withFilter = TRUE
  )
  openxlsx::freezePane(excelObject, sheet = sheetName, firstRow = TRUE)
  return(invisible())
}

#' @title EXCEL_OPTIONS
#' @description
#' List of default Excel options
#' @import openxlsx
#' @export
EXCEL_OPTIONS <- list(
  headerStyle = openxlsx::createStyle(
    fgFill = "#ADD8E6",
    textDecoration = "Bold",
    border = "Bottom",
    fontColour = "black"
  ),
  newProjectStyle = openxlsx::createStyle(
    fgFill = "#A3FFA3",
    fontColour = "black"
  ),
  deletedProjectStyle = openxlsx::createStyle(
    fgFill = "#FF8884",
    fontColour = "black"
  )
)

#' @title excelOptions
#' @description
#' Deprecated: Use `EXCEL_OPTIONS` instead.
#' List of default Excel options
#' @import openxlsx
#' @export
excelOptions <- EXCEL_OPTIONS

#' @title ALL_BUILDING_BLOCKS
#' @description
#' Allowed Building Blocks values
#' @keywords internal
ALL_BUILDING_BLOCKS <- c(
  "Individual",
  "Population",
  "Compound",
  "Protocol",
  "Event",
  "Formulation", "ObserverSet", "ExpressionProfile", "Simulation"
)

#' @title AllBuildingBlocks
#' @description
#' Deprecated: Use `ALL_BUILDING_BLOCKS` instead.
#' Allowed Building Blocks values
#' @keywords internal
AllBuildingBlocks <- ALL_BUILDING_BLOCKS
