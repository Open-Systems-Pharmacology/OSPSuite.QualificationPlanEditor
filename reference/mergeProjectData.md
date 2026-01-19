# mergeProjectData

Merge data.frames of project IDs and Paths/URLs from snapshots and
qualification

## Usage

``` r
mergeProjectData(snapshotData, qualificationData = NULL)
```

## Arguments

- snapshotData:

  A data.frame with columns \`Id\` and \`Path\`

- qualificationData:

  A data.frame with columns \`Id\` and \`Path\`

## Value

A data.frame with columns \`Id\`, \`Path\` and \`Status\`

## Examples

``` r
# Qualification data
qualiData <- data.frame(Id = c("a", "b", "c"), Path = c("a", "b", "c"))

# Snapshot data
snapData <- data.frame(Id = c("c", "d"), Path = c("newC", "newD"))

# Merged data along with status
mergeProjectData(snapData, qualiData)
#>   Id Path    Status
#> 1  a    a Unchanged
#> 2  b    b Unchanged
#> 3  c newC   Changed
#> 4  d newD     Added
```
