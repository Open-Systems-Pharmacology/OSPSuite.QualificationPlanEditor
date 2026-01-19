# applyDataValidation

Write a dataValidation listing to cells in an Excel sheet

## Usage

``` r
applyDataValidation(
  value,
  data,
  sheetName,
  columnNames,
  excelObject,
  additionalRows = 100
)
```

## Arguments

- value:

  Character string. Data validation listing as an Excel expression. For
  instance \`"'Lookup'!\$L\$2:\$L\$4"\` to use values from \`'Lookup'\`
  Excel sheet between \`L2\` and \`L4\` cells.

- data:

  A data.frame previously added to the Excel sheet \`sheetName\`

- sheetName:

  Character string. Name of the sheet

- columnNames:

  Character string. Names of column variable to apply the dataValidation

- excelObject:

  An openxlsx workbook object

- additionalRows:

  Integer. Additional rows to apply dataValidation

## Value

Invisibly returns \`NULL\`. \*\*Side effect\*\*: mutates the workbook by
writing dataValidation listing
