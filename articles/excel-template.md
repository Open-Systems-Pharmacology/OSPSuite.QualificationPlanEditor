# Excel Template

``` r
library(ospsuite.qualificationplaneditor)
```

## Context

This article describes the Excel template to be edited to create or
update a qualification plan.

## Color convention

In the Excel template, many cells are filled with colors that follows
the convention defined below:

### Header

Two background colors are used for headers:

- Blue: data was found and corresponding Excel sheet was filled with
  project snapshots, observed datasets and/or qualification plan
  information
- Yellow: no data was found to fill corresponding sheet

### Table rows

- Green: project or observed dataset is not present in current
  qualification plan and assumed as to be **Added** to the qualification
- Grey: project or observed dataset is present in current qualification
  plan and  
  either not present in the list of added snapshots/observed dataset  
  or present but version/path is the same as in the qualification plan
- Yellow: project or observed dataset is present in current
  qualification plan and present in the list of added snapshots/observed
  dataset  
  while version/path is **Changed** between them

## How to edit Excel sheets

### MetaInfo

Defines the version of the Qualification Plan Schema. The value should
be formatted as `vX.Y`.

You can check version tags on GitHub in
[QualificationPlan](https://github.com/Open-Systems-Pharmacology/QualificationPlan/tags)
repository.

### Projects

List project identifiers (`Id`) and their paths. The background use the
color convention defined above.

This Excel sheet should not be edited.

### Simulations_Outputs

List simulations and outputs for each project. The background use the
color convention defined above.

This Excel sheet should not be edited.

### Simulations_ObsData

List simulations and observed data for each project. The background use
the color convention defined above.

This Excel sheet should not be edited.

### ObsData

List Observed dataset identifiers (`Id`), their paths and Type. The
background use the color convention defined above.

You can edit the Type of Observed data.

### BB

List Building Blocks potential inheritance. Fill the **Parent-Project**
column for a project to inherit the corresponding building block from a
parent project.

An Excel data validation is set up to select from available projects.

### SimParam

List Simulated Parameters potential inheritance. Fill the **Parent
Project**, **Parent Simulation**, **Path** and **Target Simulation**
columns for a project to inherit the corresponding simulated parameters
from a parent project.

Excel data validations are set up to select from available projects and
simulations.

### All_Plots

List all plots evaluations for each project and simulation.

Fill the **Section Reference** column to include the evaluation in the
corresponding section. Excel data validations are set up to select from
available sections.

### CT_Plots and CT_Mapping

Define and list Comparison Time Profile (CT) plots.

Excel data validations are set up to select from available sections,
projects, simulations, observed data, etc.

### GOF_Plots and GOF_Mapping

Define and list Goodness of Fit (GOF) plots.

Excel data validations are set up to select from available sections,
projects, simulations, observed data, etc.

### DDIRatio_Plots and DDIRatio_Mapping

Define and list DDI Ratio plots.

Excel data validations are set up to select from available sections,
projects, simulations, observed data, etc.

### PKRatio_Plots and PKRatio_Mapping

Define and list PK Ratio plots.

Excel data validations are set up to select from available sections,
projects, simulations, observed data, etc.

### Sections

Define and list Qualification Report sections.

Fill **Section Reference** tag to identify a section. If section is a
sub-section, fill the **Parent Section** column, Excel data validations
are set up to select from available sections.

### Intro

Define the path of the markdown file used as introduction of your
qualification report.

### Inputs

Fill the **Project**, **BB-Type**, **BB-Name** and **Section Reference**
to include the Building Block definitions into the corresponding section
of your qualification report. Excel data validations are set up to
select from available building blocks and sections.

### GlobalPlotSettings

Define the global settings of the exported figures including the size of
the figure in pixels.

### GlobalAxesSettings

Define the global axes settings of the exported figures corresponding to
dimensions, units and scales of the plots.

### Lookup

Look up table defining allowed values for qualification plan properties.
