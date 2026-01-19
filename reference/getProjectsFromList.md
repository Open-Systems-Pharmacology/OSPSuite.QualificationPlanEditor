# getProjectsFromList

Get a data.frame of project IDs and Paths/URLs

## Usage

``` r
getProjectsFromList(snapshotPaths)
```

## Arguments

- snapshotPaths:

  List of project snapshots given by their URL or relative path

## Value

data.frame with columns \`ID\` and \`Path\`

## Examples

``` r
# Get the project data from a list of paths
snapshotPaths <- list(
  "Raltegravir" = file.path(
    "https://raw.githubusercontent.com",
    "Open-Systems-Pharmacology",
    "Raltegravir-Model",
    "v1.2",
    "Raltegravir-Model.json"
  ),
  "Atazanavir" = file.path(
    "https://raw.githubusercontent.com",
    "Open-Systems-Pharmacology",
    "Atazanavir-Model",
    "v1.2",
    "Atazanavir-Model.json"
  )
)
getProjectsFromList(snapshotPaths)
#>            Id
#> 1 Raltegravir
#> 2  Atazanavir
#>                                                                                                        Path
#> 1 https://raw.githubusercontent.com/Open-Systems-Pharmacology/Raltegravir-Model/v1.2/Raltegravir-Model.json
#> 2   https://raw.githubusercontent.com/Open-Systems-Pharmacology/Atazanavir-Model/v1.2/Atazanavir-Model.json
```
