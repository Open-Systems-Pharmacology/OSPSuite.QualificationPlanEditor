#' @title toExcelEditor
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
toExcelEditor <- function(fileName = "qualification.xlsx",
                          snapshotPaths = NULL,
                          observedDataPaths = NULL,
                          excelTemplate = NULL,
                          qualificationPlan = NULL) {
  cli::cli_h1("Exporting to Excel Editor")
  ospsuite.utils::validateIsFileExtension(fileName, "xlsx")
  excelTemplate <- excelTemplate %||%
    system.file("Qualification-Template.xlsx", package = "ospsuite.qualificationplaneditor")
  ospsuite.utils::validateIsFileExtension(excelTemplate, "xlsx")
  if (!file.exists(excelTemplate)) {
    cli::cli_abort("excelTemplate: {.file {excelTemplate}} does not exist")
  }

  #---- Copy template to output file ----
  cli::cli_progress_step("Copying Excel Template to {.file {fileName}}")
  fileCopied <- file.copy(from = excelTemplate, to = fileName, overwrite = TRUE)
  if (!fileCopied) {
    cli::cli_abort("Failed to copy template {.file {excelTemplate}} to {.file {fileName}}")
  }

  #---- Load workbook with error handling ----
  excelObject <- tryCatch(
    openxlsx::loadWorkbook(fileName),
    error = function(e) {
      cli::cli_abort("Cannot load workbook {.file {fileName}}: {e$message}")
    }
  )
  #---- Check for Qualification Plan ----
  cli::cli_progress_step("Checking for Qualification Plan")
  useQualification <- !is.null(qualificationPlan)
  cli::cli_alert_info(
    ifelse(
      useQualification,
      "Qualification Plan: {.file {qualificationPlan}}",
      "{.strong No} Qualification Plan input"
    )
  )

  #---- Projects ----
  cli::cli_progress_step("Exporting {.field Projects} Data")
  projectData <- getProjectsFromList(snapshotPaths)
  projectStatus <- mergeProjectData(projectData)
  # Qualification Plan provided
  qualificationContent <- NULL
  if (useQualification) {
    qualificationContent <- tryCatch(
      jsonlite::fromJSON(qualificationPlan, simplifyVector = FALSE),
      error = function(e) {
        cli::cli_abort("Cannot parse qualification plan: {e$message}")
      }
    )
  }
  qualificationProjectData <- getProjectsFromQualification(qualificationContent)
  qualificationObservedData <- getObsDataFromQualification(qualificationContent)
  qualificationBBData <- getBBDataFromQualification(qualificationContent)

  # Update Project Data and map to project status
  projectStatus <- mergeProjectData(projectData, qualificationProjectData)
  projectData <- projectStatus |> dplyr::select(-dplyr::all_of("Status"))

  writeDataToSheet(data = projectData, sheetName = "Projects", excelObject = excelObject)
  styleProjectStatus(
    projectIds = projectData$Id,
    columns = seq_len(ncol(projectData)),
    statusMapping = projectStatus,
    sheetName = "Projects",
    excelObject = excelObject
  )

  #---- Simulation Outputs ----
  cli::cli_progress_step("Exporting {.field Simulation Outputs} Data")
  simulationsOutputs <- getSimulationsOutputsFromProjects(projectData)
  writeDataToSheet(data = simulationsOutputs, sheetName = "Simulations_Outputs", excelObject = excelObject)
  styleProjectStatus(
    projectIds = simulationsOutputs$Project,
    columns = seq_len(ncol(simulationsOutputs)),
    statusMapping = projectStatus,
    sheetName = "Simulations_Outputs",
    excelObject = excelObject
  )

  #---- Simulations ObsData ----
  cli::cli_progress_step("Exporting {.field Simulation Observed Data}")
  simulationsObsData <- getSimulationsObsDataFromProjects(projectData)
  writeDataToSheet(data = simulationsObsData, sheetName = "Simulations_ObsData", excelObject = excelObject)
  styleProjectStatus(
    projectIds = simulationsObsData$Project,
    columns = seq_len(ncol(simulationsObsData)),
    statusMapping = projectStatus,
    sheetName = "Simulations_ObsData",
    excelObject = excelObject
  )

  #---- Obs Data ----
  cli::cli_progress_step("Exporting {.field Observed Data}")
  observedData <- getObsDataFromList(observedDataPaths)
  observedStatus <- mergeObsData(observedData)
  # Merge to observed data data
  observedStatus <- mergeObsData(observedData, qualificationObservedData)
  observedData <- observedStatus |> dplyr::select(-dplyr::all_of("Status"))
  writeDataToSheet(data = observedData, sheetName = "ObsData", excelObject = excelObject)
  # Drop down list for Obs Data Type column
  applyDataValidation(
    value = excelListingValue(lookupData, "ObservedDataType", "Lookup"),
    data = observedData,
    sheetName = "ObsData",
    columnNames = "Type",
    excelObject = excelObject
  )
  styleProjectStatus(
    projectIds = observedData$Id,
    columns = seq_len(ncol(observedData)),
    statusMapping = observedStatus,
    sheetName = "ObsData",
    excelObject = excelObject
  )

  #---- Building Blocks ----
  cli::cli_progress_step("Exporting {.field Building Block} Data")
  bbData <- getBBDataFromProjects(projectData)
  bbData <- mergeBBData(bbData, qualificationBBData)
  writeDataToSheet(data = bbData, sheetName = "BB", excelObject = excelObject)
  # Drop down list for Parent-Project column
  applyDataValidation(
    value = excelListingValue(projectData, "Id", "Projects"),
    data = bbData,
    sheetName = "BB",
    columnNames = "Parent-Project",
    excelObject = excelObject
  )
  styleProjectStatus(
    projectIds = bbData$Project,
    columns = seq_len(ncol(bbData)),
    statusMapping = projectStatus,
    sheetName = "BB",
    excelObject = excelObject
  )

  #---- Qualification Plan provided ----
  cli::cli_h2("Qualification Plan")
  # MetaInfo
  cli::cli_progress_step("Exporting {.field Schema} Data")
  # Parse version from schema
  writeDataToSheet(
    data = getSchemaVersion(qualificationContent),
    sheetName = "MetaInfo",
    excelObject = excelObject
  )

  cli::cli_progress_step("Exporting {.field Sections}")
  # Sections
  sectionsData <- getQualificationSections(qualificationContent)
  writeDataToSheet(data = sectionsData, sheetName = "Sections", excelObject = excelObject)
  # Drop down list for Parent Section column
  sectionReferenceListing <- excelListingValue(sectionsData, "Section Reference", "Sections")
  applyDataValidation(
    value = sectionReferenceListing,
    data = sectionsData,
    sheetName = "Sections",
    columnNames = "Parent Section",
    excelObject = excelObject
  )

  cli::cli_progress_step("Exporting {.field Intro and Inputs}")
  # Intro
  writeDataToSheet(
    data = getQualificationIntro(qualificationContent),
    sheetName = "Intro",
    excelObject = excelObject
  )
  # Inputs
  inputsData <- getQualificationInputs(qualificationContent)
  writeDataToSheet(data = inputsData, sheetName = "Inputs", excelObject = excelObject)
  # Drop down list for Project, BB-Type, BB-Name, Section Reference columns
  applyDataValidation(
    value = excelListingValue(projectData, "Id", "Projects"),
    data = inputsData,
    sheetName = "Inputs",
    columnNames = "Project",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(bbData, "BB-Type", "BB"),
    data = inputsData,
    sheetName = "Inputs",
    columnNames = "BB-Type",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(bbData, "BB-Name", "BB"),
    data = inputsData,
    sheetName = "Inputs",
    columnNames = "BB-Name",
    excelObject = excelObject
  )
  applyDataValidation(
    value = sectionReferenceListing,
    data = inputsData,
    sheetName = "Inputs",
    columnNames = "Section Reference",
    excelObject = excelObject
  )

  cli::cli_progress_step("Exporting {.field Simulation Parameters} Settings")
  # Sim Param
  simParamData <- getQualificationSimParam(qualificationContent)
  writeDataToSheet(data = simParamData, sheetName = "SimParam", excelObject = excelObject)
  applyDataValidation(
    value = excelListingValue(projectData, "Id", "Projects"),
    data = simParamData,
    sheetName = "SimParam",
    columnNames = "Project",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(projectData, "Id", "Projects"),
    data = simParamData,
    sheetName = "SimParam",
    columnNames = "Parent Project",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(simulationsOutputs, "Simulation", "Simulations_Outputs"),
    data = simParamData,
    sheetName = "SimParam",
    columnNames = "Parent Simulation",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(simulationsOutputs, "Simulation", "Simulations_Outputs"),
    data = simParamData,
    sheetName = "SimParam",
    columnNames = "TargetSimulation",
    excelObject = excelObject
  )

  cli::cli_progress_step("Exporting {.field All Plots} Settings")
  # AllPlots
  allPlotsData <- getQualificationAllPlots(qualificationContent, simulationsOutputs)
  writeDataToSheet(data = allPlotsData, sheetName = "All_Plots", excelObject = excelObject)
  styleProjectStatus(
    projectIds = allPlotsData$Project,
    columns = seq_len(ncol(allPlotsData)),
    statusMapping = projectStatus,
    sheetName = "All_Plots",
    excelObject = excelObject
  )
  # Drop down list for Project, Simulation, and Section Reference column
  applyDataValidation(
    value = excelListingValue(projectData, "Id", "Projects"),
    data = allPlotsData,
    sheetName = "All_Plots",
    columnNames = "Project",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(simulationsOutputs, "Simulation", "Simulations_Outputs"),
    data = allPlotsData,
    sheetName = "All_Plots",
    columnNames = "Simulation",
    excelObject = excelObject
  )
  applyDataValidation(
    value = sectionReferenceListing,
    data = allPlotsData,
    sheetName = "All_Plots",
    columnNames = "Section Reference",
    excelObject = excelObject
  )

  cli::cli_progress_step("Exporting {.field Comparison Time Profile} Plot Settings")
  # Comparison Time (CT) Profile
  ctPlotsData <- getQualificationCTPlots(qualificationContent)
  writeDataToSheet(data = ctPlotsData, sheetName = "CT_Plots", excelObject = excelObject)
  # Drop down list for Section Reference column
  applyDataValidation(
    value = sectionReferenceListing,
    data = ctPlotsData,
    sheetName = "CT_Plots",
    columnNames = "Section Reference",
    excelObject = excelObject
  )
  # Drop down list for TimeUnit column
  applyDataValidation(
    value = excelListingValue(lookupData, "TimeUnit", "Lookup"),
    data = ctPlotsData,
    sheetName = "CT_Plots",
    columnNames = "TimeUnit",
    excelObject = excelObject
  )
  # CT Mapping
  ctMapping <- getQualificationCTMapping(qualificationContent)
  writeDataToSheet(data = ctMapping, sheetName = "CT_Mapping", excelObject = excelObject)
  styleProjectStatus(
    projectIds = ctMapping$Project,
    columns = which(names(ctMapping) %in% c("Project", "Simulation", "Output")),
    statusMapping = projectStatus,
    sheetName = "CT_Mapping",
    excelObject = excelObject
  )
  styleProjectStatus(
    projectIds = ctMapping$`Observed data`,
    columns = which(names(ctMapping) %in% c("Observed data")),
    statusMapping = observedStatus,
    sheetName = "CT_Mapping",
    excelObject = excelObject
  )

  # Color CT Mapping
  styleColorMapping(mapping = ctMapping, sheetName = "CT_Mapping", excelObject = excelObject)
  # Drop down lists for Project, Simulation, Output, Plot Title, TimeUnit, Color and Symbol columns
  applyDataValidation(
    value = excelListingValue(projectData, "Id", "Projects"),
    data = ctMapping,
    sheetName = "CT_Mapping",
    columnNames = "Project",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(simulationsOutputs, "Simulation", "Simulations_Outputs"),
    data = ctMapping,
    sheetName = "CT_Mapping",
    columnNames = "Simulation",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(simulationsOutputs, "Output", "Simulations_Outputs"),
    data = ctMapping,
    sheetName = "CT_Mapping",
    columnNames = "Output",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(ctPlotsData, "Title", "CT_Plots"),
    data = ctMapping,
    sheetName = "CT_Mapping",
    columnNames = "Plot Title",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(lookupData, "TimeUnit", "Lookup"),
    data = ctMapping,
    sheetName = "CT_Mapping",
    columnNames = "TimeUnit",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(lookupData, "Color", "Lookup"),
    data = ctMapping,
    sheetName = "CT_Mapping",
    columnNames = "Color",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(lookupData, "Symbol", "Lookup"),
    data = ctMapping,
    sheetName = "CT_Mapping",
    columnNames = "Symbol",
    excelObject = excelObject
  )

  cli::cli_progress_step("Exporting {.field GOF Merged} Plot Settings")
  # Goodness of fit (GOF) Plots
  gofPlotsData <- getQualificationGOFPlots(qualificationContent)
  writeDataToSheet(data = gofPlotsData, sheetName = "GOF_Plots", excelObject = excelObject)
  # Drop down lists for Section Reference, Plot Type, Artifacts and Group Symbol columns
  applyDataValidation(
    value = sectionReferenceListing,
    data = gofPlotsData,
    sheetName = "GOF_Plots",
    columnNames = "Section Reference",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(lookupData, "GOFMergedPlotType", "Lookup"),
    data = gofPlotsData,
    sheetName = "GOF_Plots",
    columnNames = "Plot Type",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(lookupData, "ArtifactsGOFPlots", "Lookup"),
    data = gofPlotsData,
    sheetName = "GOF_Plots",
    columnNames = "Artifacts",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(lookupData, "Symbol", "Lookup"),
    data = gofPlotsData,
    sheetName = "GOF_Plots",
    columnNames = "Group Symbol",
    excelObject = excelObject
  )
  # GOF Mapping
  gofMapping <- getQualificationGOFMapping(qualificationContent)
  writeDataToSheet(data = gofMapping, sheetName = "GOF_Mapping", excelObject = excelObject)
  styleProjectStatus(
    projectIds = gofMapping$Project,
    columns = which(names(gofMapping) %in% c("Project", "Simulation", "Output")),
    statusMapping = projectStatus,
    sheetName = "GOF_Mapping",
    excelObject = excelObject
  )
  styleProjectStatus(
    projectIds = gofMapping$`Observed data`,
    columns = which(names(gofMapping) %in% c("Observed data")),
    statusMapping = observedStatus,
    sheetName = "GOF_Mapping",
    excelObject = excelObject
  )
  # Color GOF Mapping
  styleColorMapping(mapping = gofMapping, sheetName = "GOF_Mapping", excelObject = excelObject)
  # Drop down lists for Project, Simulation, Output, Plot Title, Group Title, and Color columns
  applyDataValidation(
    value = excelListingValue(projectData, "Id", "Projects"),
    data = gofMapping,
    sheetName = "GOF_Mapping",
    columnNames = "Project",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(simulationsOutputs, "Simulation", "Simulations_Outputs"),
    data = gofMapping,
    sheetName = "GOF_Mapping",
    columnNames = "Simulation",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(simulationsOutputs, "Output", "Simulations_Outputs"),
    data = gofMapping,
    sheetName = "GOF_Mapping",
    columnNames = "Output",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(gofPlotsData, "Title", "GOF_Plots"),
    data = gofMapping,
    sheetName = "GOF_Mapping",
    columnNames = "Plot Title",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(gofPlotsData, "Group Caption", "GOF_Plots"),
    data = gofMapping,
    sheetName = "GOF_Mapping",
    columnNames = "Group Title",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(lookupData, "Color", "Lookup"),
    data = gofMapping,
    sheetName = "GOF_Mapping",
    columnNames = "Color",
    excelObject = excelObject
  )

  cli::cli_progress_step("Exporting {.field DDI Ratio} Plot Settings")
  # DDI Ratio
  ddiRatioPlotsData <- getQualificationDDIRatio(qualificationContent)
  writeDataToSheet(data = ddiRatioPlotsData, sheetName = "DDIRatio_Plots", excelObject = excelObject)
  # Color DDI Ratios
  styleColorMapping(mapping = ddiRatioPlotsData, sheetName = "DDIRatio_Plots", excelObject = excelObject, columnName = "Group Color")
  # Drop down lists for Section Ref, PK-Parameter, Plot Type, Subunits, Artifacts, Group Color and Group Symbol columns
  applyDataValidation(
    value = sectionReferenceListing,
    data = ddiRatioPlotsData,
    sheetName = "DDIRatio_Plots",
    columnNames = "Section Ref",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(lookupData, "PK Parameter", "Lookup"),
    data = ddiRatioPlotsData,
    sheetName = "DDIRatio_Plots",
    columnNames = "PK-Parameter",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(lookupData, "DDIRatioPlotType", "Lookup"),
    data = ddiRatioPlotsData,
    sheetName = "DDIRatio_Plots",
    columnNames = "Plot Type",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(lookupData, "subunitsDDIRatioPlots", "Lookup"),
    data = ddiRatioPlotsData,
    sheetName = "DDIRatio_Plots",
    columnNames = "Subunits",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(lookupData, "ArtifactsRatioPlots", "Lookup"),
    data = ddiRatioPlotsData,
    sheetName = "DDIRatio_Plots",
    columnNames = "Artifacts",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(lookupData, "Color", "Lookup"),
    data = ddiRatioPlotsData,
    sheetName = "DDIRatio_Plots",
    columnNames = "Group Color",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(lookupData, "Symbol", "Lookup"),
    data = ddiRatioPlotsData,
    sheetName = "DDIRatio_Plots",
    columnNames = "Group Symbol",
    excelObject = excelObject
  )

  # DDI Ratio Mapping
  ddiRatioMapping <- getQualificationDDIRatioMapping(qualificationContent)
  writeDataToSheet(data = ddiRatioMapping, sheetName = "DDIRatio_Mapping", excelObject = excelObject)
  styleProjectStatus(
    projectIds = ddiRatioMapping$Project,
    columns = which(names(ddiRatioMapping) %in% c("Project", "Simulation_Control", "Simulation_Treatment", "Output")),
    statusMapping = projectStatus,
    sheetName = "DDIRatio_Mapping",
    excelObject = excelObject
  )
  styleProjectStatus(
    projectIds = ddiRatioMapping$`Observed data`,
    columns = which(names(ddiRatioMapping) %in% c("Observed data", "ObsDataRecordID")),
    statusMapping = observedStatus,
    sheetName = "DDIRatio_Mapping",
    excelObject = excelObject
  )
  # Drop down lists for Output, Project, Simulation_Control, Simulation_Treatment,
  # Plot Title, Group Title, Observed data, Control TimeUnit, and Treatment TimeUnit columns
  applyDataValidation(
    value = excelListingValue(projectData, "Id", "Projects"),
    data = ddiRatioMapping,
    sheetName = "DDIRatio_Mapping",
    columnNames = "Project",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(simulationsOutputs, "Output", "Simulations_Outputs"),
    data = ddiRatioMapping,
    sheetName = "DDIRatio_Mapping",
    columnNames = "Output",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(simulationsOutputs, "Simulation", "Simulations_Outputs"),
    data = ddiRatioMapping,
    sheetName = "DDIRatio_Mapping",
    columnNames = "Simulation_Control",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(simulationsOutputs, "Simulation", "Simulations_Outputs"),
    data = ddiRatioMapping,
    sheetName = "DDIRatio_Mapping",
    columnNames = "Simulation_Treatment",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(ddiRatioPlotsData, "Title", "DDIRatio_Plots"),
    data = ddiRatioMapping,
    sheetName = "DDIRatio_Mapping",
    columnNames = "Plot Title",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(ddiRatioPlotsData, "Group Caption", "DDIRatio_Plots"),
    data = ddiRatioMapping,
    sheetName = "DDIRatio_Mapping",
    columnNames = "Group Title",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(observedData, "Id", "ObsData"),
    data = ddiRatioMapping,
    sheetName = "DDIRatio_Mapping",
    columnNames = "Observed data",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(lookupData, "TimeUnit", "Lookup"),
    data = ddiRatioMapping,
    sheetName = "DDIRatio_Mapping",
    columnNames = "Control TimeUnit",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(lookupData, "TimeUnit", "Lookup"),
    data = ddiRatioMapping,
    sheetName = "DDIRatio_Mapping",
    columnNames = "Treatment TimeUnit",
    excelObject = excelObject
  )

  # PK Ratio
  pkRatioPlotsData <- getQualificationPKRatio(qualificationContent)
  writeDataToSheet(data = pkRatioPlotsData, sheetName = "PKRatio_Plots", excelObject = excelObject)
  # Color PK Ratios
  styleColorMapping(mapping = pkRatioPlotsData, sheetName = "PKRatio_Plots", excelObject = excelObject, columnName = "Group Color")
  # Drop down lists for Section Reference, PK-Parameter, Artifacts, Group Color and Group Symbol columns
  applyDataValidation(
    value = sectionReferenceListing,
    data = pkRatioPlotsData,
    sheetName = "PKRatio_Plots",
    columnNames = "Section Reference",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(lookupData, "PK Parameter", "Lookup"),
    data = pkRatioPlotsData,
    sheetName = "PKRatio_Plots",
    columnNames = "PK-Parameter",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(lookupData, "ArtifactsRatioPlots", "Lookup"),
    data = pkRatioPlotsData,
    sheetName = "PKRatio_Plots",
    columnNames = "Artifacts",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(lookupData, "Color", "Lookup"),
    data = pkRatioPlotsData,
    sheetName = "PKRatio_Plots",
    columnNames = "Group Color",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(lookupData, "Symbol", "Lookup"),
    data = pkRatioPlotsData,
    sheetName = "PKRatio_Plots",
    columnNames = "Group Symbol",
    excelObject = excelObject
  )

  # PK Ratio Mapping
  pkRatioMapping <- getQualificationPKRatioMapping(qualificationContent)
  writeDataToSheet(data = pkRatioMapping, sheetName = "PKRatio_Mapping", excelObject = excelObject)
  styleProjectStatus(
    projectIds = pkRatioMapping$Project,
    columns = which(names(pkRatioMapping) %in% c("Project", "Simulation", "Output")),
    statusMapping = projectStatus,
    sheetName = "PKRatio_Mapping",
    excelObject = excelObject
  )
  styleProjectStatus(
    projectIds = pkRatioMapping$`Observed data`,
    columns = which(names(pkRatioMapping) %in% c("Observed data", "ObservedDataRecordId")),
    statusMapping = observedStatus,
    sheetName = "PKRatio_Mapping",
    excelObject = excelObject
  )
  # Drop down lists for Output, Project, Simulation,
  # Plot Title, Group Title, Observed data columns
  applyDataValidation(
    value = excelListingValue(projectData, "Id", "Projects"),
    data = pkRatioMapping,
    sheetName = "PKRatio_Mapping",
    columnNames = "Project",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(simulationsOutputs, "Simulation", "Simulations_Outputs"),
    data = pkRatioMapping,
    sheetName = "PKRatio_Mapping",
    columnNames = "Simulation",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(simulationsOutputs, "Output", "Simulations_Outputs"),
    data = pkRatioMapping,
    sheetName = "PKRatio_Mapping",
    columnNames = "Output",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(pkRatioPlotsData, "Title", "PKRatio_Plots"),
    data = pkRatioMapping,
    sheetName = "PKRatio_Mapping",
    columnNames = "Plot Title",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(pkRatioPlotsData, "Group Caption", "PKRatio_Plots"),
    data = pkRatioMapping,
    sheetName = "PKRatio_Mapping",
    columnNames = "Group Title",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(observedData, "Id", "ObsData"),
    data = pkRatioMapping,
    sheetName = "PKRatio_Mapping",
    columnNames = "Observed data",
    excelObject = excelObject
  )

  # Global Plot Settings
  cli::cli_progress_step("Exporting {.field Global Plot Settings}")
  globalPlotSettings <- formatPlotSettings(qualificationContent$Plots$PlotSettings)
  writeDataToSheet(data = globalPlotSettings, sheetName = "GlobalPlotSettings", excelObject = excelObject)
  # Drop down lists for FontFamilyName
  applyDataValidation(
    value = excelListingValue(lookupData, "FontFamilyName", "Lookup"),
    data = globalPlotSettings,
    sheetName = "GlobalPlotSettings",
    columnNames = "FontFamilyName",
    excelObject = excelObject
  )

  # GlobalAxes DDI PreVsObs
  cli::cli_progress_step("Exporting {.field Global Axes Settings}")
  ddiAxesSettings <- lapply(
    ALL_EXCEL_AXES,
    function(plotName) {
      formatGlobalAxesSettings(
        axesSettings = qualificationContent$Plots$AxesSettings[[plotName]],
        plotName = plotName
      )
    }
  )
  ddiAxesSettings <- do.call("rbind", ddiAxesSettings)
  writeDataToSheet(data = ddiAxesSettings, sheetName = "GlobalAxesSettings", excelObject = excelObject)
  # Drop down lists for Dimension, GridLines, and Scaling
  applyDataValidation(
    value = excelListingValue(lookupData, "Dimension", "Lookup"),
    data = ddiAxesSettings,
    sheetName = "GlobalAxesSettings",
    columnNames = "Dimension",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(lookupData, "Boolean", "Lookup"),
    data = ddiAxesSettings,
    sheetName = "GlobalAxesSettings",
    columnNames = "GridLines",
    excelObject = excelObject
  )
  applyDataValidation(
    value = excelListingValue(lookupData, "Scaling", "Lookup"),
    data = ddiAxesSettings,
    sheetName = "GlobalAxesSettings",
    columnNames = "Scaling",
    excelObject = excelObject
  )
  # Save the final workbook
  cli::cli_progress_step("Saving extracted data into {.file {fileName}}")
  openxlsx::saveWorkbook(excelObject, file = fileName, overwrite = TRUE)
  return(invisible(TRUE))
}
