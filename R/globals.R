# Prevent warning when using dplyr
utils::globalVariables(c(".data"))

#' @title lookupData
#' @description
#' data.frame of all lookup values
#' Allowing all definitions to be centralized in Qualification-Template
#' @importFrom readxl read_xlsx
#' @keywords internal
lookupData <- readxl::read_xlsx(
  system.file("Qualification-Template.xlsx", package = "ospsuite.qualificationplaneditor"),
  sheet = "Lookup",
  na = ""
)

#' @title EXCEL_OPTIONS
#' @description
#' List of default Excel options
#' @import openxlsx
#' @export
EXCEL_OPTIONS <- list( # nolint
  headerStyle = openxlsx::createStyle(
    fgFill = "#ADD8E6",
    textDecoration = "Bold",
    border = "Bottom",
    fontColour = "black"
  ),
  addedProjectStyle = openxlsx::createStyle(
    fgFill = "#A3FFA3",
    fontColour = "black"
  ),
  changedProjectStyle = openxlsx::createStyle(
    fgFill = "#FFFFBF",
    fontColour = "black"
  ),
  unchangedProjectStyle = openxlsx::createStyle(
    fgFill = "#DDDDDD",
    fontColour = "black"
  )
)

#' @title ALL_BUILDING_BLOCKS
#' @description
#' Allowed Building Blocks values
#' @keywords internal
#' @importFrom stats na.exclude
ALL_BUILDING_BLOCKS <- lookupData[["BuildingBlock"]] |> # nolint
  stats::na.exclude() |>
  as.character()

#' @title ALL_EXCEL_AXES
#' @description
#' Allowed Excel Axes
#' @keywords internal
ALL_EXCEL_AXES <- lookupData[["AxesSettingsPlots"]] |> # nolint
  stats::na.exclude() |>
  as.character()

#' @title ALL_EXCEL_DIMENSIONS
#' @description
#' Allowed Excel Dimensions Blocks values
#' @keywords internal
#' @importFrom stats na.exclude
ALL_EXCEL_DIMENSIONS <- lookupData[["Dimension"]] |> # nolint
  stats::na.exclude() |>
  as.character()

#' @title ALL_EXCEL_SHEETS
#' @description
#' Required Excel sheets to be read by UI
#' @keywords internal
#' @importFrom readxl excel_sheets
ALL_EXCEL_SHEETS <- system.file( # nolint
  "Qualification-Template.xlsx",
  package = "ospsuite.qualificationplaneditor"
) |>
  readxl::excel_sheets()

#' @title EXCEL_MAPPING
#' @description
#' Dictionary mapping Excel to Qualification variables
#' @keywords internal
EXCEL_MAPPING <- read.csv( # nolint
  system.file("excel-qualification-dictionary.csv", package = "ospsuite.qualificationplaneditor"),
  na.strings = "",
  stringsAsFactors = FALSE
)

#' @title PLOT_SETTINGS
#' @description
#' Default plot settings used by qualification plans
#' @keywords internal
PLOT_SETTINGS <- list( # nolint
  ChartWidth = 500, 
  ChartHeight = 400,
  AxisSize = 11, 
  LegendSize = 9, 
  OriginSize = 11, 
  FontFamilyName = "Arial",
  WatermarkSize = 40
)

#' @title AXES_SETTINGS
#' @description
#' Default axes settings used by qualification plans
#' @keywords internal
AXES_SETTINGS <- list( # nolint
  ComparisonTimeProfile = list(
    list(Type = "X", Dimension = "Time", Unit = "h", GridLines = FALSE, Scaling = "Linear"),
    list(Type = "Y", Dimension = "Concentration (mass)", Unit = "µg/l", GridLines = FALSE, Scaling = "Log")
  ),
  GOFMergedPlotsPredictedVsObserved = list(
    list(Type = "X", Dimension = "Concentration (mass)", Unit = "µg/l", GridLines = FALSE, Scaling = "Log"),
    list(Type = "Y", Dimension = "Concentration (mass)", Unit = "µg/l", GridLines = FALSE, Scaling = "Log")
  ),
  GOFMergedPlotsResidualsOverTime = list(
    list(Type = "X", Dimension = "Time", Unit = "h", GridLines = FALSE, Scaling = "Linear"),
    list(Type = "Y", Dimension = "Dimensionless", Unit = "", GridLines = FALSE, Scaling = "Linear")
  ),
  DDIRatioPlotsPredictedVsObserved = list(
    list(Type = "X", Dimension = "Dimensionless", Unit = "", GridLines = FALSE, Scaling = "Log"),
    list(Type = "Y", Dimension = "Dimensionless", Unit = "", GridLines = FALSE, Scaling = "Log")
  ),
  DDIRatioPlotsResidualsVsObserved = list(
    list(Type = "X", Dimension = "Dimensionless", Unit = "", GridLines = FALSE, Scaling = "Log"),
    list(Type = "Y", Dimension = "Dimensionless", Unit = "", GridLines = FALSE, Scaling = "Log")
  ),
  PKRatioPlots = list(
    list(Type = "X", Dimension = "Age", Unit = "year(s)", GridLines = FALSE, Scaling = "Linear"),
    list(Type = "Y", Dimension = "Dimensionless", Unit = "", GridLines = FALSE, Scaling = "Log")
  )
)


#' @title excelOption
#' @description
#' Because `ospsuite.utils::validateColumns()` has been deprecated in favor of `ospsuite.utils::validateIsOption()`, 
#' `excelOption()` uses `ospsuite.utils::characterOption()` with defaults appropriate for validating data read from Excel
#' @param allowedValues array of character strings allowed
#' @param nullAllowed logical for `NULL` values allowed
#' @param naAllowed logical for `NA` values allowed
#' @param expectedLength expected rows for data
#' @keywords internal
#' @importFrom ospsuite.utils characterOption
excelOption <- function(allowedValues = NULL, nullAllowed = TRUE, naAllowed = FALSE, expectedLength = NULL){
  ospsuite.utils::characterOption(
    allowedValues = allowedValues,
    nullAllowed = nullAllowed,
    naAllowed = naAllowed,
    expectedLength = expectedLength
  )
}
