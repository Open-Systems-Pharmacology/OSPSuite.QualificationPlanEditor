# formatPlotSettings

Format plot settings into a standardized data.frame for further
processing or reporting

## Usage

``` r
formatPlotSettings(plotSettings, fillEmpty = FALSE)
```

## Arguments

- plotSettings:

  Content of a qualification plan

- fillEmpty:

  Logical. If \`FALSE\`, empty values are replaced by \`NA\`. If
  \`TRUE\`, fill empty values with default qualification plan Plot
  Settings.

## Value

A data.frame with plot settings information
