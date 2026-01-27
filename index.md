# OSPSuite.QualificationPlanEditor

Convert your qualification plan to Excel for easy editing, then convert
it back to a qualification plan with
[ospsuite.qualificationplaneditor](https://github.com/open-systems-pharmacology/ospsuite.qualificationplaneditor).

## Installation

You can install the development version of
[ospsuite.qualificationplaneditor](https://github.com/open-systems-pharmacology/ospsuite.qualificationplaneditor)
like this:

``` r
remotes::install_github("Open-Systems-Pharmacology/OSPSuite.QualificationPlanEditor")
```

## Example

Here is a basic example showing how to include an updated project
snapshot in your qualification plan:

``` r
## Load the ospsuite.qualificationplaneditor package
library(ospsuite.qualificationplaneditor)
ospPath <- "https://raw.githubusercontent.com/Open-Systems-Pharmacology"
excelQualification <- "Updated-Qualification.xlsx"

# List your updated snapshot projects
snapshotPaths <- list(
  "Compound A" = file.path(ospPath, "A-Model/vX.X/A-Model.json"),
  "Compound B" = file.path(ospPath, "B-Model/vX.X/B-Model.json"),
  "A-B-DDI" = file.path(ospPath, "A-B-DDI/vX.X/A-B-DDI.json")
)

# List your updated observed datasets
observedDataPaths <- list("DDI Ratios" = list(
    Path = file.path(ospPath, "Database-for-observed-data/vX.X/DDI.csv"),
    Type = "DDIRatio"
    ))

# Initial qualification plan
qualificationPlan <- file.path(ospPath, "A-Model/vY.Y/Qualification/qualification_plan.json")

# Qualification plan converted to Excel
excelUI(
  fileName = excelQualification,
  snapshotPaths = snapshotPaths, 
  observedDataPaths = observedDataPaths,
  qualificationPlan = qualificationPlan
)

# Tip: this will open Excel (or Libre office) with the created Excel workbook
utils::browseURL(excelQualification)
```

## Code of conduct

Everyone interacting in the Open Systems Pharmacology community
(codebases, issue trackers, chat rooms, mailing lists etc.) is expected
to follow the Open Systems Pharmacology [code of
conduct](https://github.com/Open-Systems-Pharmacology/Suite/blob/master/CODE_OF_CONDUCT.md).

## Contribution 💡

We encourage contribution to the Open Systems Pharmacology community.
Before getting started please read the [contribution
guidelines](https://github.com/Open-Systems-Pharmacology/Suite/blob/master/CONTRIBUTING.md).
If you are contributing code, please be familiar with the [coding
standards](https://dev.open-systems-pharmacology.org/r-development-resources/coding_standards_r).

## License

[ospsuite.qualificationplaneditor](https://github.com/open-systems-pharmacology/ospsuite.qualificationplaneditor)
package is released under the [GPLv2
License](https://www.open-systems-pharmacology.org/OSPSuite.QualificationPlanEditor/LICENSE).

All trademarks within this document belong to their legitimate owners.
