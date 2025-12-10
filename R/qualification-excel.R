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

  # Schema
  cli::cli_progress_step("Exporting {.field Schema} Data")
  qualificationSchema <- readxl::read_excel(excelFile, sheet = "MetaInfo")
  qualificationSchema <- paste0(
    "https://raw.githubusercontent.com/Open-Systems-Pharmacology/QualificationPlan/v",
    utils::head(qualificationSchema[[1]], 1),
    "/schemas/OSP_Qualification_Plan_Schema.json"
  )

  # Projects
  cli::cli_progress_step("Exporting {.field Projects} Data")
  qualificationProjects <- readxl::read_excel(excelFile, sheet = "Projects", col_types = "text")
  ospsuite.utils::validateColumns(
    qualificationProjects,
    columnSpecs = list(
      Id = list(type = "character", naAllowed = FALSE),
      Path = list(type = "character", naAllowed = FALSE)
    )
  )
  # Building Blocks
  qualificationBB <- readxl::read_excel(excelFile, sheet = "BB", col_types = "text")
  ospsuite.utils::validateColumns(
    qualificationBB,
    columnSpecs = list(
      "Project" = list(type = "character", allowedValues = qualificationProjects$Id, naAllowed = FALSE, nullAllowed = TRUE),
      "BB-Type" = list(type = "character", naAllowed = FALSE, nullAllowed = TRUE),
      "BB-Name" = list(type = "character", naAllowed = FALSE, nullAllowed = TRUE),
      "Parent-Project" = list(type = "character", allowedValues = qualificationProjects$Id, naAllowed = TRUE, nullAllowed = TRUE)
    )
  )

  # SimulationParameters
  qualificationSimParam <- readxl::read_excel(excelFile, sheet = "SimParam", col_types = "text")
  ospsuite.utils::validateColumns(
    qualificationSimParam,
    columnSpecs = list(
      "Project" = list(type = "character", allowedValues = qualificationProjects$Id, naAllowed = FALSE, nullAllowed = TRUE),
      "Parent Project" = list(type = "character", allowedValues = qualificationProjects$Id, naAllowed = FALSE, nullAllowed = TRUE),
      "Parent Simulation" = list(type = "character", naAllowed = FALSE, nullAllowed = TRUE),
      "Path" = list(type = "character", naAllowed = FALSE, nullAllowed = TRUE),
      "TargetSimulation" = list(type = "character", naAllowed = FALSE, nullAllowed = TRUE)
    )
  )

  exportedQualificationProjects <- getProjectsFromExcel(
    qualificationProjects,
    qualificationBB,
    qualificationSimParam
  )

  # ObservedDataSets
  cli::cli_progress_step("Exporting {.field Observed Data}")
  qualificationObsDataSets <- readxl::read_excel(excelFile, sheet = "ObsData", col_types = "text")
  allowedDataTypes <- lookupData$ObservedDataType |>
    stats::na.exclude() |>
    as.character()
  ospsuite.utils::validateColumns(
    qualificationObsDataSets,
    columnSpecs = list(
      Id = list(type = "character", naAllowed = FALSE, nullAllowed = TRUE),
      Path = list(type = "character", naAllowed = FALSE, nullAllowed = TRUE),
      Type = list(type = "character", allowedValues = allowedDataTypes, naAllowed = TRUE, nullAllowed = TRUE)
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
      Dimension = list(type = "character", allowedValues = ALL_EXCEL_DIMENSIONS, naAllowed = TRUE, nullAllowed = TRUE),
      # Need to allow na to include unitless axes
      Unit = list(type = "character", naAllowed = TRUE, nullAllowed = TRUE),
      GridLines = list(type = "logical", naAllowed = TRUE, nullAllowed = TRUE),
      Scaling = list(type = "character", allowedValues = c("Linear", "Log"), naAllowed = TRUE, nullAllowed = TRUE)
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
  qualificationPlotSettings <- getPlotSettingsFromExcel(qualificationPlotSettings)
  # AllPlots
  cli::cli_progress_step("Exporting {.field All Plots} Settings")
  allPlotsData <- readxl::read_excel(excelFile, sheet = "All_Plots")
  allPlotsData <- getAllPlotsFromExcel(allPlotsData)

  # ComparisonTimeProfile Plots
  cli::cli_progress_step("Exporting {.field Comparison Time Profile} Plot Settings")
  ctData <- readxl::read_excel(excelFile, sheet = "CT_Plots")
  ctMapping <- readxl::read_excel(excelFile, sheet = "CT_Mapping")
  ctPlots <- getCTPlotsFromExcel(ctData, ctMapping)

  # GOFMerged Plots
  cli::cli_progress_step("Exporting {.field GOF} Plot Settings")
  gofData <- readxl::read_excel(excelFile, sheet = "GOF_Plots")
  gofMapping <- readxl::read_excel(excelFile, sheet = "GOF_Mapping")
  gofPlots <- getGOFPlotsFromExcel(gofData, gofMapping)

  # DDIRatio Plots
  cli::cli_progress_step("Exporting {.field DDI Ratio} Plot Settings")
  ddiData <- readxl::read_excel(excelFile, sheet = "DDIRatio_Plots")
  ddiMapping <- readxl::read_excel(excelFile, sheet = "DDIRatio_Mapping")
  ddiPlots <- getDDIPlotsFromExcel(ddiData, ddiMapping)

  # PKRatioPlots
  cli::cli_progress_step("Exporting {.field PK Ratio} Plot Settings")
  pkData <- readxl::read_excel(excelFile, sheet = "PKRatio_Plots")
  pkMapping <- readxl::read_excel(excelFile, sheet = "PKRatio_Mapping")
  pkPlots <- getPKPlotsFromExcel(pkData, pkMapping)

  qualificationPlots <- list(
    AxesSettings = qualificationAxesSettings,
    PlotSettings = qualificationPlotSettings,
    AllPlots = allPlotsData,
    GOFMergedPlots = gofPlots,
    ComparisonTimeProfilePlots = ctPlots,
    DDIRatioPlots = ddiPlots,
    PKRatioPlots = pkPlots
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
  qualificationInputs <- getInputsFromExcel(qualificationInputs)

  # Format section as a nested list
  qualificationSections <- getExcelSections(qualificationSections)
  # Intro
  qualificationIntro <- readxl::read_excel(excelFile, sheet = "Intro")
  if (nrow(qualificationIntro) == 0) {
    qualificationIntro <- NULL
  }

  qualificationContent <- list(
    "$schema" = qualificationSchema,
    "Projects" = exportedQualificationProjects,
    "ObservedDataSets" = qualificationObsDataSets,
    "Plots" = qualificationPlots,
    "Inputs" = qualificationInputs,
    "Sections" = qualificationSections,
    "Intro" = qualificationIntro
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

#' @title getExcelSections
#' @description
#' Parse qualification plan sections
#' @param sectionData A data.frame
#' @return A nexted list of sections
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
#' @param sectionData A data.frame of all section information
#' @return A nested list
#' @keywords internal
parseSectionsToNestedList <- function(sectionsIn, sectionData) {
  names(sectionsIn) <- c("Reference", "Title", "Content", "Parent")
  sectionsOut <- as.list(sectionsIn |> dplyr::select(-dplyr::matches("Parent")))
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
    axesSetting <- qualificationAxesSettings |>
      dplyr::filter(.data[["Plot"]] %in% plotName)

    if (nrow(axesSetting) == 0) {
      next
    }
    if (nrow(axesSetting) < 2) {
      cli::cli_abort("GlobalAxes sheet: {.strong {plotName}} plot only has {.val 1} axis defined")
    }
    exportedSettings[[plotName]] <- axesSetting |>
      dplyr::select(-dplyr::matches("Plot")) |>
      dplyr::mutate(Unit = ifelse(is.na(.data[["Unit"]]), "", .data[["Unit"]]))
  }
  return(exportedSettings)
}

#' @title getProjectsFromExcel
#' @description
#' Get qualification project if building blocks
#' @param projectData A data.frame of project Id and Path
#' @param bbData A data.frame mapping Building Block to parent project
#' @param simParamData A data.frame mapping SimulationParameters to parent project
#' @return A list of Project with their building blocks and simulation parameters
#' @keywords internal
getProjectsFromExcel <- function(projectData, bbData, simParamData) {
  noBB <- is.na(bbData[["Parent-Project"]])
  noSimParam <- is.na(simParamData[["Parent Project"]])
  if (all(noBB, noSimParam)) {
    return(projectData)
  }
  bbData <- bbData |> dplyr::filter(!noBB)
  simParamData <- simParamData |> dplyr::filter(!noSimParam)
  updatedProjects <- lapply(
    seq_len(nrow(projectData)),
    function(rowIndex) {
      selectedBBData <- mapDataToProject(projectData$Id[rowIndex], bbData, "BB")
      selectedSimParamData <- mapDataToProject(projectData$Id[rowIndex], simParamData, "SimParam")
      updatedProject <- list(
        Id = projectData$Id[rowIndex],
        Path = projectData$Path[rowIndex],
        BuildingBlocks = selectedBBData,
        SimulationParameters = selectedSimParamData
      )
      # Remove NULL fields from updated project
      fieldsToKeep <- which(!sapply(updatedProject, is.null))
      updatedProject <- updatedProject[fieldsToKeep]
      return(updatedProject)
    }
  )
  return(updatedProjects)
}

#' @title mapDataToProject
#' @description
#' Map building block or simulation parameter data to a project
#' @param projectId A character identifier of project
#' @param data A data.frame of Building Block or Simulation Parameter data
#' @param type A character `"BB"` for Building Block and `"SimParam"` for Simulation Parameter data
#' @return A formatted list or data.frame mapped to the Project
#' @keywords internal
mapDataToProject <- function(projectId, data, type) {
  # Get all data associated to project Id
  selectedData <- data |> dplyr::filter(.data[["Project"]] %in% projectId)
  if (nrow(selectedData) == 0) {
    return(NULL)
  }
  selectedData <- mapToQualification(selectedData, sheetName = type)
  # BB keep data.frame as is
  if (ospsuite.utils::isIncluded(type, "BB")) {
    return(selectedData)
  }
  # SimParam need to be split by Project, Simulation and Path
  selectedData <- split(
    selectedData,
    list(
      selectedData[["Project"]],
      selectedData[["Simulation"]],
      selectedData[["Path"]]
    )
  ) |> unname()
  # Remove all duplicated Project, Simulation and Path values from each list
  selectedData <- lapply(
    selectedData,
    function(dataContent) {
      lapply(as.list(dataContent), unique)
    }
  )
  return(selectedData)
}

#' @title getAllPlotsFromExcel
#' @description
#' Get qualification settings for AllPlots field
#' @param data A data.frame of plot settings
#' @return A data.frame with columns 'Project', 'Simulation', and 'Section Reference', or NA if no data
#' @keywords internal
getAllPlotsFromExcel <- function(data) {
  data <- data |>
    dplyr::filter(!is.na(.data[["Section Reference"]]))
  if (nrow(data) == 0) {
    # Returns an empty list that will be converted as [] in json
    # to match expected qualification json structure
    return(list())
  }
  allPlotsData <- mapToQualification(data, sheetName = "All_Plots")
  return(allPlotsData)
}

#' @title getCTPlotsFromExcel
#' @description
#' Get qualification settings for ComparisonTimeProfile plots
#' @param data A data.frame of plot settings
#' @param mapping A data.frame mapping plot information to projects
#' @return A list of ComparisonTimeProfile plots
#' @keywords internal
getCTPlotsFromExcel <- function(data, mapping) {
  data <- data |>
    dplyr::filter(!is.na(.data[["Section Reference"]]))
  if (nrow(data) == 0) {
    return(list())
  }
  ctPlots <- vector(mode = "list", length = nrow(data))
  ctData <- mapToQualification(data, sheetName = "CT_Plots")
  for (plotIndex in seq_along(ctPlots)) {
    mappingsData <- mapping |>
      dplyr::filter(.data[["Plot Title"]] %in% ctData[plotIndex, "Title"]) |>
      mapToQualification(sheetName = "CT_Mapping")

    ctPlots[[plotIndex]] <- c(ctData[plotIndex, ], list(OutputMappings = mappingsData))
    # TODO: handle plot and axes settings if defined
  }
  return(ctPlots)
}

#' @title getGOFPlotsFromExcel
#' @description
#' Get qualification settings for GOFMerged plots
#' @param data A data.frame of plot settings
#' @param mapping A data.frame mapping plot information to projects
#' @return A list of GOFMerged plots
#' @keywords internal
#' @importFrom stats na.exclude
getGOFPlotsFromExcel <- function(data, mapping) {
  if (nrow(data) == 0) {
    return(list())
  }
  plotRows <- cummax(seq_along(data$Title) * !is.na(data$Title))
  gofPlotInfo <- split(data, plotRows)
  gofPlots <- vector(mode = "list", length = dplyr::n_distinct(plotRows))

  for (plotIndex in seq_along(gofPlots)) {
    # Regular Fields
    gofPlotData <- lapply(as.list(gofPlotInfo[[plotIndex]]), stats::na.exclude)
    # Do not export plots without a section reference
    if (ospsuite.utils::isEmpty(gofPlotData[["Section Reference"]])) {
      gofPlots[[plotIndex]] <- NULL
      next
    }
    gofData <- mapToQualification(gofPlotData, sheetName = "GOF_Plots")
    plotTitle <- gofData[["Title"]]
    # Groups
    gofGroupData <- mapToQualification(
      gofPlotData,
      sheetName = "GOF_Plots",
      qualificationPlanSelector = "Groups"
    ) |> as.data.frame()
    # TODO: handle plot and axes settings if defined
    gofGroups <- vector(mode = "list", length = nrow(gofGroupData))
    for (groupIndex in seq_along(gofGroups)) {
      groupTitle <- gofGroupData[groupIndex, "Caption"]
      # Get all relevant GOF mapping
      outputMappings <- mapping |>
        dplyr::filter(
          .data[["Plot Title"]] %in% plotTitle,
          .data[["Group Title"]] %in% groupTitle
        ) |>
        mapToQualification(sheetName = "GOF_Mapping")

      gofGroups[[groupIndex]] <- c(gofGroupData[groupIndex, ], list(OutputMappings = outputMappings))
    }
    gofPlots[[plotIndex]] <- c(gofData, list(Groups = gofGroups))
  }
  # Remove NULLs from exported plots
  indicesToKeep <- which(!sapply(gofPlots, is.null))
  gofPlots <- gofPlots[indicesToKeep]
  return(gofPlots)
}

#' @title getDDIPlotsFromExcel
#' @description
#' Get qualification settings for DDI Ratio plots
#' @param data A data.frame of plot settings
#' @param mapping A data.frame mapping plot information to projects
#' @return A list of DDIRatio plots
#' @keywords internal
getDDIPlotsFromExcel <- function(data, mapping) {
  if (nrow(data) == 0) {
    return(list())
  }
  plotRows <- cummax(seq_along(data$Title) * !is.na(data$Title))
  ddiPlotInfo <- split(data, plotRows)
  ddiPlots <- vector(mode = "list", length = dplyr::n_distinct(plotRows))
  for (plotIndex in seq_along(ddiPlots)) {
    # Regular Fields
    ddiPlotData <- lapply(as.list(ddiPlotInfo[[plotIndex]]), stats::na.exclude)
    # Do not export plots without a section reference
    if (ospsuite.utils::isEmpty(ddiPlotData[["Section Ref"]])) {
      ddiPlots[[plotIndex]] <- NULL
      next
    }
    ddiData <- mapToQualification(ddiPlotData, sheetName = "DDIRatio_Plots")
    plotTitle <- ddiData[["Title"]]
    # Groups
    ddiGroupData <- mapToQualification(
      ddiPlotData,
      sheetName = "DDIRatio_Plots",
      qualificationPlanSelector = "Groups"
    ) |> as.data.frame()

    # TODO: handle plot and axes settings if defined
    ddiGroups <- vector(mode = "list", length = nrow(ddiGroupData))
    for (groupIndex in seq_along(ddiGroups)) {
      groupTitle <- ddiGroupData[groupIndex, "Caption"]
      # Get all relevant DDI Ratios
      ddiRatiosData <- mapping |>
        dplyr::filter(
          .data[["Plot Title"]] %in% plotTitle,
          .data[["Group Title"]] %in% groupTitle
        )
      ddiRatiosOutputs <- mapToQualification(ddiRatiosData, sheetName = "DDIRatio_Mapping")
      ddiRatiosControl <- mapToQualification(
        ddiRatiosData,
        sheetName = "DDIRatio_Mapping",
        qualificationPlanSelector = "SimulationControl"
      )
      ddiRatiosTreatment <- mapToQualification(
        ddiRatiosData,
        sheetName = "DDIRatio_Mapping",
        qualificationPlanSelector = "SimulationDDI"
      )
      # Format DDI Ratios as an array of lists corresponding to each row of the ddiRatiosData
      ddiRatios <- lapply(
        seq_len(nrow(ddiRatiosData)),
        function(ddiRatiosIndex) {
          c(
            ddiRatiosOutputs[ddiRatiosIndex, ],
            list(SimulationControl = ddiRatiosControl[ddiRatiosIndex, ]),
            list(SimulationDDI = ddiRatiosTreatment[ddiRatiosIndex, ])
          )
        }
      )
      ddiGroups[[groupIndex]] <- c(ddiGroupData[groupIndex, ], list(DDIRatios = ddiRatios))
    }
    ddiPlots[[plotIndex]] <- c(ddiData, list(Groups = ddiGroups))
  }
  # Remove NULLs from exported plots
  indicesToKeep <- which(!sapply(ddiPlots, is.null))
  ddiPlots <- ddiPlots[indicesToKeep]
  return(ddiPlots)
}

#' @title getPKPlotsFromExcel
#' @description
#' Get qualification settings for PK Ratio plots
#' @param data A data.frame of plot settings
#' @param mapping A data.frame mapping plot information to projects
#' @return A list of PKRatio plots
#' @keywords internal
getPKPlotsFromExcel <- function(data, mapping) {
  if (nrow(data) == 0) {
    return(list())
  }
  plotRows <- cummax(seq_along(data$Title) * !is.na(data$Title))
  pkPlotInfo <- split(data, plotRows)
  pkPlots <- vector(mode = "list", length = dplyr::n_distinct(plotRows))

  for (plotIndex in seq_along(pkPlots)) {
    # Regular Fields
    pkPlotData <- lapply(as.list(pkPlotInfo[[plotIndex]]), stats::na.exclude)
    # Do not export plots without a section reference
    if (ospsuite.utils::isEmpty(pkPlotData[["Section Reference"]])) {
      pkPlots[[plotIndex]] <- NULL
      next
    }
    pkData <- mapToQualification(pkPlotData, sheetName = "PKRatio_Plots")
    plotTitle <- pkData[["Title"]]
    pkData$PKParameters <- as.list(pkData$PKParameters)
    indicesToKeep <- which(!sapply(pkData, ospsuite.utils::isEmpty))
    pkData <- pkData[indicesToKeep]
    # Groups
    pkGroupData <- mapToQualification(
      pkPlotData,
      sheetName = "PKRatio_Plots",
      qualificationPlanSelector = "Groups"
    ) |> as.data.frame()
    # TODO: handle plot and axes settings if defined
    pkGroups <- vector(mode = "list", length = nrow(pkGroupData))
    for (groupIndex in seq_along(pkGroups)) {
      groupTitle <- pkGroupData[groupIndex, "Caption"]
      # Get all relevant PK Ratio mapping
      pkRatioMappings <- mapping |>
        dplyr::filter(
          .data[["Plot Title"]] %in% plotTitle,
          .data[["Group Title"]] %in% groupTitle
        ) |>
        mapToQualification(sheetName = "PKRatio_Mapping")

      pkGroups[[groupIndex]] <- c(pkGroupData[groupIndex, ], list(PKRatios = pkRatioMappings))
    }
    pkPlots[[plotIndex]] <- c(pkData, list(Groups = pkGroups))
  }
  # Remove NULLs from exported plots
  indicesToKeep <- which(!sapply(pkPlots, is.null))
  pkPlots <- pkPlots[indicesToKeep]
  return(pkPlots)
}

#' @title getInputsFromExcel
#' @description
#' Get qualification Inputs
#' @param data A data.frame of Inputs settings
#' @return A list of Inputs
#' @keywords internal
getInputsFromExcel <- function(data) {
  if (nrow(data) == 0) {
    return()
  }
  inputsData <- mapToQualification(data, sheetName = "Inputs")
  return(inputsData)
}

#' @title getPlotSettingsFromExcel
#' @description
#' Get qualification plot settings
#' @param data A data.frame of plot settings
#' @return A list of plot settings
#' @keywords internal
getPlotSettingsFromExcel <- function(data) {
  if (nrow(data) == 0) {
    return(NA)
  }
  # Keep only first row
  data <- data |> dplyr::filter(dplyr::row_number() == 1)
  plotSettings <- list(
    ChartWidth = data$ChartWidth,
    ChartHeight = data$ChartHeight,
    Fonts = list(
      AxisSize = data$AxisSize,
      LegendSize = data$LegendSize,
      OriginSize = data$OriginSize,
      FontFamilyName = data$FontFamilyName,
      WatermarkSize = data$WatermarkSize
    )
  )
  return(plotSettings)
}

#' @title mapToQualification
#' @description
#' Map and rename qualification data.frame or list using dictionary
#' @param data A data.frame or a list
#' @param sheetName Selected Excel sheet name
#' @param qualificationPlanSelector Qualification Plan selector for sub-fields
#' @return A data.frame or a list
#' @keywords internal
mapToQualification <- function(data, sheetName, qualificationPlanSelector = NA) {
  dictionary <- EXCEL_MAPPING |>
    dplyr::filter(
      .data[["ExcelSheet"]] %in% sheetName,
      !is.na(.data[["QualificationPlanField"]]),
      .data[["QualificationPlanSelector"]] %in% qualificationPlanSelector
    )
  selectedData <- data[dictionary$ExcelColumn]
  names(selectedData) <- dictionary$QualificationPlanField
  return(selectedData)
}
