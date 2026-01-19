# processObservedDataPaths

Process observed data paths to get latest releases

## Usage

``` r
processObservedDataPaths(
  qualificationContent,
  includePreReleases,
  returnUpdatedOnly,
  observedDataToIgnore
)
```

## Arguments

- qualificationContent:

  Content of qualification plan

- includePreReleases:

  Logical indicating whether to include pre-releases

- returnUpdatedOnly:

  Logical indicating whether to return only updated paths

- observedDataToIgnore:

  Character vector of observed data IDs to ignore

## Value

Character vector of observed data URLs with latest releases
