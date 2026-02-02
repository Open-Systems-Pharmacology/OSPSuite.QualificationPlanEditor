# getQualificationGOFMapping

Extract the goodness of fit (GOF) mapping from a qualification plan,
returning a data.frame with mapping information for GOF analysis.

## Usage

``` r
getQualificationGOFMapping(
  qualificationContent,
  simulationsOutputs,
  simulationsObsData
)
```

## Arguments

- qualificationContent:

  Content of a qualification plan

- simulationsOutputs:

  A data.frame of Project, Simulation and Output

- simulationsObsData:

  A data.frame of Project, Simulation and ObservedData

## Value

A data.frame with columns \`Project\`, \`Simulation\`, \`Output\` and
relevant GOF fields
