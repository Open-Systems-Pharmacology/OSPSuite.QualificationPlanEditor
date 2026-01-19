# processProjectPaths

Process project paths to get latest releases

## Usage

``` r
processProjectPaths(
  qualificationContent,
  includePreReleases,
  returnUpdatedOnly,
  projectsToIgnore
)
```

## Arguments

- qualificationContent:

  Content of qualification plan

- includePreReleases:

  Logical indicating whether to include pre-releases

- returnUpdatedOnly:

  Logical indicating whether to return only updated paths

- projectsToIgnore:

  Character vector of project IDs to ignore

## Value

Character vector of project URLs with latest releases
