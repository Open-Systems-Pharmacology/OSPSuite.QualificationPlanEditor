#' @title validateExcelSheet
#' @description
#' Validate that a sheet exists in an Excel workbook
#' @param sheetName Character string. Name of the sheet to validate
#' @param excelObject An openxlsx workbook object
#' @return Invisibly returns `NULL` if the sheet exists; otherwise throws an error
#' @import openxlsx
#' @keywords internal
validateExcelSheet <- function(sheetName, excelObject) {
  if (!openxlsx::sheetExists(excelObject, sheetName)) {
    cli::cli_abort("Sheet {.val {sheetName}} does not exist in the workbook")
  }
  return(invisible())
}
