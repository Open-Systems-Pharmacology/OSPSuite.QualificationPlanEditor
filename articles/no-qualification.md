# Snapshot without a Qualification Plan

``` r
library(ospsuite.qualificationplaneditor)
```

## Context

This article shows how to create a Qualification Plan from scratch using
a project snapshot. The example used here is the
[Verapamil-Model](https://github.com/Open-Systems-Pharmacology/Verapamil-Model)
available on GitHub.

``` r
snapshotPaths <- "Verapamil-Model.json"
qualificationPlan <- "qualification-verapamil.json"
excelFile <- "qualification-verapamil.xlsx"
```

## Conversion to Excel

In order to assess and edit the qualification plan, the function
[`toExcelEditor()`](https://www.open-systems-pharmacology.org/OSPSuite.QualificationPlanEditor/reference/toExcelEditor.md)
will convert it into Excel format as illustrated below.

``` r
toExcelEditor(
  fileName = excelFile, 
  snapshotPaths = snapshotPaths
  )
#> 
#> ── Exporting to Excel Editor ───────────────────────────────────────────────────
#> ℹ Copying Excel Template to qualification-verapamil.xlsx
#> ✔ Copying Excel Template to qualification-verapamil.xlsx [187ms]
#> 
#> ℹ Checking for Qualification Plan
#> ℹ No Qualification Plan input
#> ℹ Checking for Qualification Plan✔ Checking for Qualification Plan [29ms]
#> 
#> ℹ Exporting Projects Data
#> ✔ Exporting Projects Data [58ms]
#> 
#> ℹ Exporting Simulation Outputs Data
#> ✔ Exporting Simulation Outputs Data [262ms]
#> 
#> ℹ Exporting Simulation Observed Data
#> ✔ Exporting Simulation Observed Data [120ms]
#> 
#> ℹ Exporting Observed Data
#> ✔ Exporting Observed Data [29ms]
#> 
#> ℹ Exporting Building Block Data
#> 
#> ℹ Exporting Building Block Data── Qualification Plan ──
#> ℹ Exporting Building Block Data
#> ℹ Exporting Building Block Data✔ Exporting Building Block Data [105ms]
#> 
#> ℹ Exporting Schema Data
#> ✔ Exporting Schema Data [286ms]
#> 
#> ℹ Exporting Sections
#> ✔ Exporting Sections [18ms]
#> 
#> ℹ Exporting Intro and Inputs
#> ✔ Exporting Intro and Inputs [19ms]
#> 
#> ℹ Exporting Simulation Parameters Settings
#> ✔ Exporting Simulation Parameters Settings [19ms]
#> 
#> ℹ Exporting All Plots Settings
#> ✔ Exporting All Plots Settings [29ms]
#> 
#> ℹ Exporting Comparison Time Profile Plot Settings
#> ✔ Exporting Comparison Time Profile Plot Settings [33ms]
#> 
#> ℹ Exporting GOF Merged Plot Settings
#> ✔ Exporting GOF Merged Plot Settings [28ms]
#> 
#> ℹ Exporting DDI Ratio Plot Settings
#> ✔ Exporting DDI Ratio Plot Settings [45ms]
#> 
#> ℹ Exporting Global Plot Settings
#> ✔ Exporting Global Plot Settings [21ms]
#> 
#> ℹ Exporting Global Axes Settings
#> ✔ Exporting Global Axes Settings [23ms]
#> 
#> ℹ Saving extracted data into qualification-verapamil.xlsx
#> ✔ Saving extracted data into qualification-verapamil.xlsx [386ms]
```

Users can then open and edit the Excel file converted from the
Qualification Plan. The code below will open the file using the default
software reading `xlsx` files (such as Excel or Libre Office Calc).

``` r
utils::browseURL(excelFile)
```

The Excel file should include the content displayed below:

## Excel Content

- MetaInfo
- Projects
- Simulations_Outputs
- Simulations_ObsData
- ObsData
- BB
- SimParam
- All_Plots
- CT_Plots
- CT_Mapping
- GOF_Plots
- GOF_Mapping
- DDIRatio_Plots
- DDIRatio_Mapping
- PKRatio_Plots
- PKRatio_Mapping
- Sections
- Intro
- Inputs
- GlobalPlotSettings
- GlobalAxesSettings
- Lookup

| Qualification.plan.schema.version |
|:----------------------------------|
| v3.5                              |

| Id        | Path                 |
|:----------|:---------------------|
| Verapamil | Verapamil-Model.json |

| Project   | Simulation                                                             | Output                                                                                             |
|:----------|:-----------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------|
| Verapamil | iv_R-Verapamil 50 mg (5 min), Eichelbaum 1984, n=1                     | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | iv_R-Verapamil 50 mg (5 min), Eichelbaum 1984, n=1                     | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | iv_R-Verapamil 50 mg (5 min), Eichelbaum 1984, n=1                     | Organism\|Kidney\|Urine\|R-Verapamil\|Fraction excreted to urine                                   |
| Verapamil | iv_R-Verapamil 50 mg (5 min), Eichelbaum 1984, n=1                     | Organism\|Lumen\|Feces\|R-Verapamil\|Fraction excreted to feces                                    |
| Verapamil | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       | Organism\|Kidney\|Urine\|R-Verapamil\|Fraction excreted to urine                                   |
| Verapamil | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       | Organism\|Kidney\|Urine\|S-Verapamil\|Fraction excreted to urine                                   |
| Verapamil | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       | Organism\|Lumen\|Feces\|R-Verapamil\|Fraction excreted to feces                                    |
| Verapamil | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       | Organism\|Lumen\|Feces\|S-Verapamil\|Fraction excreted to feces                                    |
| Verapamil | po_Verapamil 16 mg SD (sol), Maeda 2011, n=8                           | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 16 mg SD (sol), Maeda 2011, n=8                           | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 16 mg SD (sol), Maeda 2011, n=8                           | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 16 mg SD (sol), Maeda 2011, n=8                           | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 16 mg SD (sol), Maeda 2011, n=8                           | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | po_Verapamil 16 mg SD (sol), Maeda 2011, n=8                           | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | po_Verapamil 240 mg QD (SR), Blume, Mutschler 1994, n=24               | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 240 mg QD (SR), Blume, Mutschler 1994, n=24               | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 240 mg QD (SR), Blume, Mutschler 1994, n=24               | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 240 mg QD (SR), Blume, Mutschler 1994, n=24               | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 240 mg QD (SR), Blume, Mutschler 1994, n=24               | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | po_Verapamil 240 mg QD (SR), Blume, Mutschler 1994, n=24               | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | po_Verapamil 120 mg SD, Johnston 1981, n=6                             | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 120 mg SD, Johnston 1981, n=6                             | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 120 mg SD, Johnston 1981, n=6                             | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 120 mg SD, Johnston 1981, n=6                             | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 120 mg SD, Johnston 1981, n=6                             | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | po_Verapamil 120 mg SD, Johnston 1981, n=6                             | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | po_Verapamil 120 mg SD, Johnston 1981, n=6                             | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | po_Verapamil 120 mg SD, Johnston 1981, n=6                             | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | po_Verapamil 120 mg SD, Johnston 1981, n=6                             | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | po_Verapamil 120 mg SD, Johnston 1981, n=6                             | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | po_Verapamil 120mg SD, Abernethy 1985, n=1                             | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 120mg SD, Abernethy 1985, n=1                             | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 120mg SD, Abernethy 1985, n=1                             | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 120mg SD, Abernethy 1985, n=1                             | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 120mg SD, Abernethy 1985, n=1                             | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | po_Verapamil 120mg SD, Abernethy 1985, n=1                             | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | po_Verapamil 120mg SD, Abernethy 1985, n=1                             | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | po_Verapamil 120mg SD, Abernethy 1985, n=1                             | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | po_Verapamil 120mg SD, Abernethy 1985, n=1                             | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | po_Verapamil 120mg SD, Abernethy 1985, n=1                             | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | po_R-Verapamil 250mg SD, Vogelgesang 1984, n=1                         | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_R-Verapamil 250mg SD, Vogelgesang 1984, n=1                         | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_R-Verapamil 250mg SD, Vogelgesang 1984, n=1                         | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | po_R-Verapamil 250mg SD, Vogelgesang 1984, n=1                         | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | po_Verapamil 0.1 mg SD (sol), Maeda 2011, n=8                          | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 0.1 mg SD (sol), Maeda 2011, n=8                          | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 0.1 mg SD (sol), Maeda 2011, n=8                          | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 0.1 mg SD (sol), Maeda 2011, n=8                          | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 0.1 mg SD (sol), Maeda 2011, n=8                          | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | po_Verapamil 0.1 mg SD (sol), Maeda 2011, n=8                          | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | po_Verapamil 3 mg SD (sol), Maeda 2011, n=8                            | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 3 mg SD (sol), Maeda 2011, n=8                            | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 3 mg SD (sol), Maeda 2011, n=8                            | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 3 mg SD (sol), Maeda 2011, n=8                            | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 3 mg SD (sol), Maeda 2011, n=8                            | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | po_Verapamil 3 mg SD (sol), Maeda 2011, n=8                            | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | po_Verapamil 80 mg SD (sol), Maeda 2011, n=8                           | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 80 mg SD (sol), Maeda 2011, n=8                           | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 80 mg SD (sol), Maeda 2011, n=8                           | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 80 mg SD (sol), Maeda 2011, n=8                           | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 80 mg SD (sol), Maeda 2011, n=8                           | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | po_Verapamil 80 mg SD (sol), Maeda 2011, n=8                           | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | po_Verapamil 40 mg SD, John 1992, n=6                                  | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 40 mg SD, John 1992, n=6                                  | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 40 mg SD, John 1992, n=6                                  | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 40 mg SD, John 1992, n=6                                  | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 40 mg SD, John 1992, n=6                                  | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | po_Verapamil 40 mg SD, John 1992, n=6                                  | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | po_Verapamil 40 mg SD, John 1992, n=6                                  | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | po_Verapamil 40 mg SD, John 1992, n=6                                  | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | po_Verapamil 40 mg SD, John 1992, n=6                                  | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | po_Verapamil 40 mg SD, John 1992, n=6                                  | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | po_Verapamil 60 mg SD, Choi 2008, n=12                                 | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 60 mg SD, Choi 2008, n=12                                 | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 60 mg SD, Choi 2008, n=12                                 | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 60 mg SD, Choi 2008, n=12                                 | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 60 mg SD, Choi 2008, n=12                                 | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | po_Verapamil 60 mg SD, Choi 2008, n=12                                 | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | po_Verapamil 60 mg SD, Choi 2008, n=12                                 | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | po_Verapamil 60 mg SD, Choi 2008, n=12                                 | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | po_Verapamil 60 mg SD, Choi 2008, n=12                                 | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | po_Verapamil 60 mg SD, Choi 2008, n=12                                 | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                | Organism\|Kidney\|Urine\|R-Verapamil\|Fraction excreted to urine                                   |
| Verapamil | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                | Organism\|Kidney\|Urine\|S-Verapamil\|Fraction excreted to urine                                   |
| Verapamil | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                | Organism\|Lumen\|Feces\|R-Verapamil\|Fraction excreted to feces                                    |
| Verapamil | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                | Organism\|Lumen\|Feces\|S-Verapamil\|Fraction excreted to feces                                    |
| Verapamil | po_Verapamil 120 mg SD, Hla 1987, n=10                                 | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 120 mg SD, Hla 1987, n=10                                 | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 120 mg SD, Hla 1987, n=10                                 | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 120 mg SD, Hla 1987, n=10                                 | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 120 mg SD, Hla 1987, n=10                                 | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | po_Verapamil 120 mg SD, Hla 1987, n=10                                 | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | po_Verapamil 120 mg MD, Hla 1987, n=10                                 | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 120 mg MD, Hla 1987, n=10                                 | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 120 mg MD, Hla 1987, n=10                                 | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 120 mg MD, Hla 1987, n=10                                 | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 120 mg MD, Hla 1987, n=10                                 | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | po_Verapamil 120 mg MD, Hla 1987, n=10                                 | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | iv_R-Verapamil 5 mg (5 min), Eichelbaum 1984, n=1                      | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | iv_R-Verapamil 5 mg (5 min), Eichelbaum 1984, n=1                      | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | iv_R-Verapamil 5 mg (5 min), Eichelbaum 1984, n=1                      | Organism\|Kidney\|Urine\|R-Verapamil\|Fraction excreted to urine                                   |
| Verapamil | iv_R-Verapamil 5 mg (5 min), Eichelbaum 1984, n=1                      | Organism\|Lumen\|Feces\|R-Verapamil\|Fraction excreted to feces                                    |
| Verapamil | iv_R-Verapamil 25 mg (5 min), Eichelbaum 1984, n=1                     | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | iv_R-Verapamil 25 mg (5 min), Eichelbaum 1984, n=1                     | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | iv_R-Verapamil 25 mg (5 min), Eichelbaum 1984, n=1                     | Organism\|Kidney\|Urine\|R-Verapamil\|Fraction excreted to urine                                   |
| Verapamil | iv_R-Verapamil 25 mg (5 min), Eichelbaum 1984, n=1                     | Organism\|Lumen\|Feces\|R-Verapamil\|Fraction excreted to feces                                    |
| Verapamil | iv_S-Verapamil 5 mg SD (5min), Eichelbaum 1984, n=1                    | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | iv_S-Verapamil 5 mg SD (5min), Eichelbaum 1984, n=1                    | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | iv_S-Verapamil 5 mg SD (5min), Eichelbaum 1984, n=1                    | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | iv_S-Verapamil 5 mg SD (5min), Eichelbaum 1984, n=1                    | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | iv_S-Verapamil 7.5 mg SD (5min), Eichelbaum 1984, n=1                  | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | iv_S-Verapamil 7.5 mg SD (5min), Eichelbaum 1984, n=1                  | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | iv_S-Verapamil 7.5 mg SD (5min), Eichelbaum 1984, n=1                  | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | iv_S-Verapamil 7.5 mg SD (5min), Eichelbaum 1984, n=1                  | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | iv_S-Verapamil 10 mg SD (5min), Eichelbaum 1984, n=1                   | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | iv_S-Verapamil 10 mg SD (5min), Eichelbaum 1984, n=1                   | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | iv_S-Verapamil 10 mg SD (5min), Eichelbaum 1984, n=1                   | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | iv_S-Verapamil 10 mg SD (5min), Eichelbaum 1984, n=1                   | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | po_Verapamil 240 mg SD, Karim 1995, n=12                               | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 240 mg SD, Karim 1995, n=12                               | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 240 mg SD, Karim 1995, n=12                               | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 240 mg SD, Karim 1995, n=12                               | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 240 mg SD, Karim 1995, n=12                               | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | po_Verapamil 240 mg SD, Karim 1995, n=12                               | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | po_Verapamil 240 mg SD, Karim 1995, n=12                               | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | po_Verapamil 240 mg SD, Karim 1995, n=12                               | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | po_Verapamil 240 mg SD, Karim 1995, n=12                               | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | po_Verapamil 240 mg SD, Karim 1995, n=12                               | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | iv_Verapamil 10 mg (bol), Smith 1984, n=8                              | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | iv_Verapamil 10 mg (bol), Smith 1984, n=8                              | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | iv_Verapamil 10 mg (bol), Smith 1984, n=8                              | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | iv_Verapamil 10 mg (bol), Smith 1984, n=8                              | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | iv_Verapamil 10 mg (bol), Smith 1984, n=8                              | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | iv_Verapamil 10 mg (bol), Smith 1984, n=8                              | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | po_Verapamil 120 mg SD, Smith 1984, n=8                                | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 120 mg SD, Smith 1984, n=8                                | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 120 mg SD, Smith 1984, n=8                                | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 120 mg SD, Smith 1984, n=8                                | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 120 mg SD, Smith 1984, n=8                                | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | po_Verapamil 120 mg SD, Smith 1984, n=8                                | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | po_Verapamil 80mg SD, Wing 1985, n=1                                   | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 80mg SD, Wing 1985, n=1                                   | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 80mg SD, Wing 1985, n=1                                   | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 80mg SD, Wing 1985, n=1                                   | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 80mg SD, Wing 1985, n=1                                   | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | po_Verapamil 80mg SD, Wing 1985, n=1                                   | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | po_Verapamil 80mg SD, Wing 1985, n=1                                   | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | po_Verapamil 80mg SD, Wing 1985, n=1                                   | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | po_Verapamil 80mg SD, Wing 1985, n=1                                   | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | po_Verapamil 80mg SD, Wing 1985, n=1                                   | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil | po_Verapamil 160 mg SD, Mikus 1990, n=1                                | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 160 mg SD, Mikus 1990, n=1                                | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 160 mg SD, Mikus 1990, n=1                                | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil | po_Verapamil 160 mg SD, Mikus 1990, n=1                                | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil | po_Verapamil 160 mg SD, Mikus 1990, n=1                                | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil | po_Verapamil 160 mg SD, Mikus 1990, n=1                                | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil | po_Verapamil 160 mg SD, Mikus 1990, n=1                                | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil | po_Verapamil 160 mg SD, Mikus 1990, n=1                                | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil | po_Verapamil 160 mg SD, Mikus 1990, n=1                                | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil | po_Verapamil 160 mg SD, Mikus 1990, n=1                                | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |

| Project   | Simulation                                                             | ObservedData                                                                                                                  |
|:----------|:-----------------------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------|
| Verapamil | iv_R-Verapamil 50 mg (5 min), Eichelbaum 1984, n=1                     | Eichelbaum 1984 - Subject 4 - R-Verapamil - IV - 50 mg - Plasma - indiv.                                                      |
| Verapamil | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       | Härtter et al. 2012 - 120mg po SD - R-Norverapamil - PO - 120 mg - Plasma - agg. (n=19)                                       |
| Verapamil | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       | Härtter et al. 2012 - 120mg po SD - R-Verapamil - PO - 120 mg - Plasma - agg. (n=19)                                          |
| Verapamil | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       | Härtter et al. 2012 - 120mg po SD - S-Norverapamil - PO - 120 mg - Plasma - agg. (n=19)                                       |
| Verapamil | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       | Härtter et al. 2012 - 120mg po SD - S-Verapamil - PO - 120 mg - Plasma - agg. (n=19)                                          |
| Verapamil | po_Verapamil 16 mg SD (sol), Maeda 2011, n=8                           | Maeda 2011 - Verapamil 16 mg - Verapamil - PO - 16 mg - Plasma - agg. (n=8)                                                   |
| Verapamil | po_Verapamil 16 mg SD (sol), Maeda 2011, n=8                           | Maeda 2011 - Verapamil 16 mg - Norverapamil - Norverapamil - PO - 16 mg - Plasma - agg. (n=8)                                 |
| Verapamil | po_Verapamil 240 mg QD (SR), Blume, Mutschler 1994, n=24               | Blume, Mutschler 1994 - Verapamil - Verapamil - PO - 240 mg - Plasma - agg. (n=24)                                            |
| Verapamil | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            | Mooy et al. 1985 - Normal volunteers, 3mg IV - Verapamil - IV - 3 mg - Plasma - agg. (n=5)                                    |
| Verapamil | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  | Mooy et al. 1985 - Normal volunteers, 80mg PO - Verapamil - PO - 80 mg - Plasma - agg. (n=6)                                  |
| Verapamil | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  | Mooy et al. 1985 - Normal volunteers, 80mg PO - Norverapamil - PO - 80 mg - Plasma - agg. (n=6)                               |
| Verapamil | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         | Streit 2005 - intravenous verapamil during normoxia (5 mg) - Verapamil - IV - 5 mg - Plasma - agg. (n=10)                     |
| Verapamil | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         | Streit et al. 2005 - intravenous verapamil during normoxia (5 mg) - Norverapamil - IV - 5 mg - Plasma - agg. (n=10)           |
| Verapamil | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   | Johnston 1981 - Verapamil IV - Verapamil - IV - 0.1 mg/kg - Plasma - agg. (n=6)                                               |
| Verapamil | po_Verapamil 120 mg SD, Johnston 1981, n=6                             | Johnston 1981 - Verapamil PO - Verapamil - PO - 120 mg - Plasma - agg. (n=6)                                                  |
| Verapamil | po_Verapamil 120 mg SD, Johnston 1981, n=6                             | Johnston 1981 - Verapamil PO - Norverapamil - PO - 120 mg - Plasma - agg. (n=6)                                               |
| Verapamil | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      | Abernethy et al. 1985 - 10mg Verapamil without cimetidine, IV - Verapamil - IV - 10 mg - Plasma - indiv.                      |
| Verapamil | po_Verapamil 120mg SD, Abernethy 1985, n=1                             | Abernethy et al. 1985 - 120mg Verapamil without cimetidine, PO - Verapamil - PO - 120 mg - Plasma - indiv.                    |
| Verapamil | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      | Barbarash 1988 - Verapamil IV control - Verapamil - IV - 10 mg - Serum - agg. (n=6)                                           |
| Verapamil | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            | Barbarash 1988 - Verapamil PO control - Verapamil - PO - 120 mg - Serum - agg. (n=6)                                          |
| Verapamil | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            | McAllister 1982 - Verapamil 10 mg IV - Verapamil - IV - 10 mg - Plasma - agg. (n=20)                                          |
| Verapamil | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    | Freedman et al. 1981 - Control Subject (Subject number 4) - Verapamil - IV - 13.1 mg - Plasma - indiv.                        |
| Verapamil | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | Abernethy et al. 1993 - Representative younger subject - R-Verapamil - IV - 20 mg - Plasma - indiv.                           |
| Verapamil | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | Abernethy et al. 1993 - Representative younger subject - S-Verapamil - IV - 20 mg - Plasma - indiv.                           |
| Verapamil | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | Abernethy et al. 1993 - Representative younger subject - Verapamil - IV - 20 mg - Plasma - indiv.                             |
| Verapamil | po_R-Verapamil 250mg SD, Vogelgesang 1984, n=1                         | Vogelgesang et al. 1984 - Healthy volunteers - R-Verapamil - PO - 250 mg - Plasma - indiv.                                    |
| Verapamil | po_Verapamil 0.1 mg SD (sol), Maeda 2011, n=8                          | Maeda 2011 - Verapamil 0.1 mg - Norverapamil - Norverapamil - PO - 0.1 mg - Plasma - agg. (n=8)                               |
| Verapamil | po_Verapamil 0.1 mg SD (sol), Maeda 2011, n=8                          | Maeda 2011 - Verapamil 0.1 mg - Verapamil - PO - 0.1 mg - Plasma - agg. (n=8)                                                 |
| Verapamil | po_Verapamil 3 mg SD (sol), Maeda 2011, n=8                            | Maeda 2011 - Verapamil 3 mg - Verapamil - PO - 3 mg - Plasma - agg. (n=8)                                                     |
| Verapamil | po_Verapamil 3 mg SD (sol), Maeda 2011, n=8                            | Maeda 2011 - Verapamil 3 mg - Norverapamil - Norverapamil - PO - 3 mg - Plasma - agg. (n=8)                                   |
| Verapamil | po_Verapamil 80 mg SD (sol), Maeda 2011, n=8                           | Maeda 2011 - Verapamil 80 mg - Verapamil - PO - 80 mg - Plasma - agg. (n=8)                                                   |
| Verapamil | po_Verapamil 80 mg SD (sol), Maeda 2011, n=8                           | Maeda 2011 - Verapamil 80 mg - Norverapamil - Norverapamil - PO - 80 mg - Plasma - agg. (n=8)                                 |
| Verapamil | po_Verapamil 40 mg SD, John 1992, n=6                                  | John et al. 1992 - Healthy volunteers - Verapamil - PO - 40 mg - Plasma - agg. (n=6)                                          |
| Verapamil | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     | Sawicki, Janicki 2002 - Healthy volunteers; conventional tablets - Norverapamil - PO - 40 mg - Plasma - agg. (n=12)           |
| Verapamil | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     | Sawicki, Janicki 2002 - Healthy volunteers; conventional tablets - Verapamil - PO - 40 mg - Plasma - agg. (n=12)              |
| Verapamil | po_Verapamil 60 mg SD, Choi 2008, n=12                                 | Choi et al. 2008 - 60mg Verapamil in absence of oral atorvastatin - Verapamil - PO - 60 mg - Arterial Plasma - agg. (n=12)    |
| Verapamil | po_Verapamil 60 mg SD, Choi 2008, n=12                                 | Choi et al. 2008 - 60mg Verapamil in absence of oral atorvastatin - Norverapamil - PO - 60 mg - Arterial Plasma - agg. (n=12) |
| Verapamil | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           | Ratiopharm 1988 - Unknown - Verapamil - PO - 80 mg - Plasma - agg. (n=16)                                                     |
| Verapamil | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           | Ratiopharm 1988 - Unknown - Norverapamil - PO - 80 mg - Plasma - agg. (n=16)                                                  |
| Verapamil | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              | Ratiopharm 1989 - Unknown - Norverapamil - PO - 80 mg - Plasma - agg. (n=16)                                                  |
| Verapamil | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              | Ratiopharm 1989 - Unknown - Verapamil - PO - 80 mg - Plasma - agg. (n=16)                                                     |
| Verapamil | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        | Johnson 2001 - Verapamil Steady State - Verapamil - PO - 80 mg - Plasma - agg. (n=12)                                         |
| Verapamil | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        | Johnson 2001 - Verapamil Steady State - Norverapamil - PO - 80 mg - Plasma - agg. (n=12)                                      |
| Verapamil | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | Boehringer 2018 - Unknown - R-Norverapamil - PO - 120 mg - Plasma - agg. (n=12)                                               |
| Verapamil | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | Boehringer 2018 - Unknown - R-Verapamil - PO - 120 mg - Plasma - agg. (n=12)                                                  |
| Verapamil | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | Boehringer 2018 - Unknown - S-Norverapamil - PO - 120 mg - Plasma - agg. (n=12)                                               |
| Verapamil | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | Boehringer 2018 - Unknown - S-Verapamil - PO - 120 mg - Plasma - agg. (n=12)                                                  |
| Verapamil | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                | Härtter et al. 2012 - 120mg po bid - R-Norverapamil - PO - 120 mg - Plasma - agg. (n=20)                                      |
| Verapamil | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                | Härtter et al. 2012 - 120mg po bid - R-Verapamil - PO - 120 mg - Plasma - agg. (n=20)                                         |
| Verapamil | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                | Härtter et al. 2012 - 120mg po bid - S-Norverapamil - PO - 120 mg - Plasma - agg. (n=20)                                      |
| Verapamil | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                | Härtter et al. 2012 - 120mg po bid - S-Verapamil - PO - 120 mg - Plasma - agg. (n=20)                                         |
| Verapamil | po_Verapamil 120 mg SD, Hla 1987, n=10                                 | Hla 1987 - conventional Verapamil 120mg once daily (day 1) - Verapamil - PO - 120 mg - Plasma - agg. (n=10)                   |
| Verapamil | po_Verapamil 120 mg MD, Hla 1987, n=10                                 | Hla 1987 - conventional Verapamil 120mg twice daily (day 10) - Verapamil - PO - 120 mg - Plasma - agg. (n=10)                 |
| Verapamil | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  | van Haarst et al. 2009 - Verapamil only - Norverapamil - PO - 180 mg - Plasma - agg. (n=10)                                   |
| Verapamil | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  | van Haarst et al. 2009 - Verapamil only - Verapamil - PO - 180 mg - Plasma - agg. (n=10)                                      |
| Verapamil | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     | Blume, Mutschler 1989 - Verapamil - Verapamil - PO - 80 mg - Plasma - agg. (n=18)                                             |
| Verapamil | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    | Blume, Mutschler 1987 - Verapamil - Verapamil - PO - 120 mg - Plasma - agg. (n=12)                                            |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     | Blume, Mutschler 1990 - Verapamil - Verapamil - PO - 40 mg - Plasma - agg. (n=24)                                             |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     | Blume, Mutschler 1983 - Verapamil - Verapamil - PO - 40 mg - Plasma - agg. (n=12)                                             |
| Verapamil | iv_R-Verapamil 5 mg (5 min), Eichelbaum 1984, n=1                      | Eichelbaum 1984 - Subject 4 - R-Verapamil - IV - 5 mg - Plasma - indiv.                                                       |
| Verapamil | iv_R-Verapamil 25 mg (5 min), Eichelbaum 1984, n=1                     | Eichelbaum 1984 - Subject 4 - R-Verapamil - IV - 25 mg - Plasma - indiv.                                                      |
| Verapamil | iv_S-Verapamil 5 mg SD (5min), Eichelbaum 1984, n=1                    | Eichelbaum 1984 - Subject 4 - S-Verapamil - IV - 5 mg - Plasma - indiv.                                                       |
| Verapamil | iv_S-Verapamil 7.5 mg SD (5min), Eichelbaum 1984, n=1                  | Eichelbaum 1984 - Subject 4 - S-Verapamil - IV - 7.5 mg - Plasma - indiv.                                                     |
| Verapamil | iv_S-Verapamil 10 mg SD (5min), Eichelbaum 1984, n=1                   | Eichelbaum 1984 - Subject 4 - S-Verapamil - IV - 10 mg - Plasma - indiv.                                                      |
| Verapamil | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       | Backman 1994 - Verapamil - Verapamil - PO - 80 mg - Plasma - agg. (n=9)                                                       |
| Verapamil | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   | McAllister 1982 - Verapamil 80 mg PO - Verapamil - PO - 80 mg - Plasma - agg. (n=20)                                          |
| Verapamil | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  | McAllister 1982 - Verapamil 120 mg PO - Verapamil - PO - 120 mg - Plasma - agg. (n=20)                                        |
| Verapamil | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  | McAllister 1982 - Verapamil 160 mg PO - Verapamil - PO - 160 mg - Plasma - agg. (n=20)                                        |
| Verapamil | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  | Jorgensen 1988 - Conventional Verapamil 120 mg BID (day 8) - Verapamil - PO - 120 mg - Plasma - agg. (n=12)                   |
| Verapamil | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  | Jorgensen 1988 - Conventional Verapamil 120 mg BID (day 1 - 5 and 8) - Verapamil - PO - 120 mg - Plasma - agg. (n=12)         |
| Verapamil | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 | Jorgensen 1988 - Sustained release Verapamil 240 mg OD (day 8) - Verapamil - PO - 240 mg - Plasma - agg. (n=12)               |
| Verapamil | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 | Jorgensen 1988 - Sustained release Verapamil 240 mg OD (day 1 - 5 and 8) - Verapamil - PO - 240 mg - Plasma - agg. (n=12)     |
| Verapamil | po_Verapamil 240 mg SD, Karim 1995, n=12                               | Karim 1995 - Verapamil total IR fasting - Verapamil - PO - 240 mg - Plasma - agg. (n=12)                                      |
| Verapamil | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        | Shand 1981 - Verapamil day 1 - Verapamil - PO - 120 mg - Plasma - agg. (n=6)                                                  |
| Verapamil | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        | Shand 1981 - Verapamil day 3 (after 7th dose) - Verapamil - PO - 120 mg - Plasma - agg. (n=6)                                 |
| Verapamil | iv_Verapamil 10 mg (bol), Smith 1984, n=8                              | Smith 1984 - IV 10 mg Verapamil control - Verapamil - IV - 10 mg - Plasma - agg. (n=8)                                        |
| Verapamil | po_Verapamil 120 mg SD, Smith 1984, n=8                                | Smith 1984 - PO 120 mg Verapamil control - Verapamil - PO - 120 mg - Plasma - agg. (n=8)                                      |
| Verapamil | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           | Wing et al. 1985 - 10mg Verapamil without cimetidine, IV - Verapamil - IV - 10 mg - Plasma - indiv.                           |
| Verapamil | po_Verapamil 80mg SD, Wing 1985, n=1                                   | Wing et al. 1985 - 80mg Verapamil without cimetidine, PO - Verapamil - PO - 80 mg - Plasma - indiv.                           |
| Verapamil | po_Verapamil 160 mg SD, Mikus 1990, n=1                                | Mikus et al. 1990 - 160mg verapamil without cimetidine, PO - R-Verapamil - PO - 160 mg - Plasma - indiv.                      |
| Verapamil | po_Verapamil 160 mg SD, Mikus 1990, n=1                                | Mikus et al. 1990 - 160mg verapamil without cimetidine, PO - S-Verapamil - PO - 160 mg - Plasma - indiv.                      |

| Id  | Path | Type |
|-----|------|------|

| Project   | BB-Type     | BB-Name                                                       | Parent-Project |
|:----------|:------------|:--------------------------------------------------------------|---------------:|
| Verapamil | Individual  | Härtter 2012 SD, n=19                                         |                |
| Verapamil | Individual  | Eichelbaum 1984, n=1                                          |                |
| Verapamil | Individual  | Smith 1984, n=8                                               |                |
| Verapamil | Individual  | Blume, Mutschler 1994, n=24                                   |                |
| Verapamil | Individual  | Maeda 2011, n=8                                               |                |
| Verapamil | Individual  | Wing 1985, n=1                                                |                |
| Verapamil | Individual  | McAllister, Kirsten 1982, n=20                                |                |
| Verapamil | Individual  | Freedman 1981, n=1                                            |                |
| Verapamil | Individual  | Abernethy 1993, n=1                                           |                |
| Verapamil | Individual  | Vogelgesang 1984, n=1                                         |                |
| Verapamil | Individual  | John 1992, n=6                                                |                |
| Verapamil | Individual  | Sawicki, Janicki 2002, n=12                                   |                |
| Verapamil | Individual  | Choi 2008, n=12                                               |                |
| Verapamil | Individual  | Ratiopharm 1988, n=16                                         |                |
| Verapamil | Individual  | Ratiopharm 1989, n=16                                         |                |
| Verapamil | Individual  | Johnson 2001, n=12                                            |                |
| Verapamil | Individual  | Boehringer 2018, n=12                                         |                |
| Verapamil | Individual  | Härtter 2012 MD, n=20                                         |                |
| Verapamil | Individual  | Hla 1987, n=10                                                |                |
| Verapamil | Individual  | Mikus 1990, n=1                                               |                |
| Verapamil | Individual  | van Haarst 2009, n=10                                         |                |
| Verapamil | Individual  | Blume, Mutschler 1983, n=12                                   |                |
| Verapamil | Individual  | Blume, Mutschler 1990, n=24                                   |                |
| Verapamil | Individual  | Blume, Mutschler 1989, n=18                                   |                |
| Verapamil | Individual  | Blume, Mutschler 1987, n=12                                   |                |
| Verapamil | Individual  | Barbarash 1988, n=6                                           |                |
| Verapamil | Individual  | Abernethy 1985, n=1                                           |                |
| Verapamil | Individual  | Johnston 1981, n=6                                            |                |
| Verapamil | Individual  | Mooy 1985, n=5                                                |                |
| Verapamil | Individual  | Streit 2005, n=10                                             |                |
| Verapamil | Individual  | Backman 1994                                                  |                |
| Verapamil | Individual  | Jorgensen 1988, n = 12                                        |                |
| Verapamil | Individual  | Karim 1995, n = 12                                            |                |
| Verapamil | Individual  | Shand 1981, n = 6                                             |                |
| Verapamil | Compound    | R-Verapamil                                                   |                |
| Verapamil | Compound    | S-Verapamil                                                   |                |
| Verapamil | Compound    | R-Norverapamil                                                |                |
| Verapamil | Compound    | S-Norverapamil                                                |                |
| Verapamil | Compound    | Sum-Verapamil                                                 |                |
| Verapamil | Compound    | Sum-Norverapamil                                              |                |
| Verapamil | Protocol    | Härtter 2012, Verapamil 120 mg SD, R-Vera                     |                |
| Verapamil | Protocol    | Härtter 2012, Verapamil 120 mg SD, S-Vera                     |                |
| Verapamil | Protocol    | Eichelbaum 1984, R-Verapamil 50 mg iv (5 min)                 |                |
| Verapamil | Protocol    | Maeda 2011, Verapamil 16 mg po SD (sol), R-Vera               |                |
| Verapamil | Protocol    | Maeda 2011, Verapamil 16 mg po SD (sol), S-Vera               |                |
| Verapamil | Protocol    | Blume, Mutschler 1994, 240 mg po QD (SR), R-Vera              |                |
| Verapamil | Protocol    | Blume, Mutschler 1994, 240 mg po QD (SR), S-Vera              |                |
| Verapamil | Protocol    | Smith 1984, Verapamil 10 mg iv (bol), R-Vera                  |                |
| Verapamil | Protocol    | Smith 1984, Verapamil 10 mg iv (bol), S-Vera                  |                |
| Verapamil | Protocol    | Mooy 1985, Verapamil 3mg iv (5min) SD, R-Vera                 |                |
| Verapamil | Protocol    | Mooy 1985, Verapamil 3mg iv (5min) SD, S-Vera                 |                |
| Verapamil | Protocol    | Mooy 1985, Verapamil 80mg po SD, R-Vera                       |                |
| Verapamil | Protocol    | Mooy 1985, Verapamil 80mg po SD, S-Vera                       |                |
| Verapamil | Protocol    | Streit 2005, Verapamil 5mg iv (10min) SD, S-Vera              |                |
| Verapamil | Protocol    | Streit 2005, Verapamil 5mg iv (10min) SD, R-Vera              |                |
| Verapamil | Protocol    | Johnston 1981, Verapamil 0.1mg/kg iv (5min) SD, S-Vera        |                |
| Verapamil | Protocol    | Johnston 1981, Verapamil 0.1mg/kg iv (5min) SD, R-Vera        |                |
| Verapamil | Protocol    | Johnston 1981, Verapamil 120mg po SD, R-Vera                  |                |
| Verapamil | Protocol    | Johnston 1981, Verapamil 120mg po SD, S-Vera                  |                |
| Verapamil | Protocol    | Abernethy 1985, Verapamil 10mg iv (10min) SD, R-Vera          |                |
| Verapamil | Protocol    | Abernethy 1985, Verapamil 10mg iv (10min) SD, S-Vera          |                |
| Verapamil | Protocol    | Abernethy 1985, Verapamil 120mg po SD, R-Vera                 |                |
| Verapamil | Protocol    | Abernethy 1985, Verapamil 120mg po SD, S-Vera                 |                |
| Verapamil | Protocol    | Barbarash 1988, Verapamil 10mg iv (10min) SD, S-Vera          |                |
| Verapamil | Protocol    | Barbarash 1988, Verapamil 10mg iv (10min) SD, R-Vera          |                |
| Verapamil | Protocol    | Barbarash 1988, Verapamil 120mg po SD, R-Vera                 |                |
| Verapamil | Protocol    | Barbarash 1988, Verapamil 120mg po SD, S-Vera                 |                |
| Verapamil | Protocol    | Wing 1985, Verapamil 10mg iv (10min) SD, R-Vera               |                |
| Verapamil | Protocol    | Wing 1985, Verapamil 10mg iv (10min) SD, S-Vera               |                |
| Verapamil | Protocol    | Wing 1985, Verapamil 80mg po SD, R-Vera                       |                |
| Verapamil | Protocol    | Wing 1985, Verapamil 80mg po SD, S-Vera                       |                |
| Verapamil | Protocol    | McAllister, Kirsten 1982, Verapamil 10mg iv (5min) SD, S-Vera |                |
| Verapamil | Protocol    | McAllister, Kirsten 1982, Verapamil 10mg iv (5min) SD, R-Vera |                |
| Verapamil | Protocol    | Smith 1984, Verapamil 120mg po SD, S-Vera                     |                |
| Verapamil | Protocol    | Smith 1984, Verapamil 120mg po SD, R-Vera                     |                |
| Verapamil | Protocol    | Freedman 1981, Verapamil 13.1mg iv (13min) SD, R-Vera         |                |
| Verapamil | Protocol    | Freedman 1981, Verapamil 13.1mg iv (13min) SD, S-Vera         |                |
| Verapamil | Protocol    | Abernethy 1993, Verapamil 20mg iv (30min) SD, R-Vera          |                |
| Verapamil | Protocol    | Abernethy 1993, Verapamil 20mg iv (30min) SD, S-Vera          |                |
| Verapamil | Protocol    | Vogelgesang 1984, R-Verapamil 250mg po SD                     |                |
| Verapamil | Protocol    | Maeda 2011, Verapamil 0.1 mg po SD (sol), R-Vera              |                |
| Verapamil | Protocol    | Maeda 2011, Verapamil 0.1 mg po SD (sol), S-Vera              |                |
| Verapamil | Protocol    | Maeda 2011, Verapamil 3 mg po SD (sol), R-Vera                |                |
| Verapamil | Protocol    | Maeda 2011, Verapamil 3 mg po SD (sol), S-Vera                |                |
| Verapamil | Protocol    | Maeda 2011, Verapamil 80 mg po SD (sol), S-Vera               |                |
| Verapamil | Protocol    | Maeda 2011, Verapamil 80 mg po SD (sol), R-Vera               |                |
| Verapamil | Protocol    | John 1992, Verapamil 40mg po (tab) SD, R-Vera                 |                |
| Verapamil | Protocol    | John 1992, Verapamil 40mg po (tab) SD, S-Vera                 |                |
| Verapamil | Protocol    | Sawicki, Janicki 2002, Verapamil 40mg po (tab) SD, R-Vera     |                |
| Verapamil | Protocol    | Sawicki, Janicki 2002, Verapamil 40mg po (tab) SD, S-Vera     |                |
| Verapamil | Protocol    | Choi 2008, Verapamil 60 mg po (caps) SD, R-Vera               |                |
| Verapamil | Protocol    | Choi 2008, Verapamil 60 mg po (caps) SD, S-Vera               |                |
| Verapamil | Protocol    | Ratiopharm 1988, Verapamil 80mg po SD, R-Vera                 |                |
| Verapamil | Protocol    | Ratiopharm 1988, Verapamil 80mg po SD, S-Vera                 |                |
| Verapamil | Protocol    | Ratiopharm 1989, Verapamil 80mg (2 40mg tabs) po SD, R-Vera   |                |
| Verapamil | Protocol    | Ratiopharm 1989, Verapamil 80mg (2 40mg tabs) po SD, S-Vera   |                |
| Verapamil | Protocol    | Johnson 2001, Verapamil 80mg po tid 7rep, R-Vera              |                |
| Verapamil | Protocol    | Johnson 2001, Verapamil 80mg po tid 7rep, S-Vera              |                |
| Verapamil | Protocol    | Boehringer 2018, Verapamil 120mg po (IR tab) SD, R-Vera       |                |
| Verapamil | Protocol    | Boehringer 2018, Verapamil 120mg po (IR tab) SD, S-Vera       |                |
| Verapamil | Protocol    | Härtter 2012, Verapamil 120 mg bid, R-Vera                    |                |
| Verapamil | Protocol    | Härtter 2012, Verapamil 120 mg bid, S-Vera                    |                |
| Verapamil | Protocol    | Hla 1987, Verapamil 120mg po (tab) SD, R-Vera                 |                |
| Verapamil | Protocol    | Hla 1987, Verapamil 120mg po (tab) SD, S-Vera                 |                |
| Verapamil | Protocol    | Hla 1987, Verapamil 120mg po (tab) MD, R-Vera                 |                |
| Verapamil | Protocol    | Hla 1987, Verapamil 120mg po (tab) MD, S-Vera                 |                |
| Verapamil | Protocol    | Mikus 1990, Verapamil 160mg po (sol) SD, R-Vera               |                |
| Verapamil | Protocol    | Mikus 1990, Verapamil 160mg po (sol) SD, S-Vera               |                |
| Verapamil | Protocol    | van Haarst 2009, Verapamil 180mg PO BID 3days, R-Vera         |                |
| Verapamil | Protocol    | van Haarst 2009, Verapamil 180mg PO BID 3days, S-Vera         |                |
| Verapamil | Protocol    | Blume, Mutschler 1987, Verapamil 120mg po SD, R-Vera          |                |
| Verapamil | Protocol    | Blume, Mutschler 1987, Verapamil 120mg po SD, S-Vera          |                |
| Verapamil | Protocol    | Blume, Mutschler 1989, Verapamil 80mg po SD, R-Vera           |                |
| Verapamil | Protocol    | Blume, Mutschler 1989, Verapamil 80mg po SD, S-Vera           |                |
| Verapamil | Protocol    | Blume, Mutschler 1990, Verapamil 40mg po SD, R-Vera           |                |
| Verapamil | Protocol    | Blume, Mutschler 1990, Verapamil 40mg po SD, S-Vera           |                |
| Verapamil | Protocol    | Blume, Mutschler 1983, Verapamil 40mg po SD, R-Vera           |                |
| Verapamil | Protocol    | Blume, Mutschler 1983, Verapamil 40mg po SD, S-Vera           |                |
| Verapamil | Protocol    | Eichelbaum 1984, R-Verapamil 25 mg iv (5 min)                 |                |
| Verapamil | Protocol    | Eichelbaum 1984, R-Verapamil 5 mg iv (5 min)                  |                |
| Verapamil | Protocol    | Eichelbaum 1984, S-Verapamil 5 mg iv (5 min)                  |                |
| Verapamil | Protocol    | Eichelbaum 1984, S-Verapamil 7.5 mg iv (5 min)                |                |
| Verapamil | Protocol    | Eichelbaum 1984, S-Verapamil 10 mg iv (5 min)                 |                |
| Verapamil | Protocol    | Backman 1994, Verapamil 80mg po TID, R-Vera                   |                |
| Verapamil | Protocol    | Backman 1994, Verapamil 80mg po TID, S-Vera                   |                |
| Verapamil | Protocol    | McAllister 1982, Verapamil 80mg po SD, S-Vera                 |                |
| Verapamil | Protocol    | McAllister 1982, Verapamil 80mg po SD, R-Vera                 |                |
| Verapamil | Protocol    | McAllister 1982, Verapamil 160mg po SD, R-Vera                |                |
| Verapamil | Protocol    | McAllister 1982, Verapamil 160mg po SD, S-Vera                |                |
| Verapamil | Protocol    | McAllister 1982, Verapamil 120 mg SD, R-Vera                  |                |
| Verapamil | Protocol    | McAllister 1982, Verapamil 120 mg SD, S-Vera                  |                |
| Verapamil | Protocol    | Jorgensen 1988, Verapamil 120mg PO BID, R-Vera                |                |
| Verapamil | Protocol    | Jorgensen 1988, Verapamil 120mg PO BID, S-Vera                |                |
| Verapamil | Protocol    | Jorgensen 1988, Verapamil 240mg PO MD, R-Vera                 |                |
| Verapamil | Protocol    | Jorgensen 1988, Verapamil 240mg PO MD, S-Vera                 |                |
| Verapamil | Protocol    | Karim 1995, Verapamil 240mg PO SD, R-Vera                     |                |
| Verapamil | Protocol    | Karim 1995, Verapamil 240mg PO SD, S-Vera                     |                |
| Verapamil | Protocol    | Shand 1981, Verapamil 120 mg TID, R-Vera                      |                |
| Verapamil | Protocol    | Shand 1981, Verapamil 120 mg TID, S-Vera                      |                |
| Verapamil | Formulation | Solution                                                      |                |
| Verapamil | Formulation | Retard Tablet Verapamil (Knoll)                               |                |
| Verapamil | ObserverSet | Sum-Verapamil                                                 |                |
| Verapamil | ObserverSet | Sum-Norverapamil                                              |                |
| Verapamil | ObserverSet | Sum-Verapamil fe to urine                                     |                |
| Verapamil | ObserverSet | Sum-Norverapamil fe to urine                                  |                |
| Verapamil | ObserverSet | Sum-Verapamil fe to feces                                     |                |
| Verapamil | ObserverSet | Sum-Norverapamil fe to feces                                  |                |

| Project | Parent.Project | Parent.Simulation | Path | TargetSimulation |
|---------|----------------|-------------------|------|------------------|

| Project   | Simulation                                                             | Section.Reference |
|:----------|:-----------------------------------------------------------------------|------------------:|
| Verapamil | iv_R-Verapamil 50 mg (5 min), Eichelbaum 1984, n=1                     |                NA |
| Verapamil | iv_R-Verapamil 50 mg (5 min), Eichelbaum 1984, n=1                     |                NA |
| Verapamil | iv_R-Verapamil 50 mg (5 min), Eichelbaum 1984, n=1                     |                NA |
| Verapamil | iv_R-Verapamil 50 mg (5 min), Eichelbaum 1984, n=1                     |                NA |
| Verapamil | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       |                NA |
| Verapamil | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       |                NA |
| Verapamil | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       |                NA |
| Verapamil | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       |                NA |
| Verapamil | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       |                NA |
| Verapamil | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       |                NA |
| Verapamil | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       |                NA |
| Verapamil | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       |                NA |
| Verapamil | po_Verapamil 16 mg SD (sol), Maeda 2011, n=8                           |                NA |
| Verapamil | po_Verapamil 16 mg SD (sol), Maeda 2011, n=8                           |                NA |
| Verapamil | po_Verapamil 16 mg SD (sol), Maeda 2011, n=8                           |                NA |
| Verapamil | po_Verapamil 16 mg SD (sol), Maeda 2011, n=8                           |                NA |
| Verapamil | po_Verapamil 16 mg SD (sol), Maeda 2011, n=8                           |                NA |
| Verapamil | po_Verapamil 16 mg SD (sol), Maeda 2011, n=8                           |                NA |
| Verapamil | po_Verapamil 240 mg QD (SR), Blume, Mutschler 1994, n=24               |                NA |
| Verapamil | po_Verapamil 240 mg QD (SR), Blume, Mutschler 1994, n=24               |                NA |
| Verapamil | po_Verapamil 240 mg QD (SR), Blume, Mutschler 1994, n=24               |                NA |
| Verapamil | po_Verapamil 240 mg QD (SR), Blume, Mutschler 1994, n=24               |                NA |
| Verapamil | po_Verapamil 240 mg QD (SR), Blume, Mutschler 1994, n=24               |                NA |
| Verapamil | po_Verapamil 240 mg QD (SR), Blume, Mutschler 1994, n=24               |                NA |
| Verapamil | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            |                NA |
| Verapamil | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            |                NA |
| Verapamil | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            |                NA |
| Verapamil | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            |                NA |
| Verapamil | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            |                NA |
| Verapamil | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            |                NA |
| Verapamil | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            |                NA |
| Verapamil | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            |                NA |
| Verapamil | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            |                NA |
| Verapamil | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            |                NA |
| Verapamil | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  |                NA |
| Verapamil | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  |                NA |
| Verapamil | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  |                NA |
| Verapamil | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  |                NA |
| Verapamil | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  |                NA |
| Verapamil | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  |                NA |
| Verapamil | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  |                NA |
| Verapamil | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  |                NA |
| Verapamil | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  |                NA |
| Verapamil | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  |                NA |
| Verapamil | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         |                NA |
| Verapamil | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         |                NA |
| Verapamil | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         |                NA |
| Verapamil | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         |                NA |
| Verapamil | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         |                NA |
| Verapamil | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         |                NA |
| Verapamil | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         |                NA |
| Verapamil | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         |                NA |
| Verapamil | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         |                NA |
| Verapamil | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         |                NA |
| Verapamil | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   |                NA |
| Verapamil | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   |                NA |
| Verapamil | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   |                NA |
| Verapamil | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   |                NA |
| Verapamil | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   |                NA |
| Verapamil | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   |                NA |
| Verapamil | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   |                NA |
| Verapamil | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   |                NA |
| Verapamil | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   |                NA |
| Verapamil | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   |                NA |
| Verapamil | po_Verapamil 120 mg SD, Johnston 1981, n=6                             |                NA |
| Verapamil | po_Verapamil 120 mg SD, Johnston 1981, n=6                             |                NA |
| Verapamil | po_Verapamil 120 mg SD, Johnston 1981, n=6                             |                NA |
| Verapamil | po_Verapamil 120 mg SD, Johnston 1981, n=6                             |                NA |
| Verapamil | po_Verapamil 120 mg SD, Johnston 1981, n=6                             |                NA |
| Verapamil | po_Verapamil 120 mg SD, Johnston 1981, n=6                             |                NA |
| Verapamil | po_Verapamil 120 mg SD, Johnston 1981, n=6                             |                NA |
| Verapamil | po_Verapamil 120 mg SD, Johnston 1981, n=6                             |                NA |
| Verapamil | po_Verapamil 120 mg SD, Johnston 1981, n=6                             |                NA |
| Verapamil | po_Verapamil 120 mg SD, Johnston 1981, n=6                             |                NA |
| Verapamil | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      |                NA |
| Verapamil | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      |                NA |
| Verapamil | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      |                NA |
| Verapamil | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      |                NA |
| Verapamil | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      |                NA |
| Verapamil | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      |                NA |
| Verapamil | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      |                NA |
| Verapamil | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      |                NA |
| Verapamil | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      |                NA |
| Verapamil | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      |                NA |
| Verapamil | po_Verapamil 120mg SD, Abernethy 1985, n=1                             |                NA |
| Verapamil | po_Verapamil 120mg SD, Abernethy 1985, n=1                             |                NA |
| Verapamil | po_Verapamil 120mg SD, Abernethy 1985, n=1                             |                NA |
| Verapamil | po_Verapamil 120mg SD, Abernethy 1985, n=1                             |                NA |
| Verapamil | po_Verapamil 120mg SD, Abernethy 1985, n=1                             |                NA |
| Verapamil | po_Verapamil 120mg SD, Abernethy 1985, n=1                             |                NA |
| Verapamil | po_Verapamil 120mg SD, Abernethy 1985, n=1                             |                NA |
| Verapamil | po_Verapamil 120mg SD, Abernethy 1985, n=1                             |                NA |
| Verapamil | po_Verapamil 120mg SD, Abernethy 1985, n=1                             |                NA |
| Verapamil | po_Verapamil 120mg SD, Abernethy 1985, n=1                             |                NA |
| Verapamil | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      |                NA |
| Verapamil | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      |                NA |
| Verapamil | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      |                NA |
| Verapamil | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      |                NA |
| Verapamil | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      |                NA |
| Verapamil | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      |                NA |
| Verapamil | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      |                NA |
| Verapamil | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      |                NA |
| Verapamil | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      |                NA |
| Verapamil | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      |                NA |
| Verapamil | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            |                NA |
| Verapamil | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            |                NA |
| Verapamil | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            |                NA |
| Verapamil | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            |                NA |
| Verapamil | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            |                NA |
| Verapamil | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            |                NA |
| Verapamil | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            |                NA |
| Verapamil | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            |                NA |
| Verapamil | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            |                NA |
| Verapamil | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            |                NA |
| Verapamil | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            |                NA |
| Verapamil | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            |                NA |
| Verapamil | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            |                NA |
| Verapamil | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            |                NA |
| Verapamil | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            |                NA |
| Verapamil | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            |                NA |
| Verapamil | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            |                NA |
| Verapamil | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            |                NA |
| Verapamil | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            |                NA |
| Verapamil | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            |                NA |
| Verapamil | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    |                NA |
| Verapamil | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    |                NA |
| Verapamil | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    |                NA |
| Verapamil | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    |                NA |
| Verapamil | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    |                NA |
| Verapamil | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    |                NA |
| Verapamil | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    |                NA |
| Verapamil | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    |                NA |
| Verapamil | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    |                NA |
| Verapamil | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    |                NA |
| Verapamil | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      |                NA |
| Verapamil | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      |                NA |
| Verapamil | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      |                NA |
| Verapamil | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      |                NA |
| Verapamil | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      |                NA |
| Verapamil | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      |                NA |
| Verapamil | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      |                NA |
| Verapamil | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      |                NA |
| Verapamil | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      |                NA |
| Verapamil | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      |                NA |
| Verapamil | po_R-Verapamil 250mg SD, Vogelgesang 1984, n=1                         |                NA |
| Verapamil | po_R-Verapamil 250mg SD, Vogelgesang 1984, n=1                         |                NA |
| Verapamil | po_R-Verapamil 250mg SD, Vogelgesang 1984, n=1                         |                NA |
| Verapamil | po_R-Verapamil 250mg SD, Vogelgesang 1984, n=1                         |                NA |
| Verapamil | po_Verapamil 0.1 mg SD (sol), Maeda 2011, n=8                          |                NA |
| Verapamil | po_Verapamil 0.1 mg SD (sol), Maeda 2011, n=8                          |                NA |
| Verapamil | po_Verapamil 0.1 mg SD (sol), Maeda 2011, n=8                          |                NA |
| Verapamil | po_Verapamil 0.1 mg SD (sol), Maeda 2011, n=8                          |                NA |
| Verapamil | po_Verapamil 0.1 mg SD (sol), Maeda 2011, n=8                          |                NA |
| Verapamil | po_Verapamil 0.1 mg SD (sol), Maeda 2011, n=8                          |                NA |
| Verapamil | po_Verapamil 3 mg SD (sol), Maeda 2011, n=8                            |                NA |
| Verapamil | po_Verapamil 3 mg SD (sol), Maeda 2011, n=8                            |                NA |
| Verapamil | po_Verapamil 3 mg SD (sol), Maeda 2011, n=8                            |                NA |
| Verapamil | po_Verapamil 3 mg SD (sol), Maeda 2011, n=8                            |                NA |
| Verapamil | po_Verapamil 3 mg SD (sol), Maeda 2011, n=8                            |                NA |
| Verapamil | po_Verapamil 3 mg SD (sol), Maeda 2011, n=8                            |                NA |
| Verapamil | po_Verapamil 80 mg SD (sol), Maeda 2011, n=8                           |                NA |
| Verapamil | po_Verapamil 80 mg SD (sol), Maeda 2011, n=8                           |                NA |
| Verapamil | po_Verapamil 80 mg SD (sol), Maeda 2011, n=8                           |                NA |
| Verapamil | po_Verapamil 80 mg SD (sol), Maeda 2011, n=8                           |                NA |
| Verapamil | po_Verapamil 80 mg SD (sol), Maeda 2011, n=8                           |                NA |
| Verapamil | po_Verapamil 80 mg SD (sol), Maeda 2011, n=8                           |                NA |
| Verapamil | po_Verapamil 40 mg SD, John 1992, n=6                                  |                NA |
| Verapamil | po_Verapamil 40 mg SD, John 1992, n=6                                  |                NA |
| Verapamil | po_Verapamil 40 mg SD, John 1992, n=6                                  |                NA |
| Verapamil | po_Verapamil 40 mg SD, John 1992, n=6                                  |                NA |
| Verapamil | po_Verapamil 40 mg SD, John 1992, n=6                                  |                NA |
| Verapamil | po_Verapamil 40 mg SD, John 1992, n=6                                  |                NA |
| Verapamil | po_Verapamil 40 mg SD, John 1992, n=6                                  |                NA |
| Verapamil | po_Verapamil 40 mg SD, John 1992, n=6                                  |                NA |
| Verapamil | po_Verapamil 40 mg SD, John 1992, n=6                                  |                NA |
| Verapamil | po_Verapamil 40 mg SD, John 1992, n=6                                  |                NA |
| Verapamil | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     |                NA |
| Verapamil | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     |                NA |
| Verapamil | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     |                NA |
| Verapamil | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     |                NA |
| Verapamil | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     |                NA |
| Verapamil | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     |                NA |
| Verapamil | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     |                NA |
| Verapamil | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     |                NA |
| Verapamil | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     |                NA |
| Verapamil | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     |                NA |
| Verapamil | po_Verapamil 60 mg SD, Choi 2008, n=12                                 |                NA |
| Verapamil | po_Verapamil 60 mg SD, Choi 2008, n=12                                 |                NA |
| Verapamil | po_Verapamil 60 mg SD, Choi 2008, n=12                                 |                NA |
| Verapamil | po_Verapamil 60 mg SD, Choi 2008, n=12                                 |                NA |
| Verapamil | po_Verapamil 60 mg SD, Choi 2008, n=12                                 |                NA |
| Verapamil | po_Verapamil 60 mg SD, Choi 2008, n=12                                 |                NA |
| Verapamil | po_Verapamil 60 mg SD, Choi 2008, n=12                                 |                NA |
| Verapamil | po_Verapamil 60 mg SD, Choi 2008, n=12                                 |                NA |
| Verapamil | po_Verapamil 60 mg SD, Choi 2008, n=12                                 |                NA |
| Verapamil | po_Verapamil 60 mg SD, Choi 2008, n=12                                 |                NA |
| Verapamil | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           |                NA |
| Verapamil | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           |                NA |
| Verapamil | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           |                NA |
| Verapamil | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           |                NA |
| Verapamil | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           |                NA |
| Verapamil | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           |                NA |
| Verapamil | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           |                NA |
| Verapamil | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           |                NA |
| Verapamil | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           |                NA |
| Verapamil | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           |                NA |
| Verapamil | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              |                NA |
| Verapamil | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              |                NA |
| Verapamil | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              |                NA |
| Verapamil | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              |                NA |
| Verapamil | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              |                NA |
| Verapamil | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              |                NA |
| Verapamil | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              |                NA |
| Verapamil | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              |                NA |
| Verapamil | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              |                NA |
| Verapamil | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              |                NA |
| Verapamil | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        |                NA |
| Verapamil | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        |                NA |
| Verapamil | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        |                NA |
| Verapamil | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        |                NA |
| Verapamil | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        |                NA |
| Verapamil | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        |                NA |
| Verapamil | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        |                NA |
| Verapamil | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        |                NA |
| Verapamil | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        |                NA |
| Verapamil | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        |                NA |
| Verapamil | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 |                NA |
| Verapamil | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 |                NA |
| Verapamil | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 |                NA |
| Verapamil | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 |                NA |
| Verapamil | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 |                NA |
| Verapamil | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 |                NA |
| Verapamil | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 |                NA |
| Verapamil | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 |                NA |
| Verapamil | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 |                NA |
| Verapamil | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 |                NA |
| Verapamil | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                |                NA |
| Verapamil | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                |                NA |
| Verapamil | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                |                NA |
| Verapamil | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                |                NA |
| Verapamil | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                |                NA |
| Verapamil | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                |                NA |
| Verapamil | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                |                NA |
| Verapamil | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                |                NA |
| Verapamil | po_Verapamil 120 mg SD, Hla 1987, n=10                                 |                NA |
| Verapamil | po_Verapamil 120 mg SD, Hla 1987, n=10                                 |                NA |
| Verapamil | po_Verapamil 120 mg SD, Hla 1987, n=10                                 |                NA |
| Verapamil | po_Verapamil 120 mg SD, Hla 1987, n=10                                 |                NA |
| Verapamil | po_Verapamil 120 mg SD, Hla 1987, n=10                                 |                NA |
| Verapamil | po_Verapamil 120 mg SD, Hla 1987, n=10                                 |                NA |
| Verapamil | po_Verapamil 120 mg MD, Hla 1987, n=10                                 |                NA |
| Verapamil | po_Verapamil 120 mg MD, Hla 1987, n=10                                 |                NA |
| Verapamil | po_Verapamil 120 mg MD, Hla 1987, n=10                                 |                NA |
| Verapamil | po_Verapamil 120 mg MD, Hla 1987, n=10                                 |                NA |
| Verapamil | po_Verapamil 120 mg MD, Hla 1987, n=10                                 |                NA |
| Verapamil | po_Verapamil 120 mg MD, Hla 1987, n=10                                 |                NA |
| Verapamil | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  |                NA |
| Verapamil | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  |                NA |
| Verapamil | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  |                NA |
| Verapamil | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  |                NA |
| Verapamil | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  |                NA |
| Verapamil | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  |                NA |
| Verapamil | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  |                NA |
| Verapamil | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  |                NA |
| Verapamil | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  |                NA |
| Verapamil | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  |                NA |
| Verapamil | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     |                NA |
| Verapamil | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     |                NA |
| Verapamil | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     |                NA |
| Verapamil | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     |                NA |
| Verapamil | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     |                NA |
| Verapamil | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     |                NA |
| Verapamil | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     |                NA |
| Verapamil | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     |                NA |
| Verapamil | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     |                NA |
| Verapamil | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     |                NA |
| Verapamil | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    |                NA |
| Verapamil | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    |                NA |
| Verapamil | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    |                NA |
| Verapamil | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    |                NA |
| Verapamil | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    |                NA |
| Verapamil | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    |                NA |
| Verapamil | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    |                NA |
| Verapamil | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    |                NA |
| Verapamil | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    |                NA |
| Verapamil | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    |                NA |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     |                NA |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     |                NA |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     |                NA |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     |                NA |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     |                NA |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     |                NA |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     |                NA |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     |                NA |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     |                NA |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     |                NA |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     |                NA |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     |                NA |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     |                NA |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     |                NA |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     |                NA |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     |                NA |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     |                NA |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     |                NA |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     |                NA |
| Verapamil | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     |                NA |
| Verapamil | iv_R-Verapamil 5 mg (5 min), Eichelbaum 1984, n=1                      |                NA |
| Verapamil | iv_R-Verapamil 5 mg (5 min), Eichelbaum 1984, n=1                      |                NA |
| Verapamil | iv_R-Verapamil 5 mg (5 min), Eichelbaum 1984, n=1                      |                NA |
| Verapamil | iv_R-Verapamil 5 mg (5 min), Eichelbaum 1984, n=1                      |                NA |
| Verapamil | iv_R-Verapamil 25 mg (5 min), Eichelbaum 1984, n=1                     |                NA |
| Verapamil | iv_R-Verapamil 25 mg (5 min), Eichelbaum 1984, n=1                     |                NA |
| Verapamil | iv_R-Verapamil 25 mg (5 min), Eichelbaum 1984, n=1                     |                NA |
| Verapamil | iv_R-Verapamil 25 mg (5 min), Eichelbaum 1984, n=1                     |                NA |
| Verapamil | iv_S-Verapamil 5 mg SD (5min), Eichelbaum 1984, n=1                    |                NA |
| Verapamil | iv_S-Verapamil 5 mg SD (5min), Eichelbaum 1984, n=1                    |                NA |
| Verapamil | iv_S-Verapamil 5 mg SD (5min), Eichelbaum 1984, n=1                    |                NA |
| Verapamil | iv_S-Verapamil 5 mg SD (5min), Eichelbaum 1984, n=1                    |                NA |
| Verapamil | iv_S-Verapamil 7.5 mg SD (5min), Eichelbaum 1984, n=1                  |                NA |
| Verapamil | iv_S-Verapamil 7.5 mg SD (5min), Eichelbaum 1984, n=1                  |                NA |
| Verapamil | iv_S-Verapamil 7.5 mg SD (5min), Eichelbaum 1984, n=1                  |                NA |
| Verapamil | iv_S-Verapamil 7.5 mg SD (5min), Eichelbaum 1984, n=1                  |                NA |
| Verapamil | iv_S-Verapamil 10 mg SD (5min), Eichelbaum 1984, n=1                   |                NA |
| Verapamil | iv_S-Verapamil 10 mg SD (5min), Eichelbaum 1984, n=1                   |                NA |
| Verapamil | iv_S-Verapamil 10 mg SD (5min), Eichelbaum 1984, n=1                   |                NA |
| Verapamil | iv_S-Verapamil 10 mg SD (5min), Eichelbaum 1984, n=1                   |                NA |
| Verapamil | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       |                NA |
| Verapamil | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       |                NA |
| Verapamil | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       |                NA |
| Verapamil | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       |                NA |
| Verapamil | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       |                NA |
| Verapamil | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       |                NA |
| Verapamil | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       |                NA |
| Verapamil | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       |                NA |
| Verapamil | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       |                NA |
| Verapamil | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       |                NA |
| Verapamil | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   |                NA |
| Verapamil | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   |                NA |
| Verapamil | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   |                NA |
| Verapamil | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   |                NA |
| Verapamil | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   |                NA |
| Verapamil | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   |                NA |
| Verapamil | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   |                NA |
| Verapamil | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   |                NA |
| Verapamil | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   |                NA |
| Verapamil | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   |                NA |
| Verapamil | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  |                NA |
| Verapamil | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  |                NA |
| Verapamil | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  |                NA |
| Verapamil | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  |                NA |
| Verapamil | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  |                NA |
| Verapamil | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  |                NA |
| Verapamil | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  |                NA |
| Verapamil | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  |                NA |
| Verapamil | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  |                NA |
| Verapamil | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  |                NA |
| Verapamil | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  |                NA |
| Verapamil | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  |                NA |
| Verapamil | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  |                NA |
| Verapamil | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  |                NA |
| Verapamil | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  |                NA |
| Verapamil | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  |                NA |
| Verapamil | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  |                NA |
| Verapamil | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  |                NA |
| Verapamil | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  |                NA |
| Verapamil | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  |                NA |
| Verapamil | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  |                NA |
| Verapamil | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  |                NA |
| Verapamil | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  |                NA |
| Verapamil | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  |                NA |
| Verapamil | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  |                NA |
| Verapamil | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  |                NA |
| Verapamil | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  |                NA |
| Verapamil | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  |                NA |
| Verapamil | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  |                NA |
| Verapamil | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  |                NA |
| Verapamil | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 |                NA |
| Verapamil | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 |                NA |
| Verapamil | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 |                NA |
| Verapamil | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 |                NA |
| Verapamil | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 |                NA |
| Verapamil | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 |                NA |
| Verapamil | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 |                NA |
| Verapamil | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 |                NA |
| Verapamil | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 |                NA |
| Verapamil | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 |                NA |
| Verapamil | po_Verapamil 240 mg SD, Karim 1995, n=12                               |                NA |
| Verapamil | po_Verapamil 240 mg SD, Karim 1995, n=12                               |                NA |
| Verapamil | po_Verapamil 240 mg SD, Karim 1995, n=12                               |                NA |
| Verapamil | po_Verapamil 240 mg SD, Karim 1995, n=12                               |                NA |
| Verapamil | po_Verapamil 240 mg SD, Karim 1995, n=12                               |                NA |
| Verapamil | po_Verapamil 240 mg SD, Karim 1995, n=12                               |                NA |
| Verapamil | po_Verapamil 240 mg SD, Karim 1995, n=12                               |                NA |
| Verapamil | po_Verapamil 240 mg SD, Karim 1995, n=12                               |                NA |
| Verapamil | po_Verapamil 240 mg SD, Karim 1995, n=12                               |                NA |
| Verapamil | po_Verapamil 240 mg SD, Karim 1995, n=12                               |                NA |
| Verapamil | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        |                NA |
| Verapamil | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        |                NA |
| Verapamil | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        |                NA |
| Verapamil | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        |                NA |
| Verapamil | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        |                NA |
| Verapamil | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        |                NA |
| Verapamil | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        |                NA |
| Verapamil | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        |                NA |
| Verapamil | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        |                NA |
| Verapamil | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        |                NA |
| Verapamil | iv_Verapamil 10 mg (bol), Smith 1984, n=8                              |                NA |
| Verapamil | iv_Verapamil 10 mg (bol), Smith 1984, n=8                              |                NA |
| Verapamil | iv_Verapamil 10 mg (bol), Smith 1984, n=8                              |                NA |
| Verapamil | iv_Verapamil 10 mg (bol), Smith 1984, n=8                              |                NA |
| Verapamil | iv_Verapamil 10 mg (bol), Smith 1984, n=8                              |                NA |
| Verapamil | iv_Verapamil 10 mg (bol), Smith 1984, n=8                              |                NA |
| Verapamil | po_Verapamil 120 mg SD, Smith 1984, n=8                                |                NA |
| Verapamil | po_Verapamil 120 mg SD, Smith 1984, n=8                                |                NA |
| Verapamil | po_Verapamil 120 mg SD, Smith 1984, n=8                                |                NA |
| Verapamil | po_Verapamil 120 mg SD, Smith 1984, n=8                                |                NA |
| Verapamil | po_Verapamil 120 mg SD, Smith 1984, n=8                                |                NA |
| Verapamil | po_Verapamil 120 mg SD, Smith 1984, n=8                                |                NA |
| Verapamil | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           |                NA |
| Verapamil | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           |                NA |
| Verapamil | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           |                NA |
| Verapamil | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           |                NA |
| Verapamil | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           |                NA |
| Verapamil | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           |                NA |
| Verapamil | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           |                NA |
| Verapamil | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           |                NA |
| Verapamil | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           |                NA |
| Verapamil | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           |                NA |
| Verapamil | po_Verapamil 80mg SD, Wing 1985, n=1                                   |                NA |
| Verapamil | po_Verapamil 80mg SD, Wing 1985, n=1                                   |                NA |
| Verapamil | po_Verapamil 80mg SD, Wing 1985, n=1                                   |                NA |
| Verapamil | po_Verapamil 80mg SD, Wing 1985, n=1                                   |                NA |
| Verapamil | po_Verapamil 80mg SD, Wing 1985, n=1                                   |                NA |
| Verapamil | po_Verapamil 80mg SD, Wing 1985, n=1                                   |                NA |
| Verapamil | po_Verapamil 80mg SD, Wing 1985, n=1                                   |                NA |
| Verapamil | po_Verapamil 80mg SD, Wing 1985, n=1                                   |                NA |
| Verapamil | po_Verapamil 80mg SD, Wing 1985, n=1                                   |                NA |
| Verapamil | po_Verapamil 80mg SD, Wing 1985, n=1                                   |                NA |
| Verapamil | po_Verapamil 160 mg SD, Mikus 1990, n=1                                |                NA |
| Verapamil | po_Verapamil 160 mg SD, Mikus 1990, n=1                                |                NA |
| Verapamil | po_Verapamil 160 mg SD, Mikus 1990, n=1                                |                NA |
| Verapamil | po_Verapamil 160 mg SD, Mikus 1990, n=1                                |                NA |
| Verapamil | po_Verapamil 160 mg SD, Mikus 1990, n=1                                |                NA |
| Verapamil | po_Verapamil 160 mg SD, Mikus 1990, n=1                                |                NA |
| Verapamil | po_Verapamil 160 mg SD, Mikus 1990, n=1                                |                NA |
| Verapamil | po_Verapamil 160 mg SD, Mikus 1990, n=1                                |                NA |
| Verapamil | po_Verapamil 160 mg SD, Mikus 1990, n=1                                |                NA |
| Verapamil | po_Verapamil 160 mg SD, Mikus 1990, n=1                                |                NA |

| Title | Section.Reference | Simulation.Duration | TimeUnit | ChartWidth | ChartHeight | AxisSize | LegendSize | OriginSize | FontFamilyName | WatermarkSize | X_Dimension | X_GridLines | X_Scaling | Y_Dimension | Y_GridLines | Y_Scaling |
|-------|-------------------|---------------------|----------|------------|-------------|----------|------------|------------|----------------|---------------|-------------|-------------|-----------|-------------|-------------|-----------|

| Project | Simulation | Output | Observed.data | Plot.Title | StartTime | TimeUnit | Color | Caption | Symbol |
|---------|------------|--------|---------------|------------|-----------|----------|-------|---------|--------|

| Title | Section.Reference | Plot.Type | Artifacts | Group.Caption | Group.Symbol | ChartWidth | ChartHeight | AxisSize | LegendSize | OriginSize | FontFamilyName | WatermarkSize | X_Dimension | X_GridLines | X_Scaling | Y_Dimension | Y_GridLines | Y_Scaling |
|-------|-------------------|-----------|-----------|---------------|--------------|------------|-------------|----------|------------|------------|----------------|---------------|-------------|-------------|-----------|-------------|-------------|-----------|

| Project | Simulation | Output | Observed.data | Plot.Title | Group.Title | Color |
|---------|------------|--------|---------------|------------|-------------|-------|

| Title | Section.Ref | PK-Parameter | Plot.Type | Subunits | Artifacts | Group.Caption | Group.Color | Group.Symbol | ChartWidth | ChartHeight | AxisSize | LegendSize | OriginSize | FontFamilyName | WatermarkSize | X_Dimension | X_GridLines | X_Scaling | Y_Dimension | Y_GridLines | Y_Scaling |
|-------|-------------|--------------|-----------|----------|-----------|---------------|-------------|--------------|------------|-------------|----------|------------|------------|----------------|---------------|-------------|-------------|-----------|-------------|-------------|-----------|

| Project | Simulation_Control | Control.StartTime | Control.EndTime | Control.TimeUnit | Simulation_Treatment | Treatment.StartTime | Treatment.EndTime | Treatment.TimeUnit | Output | Plot.Title | Group.Title | Observed.data | ObsDataRecordID |
|---------|--------------------|-------------------|-----------------|------------------|----------------------|---------------------|-------------------|--------------------|--------|------------|-------------|---------------|-----------------|

| Title | Section.Reference | PK-Parameter | Artifacts | Group.Caption | Group.Color | Group.Symbol | ChartWidth | ChartHeight | AxisSize | LegendSize | OriginSize | FontFamilyName | WatermarkSize | X_Dimension | X_GridLines | X_Scaling | Y_Dimension | Y_GridLines | Y_Scaling |
|-------|-------------------|--------------|-----------|---------------|-------------|--------------|------------|-------------|----------|------------|------------|----------------|---------------|-------------|-------------|-----------|-------------|-------------|-----------|

| Project | Simulation | Output | Observed.data | ObservedDataRecordId | Plot.Title | Group.Title |
|---------|------------|--------|---------------|----------------------|------------|-------------|

| Section.Reference | Title | Content | Parent.Section |
|-------------------|-------|---------|----------------|

| Path |
|------|

| Project | BB-Type | BB-Name | Section.Reference |
|---------|---------|---------|-------------------|

| ChartWidth | ChartHeight | AxisSize | LegendSize | OriginSize | FontFamilyName | WatermarkSize |
|------------|-------------|----------|------------|------------|----------------|---------------|

| Plot                              | Type | Dimension | Unit | GridLines | Scaling |
|:----------------------------------|:-----|----------:|-----:|----------:|--------:|
| GOFMergedPlotsPredictedVsObserved | X    |        NA |   NA |        NA |      NA |
| GOFMergedPlotsPredictedVsObserved | Y    |        NA |   NA |        NA |      NA |
| GOFMergedPlotsResidualsOverTime   | X    |        NA |   NA |        NA |      NA |
| GOFMergedPlotsResidualsOverTime   | Y    |        NA |   NA |        NA |      NA |
| DDIRatioPlotsPredictedVsObserved  | X    |        NA |   NA |        NA |      NA |
| DDIRatioPlotsPredictedVsObserved  | Y    |        NA |   NA |        NA |      NA |
| DDIRatioPlotsResidualsVsObserved  | X    |        NA |   NA |        NA |      NA |
| DDIRatioPlotsResidualsVsObserved  | Y    |        NA |   NA |        NA |      NA |
| ComparisonTimeProfile             | X    |        NA |   NA |        NA |      NA |
| ComparisonTimeProfile             | Y    |        NA |   NA |        NA |      NA |
| PKRatioPlots                      | X    |        NA |   NA |        NA |      NA |
| PKRatioPlots                      | Y    |        NA |   NA |        NA |      NA |

| BuildingBlock     | BuildingBlockOrSimulation | TimeUnit | Symbol               | Color    | Dimension             | Scaling | FontFamilyName     | ArtifactsRatioPlots | ArtifactsGOFPlots | subunitsDDIRatioPlots | PK.Parameter                   | ObservedDataType | GOFMergedPlotType   | DDIRatioPlotType    | Treatment | Boolean | AxesSettingsPlots                 |
|:------------------|:--------------------------|:---------|:---------------------|:---------|:----------------------|:--------|:-------------------|:--------------------|:------------------|:----------------------|:-------------------------------|:-----------------|:--------------------|:--------------------|:----------|:-------:|:----------------------------------|
| Individual        | Individual                | s        | Circle               | \#CC6677 | Age                   | Linear  | Arial              | Table               | GMFE              | Mechanism             | AUC                            | DDIRatio         | predictedVsObserved | predictedVsObserved | X         |  FALSE  | GOFMergedPlotsPredictedVsObserved |
| Population        | Population                | min      | Square               | \#332288 | Amount                | Log     | Tahoma             | GMFE                | Plot              | Perpetrator           | CMAX                           | PKRatio          | residualsOverTime   | residualsVsObserved | NA        |  TRUE   | GOFMergedPlotsResidualsOverTime   |
| Compound          | Compound                  | h        | Diamond              | \#DDCC77 | Concentration (mass)  | NA      | TimesNewRoman      | Plot                | Measure           | Victim                | C_max                          | TimeProfile      | NA                  | NA                  | NA        |   NA    | DDIRatioPlotsPredictedVsObserved  |
| Protocol          | Protocol                  | day(s)   | Asterisk             | \#117733 | Concentration (molar) | NA      | MicrosoftSansSerif | Measure             | NA                | NA                    | C_max_norm                     | NA               | NA                  | NA                  | NA        |   NA    | DDIRatioPlotsResidualsVsObserved  |
| Event             | Event                     | week(s)  | Cross                | \#88CCEE | Fraction              | NA      | NA                 | NA                  | NA                | NA                    | C_max_tD1_tD2                  | NA               | NA                  | NA                  | NA        |   NA    | ComparisonTimeProfile             |
| Formulation       | Formulation               | month(s) | Triangle             | \#882255 | Mass                  | NA      | NA                 | NA                  | NA                | NA                    | C_max_tD1_tD2_norm             | NA               | NA                  | NA                  | NA        |   NA    | PKRatioPlots                      |
| ObserverSet       | ObserverSet               | year(s)  | InvertedTriangle     | \#44AA99 | Time                  | NA      | NA                 | NA                  | NA                | NA                    | C_max_tDLast_tEnd              | NA               | NA                  | NA                  | NA        |   NA    | NA                                |
| ExpressionProfile | ExpressionProfile         | NA       | Plus                 | \#999933 | Dimensionless         | NA      | NA                 | NA                  | NA                | NA                    | C_max_tDLast_tEnd_norm         | NA               | NA                  | NA                  | NA        |   NA    | NA                                |
| NA                | Simulation                | NA       | Star                 | \#AA4499 | NA                    | NA      | NA                 | NA                  | NA                | NA                    | t_max                          | NA               | NA                  | NA                  | NA        |   NA    | NA                                |
| NA                | NA                        | NA       | Pentagon             | \#DDDDDD | NA                    | NA      | NA                 | NA                  | NA                | NA                    | t_max_tD1_tD2                  | NA               | NA                  | NA                  | NA        |   NA    | NA                                |
| NA                | NA                        | NA       | Hexagon              | NA       | NA                    | NA      | NA                 | NA                  | NA                | NA                    | t_max_tDLast_tEnd              | NA               | NA                  | NA                  | NA        |   NA    | NA                                |
| NA                | NA                        | NA       | ThinCross            | NA       | NA                    | NA      | NA                 | NA                  | NA                | NA                    | C_trough_tD2                   | NA               | NA                  | NA                  | NA        |   NA    | NA                                |
| NA                | NA                        | NA       | ThinPlus             | NA       | NA                    | NA      | NA                 | NA                  | NA                | NA                    | C_trough_tDLast                | NA               | NA                  | NA                  | NA        |   NA    | NA                                |
| NA                | NA                        | NA       | CircleOpen           | NA       | NA                    | NA      | NA                 | NA                  | NA                | NA                    | C_tEnd                         | NA               | NA                  | NA                  | NA        |   NA    | NA                                |
| NA                | NA                        | NA       | DiamondOpen          | NA       | NA                    | NA      | NA                 | NA                  | NA                | NA                    | AUC_tEnd                       | NA               | NA                  | NA                  | NA        |   NA    | NA                                |
| NA                | NA                        | NA       | HexagonOpen          | NA       | NA                    | NA      | NA                 | NA                  | NA                | NA                    | AUC_tEnd_norm                  | NA               | NA                  | NA                  | NA        |   NA    | NA                                |
| NA                | NA                        | NA       | InvertedTriangleOpen | NA       | NA                    | NA      | NA                 | NA                  | NA                | NA                    | AUC_inf                        | NA               | NA                  | NA                  | NA        |   NA    | NA                                |
| NA                | NA                        | NA       | PentagonOpen         | NA       | NA                    | NA      | NA                 | NA                  | NA                | NA                    | AUC_inf_norm                   | NA               | NA                  | NA                  | NA        |   NA    | NA                                |
| NA                | NA                        | NA       | SquareOpen           | NA       | NA                    | NA      | NA                 | NA                  | NA                | NA                    | AUC_tD1_tD2                    | NA               | NA                  | NA                  | NA        |   NA    | NA                                |
| NA                | NA                        | NA       | StarOpen             | NA       | NA                    | NA      | NA                 | NA                  | NA                | NA                    | AUC_tD1_tD2_norm               | NA               | NA                  | NA                  | NA        |   NA    | NA                                |
| NA                | NA                        | NA       | TriangleOpen         | NA       | NA                    | NA      | NA                 | NA                  | NA                | NA                    | AUC_tDLast_minus_1_tDLast      | NA               | NA                  | NA                  | NA        |   NA    | NA                                |
| NA                | NA                        | NA       | NA                   | NA       | NA                    | NA      | NA                 | NA                  | NA                | NA                    | AUC_tDLast_minus_1_tDLast_norm | NA               | NA                  | NA                  | NA        |   NA    | NA                                |
| NA                | NA                        | NA       | NA                   | NA       | NA                    | NA      | NA                 | NA                  | NA                | NA                    | AUC_inf_tD1                    | NA               | NA                  | NA                  | NA        |   NA    | NA                                |
| NA                | NA                        | NA       | NA                   | NA       | NA                    | NA      | NA                 | NA                  | NA                | NA                    | AUC_inf_tD1_norm               | NA               | NA                  | NA                  | NA        |   NA    | NA                                |
| NA                | NA                        | NA       | NA                   | NA       | NA                    | NA      | NA                 | NA                  | NA                | NA                    | AUC_inf_tDLast                 | NA               | NA                  | NA                  | NA        |   NA    | NA                                |
| NA                | NA                        | NA       | NA                   | NA       | NA                    | NA      | NA                 | NA                  | NA                | NA                    | AUC_inf_tDLast_norm            | NA               | NA                  | NA                  | NA        |   NA    | NA                                |
| NA                | NA                        | NA       | NA                   | NA       | NA                    | NA      | NA                 | NA                  | NA                | NA                    | MRT                            | NA               | NA                  | NA                  | NA        |   NA    | NA                                |
| NA                | NA                        | NA       | NA                   | NA       | NA                    | NA      | NA                 | NA                  | NA                | NA                    | Thalf                          | NA               | NA                  | NA                  | NA        |   NA    | NA                                |
| NA                | NA                        | NA       | NA                   | NA       | NA                    | NA      | NA                 | NA                  | NA                | NA                    | Thalf_tDLast_tEnd              | NA               | NA                  | NA                  | NA        |   NA    | NA                                |
| NA                | NA                        | NA       | NA                   | NA       | NA                    | NA      | NA                 | NA                  | NA                | NA                    | FractionAucLastToInf           | NA               | NA                  | NA                  | NA        |   NA    | NA                                |
| NA                | NA                        | NA       | NA                   | NA       | NA                    | NA      | NA                 | NA                  | NA                | NA                    | CL                             | NA               | NA                  | NA                  | NA        |   NA    | NA                                |
| NA                | NA                        | NA       | NA                   | NA       | NA                    | NA      | NA                 | NA                  | NA                | NA                    | Vss                            | NA               | NA                  | NA                  | NA        |   NA    | NA                                |
| NA                | NA                        | NA       | NA                   | NA       | NA                    | NA      | NA                 | NA                  | NA                | NA                    | Vd                             | NA               | NA                  | NA                  | NA        |   NA    | NA                                |

## Convert back to json

``` r
excelToQualificationPlan(
  excelFile = excelFile,
  qualificationPlan = qualificationPlan
)
```
