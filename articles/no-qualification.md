# Snapshot without a Qualification Plan

``` r
library(ospsuite.qualificationplaneditor)
```

## Overview

This tutorial demonstrates how to create a new qualification plan from
scratch using only project snapshots, without an existing qualification
plan as a starting point. This is ideal when:

- Starting a completely new qualification project
- Creating a qualification plan for a newly developed model
- Building a qualification framework for a model that previously didn’t
  have one

We’ll use the
[Verapamil-Model](https://github.com/Open-Systems-Pharmacology/Verapamil-Model)
from the Open Systems Pharmacology GitHub repository as our example.

## Prerequisites

Before starting, ensure you have: - The
`ospsuite.qualificationplaneditor` package installed - A project
snapshot JSON file (locally or accessible via URL) - Basic understanding
of the OSP Suite workflow

## Workflow Overview

Creating a qualification plan from scratch involves three main steps:

1.  **Prepare your project snapshot**: Identify the snapshot JSON
    file(s) you want to include
2.  **Convert to Excel**: Generate an Excel workbook from the snapshot
3.  **Edit and convert back**: Edit the Excel file to add evaluations,
    then convert to JSON

Let’s walk through each step.

## Step 1: Define Your Project Files

First, we define the paths to our input and output files. The snapshot
can be a local file or a URL to a GitHub-hosted file.

``` r
# Path to the project snapshot (included with the package for this example)
snapshotPaths <- "Verapamil-Model.json"

# Output file name for the qualification plan JSON
qualificationPlan <- "qualification-verapamil.json"

# Output file name for the Excel workbook
excelFile <- "qualification-verapamil.xlsx"
```

**Note**: For your own projects, replace `"Verapamil-Model.json"` with
the path to your project snapshot file. This can be: - A local file
path: `"C:/MyProjects/MyModel.json"` - A GitHub URL:
`"https://raw.githubusercontent.com/Org/Repo/main/Model.json"`

For multiple projects, use a named list:

``` r
snapshotPaths <- list(
  "Project1" = "path/to/project1.json",
  "Project2" = "path/to/project2.json"
)
```

## Step 2: Convert Snapshot to Excel

Now we convert the project snapshot to Excel format. The key here is
that we **only** provide `snapshotPaths` - we do **not** provide a
`qualificationPlan` parameter, which tells the function to create a new
qualification plan from scratch.

``` r
toExcelEditor(
  fileName = excelFile, 
  snapshotPaths = snapshotPaths
)
#> 
#> ── Exporting to Excel Editor ───────────────────────────────────────────────────
#> ℹ Copying Excel Template to qualification-verapamil.xlsx
#> ✔ Copying Excel Template to qualification-verapamil.xlsx [201ms]
#> 
#> ℹ Checking for Qualification Plan
#> ℹ No Qualification Plan input
#> ℹ Checking for Qualification Plan✔ Checking for Qualification Plan [34ms]
#> 
#> ℹ Exporting Projects Data
#> ✔ Exporting Projects Data [67ms]
#> 
#> ℹ Exporting Simulation Outputs Data
#> ✔ Exporting Simulation Outputs Data [390ms]
#> 
#> ℹ Exporting Simulation Observed Data
#> ✔ Exporting Simulation Observed Data [53ms]
#> 
#> ℹ Exporting Observed Data
#> ✔ Exporting Observed Data [30ms]
#> 
#> ℹ Exporting Building Block Data
#> 
#> ℹ Exporting Building Block Data── Qualification Plan ──
#> ℹ Exporting Building Block Data
#> ℹ Exporting Building Block Data✔ Exporting Building Block Data [94ms]
#> 
#> ℹ Exporting Schema Data
#> ✔ Exporting Schema Data [231ms]
#> 
#> ℹ Exporting Sections
#> ✔ Exporting Sections [23ms]
#> 
#> ℹ Exporting Intro and Inputs
#> ✔ Exporting Intro and Inputs [21ms]
#> 
#> ℹ Exporting Simulation Parameters Settings
#> ✔ Exporting Simulation Parameters Settings [21ms]
#> 
#> ℹ Exporting All Plots Settings
#> ✔ Exporting All Plots Settings [35ms]
#> 
#> ℹ Exporting Comparison Time Profile Plot Settings
#> ✔ Exporting Comparison Time Profile Plot Settings [33ms]
#> 
#> ℹ Exporting GOF Merged Plot Settings
#> ✔ Exporting GOF Merged Plot Settings [32ms]
#> 
#> ℹ Exporting DDI Ratio Plot Settings
#> ✔ Exporting DDI Ratio Plot Settings [49ms]
#> 
#> ℹ Exporting Global Plot Settings
#> ✔ Exporting Global Plot Settings [30ms]
#> 
#> ℹ Exporting Global Axes Settings
#> ✔ Exporting Global Axes Settings [42ms]
#> 
#> ℹ Saving extracted data into qualification-verapamil.xlsx
#> ✔ Saving extracted data into qualification-verapamil.xlsx [396ms]
```

### What Happens During Conversion

The
[`toExcelEditor()`](https://www.open-systems-pharmacology.org/OSPSuite.QualificationPlanEditor/reference/toExcelEditor.md)
function performs several operations:

1.  **Reads the snapshot file**: Parses the project JSON to extract all
    relevant information
2.  **Extracts project data**:
    - Project metadata (ID, path)
    - Simulations and their outputs
    - Building blocks (compounds, individuals, formulations, etc.)
    - Observed data linked to simulations (if any)
3.  **Generates Excel worksheets**:
    - **Projects**: Lists all projects and their paths
    - **Simulations_Outputs**: All simulation outputs available for
      plotting
    - **Simulations_ObsData**: Observed data linked to simulations
    - **BB**: Building block structure for potential inheritance
    - **Sections**: Template sections for organizing your report
    - **All_Plots**: Individual plots from simulation outputs
    - **CT_Plots/GOF_Plots/DDIRatio_Plots/PKRatio_Plots**: Empty
      templates for creating custom plots
    - **Inputs**: Template for including building block documentation
    - **GlobalPlotSettings/GlobalAxesSettings**: Default plot
      configuration
    - **Lookup**: Reference tables for valid values
4.  **Applies formatting**:
    - Color-coding (all new projects will be green since nothing existed
      before)
    - Data validation dropdowns
    - Cell protection for read-only sheets

### Expected Output

After running this command, you should see a message confirming the
Excel file was created. The file will be ready for editing.

## Step 3: Review and Edit the Excel File

Once the Excel file is generated, you should open it to review and edit
the content. The code below opens the file using your system’s default
spreadsheet application (Excel, LibreOffice Calc, etc.):

``` r
utils::browseURL(excelFile)
```

### What to Edit

When creating a qualification plan from scratch, you’ll typically want
to:

1.  **Define Report Sections** (Sections sheet):
    - Create a logical structure for your qualification report
    - Add sections like “Introduction”, “Methods”, “Results”,
      “Discussion”
    - Create subsections as needed (e.g., “Model Development” under
      “Methods”)
2.  **Configure Plot Evaluations** (All_Plots sheet):
    - Review the automatically generated list of all possible plots
    - Assign each plot to a report section using the Section Reference
      column
    - Delete or leave blank rows for plots you don’t want to include
3.  **Create Comparison Time Profile Plots** (CT_Plots and CT_Mapping
    sheets):
    - Define plots that compare simulation outputs with observed data
    - Configure axes, titles, and other plot properties
    - Map specific outputs and observed datasets to each plot
4.  **Configure Other Plot Types** (GOF_Plots, DDIRatio_Plots,
    PKRatio_Plots):
    - Set up goodness-of-fit plots, DDI ratio plots, or PK ratio plots
      as needed
    - Configure their mappings to show the comparisons you need
5.  **Add Building Block Documentation** (Inputs sheet):
    - Specify which building blocks should be documented in the report
    - This includes compound properties, individual parameters,
      formulations, etc.
6.  **Set Introduction** (Intro sheet):
    - Provide a path to a Markdown file that will serve as your report
      introduction
    - This should explain the purpose, methods, and context of your
      qualification
7.  **Adjust Plot Settings** (GlobalPlotSettings and
    GlobalAxesSettings):
    - Customize figure dimensions, resolution, fonts
    - Set default unit preferences and axis scales

### Excel File Preview

The Excel file structure will look like this:

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
- Tips for Editing

| Qualification.plan.schema.version |
|----------------------------------:|
|                               3.5 |

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

| Section.Reference | Title   | Content | Parent.Section |
|:------------------|:--------|--------:|---------------:|
| tralala           | Tralala |      NA |             NA |

| Path |
|------|

| Project | BB-Type | BB-Name | Section.Reference |
|---------|---------|---------|-------------------|

| ChartWidth | ChartHeight | AxisSize | LegendSize | OriginSize | FontFamilyName | WatermarkSize |
|-----------:|------------:|---------:|-----------:|-----------:|:---------------|--------------:|
|        500 |         400 |       11 |          9 |         11 | Arial          |            40 |

| Plot                              | Type | Dimension            | Unit    | GridLines | Scaling |
|:----------------------------------|:-----|:---------------------|:--------|:---------:|:--------|
| GOFMergedPlotsPredictedVsObserved | X    | Concentration (mass) | µg/l    |   FALSE   | Log     |
| GOFMergedPlotsPredictedVsObserved | Y    | Concentration (mass) | µg/l    |   FALSE   | Log     |
| GOFMergedPlotsResidualsOverTime   | X    | Time                 | h       |   FALSE   | Linear  |
| GOFMergedPlotsResidualsOverTime   | Y    | Dimensionless        |         |   FALSE   | Linear  |
| DDIRatioPlotsPredictedVsObserved  | X    | Dimensionless        |         |   FALSE   | Log     |
| DDIRatioPlotsPredictedVsObserved  | Y    | Dimensionless        |         |   FALSE   | Log     |
| DDIRatioPlotsResidualsVsObserved  | X    | Dimensionless        |         |   FALSE   | Log     |
| DDIRatioPlotsResidualsVsObserved  | Y    | Dimensionless        |         |   FALSE   | Log     |
| ComparisonTimeProfile             | X    | Time                 | h       |   FALSE   | Linear  |
| ComparisonTimeProfile             | Y    | Concentration (mass) | µg/l    |   FALSE   | Log     |
| PKRatioPlots                      | X    | Age                  | year(s) |   FALSE   | Linear  |
| PKRatioPlots                      | Y    | Dimensionless        |         |   FALSE   | Log     |

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

- **Start with sections**: Define your report structure first, then
  assign evaluations to sections
- **Use color coding**: All rows should be green (new) since this is a
  fresh qualification plan
- **Leverage data validation**: Use the dropdown menus - don’t type free
  text where dropdowns exist
- **Review read-only sheets**: Check Projects, Simulations_Outputs, and
  Simulations_ObsData to understand what’s available

For detailed information about each worksheet, see the [Excel Template
Documentation](https://www.open-systems-pharmacology.org/OSPSuite.QualificationPlanEditor/articles/excel-template.md).

## Step 4: Convert Back to JSON

After editing the Excel file, convert it back to a JSON qualification
plan using
[`excelToQualificationPlan()`](https://www.open-systems-pharmacology.org/OSPSuite.QualificationPlanEditor/reference/excelToQualificationPlan.md):

``` r
excelToQualificationPlan(
  excelFile = excelFile,
  qualificationPlan = qualificationPlan
)
```

### What Happens During Conversion

The function performs several validation and conversion steps:

1.  **Reads the Excel file**: Loads all worksheets
2.  **Validates the data**:
    - Checks that required columns exist
    - Verifies section references are valid
    - Ensures project and simulation names match the definition sheets
    - Validates against lookup tables
3.  **Constructs the JSON structure**: Builds the hierarchical
    qualification plan structure
4.  **Writes the output**: Saves the qualification plan as a JSON file

### Validation Errors

If there are errors in your Excel file, the function will report them in
the console. Common errors include:

- **Invalid section reference**: You referenced a section that doesn’t
  exist in the Sections sheet
- **Invalid project/simulation name**: Names don’t match what’s in the
  Projects, Simulations_Outputs, or Simulations_ObsData sheets
- **Missing required columns**: You accidentally deleted a required
  column
- **Invalid lookup values**: You entered a value that’s not in the
  allowed list

Fix any reported errors in the Excel file and run the conversion again.

### Success

If the conversion succeeds, you’ll see a message confirming the
qualification plan was created. The JSON file is now ready to be used
with the OSP Suite Qualification Runner to generate your qualification
report.

## Next Steps

After creating your qualification plan:

1.  **Test the qualification plan**: Run it with the OSP Suite
    Qualification Runner to ensure it works correctly
2.  **Review the generated report**: Check that plots, sections, and
    content appear as expected
3.  **Iterate**: If adjustments are needed, reconvert to Excel, edit,
    and convert back to JSON

## Working with Observed Data

This example used only the project snapshot, which may include observed
data linked to simulations. To add additional observed data files:

``` r
# Define observed data
observedDataPaths <- list(
  "Clinical PK Data" = list(
    Path = "path/to/observed_data.csv",
    Type = "TimeProfile"
  ),
  "DDI Ratios" = list(
    Path = "path/to/ddi_ratios.csv",
    Type = "DDIRatio"
  )
)

# Include in conversion
toExcelEditor(
  fileName = excelFile,
  snapshotPaths = snapshotPaths,
  observedDataPaths = observedDataPaths
)
```

The observed data will then be available for use in plot evaluations.

## Related Articles

- [Excel Template
  Documentation](https://www.open-systems-pharmacology.org/OSPSuite.QualificationPlanEditor/articles/excel-template.md):
  Comprehensive guide to all Excel worksheets
- [Add a Snapshot to Qualification
  Plan](https://www.open-systems-pharmacology.org/OSPSuite.QualificationPlanEditor/articles/snapshot-qualification.md):
  How to add projects to an existing plan
- [Update Qualification Plan
  Evaluations](https://www.open-systems-pharmacology.org/OSPSuite.QualificationPlanEditor/articles/update-qualification.md):
  How to modify evaluations in an existing plan
