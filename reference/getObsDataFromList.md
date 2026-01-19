# getObsDataFromList

Get a data.frame of observed data IDs and Paths/URLs

## Usage

``` r
getObsDataFromList(observedDataPaths)
```

## Arguments

- observedDataPaths:

  List of observed data paths and types

## Value

data.frame with columns \`ID\`, \`Path\` and \`Type\`

## Examples

``` r
# Get the project data from a list of paths
observedDataPaths <- list(
  "A" = "ObsData/A.csv",
  "B" = "ObsData/B.csv",
  "A-B-DDI" = list(Path = "Projects/A-B-DDI.csv", Type = "DDIRatio")
)
getObsDataFromList(observedDataPaths)
#>        Id                 Path        Type
#> 1       A        ObsData/A.csv TimeProfile
#> 2       B        ObsData/B.csv TimeProfile
#> 3 A-B-DDI Projects/A-B-DDI.csv    DDIRatio
```
