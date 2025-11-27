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
  newProjectStyle = openxlsx::createStyle(
    fgFill = "#A3FFA3",
    fontColour = "black"
  ),
  deletedProjectStyle = openxlsx::createStyle(
    fgFill = "#FF8884",
    fontColour = "black"
  )
)

#' @title ALL_BUILDING_BLOCKS
#' @description
#' Allowed Building Blocks values
#' @keywords internal
#' @importFrom stats na.exclude
ALL_BUILDING_BLOCKS <- stats::na.exclude(lookupData[["BuildingBlock"]]) # nolint

#' @title ALL_EXCEL_AXES
#' @description
#' Allowed Excel Axes
#' @keywords internal
ALL_EXCEL_AXES <- stats::na.exclude(lookupData[["AxesSettingsPlots"]]) # nolint

#' @title ALL_EXCEL_DIMENSIONS
#' @description
#' Allowed Excel Dimensions Blocks values
#' @keywords internal
#' @importFrom stats na.exclude
ALL_EXCEL_DIMENSIONS <- stats::na.exclude(lookupData[["Dimension"]]) # nolint

#' @title ALL_EXCEL_SHEETS
#' @description
#' Required Excel sheets to be read by UI
#' @keywords internal
#' @importFrom readxl excel_sheets
ALL_EXCEL_SHEETS <- readxl::excel_sheets(system.file("Qualification-Template.xlsx", package = "ospsuite.qualificationplaneditor")) # nolint

#' @title EXCEL_MAPPING
#' @description
#' Dictionary mapping Excel to Qualification variables
#' @keywords internal
EXCEL_MAPPING <- read.csv( # nolint
  system.file("excel-qualification-dictionary.csv", package = "ospsuite.qualificationplaneditor"),
  na.strings = "",
  stringsAsFactors = FALSE
  )
