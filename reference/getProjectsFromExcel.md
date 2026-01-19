# getProjectsFromExcel

Get qualification project if building blocks

## Usage

``` r
getProjectsFromExcel(projectData, bbData, simParamData)
```

## Arguments

- projectData:

  A data.frame of project Id and Path

- bbData:

  A data.frame mapping Building Block to parent project

- simParamData:

  A data.frame mapping SimulationParameters to parent project

## Value

A list of Project with their building blocks and simulation parameters
