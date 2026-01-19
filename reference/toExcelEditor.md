# toExcelEditor

toExcelEditor

## Usage

``` r
toExcelEditor(
  fileName = "qualification.xlsx",
  snapshotPaths = NULL,
  observedDataPaths = NULL,
  excelTemplate = NULL,
  qualificationPlan = NULL
)
```

## Arguments

- fileName:

  Character string. Name of the Excel file to be created.

- snapshotPaths:

  Named list of project snapshots given by their URL or relative path.

- observedDataPaths:

  Named list of observed data sets (which are not included into the
  projects) given by their URL or relative path.

- excelTemplate:

  Character string. Path to an Excel template file (only captions and
  lookup tables). If \`NULL\`, uses the default template from the
  package.

- qualificationPlan:

  Character string. Path, URL, or JSON string of an existing
  qualification plan. If \`NULL\`, at least 1 project must be included
  in the snapshotPaths.

## Value

Invisibly returns \`NULL\`. Side effect: creates an Excel file at the
specified path.
