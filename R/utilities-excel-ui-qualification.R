#' @title getProjectsFromQualification
#' @description
#' Get a data.frame of project IDs and Paths/URLs
#' @param qualificationContent Content of a qualification plan
#' @return data.frame with columns `Id` and `Path`
#' @export
getProjectsFromQualification <- function(qualificationContent) {
  # Guard for empty/NULL inputs
  if (ospsuite.utils::isEmpty(qualificationContent$Projects)) {
    return(data.frame(Id = character(), Path = character(), stringsAsFactors = FALSE))
  }

  projectData <- lapply(
    qualificationContent$Projects,
    function(projectContent) {
      data.frame(
        Id = projectContent$Id,
        Path = projectContent$Path,
        stringsAsFactors = FALSE
      )
    }
  )
  projectData <- do.call(rbind, projectData)
  return(projectData)
}

#' @title getObsDataFromQualification
#' @description
#' Get a data.frame of observed data IDs and Paths/URLs
#' @param qualificationContent Content of a qualification plan
#' @return data.frame with columns `Id`, `Path` and `Type`
#' @export
getObsDataFromQualification <- function(qualificationContent) {
  # Guard for empty/NULL inputs
  if (ospsuite.utils::isEmpty(qualificationContent$ObservedDataSets)) {
    return(data.frame(Id = character(), Path = character(), Type = character(), stringsAsFactors = FALSE))
  }

  obsData <- lapply(
    qualificationContent$ObservedDataSets,
    function(obsDataContent) {
      data.frame(
        Id = obsDataContent$Id,
        Path = obsDataContent$Path,
        Type = obsDataContent$Type %||% "TimeProfile",
        stringsAsFactors = FALSE
      )
    }
  )
  obsData <- do.call(rbind, obsData)
  return(obsData)
}

#' @title getBBDataFromQualification
#' @description
#' Get a data.frame of projects, type, name and parent project
#' @param qualificationContent Content of a qualification plan
#' @return A data.frame with columns `Project`, `Simulation` and `Output`
#' @export
getBBDataFromQualification <- function(qualificationContent) {
  # Guard for empty/NULL inputs
  if (ospsuite.utils::isEmpty(qualificationContent$Projects)) {
    return(data.frame(
      "Project" = character(),
      "BB-Type" = character(),
      "BB-Name" = character(),
      "Parent-Project" = character(),
      check.names = FALSE,
      stringsAsFactors = FALSE
    ))
  }

  bbData <- lapply(
    qualificationContent$Projects,
    function(projectContent) {
      if (ospsuite.utils::isEmpty(projectContent$BuildingBlocks)) {
        return(NULL)
      }
      projectBB <- do.call(rbind.data.frame, projectContent$BuildingBlocks)
      data.frame(
        "Project" = projectContent$Id,
        "BB-Type" = projectBB$Type,
        "BB-Name" = projectBB$Name,
        "Parent-Project" = projectBB$Project,
        row.names = NULL,
        check.names = FALSE
      )
    }
  )

  # Filter out NULL values before rbind
  bbData <- bbData[!sapply(bbData, is.null)]

  # If all projects had NULL BuildingBlocks, return empty data.frame
  if (ospsuite.utils::isEmpty(bbData)) {
    return(data.frame(
      "Project" = character(),
      "BB-Type" = character(),
      "BB-Name" = character(),
      "Parent-Project" = character(),
      check.names = FALSE,
      stringsAsFactors = FALSE
    ))
  }

  bbData <- do.call(rbind, bbData)
  return(bbData)
}

#' @title styleQualificationCells
#' @description
#' Apply qualification styles to cells in an Excel sheet
#' @param qualificationStyles A vector of qualification styles including the names `"New"` and `"Deleted"`
#' @param columnIndices Indices of the columns to apply the styles to
#' @param sheetName Name of the sheet to write to
#' @param excelObject An openxlsx workbook object
#' @import openxlsx
#' @keywords internal
styleQualificationCells <- function(qualificationStyles, columnIndices, sheetName, excelObject) {
  openxlsx::addStyle(
    excelObject,
    sheet = sheetName,
    style = EXCEL_OPTIONS$newProjectStyle,
    rows = 1 + which(qualificationStyles %in% "New"),
    cols = columnIndices,
    gridExpand = TRUE
  )
  openxlsx::addStyle(
    excelObject,
    sheet = sheetName,
    style = EXCEL_OPTIONS$deletedProjectStyle,
    rows = 1 + which(qualificationStyles %in% "Deleted"),
    cols = columnIndices,
    gridExpand = TRUE
  )
}

#' @title getQualificationStyles
#' @description Get qualification styles for a data.frame based on project membership
#' @param data A data.frame with a project variable
#' @param commonProjects A vector of project IDs that are common between the data and the qualification plan
#' @param qualificationProjects A vector of project IDs that are new in the qualification plan
#' @param projectVariable Name of the project variable in the data.frame
#' @keywords internal
getQualificationStyles <- function(data, commonProjects, qualificationProjects, projectVariable = "Project") {
  ifelse(
    data[[projectVariable]] %in% commonProjects,
    "Unchanged",
    ifelse(data[[projectVariable]] %in% qualificationProjects, "Deleted", "New")
  )
}

#' @title getQualificationSections
#' @description
#' Get a data.frame of qualification plan sections
#' @param qualificationContent Content of a qualification plan
#' @return A data.frame with `Section Reference`, `Title`, `Content` and `Parent Section` columns
#' @keywords internal
getQualificationSections <- function(qualificationContent) {
  return(parseSectionsToDataFrame(qualificationContent$Sections))
}

#' @title parseSectionsToDataFrame
#' @description
#' Parse qualification plan sections
#' @param sectionsIn A Section list including Reference, Title, Content and Sections fields
#' @param sectionsOut A data.frame to accumulate the parsed sections
#' @param parentSection A string representing the parent section reference
#' @return A data.frame
#' @keywords internal
parseSectionsToDataFrame <- function(sectionsIn, sectionsOut = data.frame(), parentSection = NA) {
  for (section in sectionsIn) {
    sectionOut <- data.frame(
      "Section Reference" = section$Reference,
      "Title" = section$Title,
      "Content" = section$Content %||% NA,
      "Parent Section" = parentSection,
      check.names = FALSE
    )
    sectionsOut <- rbind.data.frame(sectionsOut, sectionOut, stringsAsFactors = FALSE)
    # If subsections are included and not empty, update sectionsOut data.frame
    if (!ospsuite.utils::isEmpty(section$Sections)) {
      sectionsOut <- parseSectionsToDataFrame(
        sectionsIn = section$Sections,
        sectionsOut = sectionsOut,
        parentSection = section$Reference
      )
    }
  }
  return(sectionsOut)
}

#' @title getQualificationIntro
#' @description
#' Extract intro paths from qualification content as a data.frame
#' @param qualificationContent Content of a qualification plan
#' @return data.frame with `Path` column
#' @keywords internal
getQualificationIntro <- function(qualificationContent) {
  qualificationIntro <- qualificationContent$Intro
  if (ospsuite.utils::isEmpty(qualificationIntro)) {
    return(data.frame())
  }
  return(data.frame(Path = unlist(qualificationIntro)))
}

#' @title getQualificationInputs
#' @description
#' Get a data.frame of qualification inputs with columns 'Project', 'BB-Type', 'BB-Name', and 'Section Reference'
#' @param qualificationContent Content of a qualification plan
#' @return data.frame with columns 'Project', 'BB-Type', 'BB-Name', and 'Section Reference'
#' @keywords internal
getQualificationInputs <- function(qualificationContent) {
  qualificationInputs <- qualificationContent$Inputs
  if (ospsuite.utils::isEmpty(qualificationInputs)) {
    inputsData <- data.frame(
      "Project" = NULL,
      "BB-Type" = NULL,
      "BB-Name" = NULL,
      "Section Reference" = NULL,
      check.names = FALSE
    )
    return(inputsData)
  }
  inputsData <- lapply(
    qualificationInputs,
    function(qualificationInput) {
      inputData <- data.frame(
        "Project" = qualificationInput$Project,
        "BB-Type" = qualificationInput$Type,
        "BB-Name" = qualificationInput$Name,
        "Section Reference" = qualificationInput$SectionReference,
        check.names = FALSE
      )
      return(inputData)
    }
  )
  inputsData <- do.call("rbind", inputsData)
  return(inputsData)
}

#' @title getQualificationAllPlots
#' @description
#' Extract a data.frame containing All Plots information
#' from the qualification plan content
#' @param qualificationContent Content of a qualification plan
#' @param simulationsOutputs A data.frame of Project, Simulation and Output
#' @return data.frame with columns
#' `Project`, `Simulation` and `Section Reference`
#' @keywords internal
#' @import dplyr
getQualificationAllPlots <- function(qualificationContent, simulationsOutputs) {
  allPlotsData <- data.frame()
  for (allPlot in qualificationContent$Plots$AllPlots) {
    allPlotsData <- rbind(
      allPlotsData,
      data.frame(
        Project = allPlot$Project,
        Simulation = allPlot$Simulation,
        "Section Reference" = allPlot$SectionReference,
        check.names = FALSE
      )
    )
  }
  # Add Project and Simulation that are not already defined
  newPlotData <- simulationsOutputs |>
    dplyr::filter(
      !(paste(.data[["Project"]], .data[["Simulation"]]) %in% paste(allPlotsData$Project, allPlotsData$Simulation))
      ) |>
    dplyr::mutate(`Section Reference` = NA) |>
    dplyr::select(-dplyr::matches("Output"))
  return(rbind(allPlotsData, newPlotData))
}

#' @title getQualificationCTPlots
#' @description
#' Extract a data.frame containing comparison time (CT) profile information
#' from the qualification plan content
#' @param qualificationContent Content of a qualification plan
#' @return data.frame with columns
#' `Title`, `Section Reference`, `Simulation Duration`, `TimeUnit` and plot settings
#' @keywords internal
getQualificationCTPlots <- function(qualificationContent) {
  ctProfiles <- data.frame()
  for (ctPlot in qualificationContent$Plots$ComparisonTimeProfilePlots) {
    ctProfile <- cbind(
      data.frame(
        Title = ctPlot$Title,
        "Section Reference" = ctPlot$SectionReference,
        "Simulation Duration" = ctPlot$SimulationDuration,
        TimeUnit = ctPlot$TimeUnit,
        check.names = FALSE
      ),
      formatPlotSettings(ctPlot$PlotSettings),
      formatAxesSettings(ctPlot$AxesSettings)
    )
    ctProfiles <- rbind(ctProfiles, ctProfile)
  }
  return(ctProfiles)
}

#' @title getQualificationCTMapping
#' @description
#' Extract the comparison time (CT) mapping from a qualification plan,
#' returning a data.frame with mapping information for CT analysis.
#' @param qualificationContent Content of a qualification plan
#' @return A data.frame with columns
#' `Project`, `Simulation`, `Output` and relevant CT fields
#' @keywords internal
getQualificationCTMapping <- function(qualificationContent) {
  ctMappings <- data.frame()
  for (ctPlot in qualificationContent$Plots$ComparisonTimeProfilePlots) {
    for (outputMapping in ctPlot$OutputMappings) {
      ctMapping <- data.frame(
        Project = outputMapping$Project,
        Simulation = outputMapping$Simulation,
        Output = outputMapping$Output,
        "Observed data" = unlist(outputMapping$ObservedData) %||% NA,
        "Plot Title" = ctPlot$Title,
        StartTime = outputMapping$StartTime,
        TimeUnit = outputMapping$TimeUnit,
        Color = outputMapping$Color,
        Caption = outputMapping$Caption,
        Symbol = outputMapping$Symbol,
        check.names = FALSE
      )
      ctMappings <- rbind(ctMappings, ctMapping)
    }
  }
  return(ctMappings)
}

#' @title getQualificationGOFPlots
#' @description
#' Extract a data.frame containing goodness of fit (GOF) plot information
#' from the qualification plan content
#' @param qualificationContent Content of a qualification plan
#' @return data.frame with columns
#' `Title`, `Section Reference`, `Artifacts`, `PlotTypes`, `Groups` and plot settings
#' @keywords internal
getQualificationGOFPlots <- function(qualificationContent) {
  gofPlots <- data.frame()
  for (gofPlot in qualificationContent$Plots$GOFMergedPlots) {
    gofPlotSettings <- list(
      Title = gofPlot$Title,
      "Section Reference" = gofPlot$SectionReference,
      Artifacts = unlist(gofPlot$Artifacts),
      "Plot Type" = unlist(gofPlot$PlotTypes),
      "Group Caption" = sapply(gofPlot$Groups, function(group) group$Caption),
      "Group Symbol" = sapply(gofPlot$Groups, function(group) group$Symbol)
    )
    # translating list whose fields may have different lengths into a data.frame
    maxRows <- max(sapply(gofPlotSettings, length))
    gofPlotSettings <- sapply(
      gofPlotSettings,
      function(gofField) {
        gofField <- c(gofField, rep(NA, maxRows - length(gofField)))
        return(gofField)
      },
      simplify = FALSE,
      USE.NAMES = TRUE
    )
    gofPlotSettings <- cbind(
      data.frame(gofPlotSettings, check.names = FALSE),
      formatPlotSettings(gofPlot$PlotSettings),
      formatAxesSettings(gofPlot$AxesSettings)
    )
    gofPlots <- rbind(gofPlots, gofPlotSettings)
  }
  return(gofPlots)
}

#' @title getQualificationGOFMapping
#' @description
#' Extract the goodness of fit (GOF) mapping from a qualification plan,
#' returning a data.frame with mapping information for GOF analysis.
#' @param qualificationContent Content of a qualification plan
#' @return A data.frame with columns
#' `Project`, `Simulation`, `Output` and relevant GOF fields
#' @keywords internal
getQualificationGOFMapping <- function(qualificationContent) {
  gofMappings <- data.frame()
  for (gofPlot in qualificationContent$Plots$GOFMergedPlots) {
    for (gofGroup in gofPlot$Groups) {
      for (outputMapping in gofGroup$OutputMappings) {
        gofMapping <- data.frame(
          Project = outputMapping$Project,
          Simulation = outputMapping$Simulation,
          Output = outputMapping$Output,
          "Observed data" = unlist(outputMapping$ObservedData) %||% NA,
          "Plot Title" = gofPlot$Title,
          "Group Title" = gofGroup$Caption,
          Color = outputMapping$Color,
          check.names = FALSE
        )
        gofMappings <- rbind(gofMappings, gofMapping)
      }
    }
  }
  return(gofMappings)
}

#' @title getQualificationDDIRatio
#' @description
#' Extract DDI ratio data from a qualification plan and return it as a data.frame with relevant columns
#' @param qualificationContent Content of a qualification plan
#' @return A data.frame with following columns:
#' `Title`, `Section Ref`, `PK-Parameter`, `Plot Type`, `Subunits`, `Artifacts` and legend settings
#' @keywords internal
getQualificationDDIRatio <- function(qualificationContent) {
  ddiRatios <- data.frame()
  for (ddiPlot in qualificationContent$Plots$DDIRatioPlots) {
    ddiPlotSettings <- list(
      Title = ddiPlot$Title,
      "Section Ref" = ddiPlot$SectionReference,
      "PK-Parameter" = unlist(ddiPlot$PKParameters),
      "Plot Type" = unlist(ddiPlot$PlotTypes),
      Subunits = unlist(ddiPlot$Subunits),
      Artifacts = unlist(ddiPlot$Artifacts),
      "Group Caption" = sapply(ddiPlot$Groups, function(group) group$Caption),
      "Group Color" = sapply(ddiPlot$Groups, function(group) group$Color),
      "Group Symbol" = sapply(ddiPlot$Groups, function(group) group$Symbol)
    )
    maxRows <- max(sapply(ddiPlotSettings, length))
    ddiPlotSettings <- sapply(
      ddiPlotSettings,
      function(ddiField) {
        ddiField <- c(ddiField, rep(NA, maxRows - length(ddiField)))
        return(ddiField)
      },
      simplify = FALSE,
      USE.NAMES = TRUE
    )
    ddiPlotSettings <- cbind(
      data.frame(ddiPlotSettings, check.names = FALSE),
      formatPlotSettings(ddiPlot$PlotSettings),
      formatAxesSettings(ddiPlot$AxesSettings)
    )
    ddiRatios <- rbind(ddiRatios, ddiPlotSettings)
  }
  return(ddiRatios)
}

#' @title getQualificationDDIRatioMapping
#' @description
#' Extract a data.frame mapping DDI ratio identifiers to relevant DDI Ratio fields
#' @param qualificationContent Content of a qualification plan
#' @return A data.frame with the following columns
#' `Project`, `Simulation_Control`, `Simulation_Treatment`, `Output` and control/treatment settings
#' @keywords internal
getQualificationDDIRatioMapping <- function(qualificationContent) {
  ddiMappings <- data.frame()
  for (ddiPlot in qualificationContent$Plots$DDIRatioPlots) {
    for (ddiGroup in ddiPlot$Groups) {
      for (ddiRatios in ddiGroup$DDIRatios) {
        ddiMapping <- data.frame(
          Project = ddiRatios$SimulationControl$Project,
          Simulation_Control = ddiRatios$SimulationControl$Simulation,
          "Control StartTime" = ddiRatios$SimulationControl$StartTime,
          "Control EndTime" = ddiRatios$SimulationControl$EndTime %||% NA,
          "Control TimeUnit" = ddiRatios$SimulationControl$TimeUnit,
          Simulation_Treatment = ddiRatios$SimulationDDI$Simulation,
          "Treatment StartTime" = ddiRatios$SimulationDDI$StartTime,
          "Treatment EndTime" = ddiRatios$SimulationDDI$EndTime %||% NA,
          "Treatment TimeUnit" = ddiRatios$SimulationDDI$TimeUnit,
          Output = ddiRatios$Output,
          "Plot Title" = ddiPlot$Title,
          "Group Title" = ddiGroup$Caption,
          "Observed data" = ddiRatios$ObservedData,
          ObsDataRecordID = ddiRatios$ObservedDataRecordId,
          check.names = FALSE
        )
        ddiMappings <- rbind(ddiMappings, ddiMapping)
      }
    }
  }
  return(ddiMappings)
}


#' @title formatPlotSettings
#' @description
#' Format plot settings into a standardized data.frame for further processing or reporting
#' @param plotSettings Content of a qualification plan
#' @return A data.frame with plot settings information
#' @keywords internal
formatPlotSettings <- function(plotSettings) {
  if (ospsuite.utils::isEmpty(plotSettings)) {
    return(data.frame(
      ChartWidth = NA,
      ChartHeight = NA,
      AxisSize = NA,
      LegendSize = NA,
      OriginSize = NA,
      FontFamilyName = NA,
      WatermarkSize = NA
    ))
  }
  data.frame(
    ChartWidth = plotSettings$ChartWidth %||% 500,
    ChartHeight = plotSettings$ChartHeight %||% 400,
    AxisSize = plotSettings$Fonts$AxisSize %||% 11,
    LegendSize = plotSettings$Fonts$LegendSize %||% 9,
    OriginSize = plotSettings$Fonts$OriginSize %||% 11,
    FontFamilyName = plotSettings$Fonts$FontFamilyName %||% "Arial",
    WatermarkSize = plotSettings$Fonts$WatermarkSize %||% 40
  )
}

#' @title formatAxesSettings
#' @description
#' Format axes settings for use in qualification plans or reports.
#' @param axesSettings Content of a qualification plan
#' @return A data.frame with axes setting information
#' @keywords internal
formatAxesSettings <- function(axesSettings) {
  if (ospsuite.utils::isEmpty(axesSettings)) {
    return(data.frame(
      X_Dimension = NA,
      X_GridLines = NA,
      X_Scaling = NA,
      Y_Dimension = NA,
      Y_GridLines = NA,
      Y_Scaling = NA
    ))
  }
  xAxesIndex <- which(sapply(axesSettings, function(axeSettings) {
    axeSettings$Type %in% "X"
  }))
  yAxesIndex <- which(sapply(axesSettings, function(axeSettings) {
    axeSettings$Type %in% "Y"
  }))
  xAxesSettings <- axesSettings[[xAxesIndex]]
  yAxesSettings <- axesSettings[[yAxesIndex]]
  axesSettingsData <- data.frame(
    X_Dimension = xAxesSettings$Dimension,
    X_GridLines = xAxesSettings$GridLines,
    X_Scaling = xAxesSettings$Scaling,
    Y_Dimension = yAxesSettings$Dimension,
    Y_GridLines = yAxesSettings$GridLines,
    Y_Scaling = yAxesSettings$Scaling
  )
  return(axesSettingsData)
}

#' @title formatGlobalAxesSettings
#' @description
#' Format axes settings for use in qualification plans or reports.
#' @param axesSettings Content of a qualification plan
#' @param plotName Name of plot for which axes settings are defined
#' @return A data.frame with axes setting information
#' @keywords internal
formatGlobalAxesSettings <- function(axesSettings, plotName) {
  if (ospsuite.utils::isEmpty(axesSettings)) {
    return(data.frame(
      Plot = plotName,
      Type = c("X", "Y"),
      Dimension = NA,
      Unit = NA,
      GridLines = NA,
      Scaling = NA
    ))
  }
  axesSettingsData <- dplyr::bind_rows(lapply(axesSettings, as.data.frame)) |>
    dplyr::mutate(
      Plot = plotName,
      .before = dplyr::everything()
      )
  return(axesSettingsData)
}
