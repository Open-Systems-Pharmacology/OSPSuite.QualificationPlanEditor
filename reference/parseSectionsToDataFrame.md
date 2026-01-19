# parseSectionsToDataFrame

Parse qualification plan sections

## Usage

``` r
parseSectionsToDataFrame(
  sectionsIn,
  sectionsOut = data.frame(),
  parentSection = NA
)
```

## Arguments

- sectionsIn:

  A Section list including Reference, Title, Content and Sections fields

- sectionsOut:

  A data.frame to accumulate the parsed sections

- parentSection:

  A string representing the parent section reference

## Value

A data.frame
