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
) # nolint

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
  "Formulation",
  "ObserverSet",
  "ExpressionProfile",
  "Simulation"
) # nolint

#' @title ALL_EXCEL_AXES
#' @description
#' Allowed Excel Axes
#' @keywords internal
ALL_EXCEL_AXES <- c(
  "GOFMergedPlotsPredictedVsObserved",
  "GOFMergedPlotsResidualsOverTime",
  "DDIRatioPlotsPredictedVsObserved",
  "DDIRatioPlotsResidualsVsObserved",
  "ComparisonTimeProfile",
  "PKRatioPlots"
) # nolint

#' @title ALL_EXCEL_DIMENSIONS
#' @description
#' Allowed Excel Dimensions Blocks values
#' @keywords internal
ALL_EXCEL_DIMENSIONS <- c(
  "Age",
  "Amount",
  "Concentration (mass)",
  "Concentration (molar)",
  "Fraction",
  "Mass",
  "Time",
  "Dimensionless"
) # nolint

#' @title ALL_EXCEL_SHEETS
#' @description
#' Required Excel sheets to be read by UI
#' @keywords internal
ALL_EXCEL_SHEETS <- c(
  "MetaInfo", "Projects", "Simulations_Outputs", "Simulations_ObsData", "ObsData", "BB", "SimParam",
  paste0(c("All", "CT", "GOF", "DDIRatio", "PKRatio"), "_Plots"),
  paste0(c("CT", "GOF", "DDIRatio", "PKRatio"), "_Mapping"),
  "Sections", "Inputs", "GlobalPlotSettings", "GlobalAxesSettings"
) # nolint

utils::globalVariables(c(".data"))
