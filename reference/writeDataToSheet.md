# writeDataToSheet

Write a data.frame to a specific sheet in an Excel file

## Usage

``` r
writeDataToSheet(data, sheetName, excelObject)
```

## Arguments

- data:

  A data.frame to write to the sheet

- sheetName:

  Character string. Name of the sheet to write to

- excelObject:

  An openxlsx workbook object

## Value

Invisibly returns \`NULL\`. \*\*Side effect\*\*: mutates the workbook by
writing data and freezing the header row.
