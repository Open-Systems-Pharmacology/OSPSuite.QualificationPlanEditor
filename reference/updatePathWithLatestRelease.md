# updatePathWithLatestRelease

Update a GitHub raw URL with the latest release tag

## Usage

``` r
updatePathWithLatestRelease(path, includePreReleases, returnUpdatedOnly)
```

## Arguments

- path:

  Original GitHub raw URL

- includePreReleases:

  Logical indicating whether to include pre-releases

- returnUpdatedOnly:

  Logical indicating whether to return only updated paths

## Value

Updated URL with latest release tag, or NULL if no update needed
