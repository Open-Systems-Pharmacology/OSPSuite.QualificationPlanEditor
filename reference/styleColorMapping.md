# styleColorMapping

Apply background color to mapping data.frame in excel object

## Usage

``` r
styleColorMapping(mapping, sheetName, excelObject, columnName = "Color")
```

## Arguments

- mapping:

  A data.frame

- sheetName:

  Character string. Name of the sheet to write to

- excelObject:

  An openxlsx workbook object

- columnName:

  Character string. Name of the column where colors are defined

## Value

Invisibly returns \`NULL\`. Side effect: mutates the workbook by writing
data and freezing the header row.
