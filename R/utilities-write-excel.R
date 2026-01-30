#' @title writeDataToSheet
#' @description
#' Write a data.frame to a specific sheet in an Excel file
#' @param data A data.frame to write to the sheet
#' @param sheetName Character string. Name of the sheet to write to
#' @param excelObject An openxlsx workbook object
#' @return Invisibly returns `NULL`.
#' **Side effect**: mutates the workbook by writing data and freezing the header row.
#' @import openxlsx
#' @export
#' @keywords Excel
writeDataToSheet <- function(data, sheetName, excelObject) {
  # Input validation
  ospsuite.utils::validateIsOfType(data, "data.frame")
  ospsuite.utils::validateIsCharacter(sheetName)
  ospsuite.utils::validateIsOfLength(sheetName, 1)
  ospsuite.utils::validateIsIncluded(sheetName, names(excelObject))
  if (nrow(data) == 0) {
    return(invisible())
  }
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

#' @title styleColorMapping
#' @description
#' Apply background color to mapping data.frame in excel object
#' @param mapping A data.frame
#' @param sheetName Character string. Name of the sheet to write to
#' @param excelObject An openxlsx workbook object
#' @param columnName Character string. Name of the column where colors are defined
#' @return Invisibly returns `NULL`. Side effect: mutates the workbook by writing data and freezing the header row.
#' @import openxlsx
#' @export
#' @keywords Excel
styleColorMapping <- function(mapping, sheetName, excelObject, columnName = "Color") {
  if (nrow(mapping) == 0) {
    return(invisible())
  }
  ospsuite.utils::validateIsIncluded(columnName, names(mapping))
  colorColIndex <- which(names(mapping) == columnName)
  for (rowIndex in seq_along(mapping[[columnName]])) {
    colorValue <- mapping[rowIndex, columnName]
    if (is.na(colorValue)) {
      next
    }
    openxlsx::addStyle(
      excelObject,
      sheet = sheetName,
      style = openxlsx::createStyle(fgFill = colorValue, fontColour = colorValue),
      rows = 1 + rowIndex,
      cols = colorColIndex
    )
  }
  return(invisible())
}

#' @title applyDataValidation
#' @description
#' Write a dataValidation listing to cells in an Excel sheet
#' @param value Character string. Data validation listing as an Excel expression.
#' For instance `"'Lookup'!$L$2:$L$4"` to use values
#' from `'Lookup'` Excel sheet between `L2` and `L4` cells.
#' @param data A data.frame previously added to the Excel sheet `sheetName`
#' @param sheetName Character string. Name of the sheet
#' @param columnNames Character string. Names of column variable to apply the dataValidation
#' @param excelObject An openxlsx workbook object
#' @param additionalRows Integer. Additional rows to apply dataValidation
#' @return Invisibly returns `NULL`.
#' **Side effect**: mutates the workbook by writing dataValidation listing
#' @import openxlsx
#' @export
#' @keywords Excel
applyDataValidation <- function(value, data, sheetName, columnNames, excelObject, additionalRows = 100) {
  ospsuite.utils::validateIsOfType(data, "data.frame")
  ospsuite.utils::validateIsIncluded(columnNames, names(data))
  columnIndices <- which(names(data) %in% columnNames)
  rowIndices <- 1 + seq_len(nrow(data) + additionalRows)

  openxlsx::dataValidation(
    excelObject,
    sheet = sheetName,
    cols = columnIndices,
    rows = rowIndices,
    type = "list",
    value = value
  )
  return(invisible())
}

#' @title excelListingValue
#' @description
#' Create an Excel expression for listing values used in dataValidation
#' @param data A data.frame
#' @param columnName Character string. Name of column variable from which to get listing
#' @param sheetName Character string. Name of the sheet from which to get listing
#' @param additionalRows Integer. Additional rows to apply dataValidation
#' @return Character string corresponding to Excel expression
#' @import openxlsx
#' @export
#' @keywords Excel
excelListingValue <- function(data, columnName, sheetName, additionalRows = 0) {
  ospsuite.utils::validateIsOfType(data, "data.frame")
  ospsuite.utils::validateIsIncluded(columnName, names(data))
  columnValue <- openxlsx::int2col(which(names(data) %in% columnName))
  rowValue <- 1 + max(1, nrow(data)) + additionalRows
  listingValue <- paste0("='", sheetName, "'!$", columnValue, "$2:$", columnValue, "$", rowValue)
  return(listingValue)
}

#' @title styleProjectStatus
#' @description
#' Apply color styles to cells in an Excel sheet depending on identified status
#' @param projectIds A vector of project Ids
#' @param columns Indices of the columns to apply the styles to
#' @param statusMapping A data.frame mapping project IDs to their status, with columns `Id` and `Status`
#' @param sheetName Name of the sheet to write to
#' @param excelObject An openxlsx workbook object
#' @import openxlsx
#' @keywords internal
styleProjectStatus <- function(projectIds,
                                columns,
                                statusMapping,
                                sheetName,
                                excelObject) {
  for (status in c("Unchanged", "Changed", "Added")) {
    statusIds <- statusMapping |>
      dplyr::filter(.data[["Status"]] %in% status) |>
      dplyr::pull(var = "Id")
    selectedRows <- which(projectIds %in% statusIds)
    if (ospsuite.utils::isOfLength(selectedRows, 0)) {
      next
    }
    styleName <- paste0(tolower(status), "ProjectStyle")
    openxlsx::addStyle(
      excelObject,
      sheet = sheetName,
      style = EXCEL_OPTIONS[[styleName]],
      rows = 1 + selectedRows,
      cols = columns,
      gridExpand = TRUE
    )
  }
  return(invisible())
}
