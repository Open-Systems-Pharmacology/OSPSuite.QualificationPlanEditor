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
