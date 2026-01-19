# mergeObsData

Merge data.frames of Observed data IDs and Paths/URLs from snapshots and
qualification

## Usage

``` r
mergeObsData(obsData, qualificationObsData = NULL)
```

## Arguments

- obsData:

  A data.frame with columns \`Id\`, \`Path\` and \`Type\`

- qualificationObsData:

  A data.frame with columns \`Id\`, \`Path\` and \`Type\`

## Value

A data.frame with columns \`Id\`, \`Path\`, \`Type\` and \`Status\`
