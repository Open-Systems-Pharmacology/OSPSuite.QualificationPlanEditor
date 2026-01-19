# styleProjectStatus

Apply color styles to cells in an Excel sheet depending on identified
status

## Usage

``` r
styleProjectStatus(projectIds, columns, statusMapping, sheetName, excelObject)
```

## Arguments

- projectIds:

  A vector of project Ids

- columns:

  Indices of the columns to apply the styles to

- statusMapping:

  A data.frame mapping project IDs to their status, with columns \`Id\`
  and \`Status\`

- sheetName:

  Name of the sheet to write to

- excelObject:

  An openxlsx workbook object
