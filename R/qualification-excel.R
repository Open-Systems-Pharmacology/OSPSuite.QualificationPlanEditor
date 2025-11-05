#' @title excelToQualificationPlan
#' @description
#' Export Excel as qualification plan
#' @param excelFile Path of Excel file defining the qualification plan features
#' @param qualificationPlan Path of qualification plan exported file. Must have `.json` extension.
#' @export
excelToQualificationPlan <- function(excelFile, qualificationPlan = "qualification_plan.json") {
  cli::cli_h1("Exporting to Qualification Plan")
  ospsuite.utils::validateIsFileExtension(excelFile, "xlsx")
  ospsuite.utils::validateIsFileExtension(qualificationPlan, "json")
  if (!file.exists(excelFile)) {
    cli::cli_abort("excelFile: {.file {excelFile}} does not exist")
  }
  sheetNames <- readxl::excel_sheets(excelFile)
  ospsuite.utils::validateIsIncluded(ALL_EXCEL_SHEETS, sheetNames)

  # Projects
  cli::cli_progress_step("Exporting {.field Projects} Data")
  qualificationProjects <- readxl::read_excel(excelFile, sheet = "Projects")
  ospsuite.utils::validateColumns(
    qualificationProjects,
    columnSpecs = list(
      Id = list(type = "character", naAllowed = FALSE),
      Path = list(type = "character", naAllowed = FALSE)
    )
  )
  # Building Blocks
  qualificationBB <- readxl::read_excel(excelFile, sheet = "BB")
  ospsuite.utils::validateColumns(
    qualificationBB,
    columnSpecs = list(
      "Project"	= list(type = "character", allowedValues = qualificationProjects$Id, naAllowed = FALSE, nullAllowed = TRUE),
      "BB-Type" = list(type = "character", naAllowed = FALSE, nullAllowed = TRUE),
      "BB-Name" = list(type = "character", naAllowed = FALSE, nullAllowed = TRUE),
      "Parent-Project" = list(type = "character", allowedValues = qualificationProjects$Id, naAllowed = TRUE, nullAllowed = TRUE)
    )
  )
  exportedQualificationProjects <- getProjectsFromExcel(qualificationProjects, qualificationBB)
  
  
  # ObservedDataSets
  cli::cli_progress_step("Exporting {.field Observed Data}")
  qualificationObsDataSets <- readxl::read_excel(excelFile, sheet = "ObsData")
  ospsuite.utils::validateColumns(
    qualificationObsDataSets,
    columnSpecs = list(
      Id = list(type = "character", naAllowed = FALSE, nullAllowed = TRUE),
      Path = list(type = "character", naAllowed = FALSE, nullAllowed = TRUE),
      Type = list(type = "character", allowedValues = c("DDIRatio", "TimeProfile"), naAllowed = TRUE, nullAllowed = TRUE)
    )
  )
  # Plots: list that includes
  # - AxesSettings
  cli::cli_progress_step("Exporting {.field Global Axes Settings}")
  qualificationAxesSettings <- readxl::read_excel(excelFile, sheet = "GlobalAxesSettings")
  ospsuite.utils::validateColumns(
    qualificationAxesSettings,
    columnSpecs = list(
      Plot = list(type = "character", allowedValues = ALL_EXCEL_AXES, naAllowed = FALSE, nullAllowed = TRUE),
      Type = list(type = "character", allowedValues = c("X", "Y", "Y2"), naAllowed = FALSE, nullAllowed = TRUE),
      # TODO: use a comprehensive list of dimensions and units (from ospsuite package ?)
      Dimension = list(type = "character", allowedValues = ALL_EXCEL_DIMENSIONS, naAllowed = FALSE, nullAllowed = TRUE),
      # Need to allow na to include unitless axes
      Unit = list(type = "character", naAllowed = TRUE, nullAllowed = TRUE),
      GridLines = list(type = "logical", naAllowed = FALSE, nullAllowed = TRUE),
      Scaling = list(type = "character", allowedValues = c("Linear", "Log"), naAllowed = FALSE, nullAllowed = TRUE)
    )
  )
  qualificationAxesSettings <- groupAxesSettings(qualificationAxesSettings)
  # - PlotSettings
  cli::cli_progress_step("Exporting {.field Global Plot Settings}")
  qualificationPlotSettings <- readxl::read_excel(excelFile, sheet = "GlobalPlotSettings")
  ospsuite.utils::validateColumns(
    qualificationPlotSettings,
    columnSpecs = list(
      ChartWidth = list(type = "numeric", naAllowed = FALSE, nullAllowed = TRUE),
      ChartHeight = list(type = "numeric", naAllowed = FALSE, nullAllowed = TRUE),
      AxisSize = list(type = "numeric", naAllowed = FALSE, nullAllowed = TRUE),
      LegendSize = list(type = "numeric", naAllowed = FALSE, nullAllowed = TRUE),
      OriginSize = list(type = "numeric", naAllowed = FALSE, nullAllowed = TRUE),
      FontFamilyName = list(type = "character", naAllowed = FALSE, nullAllowed = TRUE),
      WatermarkSize = list(type = "numeric", naAllowed = FALSE, nullAllowed = TRUE)
    )
  )
  # - AllPlots
  # TODO: find examples with All Plots defined in both qualification and Excel
  # - GOFMergedPlots
  # TODO: find examples with GOFMergedPlots defined in both qualification and Excel
  # - ComparisonTimeProfilePlots
  cli::cli_progress_step("Exporting {.field Comparison Time Profile} Plot Settings")
  ctData <- readxl::read_excel(excelFile, sheet = "CT_Profile")
  ctMapping <- readxl::read_excel(excelFile, sheet = "CT_Mapping")
  ctPlots <- getCTPlotsFromExcel(ctData, ctMapping)

  # - DDIRatioPlots
  cli::cli_progress_step("Exporting {.field DDI Ratio} Plot Settings")
  ddiData <- readxl::read_excel(excelFile, sheet = "DDI_Ratio")
  ddiMapping <- readxl::read_excel(excelFile, sheet = "DDI_Ratio_Mapping")
  ddiPlots <- getDDIPlotsFromExcel(ddiData, ddiMapping)

  qualificationPlots <- list(
    AxesSettings = qualificationAxesSettings,
    PlotSettings = qualificationPlotSettings,
    AllPlots = NA,
    GOFMergedPlots = NA,
    ComparisonTimeProfilePlots = ctPlots,
    DDIRatioPlots = ddiPlots
  )

  # Sections
  cli::cli_progress_step("Exporting {.field Sections}")
  qualificationSections <- readxl::read_excel(excelFile, sheet = "Sections")
  ospsuite.utils::validateColumns(
    qualificationSections,
    columnSpecs = list(
      "Section Reference" = list(type = "character", naAllowed = FALSE),
      Title = list(type = "character", naAllowed = TRUE),
      Content = list(type = "character", naAllowed = TRUE),
      "Parent Section" = list(
        type = "character",
        allowedValues = qualificationSections[["Section Reference"]],
        naAllowed = TRUE
      )
    )
  )
  # Inputs
  cli::cli_progress_step("Exporting {.field Inputs}")
  qualificationInputs <- readxl::read_excel(excelFile, sheet = "Inputs")
  ospsuite.utils::validateColumns(
    qualificationInputs,
    columnSpecs = list(
      Project = list(type = "character", allowedValues = qualificationProjects$Id, naAllowed = FALSE, nullAllowed = TRUE),
      "BB-Type" = list(type = "character", naAllowed = TRUE, nullAllowed = TRUE),
      "BB-Name" = list(type = "character", naAllowed = TRUE, nullAllowed = TRUE),
      "Section Reference" = list(
        type = "character",
        allowedValues = qualificationSections[["Section Reference"]],
        naAllowed = TRUE,
        nullAllowed = TRUE
      )
    )
  )
  # Format section as a nested list
  qualificationSections <- getExcelSections(qualificationSections)
  # Intro ?
  # qualificationIntro <- readxl::read_excel(excelFile, sheet = "Inputs")

  qualificationContent <- list(
    "$schema" = NA,
    "Projects" = exportedQualificationProjects,
    "ObservedDataSets" = qualificationObsDataSets,
    "Plots" = qualificationPlots,
    "Inputs" = qualificationInputs,
    "Sections" = qualificationSections,
    "Intro" = NA
  )

  cli::cli_progress_step("Saving extracted data into {.file {qualificationPlan}}")
  jsonlite::write_json(
    x = qualificationContent,
    path = qualificationPlan,
    pretty = TRUE,
    auto_unbox = TRUE
  )
  return(invisible(TRUE))
}

#' @title parseSectionsToNestedList
#' @description
#' Parse qualification plan sections
#' @param sectionsIn A Section list including Reference, Title, Content and Sections fields
#' @param sectionsOut A data.frame to accumulate the parsed sections
#' @param parentSection A string representing the parent section reference
#' @return A data.frame
#' @keywords internal
getExcelSections <- function(sectionData) {
  excelSections <- lapply(
    # Start by first level sections
    which(is.na(sectionData[["Parent Section"]])),
    function(rowIndex) {
      parseSectionsToNestedList(
        sectionsIn = sectionData[rowIndex, ],
        sectionData = sectionData
      )
    }
  )
  return(excelSections)
}

#' @title parseSectionsToNestedList
#' @description
#' Parse qualification plan sections
#' @param sectionsIn A data.frame row including Reference, Title, Content and Parent Section fields
#' @param sectionsOut A Section list including Reference, Title, Content and Sections fields
#' data.frame to accumulate the parsed sections
#' @param sectionData A data.frame of all section information
#' @return A nested list
#' @keywords internal
parseSectionsToNestedList <- function(sectionsIn, sectionData) {
  names(sectionsIn) <- c("Reference", "Title", "Content", "Parent")
  sectionsOut <- as.list(sectionsIn |> dplyr::select(-matches("Parent")))
  childSections <- sectionData[["Parent Section"]] %in% sectionsIn$Reference
  if (!any(childSections)) {
    sectionsOut$Sections <- NA
    return(sectionsOut)
  }
  sectionsOut$Sections <- lapply(
    which(childSections),
    function(childSectionsRow) {
      parseSectionsToNestedList(sectionData[childSectionsRow, ], sectionData)
    }
  )
  return(sectionsOut)
}

#' @title groupAxesSettings
#' @description
#' Group axis settings as a named list to export in qualification plan
#' @param qualificationAxesSettings A data.frame of axis settings
#' @return A named list of axis settings
#' @keywords internal
groupAxesSettings <- function(qualificationAxesSettings) {
  exportedSettings <- list()
  for (plotName in ALL_EXCEL_AXES) {
    axesSetting <- dplyr::filter(
      .data = qualificationAxesSettings,
      .data[["Plot"]] %in% plotName
    )
    if (nrow(axesSetting) == 0) {
      exportedSettings[[plotName]] <- NA
      next
    }
    if (nrow(axesSetting) < 2) {
      cli::cli_abort("GlobalAxes sheet: {.strong {plotName}} plot only has {.val 1} axis defined")
    }
    exportedSettings[[plotName]] <- axesSetting
  }
  return(exportedSettings)
}

#' @title getProjectsFromExcel
#' @description
#' Get qualification project if building blocks
#' @param projectData A data.frame of project Id and Path
#' @param bbData A data.frame mapping Building Block to parent project
#' @return A list of Project with their building blocks
#' @keywords internal
getProjectsFromExcel <- function(projectData, bbData) {
  noBB <- is.na(bbData[["Parent-Project"]])
  if(all(noBB)){
    return(projectData)
  }
  bbData <- dplyr::filter(.data = bbData, !noBB)
  updatedProjects <- lapply(
    seq_len(nrow(projectData)),
    function(rowIndex){
      selectedBBData <- dplyr::filter(
        .data = bbData, 
        .data[["Project"]] %in% projectData$Id[rowIndex]
        )
      if(nrow(selectedBBData)==0){
        updatedProject <- list(
          Id = projectData$Id[rowIndex], 
          Path = projectData$Path[rowIndex]
          )
        return(updatedProject)
        }
      selectedBBData <- dplyr::select(
        .data = selectedBBData, 
        dplyr::matches(c("BB-Type", "BB-Name", "Parent-Project"))
        )
      names(selectedBBData) <- c("Type", "Name", "Project")
      
      updatedProject <- list(
        Id = projectData$Id[rowIndex], 
        Path = projectData$Path[rowIndex],
        BuildingBlocks = selectedBBData
        )
      return(updatedProject)
    }
  )
  return(updatedProjects)
}

#' @title getCTPlotsFromExcel
#' @description
#' Get qualification settings for ComparisonTimeProfile plots
#' @param data A data.frame of plot settings
#' @param mapping A data.frame mapping plot information to projects
#' @return A list of ComparisonTimeProfile plots
#' @keywords internal
getCTPlotsFromExcel <- function(data, mapping) {
  ctPlots <- vector(mode = "list", length = nrow(data))
  ctDictionary <- data.frame(
    Excel = c("Project", "Simulation", "Output", "Observed data", "StartTime", "TimeUnit", "Color", "Caption", "Symbol"),
    Qualification = c("Project", "Simulation", "Output", "ObservedData", "StartTime", "TimeUnit", "Color", "Caption", "Symbol")
    )
  
  for (plotIndex in seq_len(nrow(data))) {
    plotData <- dplyr::filter(
      .data = mapping, 
      .data[["Plot Title"]] %in% data[plotIndex, "Title"]
      )
    plotData <- dplyr::select(.data = plotData, dplyr::matches(ctDictionary$Excel))
    names(plotData) <- ctDictionary$Qualification
    
    ctPlots[[plotIndex]] <- list(
      Title = data$Title[plotIndex],
      SectionReference = data$`Section Reference`[plotIndex],
      SimulationDuration = data$`Simulation Duration`[plotIndex],
      TimeUnit = data$TimeUnit[plotIndex],
      OutputMappings = plotData,
      # TODO: handle plot and axes settings if defined
      PlotSettings = NA,
      AxesSettings = NA
    )
  }
  return(ctPlots)
}

#' @title getDDIPlotsFromExcel
#' @description
#' Get qualification settings for DDI Ratio plots
#' @param data A data.frame of plot settings
#' @param mapping A data.frame mapping plot information to projects
#' @return A list of DDIRatio plots
#' @keywords internal
getDDIPlotsFromExcel <- function(data, mapping) {
  plotRows <- cummax(seq_along(data$Title) * !is.na(data$Title))
  ddiPlotInfo <- split(data, plotRows)
  ddiPlots <- vector(mode = "list", length = dplyr::n_distinct(plotRows))

  for (plotIndex in seq_along(ddiPlots)) {
    # Regular Fields
    plotTitle <- na.exclude(ddiPlotInfo[[plotIndex]]$Title)
    ddiPlots[[plotIndex]]$Title <- plotTitle
    ddiPlots[[plotIndex]]$SectionReference <- na.exclude(ddiPlotInfo[[plotIndex]]$`Section Ref`)
    ddiPlots[[plotIndex]]$PKParameters <- na.exclude(ddiPlotInfo[[plotIndex]]$`PK-Parameter`)
    ddiPlots[[plotIndex]]$PlotTypes <- na.exclude(ddiPlotInfo[[plotIndex]]$`Plot Type`)
    ddiPlots[[plotIndex]]$Artifacts <- na.exclude(ddiPlotInfo[[plotIndex]]$`Artifacts`)
    ddiPlots[[plotIndex]]$Subunits <- na.exclude(ddiPlotInfo[[plotIndex]]$`Subunits`)
    # TODO: handle plot and axes settings if defined
    ddiPlots[[plotIndex]]$PlotSettings <- NA
    ddiPlots[[plotIndex]]$AxesSettings <- NA

    # Groups
    # TODO: handle if an NA is within these 3 columns
    groupInfo <- na.exclude(ddiPlotInfo[[plotIndex]][, c("Group Caption", "Group Color", "Group Symbol")])
    ddiPlots[[plotIndex]]$Groups <- vector(mode = "list", length = nrow(groupInfo))
    for (groupIndex in seq_len(nrow(groupInfo))) {
      groupTitle <- groupInfo$`Group Caption`[groupIndex]
      ddiPlots[[plotIndex]]$Groups[[groupIndex]]$Caption <- groupTitle
      ddiPlots[[plotIndex]]$Groups[[groupIndex]]$Color <- groupInfo$`Group Color`[groupIndex]
      ddiPlots[[plotIndex]]$Groups[[groupIndex]]$Symbol <- groupInfo$`Group Symbol`[groupIndex]
      # Get all relevant DDI Ratios from mapping
      ddiRatios <- dplyr::filter(.data = mapping, `Plot Title` %in% plotTitle, `Group Title` %in% groupTitle)
      ddiPlots[[plotIndex]]$Groups[[groupIndex]]$DDIRatios <- lapply(
        seq_len(nrow(ddiRatios)),
        function(ddiRatioIndex) {
          list(
            Output = ddiRatios$Output[ddiRatioIndex],
            ObservedData = ddiRatios$`Observed data`[ddiRatioIndex],
            ObservedDataRecordId = ddiRatios$ObsDataRecordID[ddiRatioIndex],
            SimulationControl = list(
              Project = ddiRatios$Project[ddiRatioIndex],
              Simulation = ddiRatios$Simulation_Control[ddiRatioIndex],
              StartTime = ddiRatios$`Control StartTime`[ddiRatioIndex],
              EndTime = ddiRatios$`Control EndTime`[ddiRatioIndex],
              TimeUnit = ddiRatios$`Control TimeUnit`[ddiRatioIndex]
            ),
            SimulationDDI = list(
              Project = ddiRatios$Project[ddiRatioIndex],
              Simulation = ddiRatios$Simulation_Treatment[ddiRatioIndex],
              StartTime = ddiRatios$`Treatment StartTime`[ddiRatioIndex],
              EndTime = ddiRatios$`Treatment EndTime`[ddiRatioIndex],
              TimeUnit = ddiRatios$`Treatment TimeUnit`[ddiRatioIndex]
            )
          )
        }
      )
    }
  }
  return(ddiPlots)
}
