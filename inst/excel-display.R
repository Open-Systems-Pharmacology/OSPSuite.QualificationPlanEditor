#' @title displayExcel
#' @description
#' A function that displays an Excel file with its styling
#' for pkgdown html format using `gt` and `tidyxl` packages
#' @param excelFile path of Excel file
#' @param level Section level for the displayed tab
#' @return Character string
displayExcel <- function(excelFile, level = 2) {
  htmlContent <- paste(
    paste0(rep("#", level), collapse = ""),
    "Excel Content {.tabset .tabset-pills} \n\n"
  )

  excelSheets <- readxl::excel_sheets(excelFile)
  excelFormats <- tidyxl::xlsx_formats(excelFile)
  excelCells <- tidyxl::xlsx_cells(excelFile)
  for (excelSheet in excelSheets) {
    excelData <- openxlsx::readWorkbook(xlsxFile = excelFile, sheet = excelSheet, check.names = FALSE)
    # Select content for the specific Excel sheet
    dataCells <- excelCells |>
      dplyr::filter(.data[["sheet"]] %in% excelSheet) |>
      dplyr::filter(.data[["col"]] == 1)
    # Create a list to define font and background styles for each row
    dataStyles <- data.frame(
      row = dataCells$row - 1,
      color = excelFormats$local$font$color$rgb[dataCells$local_format_id],
      fill = excelFormats$local$fill$patternFill$fgColor$rgb[dataCells$local_format_id]
    ) |>
      dplyr::mutate(
        color = paste0("#", substr(.data[["color"]], 3, nchar(.data[["color"]]))),
        fill = paste0("#", substr(.data[["fill"]], 3, nchar(.data[["fill"]]))),
        color = ifelse(.data[["color"]] %in% "#NA", "#000000", .data[["color"]]),
        fill = ifelse(.data[["fill"]] %in% "#NA", "#ffffff", .data[["fill"]])
      )
    dataStyles <- split(tail(dataStyles, -1), 1:(nrow(dataStyles) - 1))
    excelTable <- styleExcelData(excelData, dataStyles)

    htmlContent <- c(
      htmlContent,
      paste(
        paste0(rep("#", level + 1), collapse = ""),
        excelSheet,
        "\n\n",
        gt::as_raw_html(excelTable),
        "\n\n"
      )
    )
  }
  return(htmlContent)
}

#' @title styleExcelData
#' @description
#' A function to apply Excel styles in each row of a data.frame
#' @param data A data.frame
#' @param styles A list of `color`, `fill` styles mapped to a `row`
#' @return A `gt` table
styleExcelData <- function(data, styles) {
  gtTable <- gt::gt(data)
  if (nrow(data) == 0) {
    return(gtTable)
  }
  for (style in styles) {
    gtTable <- gtTable |>
      gt::tab_style(
        style = list(
          gt::cell_fill(color = style$fill),
          gt::cell_text(color = style$color)
        ),
        locations = gt::cells_body(rows = style$row)
      )
  }
  return(gtTable)
}
