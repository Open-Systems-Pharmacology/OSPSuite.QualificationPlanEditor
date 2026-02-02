# getQualificationPKRatioMapping

Extract a data.frame mapping PK ratio identifiers to relevant PK Ratio
fields

## Usage

``` r
getQualificationPKRatioMapping(qualificationContent, simulationsOutputs)
```

## Arguments

- qualificationContent:

  Content of a qualification plan

- simulationsOutputs:

  A data.frame of Project, Simulation and Output

## Value

A data.frame with the following columns: \`Project\`, \`Simulation\`,
\`Output\`, \`Plot Title\`, \`Group Title\`, \`Observed data\`, and
\`ObservedDataRecordId\`
