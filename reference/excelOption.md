# excelOption

Because \`ospsuite.utils::validateColumns()\` has been deprecated in
favor of \`ospsuite.utils::validateIsOption()\`, \`excelOption()\` uses
\`ospsuite.utils::characterOption()\` with defaults appropriate for
validating data read from Excel

## Usage

``` r
excelOption(
  allowedValues = NULL,
  nullAllowed = TRUE,
  naAllowed = FALSE,
  expectedLength = NULL
)
```

## Arguments

- allowedValues:

  array of character strings allowed

- nullAllowed:

  logical for \`NULL\` values allowed

- naAllowed:

  logical for \`NA\` values allowed

- expectedLength:

  expected rows for data
