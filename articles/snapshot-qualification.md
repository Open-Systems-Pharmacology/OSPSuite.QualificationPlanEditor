# Add a Snapshot to my Qualification Plan

``` r
library(ospsuite.qualificationplaneditor)
```

## Overview

This tutorial demonstrates how to integrate a new project snapshot into
an existing qualification plan. This is a common scenario when:

- You’ve developed a new model that should be added to an existing
  qualification framework
- An existing model has been updated with a new version
- You want to include additional projects in a multi-model qualification
  study

We’ll use a practical example: adding the
[Verapamil-Model](https://github.com/Open-Systems-Pharmacology/Verapamil-Model)
to an existing qualification plan for UGT1A1- and UGT1A9-mediated
drug-drug interactions (DDI), which is available in the
[Qualification-DDI-UGT](https://github.com/Open-Systems-Pharmacology/Qualification-DDI-UGT)
repository.

## Prerequisites

Before starting, you should have: - The
`ospsuite.qualificationplaneditor` package installed - An existing
qualification plan JSON file - The new project snapshot JSON file you
want to add - Understanding of the qualification plan structure

## Workflow Overview

Adding a snapshot to an existing qualification plan involves:

1.  **Identify your files**: Locate the existing qualification plan and
    new project snapshot
2.  **Convert to Excel**: Generate an Excel workbook that merges both
    sources
3.  **Review changes**: Use color-coding to identify what’s new or
    changed
4.  **Edit and integrate**: Configure how the new project integrates
    with existing content
5.  **Convert back to JSON**: Generate the updated qualification plan

## Step 1: Prepare Your Files

First, define the paths to your project snapshot, existing qualification
plan, and output files:

``` r
# New project snapshot to add (included with package for this example)
snapshotPaths <- "Verapamil-Model.json"

# Existing qualification plan (included with package for this example)
qualificationPlan <- "qualification_ugt.json"

# Output Excel file name
excelFile <- "qualification_ugt.xlsx"
```

**Important Notes:**

- **snapshotPaths**: This is the NEW project you’re adding. Can be a
  local path or GitHub URL.

- **qualificationPlan**: This is your EXISTING qualification plan that
  you’re extending.

- For multiple new projects, use a named list:

  ``` r
  snapshotPaths <- list(
    "NewProject1" = "path/to/project1.json",
    "NewProject2" = "path/to/project2.json"
  )
  ```

## Step 2: Convert to Excel with Merged Content

Now convert both the new snapshot(s) and existing qualification plan
into a single Excel file. This is where the magic happens - the function
merges content from both sources:

``` r
toExcelEditor(
  fileName = excelFile, 
  snapshotPaths = snapshotPaths,
  qualificationPlan = qualificationPlan
)
#> 
#> ── Exporting to Excel Editor ───────────────────────────────────────────────────
#> ℹ Copying Excel Template to qualification_ugt.xlsx
#> ✔ Copying Excel Template to qualification_ugt.xlsx [194ms]
#> 
#> ℹ Checking for Qualification Plan
#> ℹ Qualification Plan: qualification_ugt.json
#> ℹ Checking for Qualification Plan✔ Checking for Qualification Plan [34ms]
#> 
#> ℹ Exporting Projects Data
#> ✔ Exporting Projects Data [66ms]
#> 
#> ℹ Exporting Simulation Outputs Data
#> ✔ Exporting Simulation Outputs Data [1.8s]
#> 
#> ℹ Exporting Simulation Observed Data
#> ✔ Exporting Simulation Observed Data [841ms]
#> 
#> ℹ Exporting Observed Data
#> ✔ Exporting Observed Data [36ms]
#> 
#> ℹ Exporting Building Block Data
#> 
#> ℹ Exporting Building Block Data── Qualification Plan ──
#> ℹ Exporting Building Block Data
#> ℹ Exporting Building Block Data✔ Exporting Building Block Data [734ms]
#> 
#> ℹ Exporting Schema Data
#> ✔ Exporting Schema Data [20ms]
#> 
#> ℹ Exporting Sections
#> ✔ Exporting Sections [25ms]
#> 
#> ℹ Exporting Intro and Inputs
#> ✔ Exporting Intro and Inputs [22ms]
#> 
#> ℹ Exporting Simulation Parameters Settings
#> ✔ Exporting Simulation Parameters Settings [24ms]
#> 
#> ℹ Exporting All Plots Settings
#> ✔ Exporting All Plots Settings [30ms]
#> 
#> ℹ Exporting Comparison Time Profile Plot Settings
#> ✔ Exporting Comparison Time Profile Plot Settings [63ms]
#> 
#> ℹ Exporting GOF Merged Plot Settings
#> ✔ Exporting GOF Merged Plot Settings [30ms]
#> 
#> ℹ Exporting DDI Ratio Plot Settings
#> ✔ Exporting DDI Ratio Plot Settings [62ms]
#> 
#> ℹ Exporting Global Plot Settings
#> ✔ Exporting Global Plot Settings [25ms]
#> 
#> ℹ Exporting Global Axes Settings
#> ✔ Exporting Global Axes Settings [32ms]
#> 
#> ℹ Saving extracted data into qualification_ugt.xlsx
#> ✔ Saving extracted data into qualification_ugt.xlsx [428ms]
```

### What Happens During Conversion

The
[`toExcelEditor()`](https://www.open-systems-pharmacology.org/OSPSuite.QualificationPlanEditor/reference/toExcelEditor.md)
function performs intelligent merging:

1.  **Reads both sources**:
    - Parses the new project snapshot(s)
    - Parses the existing qualification plan
2.  **Merges project data**:
    - Combines projects from both sources
    - Identifies new projects (from snapshot)
    - Identifies existing projects (from qualification plan)
    - Detects changed projects (in both but with different
      versions/paths)
3.  **Applies color-coding**:
    - **Green**: New projects from the snapshot that don’t exist in the
      qualification plan
    - **Yellow**: Projects that exist in both but have different
      versions or paths
    - **Grey**: Unchanged projects (same in both or only in
      qualification plan)
4.  **Preserves existing evaluations**:
    - All plot configurations from the qualification plan are retained
    - Section structure is maintained
    - Building block inheritance is preserved
5.  **Adds new possibilities**:
    - New simulations and outputs from the added project appear in
      Simulations_Outputs
    - New building blocks are available in the BB sheet
    - New simulations can be used in plot mappings

### Understanding the Merge

The key insight is that this operation is **additive and
highlighting**: - Nothing from your existing qualification plan is
removed - New content from snapshots is clearly marked (green) - Changed
content is highlighted (yellow) - You decide what to do with the new
content by editing the Excel file

## Step 3: Review and Edit the Excel File

Open the generated Excel file to review the merged content:

``` r
utils::browseURL(excelFile)
```

### Focus on Color-Coded Changes

When integrating a new snapshot, pay special attention to:

1.  **Green rows** (New Projects):
    - Review the **Projects** sheet to see the new project(s) added
    - Check **Simulations_Outputs** to understand what outputs are
      available from the new project
    - Look at **BB** sheet to see the building blocks in the new project
2.  **Yellow rows** (Changed Projects):
    - If any existing projects have been updated (new versions), they’ll
      be yellow
    - Verify the path/version change is intentional
    - Review if simulations or outputs have changed

### Key Integration Tasks

When adding a new project to an existing qualification plan, you’ll
typically need to:

#### A. Configure Building Block Inheritance (BB sheet)

If the new project should inherit building blocks from existing projects
(or vice versa):

    Project          | BB-Type    | BB-Name        | Parent-Project
    -----------------|------------|----------------|---------------
    Verapamil-Model  | Compound   | Verapamil      | ParentProject
    Verapamil-Model  | Individual | European       | Population-Model

This is useful when: - Projects share common compounds, individuals, or
formulations - You want to ensure consistency across projects - Reducing
duplication of building block definitions

#### B. Add Plot Evaluations (All_Plots sheet)

Assign the new project’s simulation outputs to report sections:

- Find rows with green background (new project outputs)
- Fill the **Section Reference** column to include them in the report
- Leave blank to exclude specific outputs

#### C. Create Comparison Plots (CT_Plots, GOF_Plots, etc.)

Integrate the new project into existing comparison plots or create new
ones:

**Example: Adding to a Comparison Time Profile plot** 1. Go to
**CT_Plots** sheet, identify or create a plot 2. Go to **CT_Mapping**
sheet 3. Add rows mapping new simulation outputs and observed data to
the plot

    PlotId | Project         | Simulation      | Output          | ObservedData
    -------|-----------------|-----------------|-----------------|---------------
    CT-1   | Verapamil-Model | DDI-Scenario-1  | Concentration   | Clinical-PK

#### D. Configure Parameter Inheritance (SimParam sheet)

If simulations in the new project should inherit parameters from
existing projects:

    Project         | TargetSimulation | Parent Project | Parent Simulation | Path
    ----------------|------------------|----------------|-------------------|-----
    Verapamil-Model | Sim-1            | BaseModel      | Reference-Sim     | /Path/To/Parameter

#### E. Document Building Blocks (Inputs sheet)

Include building block documentation for the new project in the report:

    Project         | BB-Type    | BB-Name    | Section Reference
    ----------------|------------|------------|------------------
    Verapamil-Model | Compound   | Verapamil  | 2.1-compounds
    Verapamil-Model | Individual | European   | 2.2-individuals

### Excel File Preview

The Excel file will contain both existing and new content:

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
- Best Practices for Integration

| Qualification.plan.schema.version |
|----------------------------------:|
|                               3.3 |

| Id                               | Path                                                                                                                                      |
|:---------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------|
| Mefenamic_acid                   | <https://raw.githubusercontent.com/Open-Systems-Pharmacology/Mefenamic-acid-Model/v2.0/Mefenamic_acid-Model.json>                         |
| Dapagliflozin                    | <https://raw.githubusercontent.com/Open-Systems-Pharmacology/Dapagliflozin-Model/v2.0/Dapagliflozin-Model.json>                           |
| Raltegravir                      | <https://raw.githubusercontent.com/Open-Systems-Pharmacology/Raltegravir-Model/v2.0/Raltegravir-Model.json>                               |
| Atazanavir                       | <https://raw.githubusercontent.com/Open-Systems-Pharmacology/Atazanavir-Model/v2.0/Atazanavir-Model.json>                                 |
| Mefenamic_acid-Dapagliflozin-DDI | <https://raw.githubusercontent.com/Open-Systems-Pharmacology/Mefenamic_acid-Dapagliflozin-DDI/v1.2/Mefenamic_acid-Dapagliflozin-DDI.json> |
| Atazanavir-Raltegravir-DDI       | <https://raw.githubusercontent.com/Open-Systems-Pharmacology/Atazanavir-Raltegravir-DDI/v1.1/Atazanavir-Raltegravir-DDI.json>             |
| Verapamil                        | Verapamil-Model.json                                                                                                                      |

| Project                          | Simulation                                                             | Output                                                                                             |
|:---------------------------------|:-----------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------|
| Mefenamic_acid                   | PO MD 500 mg loading / 250 mg every 6 h                                | Organism\|PeripheralVenousBlood\|Mefenamic acid\|Plasma (Peripheral Venous Blood)                  |
| Mefenamic_acid                   | PO SD 250 mg                                                           | Organism\|PeripheralVenousBlood\|Mefenamic acid\|Plasma (Peripheral Venous Blood)                  |
| Mefenamic_acid                   | PO SD 500 mg                                                           | Organism\|PeripheralVenousBlood\|Mefenamic acid\|Plasma (Peripheral Venous Blood)                  |
| Dapagliflozin                    | IV 0.08 mg (perm)                                                      | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)                   |
| Dapagliflozin                    | PO SD 10 mg (perm)                                                     | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)                   |
| Dapagliflozin                    | PO SD 10 mg (perm)                                                     | Organism\|Kidney\|Urine\|Dapagliflozin\|Fraction excreted to urine                                 |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                     | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)                   |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                     | Organism\|Dapagliflozin-UGT1A9-Optimized Metabolite\|Total fraction of dose-Dapagliflozin          |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                     | Organism\|Dapagliflozin-UGT2B7-Optimized Metabolite\|Total fraction of dose-Dapagliflozin          |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                     | Organism\|Dapagliflozin-Hepatic-CYP-Optimized Metabolite\|Total fraction of dose-Dapagliflozin     |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                     | Organism\|Lumen\|Feces\|Dapagliflozin\|Fraction excreted to feces                                  |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                     | Organism\|Kidney\|Urine\|Dapagliflozin\|Fraction excreted to urine                                 |
| Dapagliflozin                    | PO SD 2.5 mg (perm)                                                    | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)                   |
| Dapagliflozin                    | PO SD 2.5 mg (perm)                                                    | Organism\|Kidney\|Urine\|Dapagliflozin\|Fraction excreted to urine                                 |
| Dapagliflozin                    | PO SD 5 mg (perm)                                                      | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)                   |
| Dapagliflozin                    | PO SD 5 mg (perm)                                                      | Organism\|Kidney\|Urine\|Dapagliflozin\|Fraction excreted to urine                                 |
| Dapagliflozin                    | PO SD 20 mg (perm)                                                     | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)                   |
| Dapagliflozin                    | PO SD 20 mg (perm)                                                     | Organism\|Kidney\|Urine\|Dapagliflozin\|Fraction excreted to urine                                 |
| Dapagliflozin                    | PO SD 100 mg (perm)                                                    | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)                   |
| Dapagliflozin                    | PO SD 100 mg (perm)                                                    | Organism\|Kidney\|Urine\|Dapagliflozin\|Fraction excreted to urine                                 |
| Dapagliflozin                    | PO SD 250 mg (perm)                                                    | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)                   |
| Dapagliflozin                    | PO SD 250 mg (perm)                                                    | Organism\|Kidney\|Urine\|Dapagliflozin\|Fraction excreted to urine                                 |
| Dapagliflozin                    | PO SD 500 mg (perm)                                                    | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)                   |
| Dapagliflozin                    | PO SD 500 mg (perm)                                                    | Organism\|Kidney\|Urine\|Dapagliflozin\|Fraction excreted to urine                                 |
| Dapagliflozin                    | PO SD 5 mg IC tablet (Chang 2015) (perm)                               | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)                   |
| Dapagliflozin                    | PO SD 250 mg fed (perm)                                                | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)                   |
| Dapagliflozin                    | PO SD 250 mg fed (perm)                                                | Organism\|Kidney\|Urine\|Dapagliflozin\|Fraction excreted to urine                                 |
| Dapagliflozin                    | PO SD 10 mg IC tablet (Chang 2015) (perm)                              | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)                   |
| Dapagliflozin                    | PO MD 10 mg (perm)                                                     | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)                   |
| Dapagliflozin                    | PO MD 10 mg (perm)                                                     | Organism\|Kidney\|Urine\|Dapagliflozin\|Fraction excreted to urine                                 |
| Dapagliflozin                    | PO MD 100 mg (perm)                                                    | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)                   |
| Dapagliflozin                    | PO MD 100 mg (perm)                                                    | Organism\|Kidney\|Urine\|Dapagliflozin\|Fraction excreted to urine                                 |
| Dapagliflozin                    | PO MD 2.5 mg (perm)                                                    | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)                   |
| Dapagliflozin                    | PO MD 2.5 mg (perm)                                                    | Organism\|Kidney\|Urine\|Dapagliflozin\|Fraction excreted to urine                                 |
| Dapagliflozin                    | PO MD 20 mg (perm)                                                     | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)                   |
| Dapagliflozin                    | PO MD 20 mg (perm)                                                     | Organism\|Kidney\|Urine\|Dapagliflozin\|Fraction excreted to urine                                 |
| Dapagliflozin                    | PO MD 50 mg (perm)                                                     | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)                   |
| Dapagliflozin                    | PO MD 50 mg (perm)                                                     | Organism\|Kidney\|Urine\|Dapagliflozin\|Fraction excreted to urine                                 |
| Raltegravir                      | Raltegravir 800 mg (lactose formulation)                               | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                     |
| Raltegravir                      | Raltegravir 10 mg (lactose formulation)                                | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                     |
| Raltegravir                      | Raltegravir 100 mg (lactose formulation)                               | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                     |
| Raltegravir                      | Raltegravir 1200 mg (lactose formulation)                              | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                     |
| Raltegravir                      | Raltegravir 1600 mg (lactose formulation)                              | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                     |
| Raltegravir                      | Raltegravir 200 mg (lactose formulation)                               | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                     |
| Raltegravir                      | Raltegravir 25 mg (lactose formulation)                                | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                     |
| Raltegravir                      | Raltegravir 50 mg (lactose formulation)                                | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                     |
| Raltegravir                      | Raltegravir 400mg chewable fasted                                      | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                     |
| Raltegravir                      | Raltegravir 400mg filmcoated tablet                                    | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                     |
| Raltegravir                      | Raltegravir 400mg (lactose formulation)                                | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                     |
| Raltegravir                      | Raltegravir 100 mg filmcoated tablet md                                | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                     |
| Raltegravir                      | Raltegravir 200 mg filmcoated tablet md                                | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                     |
| Raltegravir                      | Raltegravir 400 mg filmcoated tablet md                                | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                     |
| Raltegravir                      | Raltegravir 400mg (granules in suspension)                             | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                     |
| Raltegravir                      | Raltegravir 400mg chewable fed                                         | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                     |
| Atazanavir                       | Acosta2007_300mg                                                       | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                      |
| Atazanavir                       | Agarwala2003_400mg                                                     | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                      |
| Atazanavir                       | Agarwala2005a_400mg                                                    | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                      |
| Atazanavir                       | Agarwala2005b_400mg                                                    | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                      |
| Atazanavir                       | Martin2008_400mg                                                       | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                      |
| Atazanavir                       | Zhu2011_400mg                                                          | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                      |
| Atazanavir                       | FDA-ClinPharmReview_AI424-014_400mg_YoungFemales                       | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                      |
| Atazanavir                       | FDA-ClinPharmReview_AI424-028_200mg                                    | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                      |
| Atazanavir                       | FDA-ClinPharmReview_AI424-028_400mg                                    | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                      |
| Atazanavir                       | FDA-ClinPharmReview_AI424-040_200mg                                    | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                      |
| Atazanavir                       | FDA-ClinPharmReview_AI424-040_400mg                                    | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                      |
| Atazanavir                       | FDA-ClinPharmReview_AI424-040_800mg                                    | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                      |
| Atazanavir                       | FDA-ClinPharmReview_AI424-056_300mg                                    | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                      |
| Atazanavir                       | FDA-ClinPharmReview_AI424-076_400mg                                    | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                      |
| Atazanavir                       | FDA-ClinPharmReview_AI424-076_800mg                                    | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                      |
| Atazanavir                       | Zhu2010_300mg_Atazanavir                                               | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                      |
| Atazanavir                       | FDA-ClinPharmReview_AI424-004_400mg_TreatmentA                         | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                      |
| Atazanavir                       | FDA-ClinPharmReview_AI424-014_400mg_YoungMales                         | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                      |
| Atazanavir                       | FDA-ClinPharmReview_AI424-014_400mg_YoungMales                         | Organism\|Kidney\|Urine\|Atazanavir\|Fraction excreted to urine                                    |
| Atazanavir                       | FDA-ClinPharmReview_AI424-015_400mg_NormalSubjects                     | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                      |
| Mefenamic_acid-Dapagliflozin-DDI | DDI Control - Dapagliflozin - Kasichayanula 2013a                      | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)                   |
| Mefenamic_acid-Dapagliflozin-DDI | DDI Treatment - Mefenamic acid/Dapagliflozin - Kasichayanula 2013a     | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)                   |
| Mefenamic_acid-Dapagliflozin-DDI | DDI Treatment - Mefenamic acid/Dapagliflozin - Kasichayanula 2013a     | Organism\|PeripheralVenousBlood\|Mefenamic acid\|Plasma (Peripheral Venous Blood)                  |
| Atazanavir-Raltegravir-DDI       | Neely2010_Raltegravir                                                  | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                     |
| Atazanavir-Raltegravir-DDI       | Neely2010_Raltegravir+Atazanavir                                       | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                     |
| Atazanavir-Raltegravir-DDI       | Neely2010_Raltegravir+Atazanavir                                       | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                      |
| Atazanavir-Raltegravir-DDI       | Iwamoto2008_Raltegravir                                                | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                     |
| Atazanavir-Raltegravir-DDI       | Iwamoto2008_Raltegravir+Atazanavir                                     | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                     |
| Atazanavir-Raltegravir-DDI       | Iwamoto2008_Raltegravir+Atazanavir                                     | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                      |
| Atazanavir-Raltegravir-DDI       | Krishna2016_Raltegravir                                                | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                     |
| Atazanavir-Raltegravir-DDI       | Krishna2016_Raltegravir+Atazanavir                                     | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                     |
| Atazanavir-Raltegravir-DDI       | Krishna2016_Raltegravir+Atazanavir                                     | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                      |
| Atazanavir-Raltegravir-DDI       | Zhu2010_Raltegravir                                                    | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                     |
| Atazanavir-Raltegravir-DDI       | Zhu2010_Raltegravir+Atazanavir                                         | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                      |
| Atazanavir-Raltegravir-DDI       | Zhu2010_Raltegravir+Atazanavir                                         | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | iv_R-Verapamil 50 mg (5 min), Eichelbaum 1984, n=1                     | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | iv_R-Verapamil 50 mg (5 min), Eichelbaum 1984, n=1                     | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | iv_R-Verapamil 50 mg (5 min), Eichelbaum 1984, n=1                     | Organism\|Kidney\|Urine\|R-Verapamil\|Fraction excreted to urine                                   |
| Verapamil                        | iv_R-Verapamil 50 mg (5 min), Eichelbaum 1984, n=1                     | Organism\|Lumen\|Feces\|R-Verapamil\|Fraction excreted to feces                                    |
| Verapamil                        | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       | Organism\|Kidney\|Urine\|R-Verapamil\|Fraction excreted to urine                                   |
| Verapamil                        | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       | Organism\|Kidney\|Urine\|S-Verapamil\|Fraction excreted to urine                                   |
| Verapamil                        | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       | Organism\|Lumen\|Feces\|R-Verapamil\|Fraction excreted to feces                                    |
| Verapamil                        | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       | Organism\|Lumen\|Feces\|S-Verapamil\|Fraction excreted to feces                                    |
| Verapamil                        | po_Verapamil 16 mg SD (sol), Maeda 2011, n=8                           | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 16 mg SD (sol), Maeda 2011, n=8                           | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 16 mg SD (sol), Maeda 2011, n=8                           | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 16 mg SD (sol), Maeda 2011, n=8                           | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 16 mg SD (sol), Maeda 2011, n=8                           | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | po_Verapamil 16 mg SD (sol), Maeda 2011, n=8                           | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | po_Verapamil 240 mg QD (SR), Blume, Mutschler 1994, n=24               | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 240 mg QD (SR), Blume, Mutschler 1994, n=24               | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 240 mg QD (SR), Blume, Mutschler 1994, n=24               | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 240 mg QD (SR), Blume, Mutschler 1994, n=24               | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 240 mg QD (SR), Blume, Mutschler 1994, n=24               | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | po_Verapamil 240 mg QD (SR), Blume, Mutschler 1994, n=24               | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 120 mg SD, Johnston 1981, n=6                             | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 120 mg SD, Johnston 1981, n=6                             | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 120 mg SD, Johnston 1981, n=6                             | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 120 mg SD, Johnston 1981, n=6                             | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 120 mg SD, Johnston 1981, n=6                             | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | po_Verapamil 120 mg SD, Johnston 1981, n=6                             | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | po_Verapamil 120 mg SD, Johnston 1981, n=6                             | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | po_Verapamil 120 mg SD, Johnston 1981, n=6                             | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 120 mg SD, Johnston 1981, n=6                             | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | po_Verapamil 120 mg SD, Johnston 1981, n=6                             | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 120mg SD, Abernethy 1985, n=1                             | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 120mg SD, Abernethy 1985, n=1                             | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 120mg SD, Abernethy 1985, n=1                             | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 120mg SD, Abernethy 1985, n=1                             | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 120mg SD, Abernethy 1985, n=1                             | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | po_Verapamil 120mg SD, Abernethy 1985, n=1                             | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | po_Verapamil 120mg SD, Abernethy 1985, n=1                             | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | po_Verapamil 120mg SD, Abernethy 1985, n=1                             | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 120mg SD, Abernethy 1985, n=1                             | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | po_Verapamil 120mg SD, Abernethy 1985, n=1                             | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | po_R-Verapamil 250mg SD, Vogelgesang 1984, n=1                         | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_R-Verapamil 250mg SD, Vogelgesang 1984, n=1                         | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_R-Verapamil 250mg SD, Vogelgesang 1984, n=1                         | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | po_R-Verapamil 250mg SD, Vogelgesang 1984, n=1                         | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 0.1 mg SD (sol), Maeda 2011, n=8                          | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 0.1 mg SD (sol), Maeda 2011, n=8                          | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 0.1 mg SD (sol), Maeda 2011, n=8                          | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 0.1 mg SD (sol), Maeda 2011, n=8                          | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 0.1 mg SD (sol), Maeda 2011, n=8                          | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | po_Verapamil 0.1 mg SD (sol), Maeda 2011, n=8                          | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | po_Verapamil 3 mg SD (sol), Maeda 2011, n=8                            | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 3 mg SD (sol), Maeda 2011, n=8                            | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 3 mg SD (sol), Maeda 2011, n=8                            | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 3 mg SD (sol), Maeda 2011, n=8                            | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 3 mg SD (sol), Maeda 2011, n=8                            | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | po_Verapamil 3 mg SD (sol), Maeda 2011, n=8                            | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | po_Verapamil 80 mg SD (sol), Maeda 2011, n=8                           | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 80 mg SD (sol), Maeda 2011, n=8                           | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 80 mg SD (sol), Maeda 2011, n=8                           | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 80 mg SD (sol), Maeda 2011, n=8                           | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 80 mg SD (sol), Maeda 2011, n=8                           | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | po_Verapamil 80 mg SD (sol), Maeda 2011, n=8                           | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | po_Verapamil 40 mg SD, John 1992, n=6                                  | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 40 mg SD, John 1992, n=6                                  | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 40 mg SD, John 1992, n=6                                  | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 40 mg SD, John 1992, n=6                                  | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 40 mg SD, John 1992, n=6                                  | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | po_Verapamil 40 mg SD, John 1992, n=6                                  | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | po_Verapamil 40 mg SD, John 1992, n=6                                  | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | po_Verapamil 40 mg SD, John 1992, n=6                                  | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 40 mg SD, John 1992, n=6                                  | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | po_Verapamil 40 mg SD, John 1992, n=6                                  | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 60 mg SD, Choi 2008, n=12                                 | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 60 mg SD, Choi 2008, n=12                                 | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 60 mg SD, Choi 2008, n=12                                 | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 60 mg SD, Choi 2008, n=12                                 | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 60 mg SD, Choi 2008, n=12                                 | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | po_Verapamil 60 mg SD, Choi 2008, n=12                                 | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | po_Verapamil 60 mg SD, Choi 2008, n=12                                 | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | po_Verapamil 60 mg SD, Choi 2008, n=12                                 | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 60 mg SD, Choi 2008, n=12                                 | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | po_Verapamil 60 mg SD, Choi 2008, n=12                                 | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                | Organism\|Kidney\|Urine\|R-Verapamil\|Fraction excreted to urine                                   |
| Verapamil                        | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                | Organism\|Kidney\|Urine\|S-Verapamil\|Fraction excreted to urine                                   |
| Verapamil                        | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                | Organism\|Lumen\|Feces\|R-Verapamil\|Fraction excreted to feces                                    |
| Verapamil                        | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                | Organism\|Lumen\|Feces\|S-Verapamil\|Fraction excreted to feces                                    |
| Verapamil                        | po_Verapamil 120 mg SD, Hla 1987, n=10                                 | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 120 mg SD, Hla 1987, n=10                                 | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 120 mg SD, Hla 1987, n=10                                 | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 120 mg SD, Hla 1987, n=10                                 | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 120 mg SD, Hla 1987, n=10                                 | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | po_Verapamil 120 mg SD, Hla 1987, n=10                                 | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | po_Verapamil 120 mg MD, Hla 1987, n=10                                 | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 120 mg MD, Hla 1987, n=10                                 | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 120 mg MD, Hla 1987, n=10                                 | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 120 mg MD, Hla 1987, n=10                                 | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 120 mg MD, Hla 1987, n=10                                 | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | po_Verapamil 120 mg MD, Hla 1987, n=10                                 | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | iv_R-Verapamil 5 mg (5 min), Eichelbaum 1984, n=1                      | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | iv_R-Verapamil 5 mg (5 min), Eichelbaum 1984, n=1                      | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | iv_R-Verapamil 5 mg (5 min), Eichelbaum 1984, n=1                      | Organism\|Kidney\|Urine\|R-Verapamil\|Fraction excreted to urine                                   |
| Verapamil                        | iv_R-Verapamil 5 mg (5 min), Eichelbaum 1984, n=1                      | Organism\|Lumen\|Feces\|R-Verapamil\|Fraction excreted to feces                                    |
| Verapamil                        | iv_R-Verapamil 25 mg (5 min), Eichelbaum 1984, n=1                     | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | iv_R-Verapamil 25 mg (5 min), Eichelbaum 1984, n=1                     | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | iv_R-Verapamil 25 mg (5 min), Eichelbaum 1984, n=1                     | Organism\|Kidney\|Urine\|R-Verapamil\|Fraction excreted to urine                                   |
| Verapamil                        | iv_R-Verapamil 25 mg (5 min), Eichelbaum 1984, n=1                     | Organism\|Lumen\|Feces\|R-Verapamil\|Fraction excreted to feces                                    |
| Verapamil                        | iv_S-Verapamil 5 mg SD (5min), Eichelbaum 1984, n=1                    | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | iv_S-Verapamil 5 mg SD (5min), Eichelbaum 1984, n=1                    | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | iv_S-Verapamil 5 mg SD (5min), Eichelbaum 1984, n=1                    | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | iv_S-Verapamil 5 mg SD (5min), Eichelbaum 1984, n=1                    | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | iv_S-Verapamil 7.5 mg SD (5min), Eichelbaum 1984, n=1                  | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | iv_S-Verapamil 7.5 mg SD (5min), Eichelbaum 1984, n=1                  | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | iv_S-Verapamil 7.5 mg SD (5min), Eichelbaum 1984, n=1                  | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | iv_S-Verapamil 7.5 mg SD (5min), Eichelbaum 1984, n=1                  | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | iv_S-Verapamil 10 mg SD (5min), Eichelbaum 1984, n=1                   | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | iv_S-Verapamil 10 mg SD (5min), Eichelbaum 1984, n=1                   | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | iv_S-Verapamil 10 mg SD (5min), Eichelbaum 1984, n=1                   | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | iv_S-Verapamil 10 mg SD (5min), Eichelbaum 1984, n=1                   | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 240 mg SD, Karim 1995, n=12                               | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 240 mg SD, Karim 1995, n=12                               | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 240 mg SD, Karim 1995, n=12                               | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 240 mg SD, Karim 1995, n=12                               | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 240 mg SD, Karim 1995, n=12                               | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | po_Verapamil 240 mg SD, Karim 1995, n=12                               | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | po_Verapamil 240 mg SD, Karim 1995, n=12                               | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | po_Verapamil 240 mg SD, Karim 1995, n=12                               | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 240 mg SD, Karim 1995, n=12                               | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | po_Verapamil 240 mg SD, Karim 1995, n=12                               | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | iv_Verapamil 10 mg (bol), Smith 1984, n=8                              | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | iv_Verapamil 10 mg (bol), Smith 1984, n=8                              | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | iv_Verapamil 10 mg (bol), Smith 1984, n=8                              | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | iv_Verapamil 10 mg (bol), Smith 1984, n=8                              | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | iv_Verapamil 10 mg (bol), Smith 1984, n=8                              | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | iv_Verapamil 10 mg (bol), Smith 1984, n=8                              | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | po_Verapamil 120 mg SD, Smith 1984, n=8                                | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 120 mg SD, Smith 1984, n=8                                | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 120 mg SD, Smith 1984, n=8                                | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 120 mg SD, Smith 1984, n=8                                | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 120 mg SD, Smith 1984, n=8                                | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | po_Verapamil 120 mg SD, Smith 1984, n=8                                | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 80mg SD, Wing 1985, n=1                                   | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 80mg SD, Wing 1985, n=1                                   | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 80mg SD, Wing 1985, n=1                                   | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 80mg SD, Wing 1985, n=1                                   | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 80mg SD, Wing 1985, n=1                                   | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | po_Verapamil 80mg SD, Wing 1985, n=1                                   | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | po_Verapamil 80mg SD, Wing 1985, n=1                                   | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | po_Verapamil 80mg SD, Wing 1985, n=1                                   | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 80mg SD, Wing 1985, n=1                                   | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | po_Verapamil 80mg SD, Wing 1985, n=1                                   | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 160 mg SD, Mikus 1990, n=1                                | Organism\|PeripheralVenousBlood\|R-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 160 mg SD, Mikus 1990, n=1                                | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 160 mg SD, Mikus 1990, n=1                                | Organism\|PeripheralVenousBlood\|S-Verapamil\|Plasma (Peripheral Venous Blood)                     |
| Verapamil                        | po_Verapamil 160 mg SD, Mikus 1990, n=1                                | Organism\|PeripheralVenousBlood\|S-Norverapamil\|Plasma (Peripheral Venous Blood)                  |
| Verapamil                        | po_Verapamil 160 mg SD, Mikus 1990, n=1                                | Organism\|PeripheralVenousBlood\|R-Verapamil\|Sum-Verapamil Plasma (Peripheral Venous Blood)       |
| Verapamil                        | po_Verapamil 160 mg SD, Mikus 1990, n=1                                | Organism\|PeripheralVenousBlood\|R-Norverapamil\|Sum-Norverapamil Plasma (Peripheral Venous Blood) |
| Verapamil                        | po_Verapamil 160 mg SD, Mikus 1990, n=1                                | Organism\|Kidney\|Urine\|R-Verapamil                                                               |
| Verapamil                        | po_Verapamil 160 mg SD, Mikus 1990, n=1                                | Organism\|Kidney\|Urine\|R-Norverapamil                                                            |
| Verapamil                        | po_Verapamil 160 mg SD, Mikus 1990, n=1                                | Organism\|Kidney\|Urine\|S-Verapamil                                                               |
| Verapamil                        | po_Verapamil 160 mg SD, Mikus 1990, n=1                                | Organism\|Kidney\|Urine\|S-Norverapamil                                                            |

| Project                          | Simulation                                                             | ObservedData                                                                                                                                                        |
|:---------------------------------|:-----------------------------------------------------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Mefenamic_acid                   | PO SD 250 mg                                                           | Rouini 2005 - Reference - Mefenamic acid - PO - 250 mg - Plasma - agg. (n=12)                                                                                       |
| Mefenamic_acid                   | PO SD 250 mg                                                           | Mahadik 2012 - Reference - Mefenamic acid - PO - 250 mg - Plasma - agg. (n=12)                                                                                      |
| Mefenamic_acid                   | PO SD 250 mg                                                           | Hamaguchi 1987 - Treatment 2 - fasted with 200 mL of water - Mefenamic acid - PO - 250 mg - Plasma - agg. (n=4)                                                     |
| Mefenamic_acid                   | PO SD 500 mg                                                           | Goosen 2017 - 500 mg SD - Mefenamic acid - PO - 500 mg - Plasma - agg.                                                                                              |
| Dapagliflozin                    | IV 0.08 mg (perm)                                                      | Boulton 2013 - 14C-dapagliflozin iv - Dapagliflozin - IV - 0.08 mg - Plasma - agg. (n=7)                                                                            |
| Dapagliflozin                    | PO SD 10 mg (perm)                                                     | Boulton 2013 - Dapagliflozin po - Dapagliflozin - PO - 10 mg - Plasma - agg. (n=7)                                                                                  |
| Dapagliflozin                    | PO SD 10 mg (perm)                                                     | Imamura 2013 - Control (Perpetrator Placebo) - Dapagliflozin - PO - 10 mg - Plasma - agg. (n=22)                                                                    |
| Dapagliflozin                    | PO SD 10 mg (perm)                                                     | Kasichayanula 2011a - fasted - Dapagliflozin - PO - 10 mg - Plasma - agg. (n=14)                                                                                    |
| Dapagliflozin                    | PO SD 10 mg (perm)                                                     | Kasichayanula 2013a - Study 1: Control (Perpetrator Placebo) - Dapagliflozin - PO - 10 mg - Plasma - agg. (n=14)                                                    |
| Dapagliflozin                    | PO SD 10 mg (perm)                                                     | Kasichayanula 2013a - Study 2: Control (Perpetrator Placebo) - Dapagliflozin - PO - 10 mg - Plasma - agg. (n=16)                                                    |
| Dapagliflozin                    | PO SD 10 mg (perm)                                                     | Vakkalagadda 2016 - Dapagliflozin - Dapagliflozin - PO - 10 mg - Plasma - agg. (n=42)                                                                               |
| Dapagliflozin                    | PO SD 10 mg (perm)                                                     | Kasichayanula 2011c - Healthy Volunteers - Dapagliflozin - PO - 10 mg - Plasma - agg. (n=6)                                                                         |
| Dapagliflozin                    | PO SD 10 mg (perm)                                                     | Komoroski 2009 - SAD 10 mg - Dapagliflozin - PO - 10 mg - Plasma - agg. (n=6)                                                                                       |
| Dapagliflozin                    | PO SD 10 mg (perm)                                                     | Komoroski 2009 - SAD 10 mg (Urine) - Dapagliflozin - PO - 10 mg - Urine - agg. (n=6)                                                                                |
| Dapagliflozin                    | PO SD 10 mg (perm)                                                     | Komoroski 2009 - MAD 10 mg (day 1) - Dapagliflozin - PO - 10 mg - Plasma - agg. (n=6)                                                                               |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                     | Kasichayanula 2011b - Study 1: 50 mg Control (Perpetrator Placebo) - Dapagliflozin - PO - 50 mg - Plasma - agg. (n=24)                                              |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                     | Kasichayanula 2013b - Healthy subjects with normal kidney function - Dapagliflozin - PO - 50 mg - Plasma - agg. (n=8)                                               |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                     | Kasichayanula 2008 - Mass Balance of 14C-dapagliflozin Urine - Dapagliflozin - PO - 50 mg - Urine - agg. (n=6)                                                      |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                     | Kasichayanula 2008 - Mass Balance of 14C-dapagliflozin Feces - Dapagliflozin - PO - 50 mg - Feces - agg. (n=6)                                                      |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                     | Kasichayanula 2008 - Mass Balance of 14C-dapagliflozin 3OG Gluc - Dapagliflozin-3-O-glucuronide - PO - 50 mg - Fraction - agg. (n=6)                                |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                     | Kasichayanula 2008 - Mass Balance of 14C-dapagliflozin 2OG Gluc - Dapagliflozin-2-O-glucuronide - PO - 50 mg - Fraction - agg. (n=6)                                |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                     | Kasichayanula 2008 - Mass Balance of 14C-dapagliflozin oxid Metab - Dapagliflozin oxidative metabolites - PO - 50 mg - Fraction - agg. (n=6)                        |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                     | Kasichayanula 2008 - Mass Balance of 14C-dapagliflozin 3OG Gluc (incl. unchanged feces exret.) - Dapagliflozin-3-O-glucuronide - PO - 50 mg - Fraction - agg. (n=6) |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                     | Kasichayanula 2008 - Mass Balance of 14C-dapagliflozin 2OG Gluc (incl. unchanged feces exret.) - Dapagliflozin-2-O-glucuronide - PO - 50 mg - Fraction - agg. (n=6) |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                     | Komoroski 2009 - SAD 50 mg - Dapagliflozin - PO - 50 mg - Plasma - agg. (n=6)                                                                                       |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                     | Komoroski 2009 - SAD 50 mg (Urine) - Dapagliflozin - PO - 50 mg - Urine - agg. (n=6)                                                                                |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                     | Komoroski 2009 - MAD 50 mg (day 1) - Dapagliflozin - PO - 50 mg - Plasma - agg. (n=6)                                                                               |
| Dapagliflozin                    | PO SD 2.5 mg (perm)                                                    | Komoroski 2009 - SAD 2.5 mg - Dapagliflozin - PO - 2.5 mg - Plasma - agg. (n=6)                                                                                     |
| Dapagliflozin                    | PO SD 2.5 mg (perm)                                                    | Komoroski 2009 - SAD 2.5 mg (Urine) - Dapagliflozin - PO - 2.5 mg - Urine - agg. (n=6)                                                                              |
| Dapagliflozin                    | PO SD 2.5 mg (perm)                                                    | Komoroski 2009 - MAD 2.5 mg (day 1) - Dapagliflozin - PO - 2.5 mg - Plasma - agg. (n=6)                                                                             |
| Dapagliflozin                    | PO SD 5 mg (perm)                                                      | Komoroski 2009 - SAD 5 mg - Dapagliflozin - PO - 5 mg - Plasma - agg. (n=6)                                                                                         |
| Dapagliflozin                    | PO SD 5 mg (perm)                                                      | Komoroski 2009 - SAD 5 mg (Urine) - Dapagliflozin - PO - 5 mg - Urine - agg. (n=6)                                                                                  |
| Dapagliflozin                    | PO SD 20 mg (perm)                                                     | Kasichayanula 2012 - Study 1: Control (Perpetrator Placebo) - Dapagliflozin - PO - 20 mg - Plasma - agg. (n=24)                                                     |
| Dapagliflozin                    | PO SD 20 mg (perm)                                                     | Komoroski 2009 - SAD 20 mg - Dapagliflozin - PO - 20 mg - Plasma - agg. (n=6)                                                                                       |
| Dapagliflozin                    | PO SD 20 mg (perm)                                                     | Komoroski 2009 - SAD 20 mg (Urine) - Dapagliflozin - PO - 20 mg - Urine - agg. (n=6)                                                                                |
| Dapagliflozin                    | PO SD 20 mg (perm)                                                     | Komoroski 2009 - MAD 20 mg (day 1) - Dapagliflozin - PO - 20 mg - Plasma - agg. (n=6)                                                                               |
| Dapagliflozin                    | PO SD 20 mg (perm)                                                     | Kasichayanula 2011b - Study 2: 20 mg Control (Perpetrator Placebo) - Dapagliflozin - PO - 20 mg - Plasma - agg. (n=18)                                              |
| Dapagliflozin                    | PO SD 20 mg (perm)                                                     | Kasichayanula 2011b - Study 3: 20 mg Control (Perpetrator Placebo) - Dapagliflozin - PO - 20 mg - Plasma - agg. (n=18)                                              |
| Dapagliflozin                    | PO SD 100 mg (perm)                                                    | Komoroski 2009 - SAD 100 mg - Dapagliflozin - PO - 100 mg - Plasma - agg. (n=6)                                                                                     |
| Dapagliflozin                    | PO SD 100 mg (perm)                                                    | Komoroski 2009 - SAD 100 mg (Urine) - Dapagliflozin - PO - 100 mg - Urine - agg. (n=6)                                                                              |
| Dapagliflozin                    | PO SD 100 mg (perm)                                                    | Komoroski 2009 - MAD 100 mg (day 1) - Dapagliflozin - PO - 100 mg - Plasma - agg. (n=6)                                                                             |
| Dapagliflozin                    | PO SD 250 mg (perm)                                                    | Komoroski 2009 - SAD 250 mg fasted - Dapagliflozin - PO - 250 mg - Plasma - agg. (n=6)                                                                              |
| Dapagliflozin                    | PO SD 250 mg (perm)                                                    | Komoroski 2009 - SAD 250 mg fasted (Urine) - Dapagliflozin - PO - 250 mg - Urine - agg. (n=6)                                                                       |
| Dapagliflozin                    | PO SD 500 mg (perm)                                                    | Komoroski 2009 - SAD 500 mg - Dapagliflozin - PO - 500 mg - Plasma - agg. (n=6)                                                                                     |
| Dapagliflozin                    | PO SD 500 mg (perm)                                                    | Komoroski 2009 - SAD 500 mg (Urine) - Dapagliflozin - PO - 500 mg - Urine - agg. (n=6)                                                                              |
| Dapagliflozin                    | PO SD 5 mg IC tablet (Chang 2015) (perm)                               | Chang 2015 - Study 1 Treatment A (single oral doses) - Dapagliflozin - PO - 5 mg - Plasma - agg. (n=36)                                                             |
| Dapagliflozin                    | PO SD 250 mg fed (perm)                                                | Komoroski 2009 - SAD 250 mg fed - Dapagliflozin - PO - 250 mg - Plasma - agg. (n=6)                                                                                 |
| Dapagliflozin                    | PO SD 10 mg IC tablet (Chang 2015) (perm)                              | Chang 2015 - Study 2 Treatment A (single oral doses) - Dapagliflozin - PO - 10 mg - Plasma - agg. (n=36)                                                            |
| Dapagliflozin                    | PO MD 10 mg (perm)                                                     | Komoroski 2009 - MAD 10 mg (day 1) - Dapagliflozin - PO - 10 mg - Plasma - agg. (n=6)                                                                               |
| Dapagliflozin                    | PO MD 10 mg (perm)                                                     | Komoroski 2009 - MAD 10 mg (day 7 and day 14) - Dapagliflozin - PO - 10 mg - Plasma - agg. (n=6)                                                                    |
| Dapagliflozin                    | PO MD 100 mg (perm)                                                    | Komoroski 2009 - MAD 100 mg (day 1) - Dapagliflozin - PO - 100 mg - Plasma - agg. (n=6)                                                                             |
| Dapagliflozin                    | PO MD 100 mg (perm)                                                    | Komoroski 2009 - MAD 100 mg (day 7 and day 14) - Dapagliflozin - PO - 100 mg - Plasma - agg. (n=6)                                                                  |
| Dapagliflozin                    | PO MD 2.5 mg (perm)                                                    | Komoroski 2009 - MAD 2.5 mg (day 7 and day 14) - Dapagliflozin - PO - 2.5 mg - Plasma - agg. (n=6)                                                                  |
| Dapagliflozin                    | PO MD 2.5 mg (perm)                                                    | Komoroski 2009 - MAD 2.5 mg (day 1) - Dapagliflozin - PO - 2.5 mg - Plasma - agg. (n=6)                                                                             |
| Dapagliflozin                    | PO MD 20 mg (perm)                                                     | Komoroski 2009 - MAD 20 mg (day 1) - Dapagliflozin - PO - 20 mg - Plasma - agg. (n=6)                                                                               |
| Dapagliflozin                    | PO MD 20 mg (perm)                                                     | Komoroski 2009 - MAD 20 mg (day 7 and day 14) - Dapagliflozin - PO - 20 mg - Plasma - agg. (n=6)                                                                    |
| Dapagliflozin                    | PO MD 50 mg (perm)                                                     | Komoroski 2009 - MAD 50 mg (day 1) - Dapagliflozin - PO - 50 mg - Plasma - agg. (n=6)                                                                               |
| Dapagliflozin                    | PO MD 50 mg (perm)                                                     | Komoroski 2009 - MAD 50 mg (day 7 and day 14) - Dapagliflozin - PO - 50 mg - Plasma - agg. (n=6)                                                                    |
| Raltegravir                      | Raltegravir 800 mg (lactose formulation)                               | Iwamoto 2008 - 800mg - Raltegravir - PO - 800 mg - Plasma - agg. (n=24)                                                                                             |
| Raltegravir                      | Raltegravir 10 mg (lactose formulation)                                | Iwamoto 2008 - 10mg - Raltegravir - PO - 10 mg - Plasma - agg. (n=24)                                                                                               |
| Raltegravir                      | Raltegravir 100 mg (lactose formulation)                               | Iwamoto 2008 - 100mg - Raltegravir - PO - 100 mg - Plasma - agg. (n=24)                                                                                             |
| Raltegravir                      | Raltegravir 1200 mg (lactose formulation)                              | Iwamoto 2008 - 1200mg - Raltegravir - PO - 1200 mg - Plasma - agg. (n=24)                                                                                           |
| Raltegravir                      | Raltegravir 1600 mg (lactose formulation)                              | Iwamoto 2008 - 1600mg - Raltegravir - PO - 1600 mg - Plasma - agg. (n=24)                                                                                           |
| Raltegravir                      | Raltegravir 200 mg (lactose formulation)                               | Iwamoto 2008 - 200mg - Raltegravir - PO - 200 mg - Plasma - agg. (n=24)                                                                                             |
| Raltegravir                      | Raltegravir 25 mg (lactose formulation)                                | Iwamoto 2008 - 25mg - Raltegravir - PO - 25 mg - Plasma - agg. (n=24)                                                                                               |
| Raltegravir                      | Raltegravir 50 mg (lactose formulation)                                | Iwamoto 2008 - 50mg - Raltegravir - PO - 50 mg - Plasma - agg. (n=24)                                                                                               |
| Raltegravir                      | Raltegravir 400mg chewable fasted                                      | Rhee 2014 - Chewable tablet fasted - Raltegravir - po - 400 mg - Plasma - agg. (n=12)                                                                               |
| Raltegravir                      | Raltegravir 400mg filmcoated tablet                                    | Rhee 2014 - filmcoated tablet - Raltegravir - po - 400 mg - Plasma - agg. (n=12)                                                                                    |
| Raltegravir                      | Raltegravir 400mg filmcoated tablet                                    | Wenning 2009 - 400mg - Raltegravir - PO - 400 mg - Plasma - agg. (n=10)                                                                                             |
| Raltegravir                      | Raltegravir 400mg filmcoated tablet                                    | Iwamoto 2008 - 400mg FCT - Raltegravir - PO - 400 mg - Plasma - agg. (n=14)                                                                                         |
| Raltegravir                      | Raltegravir 400mg (lactose formulation)                                | Iwamoto 2008 - 400mg - Raltegravir - PO - 400 mg - Plasma - agg. (n=24)                                                                                             |
| Raltegravir                      | Raltegravir 100 mg filmcoated tablet md                                | Markowitz 2006 - 100mg FCT MD - Raltegravir - PO - 100 mg - Plasma - agg. (n=7)                                                                                     |
| Raltegravir                      | Raltegravir 200 mg filmcoated tablet md                                | Markowitz 2006 - 200mg FCT MD - Raltegravir - PO - 200 mg - Plasma - agg. (n=7)                                                                                     |
| Raltegravir                      | Raltegravir 200 mg filmcoated tablet md                                | Kassahun 2007 - 200mg FCT SD - Raltegravir - PO - 200 mg - Plasma - agg. (n=8)                                                                                      |
| Raltegravir                      | Raltegravir 400 mg filmcoated tablet md                                | Markowitz 2006 - 400mg FCT MD - Raltegravir - PO - 400 mg - Plasma - agg. (n=6)                                                                                     |
| Raltegravir                      | Raltegravir 400mg (granules in suspension)                             | Rhee 2014 - granules suspension - Raltegravir - po - 400 mg - Plasma - agg. (n=12)                                                                                  |
| Raltegravir                      | Raltegravir 400mg chewable fed                                         | Rhee 2014 - Chewable tablet fed - Raltegravir - po - 400 mg - Plasma - agg. (n=12)                                                                                  |
| Atazanavir                       | Acosta2007_300mg                                                       | Acosta 2007 - Period 1 - Atazanavir - PO - 300 mg - Plasma - agg. (n=10)                                                                                            |
| Atazanavir                       | Agarwala2003_400mg                                                     | Agarwala 2003 - Day 6 - Atazanavir - PO - 400 mg - Plasma - agg. (n=65)                                                                                             |
| Atazanavir                       | Agarwala2005a_400mg                                                    | Agarwala 2005a - ATV 400 mg AM (N=15) - Atazanavir - PO - 400 mg - Plasma - agg. (n=15)                                                                             |
| Atazanavir                       | Agarwala2005b_400mg                                                    | Agarwala 2005b - ATV 400 mg (Treatment A) - Atazanavir - PO - 400 mg - Plasma - agg. (n=16)                                                                         |
| Atazanavir                       | Martin2008_400mg                                                       | Martin 2008 - Atazanavir monotherapy (n = 24) - Atazanavir - PO - 400 mg - Plasma - agg. (n=24)                                                                     |
| Atazanavir                       | Zhu2011_400mg                                                          | Zhu 2011 - Treatment A: Atazanavir 400 mg QPM - Atazanavir - PO - 400 mg - Plasma - agg. (n=28)                                                                     |
| Atazanavir                       | Zhu2011_400mg                                                          | Zhu 2011 - Treatment B: Atazanavir 400 mg QAM - Atazanavir - PO - 400 mg - Plasma - agg. (n=28)                                                                     |
| Atazanavir                       | FDA-ClinPharmReview_AI424-014_400mg_YoungFemales                       | ClinPharmReview, AI424-014, p. 77 - Young Females - Atazanavir - PO - 400 mg - Plasma - agg. (n=14)                                                                 |
| Atazanavir                       | FDA-ClinPharmReview_AI424-028_200mg                                    | ClinPharmReview, AI424-028, p. 128 - A-Day 6 - Atazanavir - PO - 200 mg - Plasma - agg. (n=8)                                                                       |
| Atazanavir                       | FDA-ClinPharmReview_AI424-028_200mg                                    | ClinPharmReview, AI424-028, p. 128 - B-Day 6 - Atazanavir - PO - 200 mg - Plasma - agg. (n=8)                                                                       |
| Atazanavir                       | FDA-ClinPharmReview_AI424-028_400mg                                    | ClinPharmReview, AI424-028, p. 128 - C-Day 6 - Atazanavir - PO - 400 mg - Plasma - agg. (n=8)                                                                       |
| Atazanavir                       | FDA-ClinPharmReview_AI424-028_400mg                                    | ClinPharmReview, AI424-028, p. 128 - D-Day 6 - Atazanavir - PO - 400 mg - Plasma - agg. (n=8)                                                                       |
| Atazanavir                       | FDA-ClinPharmReview_AI424-040_200mg                                    | ClinPharmReview, AI424-040, p. 64 - 200 mg - Atazanavir - PO - 200 mg - Plasma - agg. (n=20)                                                                        |
| Atazanavir                       | FDA-ClinPharmReview_AI424-040_400mg                                    | ClinPharmReview, AI424-040, p. 64 - 400 mg - Atazanavir - PO - 400 mg - Plasma - agg. (n=20)                                                                        |
| Atazanavir                       | FDA-ClinPharmReview_AI424-040_800mg                                    | ClinPharmReview, AI424-040, p. 64 - 800 mg - Atazanavir - PO - 800 mg - Plasma - agg. (n=20)                                                                        |
| Atazanavir                       | FDA-ClinPharmReview_AI424-056_300mg                                    | ClinPharmReview, AI424-056, p. 134 - Atazanavir without ritonavir, Day 10 - Atazanavir - PO - 300 mg - Plasma - agg. (n=30)                                         |
| Atazanavir                       | FDA-ClinPharmReview_AI424-076_400mg                                    | ClinPharmReview, AI424-076, p. 178 - 400 mg - Atazanavir - PO - 400 mg - Plasma - agg. (n=65)                                                                       |
| Atazanavir                       | FDA-ClinPharmReview_AI424-076_800mg                                    | ClinPharmReview, AI424-076, p. 178 - 800 mg - Atazanavir - PO - 800 mg - Plasma - agg. (n=66)                                                                       |
| Atazanavir                       | Zhu2010_300mg_Atazanavir                                               | Zhu 2010 - Atazanvir 300 mg twice daily - Atazanavir - PO - 300 mg - Plasma - agg. (n=22)                                                                           |
| Atazanavir                       | FDA-ClinPharmReview_AI424-004_400mg_TreatmentA                         | ClinPharmReview, AI424-004, p. 94 - Treatment A - Atazanavir - PO - 400 mg - Plasma - agg. (n=32)                                                                   |
| Atazanavir                       | FDA-ClinPharmReview_AI424-014_400mg_YoungMales                         | ClinPharmReview, AI424-029, p. 47 - Urinary radioactivity - Atazanavir - PO - 400 - Urine - agg. (n=12)                                                             |
| Atazanavir                       | FDA-ClinPharmReview_AI424-014_400mg_YoungMales                         | ClinPharmReview, AI424-014, p. 77 - Young Males - Atazanavir - PO - 400 mg - Plasma - agg. (n=15)                                                                   |
| Atazanavir                       | FDA-ClinPharmReview_AI424-015_400mg_NormalSubjects                     | ClinPharmReview, AI424-015, p. 81 - Normal subjects - Atazanavir - PO - 400 mg - Plasma - agg. (n=16)                                                               |
| Mefenamic_acid-Dapagliflozin-DDI | DDI Control - Dapagliflozin - Kasichayanula 2013a                      | Kasichayanula 2013a - Study 2: Control (Perpetrator Placebo) - Dapagliflozin - PO - 10 mg - Plasma - agg. (n=16)                                                    |
| Mefenamic_acid-Dapagliflozin-DDI | DDI Treatment - Mefenamic acid/Dapagliflozin - Kasichayanula 2013a     | Kasichayanula 2013a - Study 2: with Perpetrator (Mefenamic Acid) - Dapagliflozin - PO - 10 mg - Plasma - agg. (n=16)                                                |
| Atazanavir-Raltegravir-DDI       | Neely2010_Raltegravir                                                  | Neely 2010 - Study arm A (Raltegravir 400mg BID) - Raltegravir - PO - 400 mg - Plasma - agg. (n=20)                                                                 |
| Atazanavir-Raltegravir-DDI       | Neely2010_Raltegravir+Atazanavir                                       | Neely 2010 - Study arm B (Raltegravir 400mg OD + Atazanavir 400 mg OD) - Raltegravir - PO - 400 mg - Plasma - agg. (n=19)                                           |
| Atazanavir-Raltegravir-DDI       | Iwamoto2008_Raltegravir                                                | Iwamoto 2008 - Study I, Period 1 (control) - Raltegravir - PO - 100 mg - Plasma - agg. (n=10)                                                                       |
| Atazanavir-Raltegravir-DDI       | Iwamoto2008_Raltegravir+Atazanavir                                     | Iwamoto 2008 - Study I, Period 2 (ATV treatment) - Raltegravir - PO - 100 mg - Plasma - agg. (n=10)                                                                 |
| Atazanavir-Raltegravir-DDI       | Krishna2016_Raltegravir                                                | Krishna 2016 - Period 1, Day 1 (1200 mg raltegravir SD) - Raltegravir - PO - 1200 mg - Plasma - agg. (n=14)                                                         |
| Atazanavir-Raltegravir-DDI       | Krishna2016_Raltegravir+Atazanavir                                     | Krishna 2016 - Period 2, Day 7 (1200 mg raltegravir SD with OD doses of 400 mg ATV) - Raltegravir - PO - 1200 mg - Plasma - agg. (n=12)                             |
| Atazanavir-Raltegravir-DDI       | Zhu2010_Raltegravir                                                    | Zhu 2010 - Raltegravir 400 mg twice daily - Raltegravir - PO - 400 mg - Plasma - agg. (n=22)                                                                        |
| Atazanavir-Raltegravir-DDI       | Zhu2010_Raltegravir+Atazanavir                                         | Zhu 2010 - Raltegravir 400 mg twice daily plus atazanavir 300 mg twice daily - Raltegravir - PO - 400 mg - Plasma - agg. (n=19)                                     |
| Atazanavir-Raltegravir-DDI       | Zhu2010_Raltegravir+Atazanavir                                         | Zhu 2010 - Atazanvir 300 mg twice daily plus raltegravir 400 mg twice daily - Atazanavir - PO - 300 mg - Plasma - agg. (n=19)                                       |
| Verapamil                        | iv_R-Verapamil 50 mg (5 min), Eichelbaum 1984, n=1                     | Eichelbaum 1984 - Subject 4 - R-Verapamil - IV - 50 mg - Plasma - indiv.                                                                                            |
| Verapamil                        | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       | Härtter et al. 2012 - 120mg po SD - R-Norverapamil - PO - 120 mg - Plasma - agg. (n=19)                                                                             |
| Verapamil                        | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       | Härtter et al. 2012 - 120mg po SD - R-Verapamil - PO - 120 mg - Plasma - agg. (n=19)                                                                                |
| Verapamil                        | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       | Härtter et al. 2012 - 120mg po SD - S-Norverapamil - PO - 120 mg - Plasma - agg. (n=19)                                                                             |
| Verapamil                        | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       | Härtter et al. 2012 - 120mg po SD - S-Verapamil - PO - 120 mg - Plasma - agg. (n=19)                                                                                |
| Verapamil                        | po_Verapamil 16 mg SD (sol), Maeda 2011, n=8                           | Maeda 2011 - Verapamil 16 mg - Verapamil - PO - 16 mg - Plasma - agg. (n=8)                                                                                         |
| Verapamil                        | po_Verapamil 16 mg SD (sol), Maeda 2011, n=8                           | Maeda 2011 - Verapamil 16 mg - Norverapamil - Norverapamil - PO - 16 mg - Plasma - agg. (n=8)                                                                       |
| Verapamil                        | po_Verapamil 240 mg QD (SR), Blume, Mutschler 1994, n=24               | Blume, Mutschler 1994 - Verapamil - Verapamil - PO - 240 mg - Plasma - agg. (n=24)                                                                                  |
| Verapamil                        | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            | Mooy et al. 1985 - Normal volunteers, 3mg IV - Verapamil - IV - 3 mg - Plasma - agg. (n=5)                                                                          |
| Verapamil                        | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  | Mooy et al. 1985 - Normal volunteers, 80mg PO - Verapamil - PO - 80 mg - Plasma - agg. (n=6)                                                                        |
| Verapamil                        | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  | Mooy et al. 1985 - Normal volunteers, 80mg PO - Norverapamil - PO - 80 mg - Plasma - agg. (n=6)                                                                     |
| Verapamil                        | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         | Streit 2005 - intravenous verapamil during normoxia (5 mg) - Verapamil - IV - 5 mg - Plasma - agg. (n=10)                                                           |
| Verapamil                        | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         | Streit et al. 2005 - intravenous verapamil during normoxia (5 mg) - Norverapamil - IV - 5 mg - Plasma - agg. (n=10)                                                 |
| Verapamil                        | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   | Johnston 1981 - Verapamil IV - Verapamil - IV - 0.1 mg/kg - Plasma - agg. (n=6)                                                                                     |
| Verapamil                        | po_Verapamil 120 mg SD, Johnston 1981, n=6                             | Johnston 1981 - Verapamil PO - Verapamil - PO - 120 mg - Plasma - agg. (n=6)                                                                                        |
| Verapamil                        | po_Verapamil 120 mg SD, Johnston 1981, n=6                             | Johnston 1981 - Verapamil PO - Norverapamil - PO - 120 mg - Plasma - agg. (n=6)                                                                                     |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      | Abernethy et al. 1985 - 10mg Verapamil without cimetidine, IV - Verapamil - IV - 10 mg - Plasma - indiv.                                                            |
| Verapamil                        | po_Verapamil 120mg SD, Abernethy 1985, n=1                             | Abernethy et al. 1985 - 120mg Verapamil without cimetidine, PO - Verapamil - PO - 120 mg - Plasma - indiv.                                                          |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      | Barbarash 1988 - Verapamil IV control - Verapamil - IV - 10 mg - Serum - agg. (n=6)                                                                                 |
| Verapamil                        | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            | Barbarash 1988 - Verapamil PO control - Verapamil - PO - 120 mg - Serum - agg. (n=6)                                                                                |
| Verapamil                        | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            | McAllister 1982 - Verapamil 10 mg IV - Verapamil - IV - 10 mg - Plasma - agg. (n=20)                                                                                |
| Verapamil                        | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    | Freedman et al. 1981 - Control Subject (Subject number 4) - Verapamil - IV - 13.1 mg - Plasma - indiv.                                                              |
| Verapamil                        | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | Abernethy et al. 1993 - Representative younger subject - R-Verapamil - IV - 20 mg - Plasma - indiv.                                                                 |
| Verapamil                        | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | Abernethy et al. 1993 - Representative younger subject - S-Verapamil - IV - 20 mg - Plasma - indiv.                                                                 |
| Verapamil                        | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | Abernethy et al. 1993 - Representative younger subject - Verapamil - IV - 20 mg - Plasma - indiv.                                                                   |
| Verapamil                        | po_R-Verapamil 250mg SD, Vogelgesang 1984, n=1                         | Vogelgesang et al. 1984 - Healthy volunteers - R-Verapamil - PO - 250 mg - Plasma - indiv.                                                                          |
| Verapamil                        | po_Verapamil 0.1 mg SD (sol), Maeda 2011, n=8                          | Maeda 2011 - Verapamil 0.1 mg - Norverapamil - Norverapamil - PO - 0.1 mg - Plasma - agg. (n=8)                                                                     |
| Verapamil                        | po_Verapamil 0.1 mg SD (sol), Maeda 2011, n=8                          | Maeda 2011 - Verapamil 0.1 mg - Verapamil - PO - 0.1 mg - Plasma - agg. (n=8)                                                                                       |
| Verapamil                        | po_Verapamil 3 mg SD (sol), Maeda 2011, n=8                            | Maeda 2011 - Verapamil 3 mg - Verapamil - PO - 3 mg - Plasma - agg. (n=8)                                                                                           |
| Verapamil                        | po_Verapamil 3 mg SD (sol), Maeda 2011, n=8                            | Maeda 2011 - Verapamil 3 mg - Norverapamil - Norverapamil - PO - 3 mg - Plasma - agg. (n=8)                                                                         |
| Verapamil                        | po_Verapamil 80 mg SD (sol), Maeda 2011, n=8                           | Maeda 2011 - Verapamil 80 mg - Verapamil - PO - 80 mg - Plasma - agg. (n=8)                                                                                         |
| Verapamil                        | po_Verapamil 80 mg SD (sol), Maeda 2011, n=8                           | Maeda 2011 - Verapamil 80 mg - Norverapamil - Norverapamil - PO - 80 mg - Plasma - agg. (n=8)                                                                       |
| Verapamil                        | po_Verapamil 40 mg SD, John 1992, n=6                                  | John et al. 1992 - Healthy volunteers - Verapamil - PO - 40 mg - Plasma - agg. (n=6)                                                                                |
| Verapamil                        | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     | Sawicki, Janicki 2002 - Healthy volunteers; conventional tablets - Norverapamil - PO - 40 mg - Plasma - agg. (n=12)                                                 |
| Verapamil                        | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     | Sawicki, Janicki 2002 - Healthy volunteers; conventional tablets - Verapamil - PO - 40 mg - Plasma - agg. (n=12)                                                    |
| Verapamil                        | po_Verapamil 60 mg SD, Choi 2008, n=12                                 | Choi et al. 2008 - 60mg Verapamil in absence of oral atorvastatin - Verapamil - PO - 60 mg - Arterial Plasma - agg. (n=12)                                          |
| Verapamil                        | po_Verapamil 60 mg SD, Choi 2008, n=12                                 | Choi et al. 2008 - 60mg Verapamil in absence of oral atorvastatin - Norverapamil - PO - 60 mg - Arterial Plasma - agg. (n=12)                                       |
| Verapamil                        | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           | Ratiopharm 1988 - Unknown - Verapamil - PO - 80 mg - Plasma - agg. (n=16)                                                                                           |
| Verapamil                        | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           | Ratiopharm 1988 - Unknown - Norverapamil - PO - 80 mg - Plasma - agg. (n=16)                                                                                        |
| Verapamil                        | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              | Ratiopharm 1989 - Unknown - Norverapamil - PO - 80 mg - Plasma - agg. (n=16)                                                                                        |
| Verapamil                        | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              | Ratiopharm 1989 - Unknown - Verapamil - PO - 80 mg - Plasma - agg. (n=16)                                                                                           |
| Verapamil                        | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        | Johnson 2001 - Verapamil Steady State - Verapamil - PO - 80 mg - Plasma - agg. (n=12)                                                                               |
| Verapamil                        | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        | Johnson 2001 - Verapamil Steady State - Norverapamil - PO - 80 mg - Plasma - agg. (n=12)                                                                            |
| Verapamil                        | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | Boehringer 2018 - Unknown - R-Norverapamil - PO - 120 mg - Plasma - agg. (n=12)                                                                                     |
| Verapamil                        | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | Boehringer 2018 - Unknown - R-Verapamil - PO - 120 mg - Plasma - agg. (n=12)                                                                                        |
| Verapamil                        | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | Boehringer 2018 - Unknown - S-Norverapamil - PO - 120 mg - Plasma - agg. (n=12)                                                                                     |
| Verapamil                        | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | Boehringer 2018 - Unknown - S-Verapamil - PO - 120 mg - Plasma - agg. (n=12)                                                                                        |
| Verapamil                        | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                | Härtter et al. 2012 - 120mg po bid - R-Norverapamil - PO - 120 mg - Plasma - agg. (n=20)                                                                            |
| Verapamil                        | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                | Härtter et al. 2012 - 120mg po bid - R-Verapamil - PO - 120 mg - Plasma - agg. (n=20)                                                                               |
| Verapamil                        | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                | Härtter et al. 2012 - 120mg po bid - S-Norverapamil - PO - 120 mg - Plasma - agg. (n=20)                                                                            |
| Verapamil                        | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                | Härtter et al. 2012 - 120mg po bid - S-Verapamil - PO - 120 mg - Plasma - agg. (n=20)                                                                               |
| Verapamil                        | po_Verapamil 120 mg SD, Hla 1987, n=10                                 | Hla 1987 - conventional Verapamil 120mg once daily (day 1) - Verapamil - PO - 120 mg - Plasma - agg. (n=10)                                                         |
| Verapamil                        | po_Verapamil 120 mg MD, Hla 1987, n=10                                 | Hla 1987 - conventional Verapamil 120mg twice daily (day 10) - Verapamil - PO - 120 mg - Plasma - agg. (n=10)                                                       |
| Verapamil                        | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  | van Haarst et al. 2009 - Verapamil only - Norverapamil - PO - 180 mg - Plasma - agg. (n=10)                                                                         |
| Verapamil                        | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  | van Haarst et al. 2009 - Verapamil only - Verapamil - PO - 180 mg - Plasma - agg. (n=10)                                                                            |
| Verapamil                        | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     | Blume, Mutschler 1989 - Verapamil - Verapamil - PO - 80 mg - Plasma - agg. (n=18)                                                                                   |
| Verapamil                        | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    | Blume, Mutschler 1987 - Verapamil - Verapamil - PO - 120 mg - Plasma - agg. (n=12)                                                                                  |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     | Blume, Mutschler 1990 - Verapamil - Verapamil - PO - 40 mg - Plasma - agg. (n=24)                                                                                   |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     | Blume, Mutschler 1983 - Verapamil - Verapamil - PO - 40 mg - Plasma - agg. (n=12)                                                                                   |
| Verapamil                        | iv_R-Verapamil 5 mg (5 min), Eichelbaum 1984, n=1                      | Eichelbaum 1984 - Subject 4 - R-Verapamil - IV - 5 mg - Plasma - indiv.                                                                                             |
| Verapamil                        | iv_R-Verapamil 25 mg (5 min), Eichelbaum 1984, n=1                     | Eichelbaum 1984 - Subject 4 - R-Verapamil - IV - 25 mg - Plasma - indiv.                                                                                            |
| Verapamil                        | iv_S-Verapamil 5 mg SD (5min), Eichelbaum 1984, n=1                    | Eichelbaum 1984 - Subject 4 - S-Verapamil - IV - 5 mg - Plasma - indiv.                                                                                             |
| Verapamil                        | iv_S-Verapamil 7.5 mg SD (5min), Eichelbaum 1984, n=1                  | Eichelbaum 1984 - Subject 4 - S-Verapamil - IV - 7.5 mg - Plasma - indiv.                                                                                           |
| Verapamil                        | iv_S-Verapamil 10 mg SD (5min), Eichelbaum 1984, n=1                   | Eichelbaum 1984 - Subject 4 - S-Verapamil - IV - 10 mg - Plasma - indiv.                                                                                            |
| Verapamil                        | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       | Backman 1994 - Verapamil - Verapamil - PO - 80 mg - Plasma - agg. (n=9)                                                                                             |
| Verapamil                        | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   | McAllister 1982 - Verapamil 80 mg PO - Verapamil - PO - 80 mg - Plasma - agg. (n=20)                                                                                |
| Verapamil                        | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  | McAllister 1982 - Verapamil 120 mg PO - Verapamil - PO - 120 mg - Plasma - agg. (n=20)                                                                              |
| Verapamil                        | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  | McAllister 1982 - Verapamil 160 mg PO - Verapamil - PO - 160 mg - Plasma - agg. (n=20)                                                                              |
| Verapamil                        | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  | Jorgensen 1988 - Conventional Verapamil 120 mg BID (day 8) - Verapamil - PO - 120 mg - Plasma - agg. (n=12)                                                         |
| Verapamil                        | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  | Jorgensen 1988 - Conventional Verapamil 120 mg BID (day 1 - 5 and 8) - Verapamil - PO - 120 mg - Plasma - agg. (n=12)                                               |
| Verapamil                        | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 | Jorgensen 1988 - Sustained release Verapamil 240 mg OD (day 8) - Verapamil - PO - 240 mg - Plasma - agg. (n=12)                                                     |
| Verapamil                        | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 | Jorgensen 1988 - Sustained release Verapamil 240 mg OD (day 1 - 5 and 8) - Verapamil - PO - 240 mg - Plasma - agg. (n=12)                                           |
| Verapamil                        | po_Verapamil 240 mg SD, Karim 1995, n=12                               | Karim 1995 - Verapamil total IR fasting - Verapamil - PO - 240 mg - Plasma - agg. (n=12)                                                                            |
| Verapamil                        | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        | Shand 1981 - Verapamil day 1 - Verapamil - PO - 120 mg - Plasma - agg. (n=6)                                                                                        |
| Verapamil                        | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        | Shand 1981 - Verapamil day 3 (after 7th dose) - Verapamil - PO - 120 mg - Plasma - agg. (n=6)                                                                       |
| Verapamil                        | iv_Verapamil 10 mg (bol), Smith 1984, n=8                              | Smith 1984 - IV 10 mg Verapamil control - Verapamil - IV - 10 mg - Plasma - agg. (n=8)                                                                              |
| Verapamil                        | po_Verapamil 120 mg SD, Smith 1984, n=8                                | Smith 1984 - PO 120 mg Verapamil control - Verapamil - PO - 120 mg - Plasma - agg. (n=8)                                                                            |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           | Wing et al. 1985 - 10mg Verapamil without cimetidine, IV - Verapamil - IV - 10 mg - Plasma - indiv.                                                                 |
| Verapamil                        | po_Verapamil 80mg SD, Wing 1985, n=1                                   | Wing et al. 1985 - 80mg Verapamil without cimetidine, PO - Verapamil - PO - 80 mg - Plasma - indiv.                                                                 |
| Verapamil                        | po_Verapamil 160 mg SD, Mikus 1990, n=1                                | Mikus et al. 1990 - 160mg verapamil without cimetidine, PO - R-Verapamil - PO - 160 mg - Plasma - indiv.                                                            |
| Verapamil                        | po_Verapamil 160 mg SD, Mikus 1990, n=1                                | Mikus et al. 1990 - 160mg verapamil without cimetidine, PO - S-Verapamil - PO - 160 mg - Plasma - indiv.                                                            |

| Id         | Path                                                                                                  | Type     |
|:-----------|:------------------------------------------------------------------------------------------------------|:---------|
| DDI Ratios | <https://raw.githubusercontent.com/Open-Systems-Pharmacology/Database-for-observed-data/v1.7/DDI.csv> | DDIRatio |

| Project                          | BB-Type     | BB-Name                                                        | Parent-Project |
|:---------------------------------|:------------|:---------------------------------------------------------------|:---------------|
| Mefenamic_acid-Dapagliflozin-DDI | Individual  | Standard_Adult_UGT                                             | Dapagliflozin  |
| Mefenamic_acid-Dapagliflozin-DDI | Compound    | Mefenamic acid                                                 | Mefenamic_acid |
| Mefenamic_acid-Dapagliflozin-DDI | Compound    | Dapagliflozin                                                  | Dapagliflozin  |
| Mefenamic_acid-Dapagliflozin-DDI | Formulation | Ponstan capsule                                                | Mefenamic_acid |
| Atazanavir-Raltegravir-DDI       | Compound    | Raltegravir                                                    | Raltegravir    |
| Atazanavir-Raltegravir-DDI       | Compound    | Atazanavir                                                     | Atazanavir     |
| Atazanavir-Raltegravir-DDI       | Formulation | Reyataz capsule                                                | Atazanavir     |
| Atazanavir-Raltegravir-DDI       | Formulation | filmcoated tablet (original Merck formulation)                 | Raltegravir    |
| Mefenamic_acid                   | Individual  | Standard_Adult                                                 |                |
| Mefenamic_acid                   | Compound    | Mefenamic acid                                                 |                |
| Mefenamic_acid                   | Protocol    | PO MD 500 mg loading / 250 mg every 6 h                        |                |
| Mefenamic_acid                   | Protocol    | 250 mg SD                                                      |                |
| Mefenamic_acid                   | Protocol    | 500 mg SD                                                      |                |
| Mefenamic_acid                   | Event       | breakfast                                                      |                |
| Mefenamic_acid                   | Event       | snack (MEFA)                                                   |                |
| Mefenamic_acid                   | Formulation | Ponstan capsule                                                |                |
| Dapagliflozin                    | Individual  | Standard_Adult_UGT                                             |                |
| Dapagliflozin                    | Compound    | Dapagliflozin                                                  |                |
| Dapagliflozin                    | Protocol    | IV 0.08 mg                                                     |                |
| Dapagliflozin                    | Protocol    | PO SD 50 mg                                                    |                |
| Dapagliflozin                    | Protocol    | PO SD 2.5 mg                                                   |                |
| Dapagliflozin                    | Protocol    | PO SD 5 mg                                                     |                |
| Dapagliflozin                    | Protocol    | PO SD 10 mg                                                    |                |
| Dapagliflozin                    | Protocol    | PO SD 20 mg                                                    |                |
| Dapagliflozin                    | Protocol    | PO SD 100 mg                                                   |                |
| Dapagliflozin                    | Protocol    | PO SD 250 mg                                                   |                |
| Dapagliflozin                    | Protocol    | PO SD 500 mg                                                   |                |
| Dapagliflozin                    | Protocol    | PO MD 2.5 mg                                                   |                |
| Dapagliflozin                    | Protocol    | PO MD 10 mg                                                    |                |
| Dapagliflozin                    | Protocol    | PO MD 20 mg                                                    |                |
| Dapagliflozin                    | Protocol    | PO MD 50 mg                                                    |                |
| Dapagliflozin                    | Protocol    | PO MD 100 mg                                                   |                |
| Dapagliflozin                    | Event       | breakfast                                                      |                |
| Dapagliflozin                    | Formulation | Dissolved                                                      |                |
| Dapagliflozin                    | Formulation | IC tablet (Chang 2015)                                         |                |
| Raltegravir                      | Individual  | Standard European Male for PEQ                                 |                |
| Raltegravir                      | Compound    | Raltegravir                                                    |                |
| Raltegravir                      | Protocol    | Iwamoto 2008 400mg PO (Figure 1) omeprazole study              |                |
| Raltegravir                      | Protocol    | Iwamoto 2008 10mg PO (Figure 2) Safety-Tolerability-PK study   |                |
| Raltegravir                      | Protocol    | Iwamoto 2008 25mg PO (Figure 2) Safety-Tolerability-PK study   |                |
| Raltegravir                      | Protocol    | Iwamoto 2008 50mg PO (Figure 2) Safety-Tolerability-PK study   |                |
| Raltegravir                      | Protocol    | Iwamoto 2008 100mg PO (Figure 2) Safety-Tolerability-PK study  |                |
| Raltegravir                      | Protocol    | Iwamoto 2008 200mg PO (Figure 2) Safety-Tolerability-PK study  |                |
| Raltegravir                      | Protocol    | Iwamoto 2008 800mg PO (Figure 2) Safety-Tolerability-PK study  |                |
| Raltegravir                      | Protocol    | Iwamoto 2008 1200mg PO (Figure 2) Safety-Tolerability-PK study |                |
| Raltegravir                      | Protocol    | Iwamoto 2008 1600mg PO (Figure 2) Safety-Tolerability-PK study |                |
| Raltegravir                      | Protocol    | Markowitz 2006 100mg bid 10d                                   |                |
| Raltegravir                      | Protocol    | Markowitz 2006 200mg bid 10d                                   |                |
| Raltegravir                      | Protocol    | Markowitz 2006 400mg bid 10d                                   |                |
| Raltegravir                      | Event       | Food                                                           |                |
| Raltegravir                      | Formulation | Weibull (lactose formulation)                                  |                |
| Raltegravir                      | Formulation | chewable tablet                                                |                |
| Raltegravir                      | Formulation | filmcoated tablet (original Merck formulation)                 |                |
| Raltegravir                      | Formulation | Weibull (granules)                                             |                |
| Atazanavir                       | Individual  | Agarwala2003                                                   |                |
| Atazanavir                       | Individual  | Agarwala2005a                                                  |                |
| Atazanavir                       | Individual  | Agarwala2005b                                                  |                |
| Atazanavir                       | Individual  | Martin2008                                                     |                |
| Atazanavir                       | Individual  | Zhu2011                                                        |                |
| Atazanavir                       | Individual  | WhiteAmericanMale                                              |                |
| Atazanavir                       | Individual  | WhiteAmericanFemale                                            |                |
| Atazanavir                       | Individual  | Zhu2010                                                        |                |
| Atazanavir                       | Individual  | Acosta2007                                                     |                |
| Atazanavir                       | Compound    | Atazanavir                                                     |                |
| Atazanavir                       | Protocol    | 400mg_QD_7days                                                 |                |
| Atazanavir                       | Protocol    | 400mg_QD_6days                                                 |                |
| Atazanavir                       | Protocol    | 400mg_QD_5days                                                 |                |
| Atazanavir                       | Protocol    | 200mg_QD_5days                                                 |                |
| Atazanavir                       | Protocol    | 800mg_QD_5days                                                 |                |
| Atazanavir                       | Protocol    | 400mg_SD                                                       |                |
| Atazanavir                       | Protocol    | 300mg_BID_7days_at120h                                         |                |
| Atazanavir                       | Protocol    | 300mg_BID                                                      |                |
| Atazanavir                       | Protocol    | 200mg_QD_6days                                                 |                |
| Atazanavir                       | Protocol    | 300mg_QD_10days                                                |                |
| Atazanavir                       | Protocol    | 800mg_QD_6days                                                 |                |
| Atazanavir                       | Event       | High-fat breakfast                                             |                |
| Atazanavir                       | Event       | Light meal                                                     |                |
| Atazanavir                       | Formulation | Reyataz capsule                                                |                |
| Mefenamic_acid-Dapagliflozin-DDI | Protocol    | Dapagliflozin - PO SD 10 mg                                    |                |
| Mefenamic_acid-Dapagliflozin-DDI | Protocol    | Mefenamic acid - PO MD 500 mg loading / 250 mg every 6 h       |                |
| Mefenamic_acid-Dapagliflozin-DDI | Protocol    | Dapagliflozin - PO SD 10 mg (with MEFA)                        |                |
| Mefenamic_acid-Dapagliflozin-DDI | Event       | snack (MEFA)                                                   |                |
| Mefenamic_acid-Dapagliflozin-DDI | Formulation | Solution                                                       |                |
| Atazanavir-Raltegravir-DDI       | Individual  | Neely2010                                                      |                |
| Atazanavir-Raltegravir-DDI       | Individual  | HispanicMale                                                   |                |
| Atazanavir-Raltegravir-DDI       | Individual  | Krishna2016                                                    |                |
| Atazanavir-Raltegravir-DDI       | Individual  | Zhu2010                                                        |                |
| Atazanavir-Raltegravir-DDI       | Protocol    | 400mg_BID_8days                                                |                |
| Atazanavir-Raltegravir-DDI       | Protocol    | Raltegravir_400mg_QD_8days                                     |                |
| Atazanavir-Raltegravir-DDI       | Protocol    | Raltegravir_100mg_at144h                                       |                |
| Atazanavir-Raltegravir-DDI       | Protocol    | Raltegravir_100mg                                              |                |
| Atazanavir-Raltegravir-DDI       | Protocol    | Raltegravir_1200mg                                             |                |
| Atazanavir-Raltegravir-DDI       | Protocol    | Raltegravir_1200mg_at144h                                      |                |
| Atazanavir-Raltegravir-DDI       | Protocol    | Raltegravir_400mg_BID_5days                                    |                |
| Atazanavir-Raltegravir-DDI       | Protocol    | Raltegravir_400mg_BID_14days_at288h                            |                |
| Atazanavir-Raltegravir-DDI       | Protocol    | 300mg_BID_14days_at288h                                        |                |
| Atazanavir-Raltegravir-DDI       | Protocol    | 400mg_QD_9days                                                 |                |
| Atazanavir-Raltegravir-DDI       | Protocol    | 400mg_QD_8days                                                 |                |
| Atazanavir-Raltegravir-DDI       | Event       | High-fat breakfast                                             |                |
| Atazanavir-Raltegravir-DDI       | Event       | Light meal                                                     |                |
| Verapamil                        | Individual  | Härtter 2012 SD, n=19                                          |                |
| Verapamil                        | Individual  | Eichelbaum 1984, n=1                                           |                |
| Verapamil                        | Individual  | Smith 1984, n=8                                                |                |
| Verapamil                        | Individual  | Blume, Mutschler 1994, n=24                                    |                |
| Verapamil                        | Individual  | Maeda 2011, n=8                                                |                |
| Verapamil                        | Individual  | Wing 1985, n=1                                                 |                |
| Verapamil                        | Individual  | McAllister, Kirsten 1982, n=20                                 |                |
| Verapamil                        | Individual  | Freedman 1981, n=1                                             |                |
| Verapamil                        | Individual  | Abernethy 1993, n=1                                            |                |
| Verapamil                        | Individual  | Vogelgesang 1984, n=1                                          |                |
| Verapamil                        | Individual  | John 1992, n=6                                                 |                |
| Verapamil                        | Individual  | Sawicki, Janicki 2002, n=12                                    |                |
| Verapamil                        | Individual  | Choi 2008, n=12                                                |                |
| Verapamil                        | Individual  | Ratiopharm 1988, n=16                                          |                |
| Verapamil                        | Individual  | Ratiopharm 1989, n=16                                          |                |
| Verapamil                        | Individual  | Johnson 2001, n=12                                             |                |
| Verapamil                        | Individual  | Boehringer 2018, n=12                                          |                |
| Verapamil                        | Individual  | Härtter 2012 MD, n=20                                          |                |
| Verapamil                        | Individual  | Hla 1987, n=10                                                 |                |
| Verapamil                        | Individual  | Mikus 1990, n=1                                                |                |
| Verapamil                        | Individual  | van Haarst 2009, n=10                                          |                |
| Verapamil                        | Individual  | Blume, Mutschler 1983, n=12                                    |                |
| Verapamil                        | Individual  | Blume, Mutschler 1990, n=24                                    |                |
| Verapamil                        | Individual  | Blume, Mutschler 1989, n=18                                    |                |
| Verapamil                        | Individual  | Blume, Mutschler 1987, n=12                                    |                |
| Verapamil                        | Individual  | Barbarash 1988, n=6                                            |                |
| Verapamil                        | Individual  | Abernethy 1985, n=1                                            |                |
| Verapamil                        | Individual  | Johnston 1981, n=6                                             |                |
| Verapamil                        | Individual  | Mooy 1985, n=5                                                 |                |
| Verapamil                        | Individual  | Streit 2005, n=10                                              |                |
| Verapamil                        | Individual  | Backman 1994                                                   |                |
| Verapamil                        | Individual  | Jorgensen 1988, n = 12                                         |                |
| Verapamil                        | Individual  | Karim 1995, n = 12                                             |                |
| Verapamil                        | Individual  | Shand 1981, n = 6                                              |                |
| Verapamil                        | Compound    | R-Verapamil                                                    |                |
| Verapamil                        | Compound    | S-Verapamil                                                    |                |
| Verapamil                        | Compound    | R-Norverapamil                                                 |                |
| Verapamil                        | Compound    | S-Norverapamil                                                 |                |
| Verapamil                        | Compound    | Sum-Verapamil                                                  |                |
| Verapamil                        | Compound    | Sum-Norverapamil                                               |                |
| Verapamil                        | Protocol    | Härtter 2012, Verapamil 120 mg SD, R-Vera                      |                |
| Verapamil                        | Protocol    | Härtter 2012, Verapamil 120 mg SD, S-Vera                      |                |
| Verapamil                        | Protocol    | Eichelbaum 1984, R-Verapamil 50 mg iv (5 min)                  |                |
| Verapamil                        | Protocol    | Maeda 2011, Verapamil 16 mg po SD (sol), R-Vera                |                |
| Verapamil                        | Protocol    | Maeda 2011, Verapamil 16 mg po SD (sol), S-Vera                |                |
| Verapamil                        | Protocol    | Blume, Mutschler 1994, 240 mg po QD (SR), R-Vera               |                |
| Verapamil                        | Protocol    | Blume, Mutschler 1994, 240 mg po QD (SR), S-Vera               |                |
| Verapamil                        | Protocol    | Smith 1984, Verapamil 10 mg iv (bol), R-Vera                   |                |
| Verapamil                        | Protocol    | Smith 1984, Verapamil 10 mg iv (bol), S-Vera                   |                |
| Verapamil                        | Protocol    | Mooy 1985, Verapamil 3mg iv (5min) SD, R-Vera                  |                |
| Verapamil                        | Protocol    | Mooy 1985, Verapamil 3mg iv (5min) SD, S-Vera                  |                |
| Verapamil                        | Protocol    | Mooy 1985, Verapamil 80mg po SD, R-Vera                        |                |
| Verapamil                        | Protocol    | Mooy 1985, Verapamil 80mg po SD, S-Vera                        |                |
| Verapamil                        | Protocol    | Streit 2005, Verapamil 5mg iv (10min) SD, S-Vera               |                |
| Verapamil                        | Protocol    | Streit 2005, Verapamil 5mg iv (10min) SD, R-Vera               |                |
| Verapamil                        | Protocol    | Johnston 1981, Verapamil 0.1mg/kg iv (5min) SD, S-Vera         |                |
| Verapamil                        | Protocol    | Johnston 1981, Verapamil 0.1mg/kg iv (5min) SD, R-Vera         |                |
| Verapamil                        | Protocol    | Johnston 1981, Verapamil 120mg po SD, R-Vera                   |                |
| Verapamil                        | Protocol    | Johnston 1981, Verapamil 120mg po SD, S-Vera                   |                |
| Verapamil                        | Protocol    | Abernethy 1985, Verapamil 10mg iv (10min) SD, R-Vera           |                |
| Verapamil                        | Protocol    | Abernethy 1985, Verapamil 10mg iv (10min) SD, S-Vera           |                |
| Verapamil                        | Protocol    | Abernethy 1985, Verapamil 120mg po SD, R-Vera                  |                |
| Verapamil                        | Protocol    | Abernethy 1985, Verapamil 120mg po SD, S-Vera                  |                |
| Verapamil                        | Protocol    | Barbarash 1988, Verapamil 10mg iv (10min) SD, S-Vera           |                |
| Verapamil                        | Protocol    | Barbarash 1988, Verapamil 10mg iv (10min) SD, R-Vera           |                |
| Verapamil                        | Protocol    | Barbarash 1988, Verapamil 120mg po SD, R-Vera                  |                |
| Verapamil                        | Protocol    | Barbarash 1988, Verapamil 120mg po SD, S-Vera                  |                |
| Verapamil                        | Protocol    | Wing 1985, Verapamil 10mg iv (10min) SD, R-Vera                |                |
| Verapamil                        | Protocol    | Wing 1985, Verapamil 10mg iv (10min) SD, S-Vera                |                |
| Verapamil                        | Protocol    | Wing 1985, Verapamil 80mg po SD, R-Vera                        |                |
| Verapamil                        | Protocol    | Wing 1985, Verapamil 80mg po SD, S-Vera                        |                |
| Verapamil                        | Protocol    | McAllister, Kirsten 1982, Verapamil 10mg iv (5min) SD, S-Vera  |                |
| Verapamil                        | Protocol    | McAllister, Kirsten 1982, Verapamil 10mg iv (5min) SD, R-Vera  |                |
| Verapamil                        | Protocol    | Smith 1984, Verapamil 120mg po SD, S-Vera                      |                |
| Verapamil                        | Protocol    | Smith 1984, Verapamil 120mg po SD, R-Vera                      |                |
| Verapamil                        | Protocol    | Freedman 1981, Verapamil 13.1mg iv (13min) SD, R-Vera          |                |
| Verapamil                        | Protocol    | Freedman 1981, Verapamil 13.1mg iv (13min) SD, S-Vera          |                |
| Verapamil                        | Protocol    | Abernethy 1993, Verapamil 20mg iv (30min) SD, R-Vera           |                |
| Verapamil                        | Protocol    | Abernethy 1993, Verapamil 20mg iv (30min) SD, S-Vera           |                |
| Verapamil                        | Protocol    | Vogelgesang 1984, R-Verapamil 250mg po SD                      |                |
| Verapamil                        | Protocol    | Maeda 2011, Verapamil 0.1 mg po SD (sol), R-Vera               |                |
| Verapamil                        | Protocol    | Maeda 2011, Verapamil 0.1 mg po SD (sol), S-Vera               |                |
| Verapamil                        | Protocol    | Maeda 2011, Verapamil 3 mg po SD (sol), R-Vera                 |                |
| Verapamil                        | Protocol    | Maeda 2011, Verapamil 3 mg po SD (sol), S-Vera                 |                |
| Verapamil                        | Protocol    | Maeda 2011, Verapamil 80 mg po SD (sol), S-Vera                |                |
| Verapamil                        | Protocol    | Maeda 2011, Verapamil 80 mg po SD (sol), R-Vera                |                |
| Verapamil                        | Protocol    | John 1992, Verapamil 40mg po (tab) SD, R-Vera                  |                |
| Verapamil                        | Protocol    | John 1992, Verapamil 40mg po (tab) SD, S-Vera                  |                |
| Verapamil                        | Protocol    | Sawicki, Janicki 2002, Verapamil 40mg po (tab) SD, R-Vera      |                |
| Verapamil                        | Protocol    | Sawicki, Janicki 2002, Verapamil 40mg po (tab) SD, S-Vera      |                |
| Verapamil                        | Protocol    | Choi 2008, Verapamil 60 mg po (caps) SD, R-Vera                |                |
| Verapamil                        | Protocol    | Choi 2008, Verapamil 60 mg po (caps) SD, S-Vera                |                |
| Verapamil                        | Protocol    | Ratiopharm 1988, Verapamil 80mg po SD, R-Vera                  |                |
| Verapamil                        | Protocol    | Ratiopharm 1988, Verapamil 80mg po SD, S-Vera                  |                |
| Verapamil                        | Protocol    | Ratiopharm 1989, Verapamil 80mg (2 40mg tabs) po SD, R-Vera    |                |
| Verapamil                        | Protocol    | Ratiopharm 1989, Verapamil 80mg (2 40mg tabs) po SD, S-Vera    |                |
| Verapamil                        | Protocol    | Johnson 2001, Verapamil 80mg po tid 7rep, R-Vera               |                |
| Verapamil                        | Protocol    | Johnson 2001, Verapamil 80mg po tid 7rep, S-Vera               |                |
| Verapamil                        | Protocol    | Boehringer 2018, Verapamil 120mg po (IR tab) SD, R-Vera        |                |
| Verapamil                        | Protocol    | Boehringer 2018, Verapamil 120mg po (IR tab) SD, S-Vera        |                |
| Verapamil                        | Protocol    | Härtter 2012, Verapamil 120 mg bid, R-Vera                     |                |
| Verapamil                        | Protocol    | Härtter 2012, Verapamil 120 mg bid, S-Vera                     |                |
| Verapamil                        | Protocol    | Hla 1987, Verapamil 120mg po (tab) SD, R-Vera                  |                |
| Verapamil                        | Protocol    | Hla 1987, Verapamil 120mg po (tab) SD, S-Vera                  |                |
| Verapamil                        | Protocol    | Hla 1987, Verapamil 120mg po (tab) MD, R-Vera                  |                |
| Verapamil                        | Protocol    | Hla 1987, Verapamil 120mg po (tab) MD, S-Vera                  |                |
| Verapamil                        | Protocol    | Mikus 1990, Verapamil 160mg po (sol) SD, R-Vera                |                |
| Verapamil                        | Protocol    | Mikus 1990, Verapamil 160mg po (sol) SD, S-Vera                |                |
| Verapamil                        | Protocol    | van Haarst 2009, Verapamil 180mg PO BID 3days, R-Vera          |                |
| Verapamil                        | Protocol    | van Haarst 2009, Verapamil 180mg PO BID 3days, S-Vera          |                |
| Verapamil                        | Protocol    | Blume, Mutschler 1987, Verapamil 120mg po SD, R-Vera           |                |
| Verapamil                        | Protocol    | Blume, Mutschler 1987, Verapamil 120mg po SD, S-Vera           |                |
| Verapamil                        | Protocol    | Blume, Mutschler 1989, Verapamil 80mg po SD, R-Vera            |                |
| Verapamil                        | Protocol    | Blume, Mutschler 1989, Verapamil 80mg po SD, S-Vera            |                |
| Verapamil                        | Protocol    | Blume, Mutschler 1990, Verapamil 40mg po SD, R-Vera            |                |
| Verapamil                        | Protocol    | Blume, Mutschler 1990, Verapamil 40mg po SD, S-Vera            |                |
| Verapamil                        | Protocol    | Blume, Mutschler 1983, Verapamil 40mg po SD, R-Vera            |                |
| Verapamil                        | Protocol    | Blume, Mutschler 1983, Verapamil 40mg po SD, S-Vera            |                |
| Verapamil                        | Protocol    | Eichelbaum 1984, R-Verapamil 25 mg iv (5 min)                  |                |
| Verapamil                        | Protocol    | Eichelbaum 1984, R-Verapamil 5 mg iv (5 min)                   |                |
| Verapamil                        | Protocol    | Eichelbaum 1984, S-Verapamil 5 mg iv (5 min)                   |                |
| Verapamil                        | Protocol    | Eichelbaum 1984, S-Verapamil 7.5 mg iv (5 min)                 |                |
| Verapamil                        | Protocol    | Eichelbaum 1984, S-Verapamil 10 mg iv (5 min)                  |                |
| Verapamil                        | Protocol    | Backman 1994, Verapamil 80mg po TID, R-Vera                    |                |
| Verapamil                        | Protocol    | Backman 1994, Verapamil 80mg po TID, S-Vera                    |                |
| Verapamil                        | Protocol    | McAllister 1982, Verapamil 80mg po SD, S-Vera                  |                |
| Verapamil                        | Protocol    | McAllister 1982, Verapamil 80mg po SD, R-Vera                  |                |
| Verapamil                        | Protocol    | McAllister 1982, Verapamil 160mg po SD, R-Vera                 |                |
| Verapamil                        | Protocol    | McAllister 1982, Verapamil 160mg po SD, S-Vera                 |                |
| Verapamil                        | Protocol    | McAllister 1982, Verapamil 120 mg SD, R-Vera                   |                |
| Verapamil                        | Protocol    | McAllister 1982, Verapamil 120 mg SD, S-Vera                   |                |
| Verapamil                        | Protocol    | Jorgensen 1988, Verapamil 120mg PO BID, R-Vera                 |                |
| Verapamil                        | Protocol    | Jorgensen 1988, Verapamil 120mg PO BID, S-Vera                 |                |
| Verapamil                        | Protocol    | Jorgensen 1988, Verapamil 240mg PO MD, R-Vera                  |                |
| Verapamil                        | Protocol    | Jorgensen 1988, Verapamil 240mg PO MD, S-Vera                  |                |
| Verapamil                        | Protocol    | Karim 1995, Verapamil 240mg PO SD, R-Vera                      |                |
| Verapamil                        | Protocol    | Karim 1995, Verapamil 240mg PO SD, S-Vera                      |                |
| Verapamil                        | Protocol    | Shand 1981, Verapamil 120 mg TID, R-Vera                       |                |
| Verapamil                        | Protocol    | Shand 1981, Verapamil 120 mg TID, S-Vera                       |                |
| Verapamil                        | Formulation | Solution                                                       |                |
| Verapamil                        | Formulation | Retard Tablet Verapamil (Knoll)                                |                |
| Verapamil                        | ObserverSet | Sum-Verapamil                                                  |                |
| Verapamil                        | ObserverSet | Sum-Norverapamil                                               |                |
| Verapamil                        | ObserverSet | Sum-Verapamil fe to urine                                      |                |
| Verapamil                        | ObserverSet | Sum-Norverapamil fe to urine                                   |                |
| Verapamil                        | ObserverSet | Sum-Verapamil fe to feces                                      |                |
| Verapamil                        | ObserverSet | Sum-Norverapamil fe to feces                                   |                |

| Project                          | Parent.Project | Parent.Simulation  | Path                                            | TargetSimulation                                                   |
|:---------------------------------|:---------------|:-------------------|:------------------------------------------------|:-------------------------------------------------------------------|
| Mefenamic_acid-Dapagliflozin-DDI | Dapagliflozin  | PO SD 10 mg (perm) | Dapagliflozin\|logP (veg.oil/water)             | DDI Control - Dapagliflozin - Kasichayanula 2013a                  |
| Mefenamic_acid-Dapagliflozin-DDI | Dapagliflozin  | PO SD 10 mg (perm) | Dapagliflozin\|logP (veg.oil/water)             | DDI Treatment - Mefenamic acid/Dapagliflozin - Kasichayanula 2013a |
| Mefenamic_acid-Dapagliflozin-DDI | Dapagliflozin  | PO SD 10 mg (perm) | Dapagliflozin\|Blood/Plasma concentration ratio | DDI Control - Dapagliflozin - Kasichayanula 2013a                  |
| Mefenamic_acid-Dapagliflozin-DDI | Dapagliflozin  | PO SD 10 mg (perm) | Dapagliflozin\|Blood/Plasma concentration ratio | DDI Treatment - Mefenamic acid/Dapagliflozin - Kasichayanula 2013a |

| Project                          | Simulation                                                             | Section.Reference |
|:---------------------------------|:-----------------------------------------------------------------------|:------------------|
| Raltegravir                      | tralala                                                                | introduction      |
| Mefenamic_acid                   | PO MD 500 mg loading / 250 mg every 6 h                                | NA                |
| Mefenamic_acid                   | PO SD 250 mg                                                           | NA                |
| Mefenamic_acid                   | PO SD 500 mg                                                           | NA                |
| Dapagliflozin                    | IV 0.08 mg (perm)                                                      | NA                |
| Dapagliflozin                    | PO SD 10 mg (perm)                                                     | NA                |
| Dapagliflozin                    | PO SD 10 mg (perm)                                                     | NA                |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                     | NA                |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                     | NA                |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                     | NA                |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                     | NA                |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                     | NA                |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                     | NA                |
| Dapagliflozin                    | PO SD 2.5 mg (perm)                                                    | NA                |
| Dapagliflozin                    | PO SD 2.5 mg (perm)                                                    | NA                |
| Dapagliflozin                    | PO SD 5 mg (perm)                                                      | NA                |
| Dapagliflozin                    | PO SD 5 mg (perm)                                                      | NA                |
| Dapagliflozin                    | PO SD 20 mg (perm)                                                     | NA                |
| Dapagliflozin                    | PO SD 20 mg (perm)                                                     | NA                |
| Dapagliflozin                    | PO SD 100 mg (perm)                                                    | NA                |
| Dapagliflozin                    | PO SD 100 mg (perm)                                                    | NA                |
| Dapagliflozin                    | PO SD 250 mg (perm)                                                    | NA                |
| Dapagliflozin                    | PO SD 250 mg (perm)                                                    | NA                |
| Dapagliflozin                    | PO SD 500 mg (perm)                                                    | NA                |
| Dapagliflozin                    | PO SD 500 mg (perm)                                                    | NA                |
| Dapagliflozin                    | PO SD 5 mg IC tablet (Chang 2015) (perm)                               | NA                |
| Dapagliflozin                    | PO SD 250 mg fed (perm)                                                | NA                |
| Dapagliflozin                    | PO SD 250 mg fed (perm)                                                | NA                |
| Dapagliflozin                    | PO SD 10 mg IC tablet (Chang 2015) (perm)                              | NA                |
| Dapagliflozin                    | PO MD 10 mg (perm)                                                     | NA                |
| Dapagliflozin                    | PO MD 10 mg (perm)                                                     | NA                |
| Dapagliflozin                    | PO MD 100 mg (perm)                                                    | NA                |
| Dapagliflozin                    | PO MD 100 mg (perm)                                                    | NA                |
| Dapagliflozin                    | PO MD 2.5 mg (perm)                                                    | NA                |
| Dapagliflozin                    | PO MD 2.5 mg (perm)                                                    | NA                |
| Dapagliflozin                    | PO MD 20 mg (perm)                                                     | NA                |
| Dapagliflozin                    | PO MD 20 mg (perm)                                                     | NA                |
| Dapagliflozin                    | PO MD 50 mg (perm)                                                     | NA                |
| Dapagliflozin                    | PO MD 50 mg (perm)                                                     | NA                |
| Raltegravir                      | Raltegravir 800 mg (lactose formulation)                               | NA                |
| Raltegravir                      | Raltegravir 10 mg (lactose formulation)                                | NA                |
| Raltegravir                      | Raltegravir 100 mg (lactose formulation)                               | NA                |
| Raltegravir                      | Raltegravir 1200 mg (lactose formulation)                              | NA                |
| Raltegravir                      | Raltegravir 1600 mg (lactose formulation)                              | NA                |
| Raltegravir                      | Raltegravir 200 mg (lactose formulation)                               | NA                |
| Raltegravir                      | Raltegravir 25 mg (lactose formulation)                                | NA                |
| Raltegravir                      | Raltegravir 50 mg (lactose formulation)                                | NA                |
| Raltegravir                      | Raltegravir 400mg chewable fasted                                      | NA                |
| Raltegravir                      | Raltegravir 400mg filmcoated tablet                                    | NA                |
| Raltegravir                      | Raltegravir 400mg (lactose formulation)                                | NA                |
| Raltegravir                      | Raltegravir 100 mg filmcoated tablet md                                | NA                |
| Raltegravir                      | Raltegravir 200 mg filmcoated tablet md                                | NA                |
| Raltegravir                      | Raltegravir 400 mg filmcoated tablet md                                | NA                |
| Raltegravir                      | Raltegravir 400mg (granules in suspension)                             | NA                |
| Raltegravir                      | Raltegravir 400mg chewable fed                                         | NA                |
| Atazanavir                       | Acosta2007_300mg                                                       | NA                |
| Atazanavir                       | Agarwala2003_400mg                                                     | NA                |
| Atazanavir                       | Agarwala2005a_400mg                                                    | NA                |
| Atazanavir                       | Agarwala2005b_400mg                                                    | NA                |
| Atazanavir                       | Martin2008_400mg                                                       | NA                |
| Atazanavir                       | Zhu2011_400mg                                                          | NA                |
| Atazanavir                       | FDA-ClinPharmReview_AI424-014_400mg_YoungFemales                       | NA                |
| Atazanavir                       | FDA-ClinPharmReview_AI424-028_200mg                                    | NA                |
| Atazanavir                       | FDA-ClinPharmReview_AI424-028_400mg                                    | NA                |
| Atazanavir                       | FDA-ClinPharmReview_AI424-040_200mg                                    | NA                |
| Atazanavir                       | FDA-ClinPharmReview_AI424-040_400mg                                    | NA                |
| Atazanavir                       | FDA-ClinPharmReview_AI424-040_800mg                                    | NA                |
| Atazanavir                       | FDA-ClinPharmReview_AI424-056_300mg                                    | NA                |
| Atazanavir                       | FDA-ClinPharmReview_AI424-076_400mg                                    | NA                |
| Atazanavir                       | FDA-ClinPharmReview_AI424-076_800mg                                    | NA                |
| Atazanavir                       | Zhu2010_300mg_Atazanavir                                               | NA                |
| Atazanavir                       | FDA-ClinPharmReview_AI424-004_400mg_TreatmentA                         | NA                |
| Atazanavir                       | FDA-ClinPharmReview_AI424-014_400mg_YoungMales                         | NA                |
| Atazanavir                       | FDA-ClinPharmReview_AI424-014_400mg_YoungMales                         | NA                |
| Atazanavir                       | FDA-ClinPharmReview_AI424-015_400mg_NormalSubjects                     | NA                |
| Mefenamic_acid-Dapagliflozin-DDI | DDI Control - Dapagliflozin - Kasichayanula 2013a                      | NA                |
| Mefenamic_acid-Dapagliflozin-DDI | DDI Treatment - Mefenamic acid/Dapagliflozin - Kasichayanula 2013a     | NA                |
| Mefenamic_acid-Dapagliflozin-DDI | DDI Treatment - Mefenamic acid/Dapagliflozin - Kasichayanula 2013a     | NA                |
| Atazanavir-Raltegravir-DDI       | Neely2010_Raltegravir                                                  | NA                |
| Atazanavir-Raltegravir-DDI       | Neely2010_Raltegravir+Atazanavir                                       | NA                |
| Atazanavir-Raltegravir-DDI       | Neely2010_Raltegravir+Atazanavir                                       | NA                |
| Atazanavir-Raltegravir-DDI       | Iwamoto2008_Raltegravir                                                | NA                |
| Atazanavir-Raltegravir-DDI       | Iwamoto2008_Raltegravir+Atazanavir                                     | NA                |
| Atazanavir-Raltegravir-DDI       | Iwamoto2008_Raltegravir+Atazanavir                                     | NA                |
| Atazanavir-Raltegravir-DDI       | Krishna2016_Raltegravir                                                | NA                |
| Atazanavir-Raltegravir-DDI       | Krishna2016_Raltegravir+Atazanavir                                     | NA                |
| Atazanavir-Raltegravir-DDI       | Krishna2016_Raltegravir+Atazanavir                                     | NA                |
| Atazanavir-Raltegravir-DDI       | Zhu2010_Raltegravir                                                    | NA                |
| Atazanavir-Raltegravir-DDI       | Zhu2010_Raltegravir+Atazanavir                                         | NA                |
| Atazanavir-Raltegravir-DDI       | Zhu2010_Raltegravir+Atazanavir                                         | NA                |
| Verapamil                        | iv_R-Verapamil 50 mg (5 min), Eichelbaum 1984, n=1                     | NA                |
| Verapamil                        | iv_R-Verapamil 50 mg (5 min), Eichelbaum 1984, n=1                     | NA                |
| Verapamil                        | iv_R-Verapamil 50 mg (5 min), Eichelbaum 1984, n=1                     | NA                |
| Verapamil                        | iv_R-Verapamil 50 mg (5 min), Eichelbaum 1984, n=1                     | NA                |
| Verapamil                        | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       | NA                |
| Verapamil                        | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       | NA                |
| Verapamil                        | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       | NA                |
| Verapamil                        | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       | NA                |
| Verapamil                        | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       | NA                |
| Verapamil                        | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       | NA                |
| Verapamil                        | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       | NA                |
| Verapamil                        | po_Verapamil 120 mg SD (IR), Haertter 2012, n=19                       | NA                |
| Verapamil                        | po_Verapamil 16 mg SD (sol), Maeda 2011, n=8                           | NA                |
| Verapamil                        | po_Verapamil 16 mg SD (sol), Maeda 2011, n=8                           | NA                |
| Verapamil                        | po_Verapamil 16 mg SD (sol), Maeda 2011, n=8                           | NA                |
| Verapamil                        | po_Verapamil 16 mg SD (sol), Maeda 2011, n=8                           | NA                |
| Verapamil                        | po_Verapamil 16 mg SD (sol), Maeda 2011, n=8                           | NA                |
| Verapamil                        | po_Verapamil 16 mg SD (sol), Maeda 2011, n=8                           | NA                |
| Verapamil                        | po_Verapamil 240 mg QD (SR), Blume, Mutschler 1994, n=24               | NA                |
| Verapamil                        | po_Verapamil 240 mg QD (SR), Blume, Mutschler 1994, n=24               | NA                |
| Verapamil                        | po_Verapamil 240 mg QD (SR), Blume, Mutschler 1994, n=24               | NA                |
| Verapamil                        | po_Verapamil 240 mg QD (SR), Blume, Mutschler 1994, n=24               | NA                |
| Verapamil                        | po_Verapamil 240 mg QD (SR), Blume, Mutschler 1994, n=24               | NA                |
| Verapamil                        | po_Verapamil 240 mg QD (SR), Blume, Mutschler 1994, n=24               | NA                |
| Verapamil                        | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            | NA                |
| Verapamil                        | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            | NA                |
| Verapamil                        | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            | NA                |
| Verapamil                        | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            | NA                |
| Verapamil                        | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            | NA                |
| Verapamil                        | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            | NA                |
| Verapamil                        | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            | NA                |
| Verapamil                        | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            | NA                |
| Verapamil                        | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            | NA                |
| Verapamil                        | iv_Verapamil 3 mg SD (5min), Mooy 1985, n=5                            | NA                |
| Verapamil                        | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  | NA                |
| Verapamil                        | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  | NA                |
| Verapamil                        | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  | NA                |
| Verapamil                        | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  | NA                |
| Verapamil                        | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  | NA                |
| Verapamil                        | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  | NA                |
| Verapamil                        | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  | NA                |
| Verapamil                        | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  | NA                |
| Verapamil                        | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  | NA                |
| Verapamil                        | po_Verapamil 80 mg SD, Mooy 1985, n=6                                  | NA                |
| Verapamil                        | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         | NA                |
| Verapamil                        | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         | NA                |
| Verapamil                        | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         | NA                |
| Verapamil                        | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         | NA                |
| Verapamil                        | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         | NA                |
| Verapamil                        | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         | NA                |
| Verapamil                        | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         | NA                |
| Verapamil                        | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         | NA                |
| Verapamil                        | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         | NA                |
| Verapamil                        | iv_Verapamil 5 mg SD (5min), Streit 2005, n=10                         | NA                |
| Verapamil                        | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   | NA                |
| Verapamil                        | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   | NA                |
| Verapamil                        | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   | NA                |
| Verapamil                        | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   | NA                |
| Verapamil                        | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   | NA                |
| Verapamil                        | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   | NA                |
| Verapamil                        | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   | NA                |
| Verapamil                        | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   | NA                |
| Verapamil                        | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   | NA                |
| Verapamil                        | iv_Verapamil 0.1 mg/kg SD (5min), Johnston 1981, n=6                   | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Johnston 1981, n=6                             | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Johnston 1981, n=6                             | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Johnston 1981, n=6                             | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Johnston 1981, n=6                             | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Johnston 1981, n=6                             | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Johnston 1981, n=6                             | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Johnston 1981, n=6                             | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Johnston 1981, n=6                             | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Johnston 1981, n=6                             | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Johnston 1981, n=6                             | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Abernethy 1985, n=1                      | NA                |
| Verapamil                        | po_Verapamil 120mg SD, Abernethy 1985, n=1                             | NA                |
| Verapamil                        | po_Verapamil 120mg SD, Abernethy 1985, n=1                             | NA                |
| Verapamil                        | po_Verapamil 120mg SD, Abernethy 1985, n=1                             | NA                |
| Verapamil                        | po_Verapamil 120mg SD, Abernethy 1985, n=1                             | NA                |
| Verapamil                        | po_Verapamil 120mg SD, Abernethy 1985, n=1                             | NA                |
| Verapamil                        | po_Verapamil 120mg SD, Abernethy 1985, n=1                             | NA                |
| Verapamil                        | po_Verapamil 120mg SD, Abernethy 1985, n=1                             | NA                |
| Verapamil                        | po_Verapamil 120mg SD, Abernethy 1985, n=1                             | NA                |
| Verapamil                        | po_Verapamil 120mg SD, Abernethy 1985, n=1                             | NA                |
| Verapamil                        | po_Verapamil 120mg SD, Abernethy 1985, n=1                             | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Barbarash 1988, n=6                      | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Barbarash 1988, n=6                            | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (5min), McAllister, Kirsten 1982, n=20            | NA                |
| Verapamil                        | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    | NA                |
| Verapamil                        | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    | NA                |
| Verapamil                        | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    | NA                |
| Verapamil                        | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    | NA                |
| Verapamil                        | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    | NA                |
| Verapamil                        | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    | NA                |
| Verapamil                        | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    | NA                |
| Verapamil                        | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    | NA                |
| Verapamil                        | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    | NA                |
| Verapamil                        | iv_Verapamil 13.1 mg SD (13min), Freedman 1981, n=1                    | NA                |
| Verapamil                        | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | NA                |
| Verapamil                        | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | NA                |
| Verapamil                        | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | NA                |
| Verapamil                        | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | NA                |
| Verapamil                        | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | NA                |
| Verapamil                        | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | NA                |
| Verapamil                        | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | NA                |
| Verapamil                        | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | NA                |
| Verapamil                        | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | NA                |
| Verapamil                        | iv_Verapamil 20mg SD (30min), Abernethy 1993, n=1                      | NA                |
| Verapamil                        | po_R-Verapamil 250mg SD, Vogelgesang 1984, n=1                         | NA                |
| Verapamil                        | po_R-Verapamil 250mg SD, Vogelgesang 1984, n=1                         | NA                |
| Verapamil                        | po_R-Verapamil 250mg SD, Vogelgesang 1984, n=1                         | NA                |
| Verapamil                        | po_R-Verapamil 250mg SD, Vogelgesang 1984, n=1                         | NA                |
| Verapamil                        | po_Verapamil 0.1 mg SD (sol), Maeda 2011, n=8                          | NA                |
| Verapamil                        | po_Verapamil 0.1 mg SD (sol), Maeda 2011, n=8                          | NA                |
| Verapamil                        | po_Verapamil 0.1 mg SD (sol), Maeda 2011, n=8                          | NA                |
| Verapamil                        | po_Verapamil 0.1 mg SD (sol), Maeda 2011, n=8                          | NA                |
| Verapamil                        | po_Verapamil 0.1 mg SD (sol), Maeda 2011, n=8                          | NA                |
| Verapamil                        | po_Verapamil 0.1 mg SD (sol), Maeda 2011, n=8                          | NA                |
| Verapamil                        | po_Verapamil 3 mg SD (sol), Maeda 2011, n=8                            | NA                |
| Verapamil                        | po_Verapamil 3 mg SD (sol), Maeda 2011, n=8                            | NA                |
| Verapamil                        | po_Verapamil 3 mg SD (sol), Maeda 2011, n=8                            | NA                |
| Verapamil                        | po_Verapamil 3 mg SD (sol), Maeda 2011, n=8                            | NA                |
| Verapamil                        | po_Verapamil 3 mg SD (sol), Maeda 2011, n=8                            | NA                |
| Verapamil                        | po_Verapamil 3 mg SD (sol), Maeda 2011, n=8                            | NA                |
| Verapamil                        | po_Verapamil 80 mg SD (sol), Maeda 2011, n=8                           | NA                |
| Verapamil                        | po_Verapamil 80 mg SD (sol), Maeda 2011, n=8                           | NA                |
| Verapamil                        | po_Verapamil 80 mg SD (sol), Maeda 2011, n=8                           | NA                |
| Verapamil                        | po_Verapamil 80 mg SD (sol), Maeda 2011, n=8                           | NA                |
| Verapamil                        | po_Verapamil 80 mg SD (sol), Maeda 2011, n=8                           | NA                |
| Verapamil                        | po_Verapamil 80 mg SD (sol), Maeda 2011, n=8                           | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, John 1992, n=6                                  | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, John 1992, n=6                                  | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, John 1992, n=6                                  | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, John 1992, n=6                                  | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, John 1992, n=6                                  | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, John 1992, n=6                                  | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, John 1992, n=6                                  | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, John 1992, n=6                                  | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, John 1992, n=6                                  | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, John 1992, n=6                                  | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, Sawicki, Janicki 2002, n=12                     | NA                |
| Verapamil                        | po_Verapamil 60 mg SD, Choi 2008, n=12                                 | NA                |
| Verapamil                        | po_Verapamil 60 mg SD, Choi 2008, n=12                                 | NA                |
| Verapamil                        | po_Verapamil 60 mg SD, Choi 2008, n=12                                 | NA                |
| Verapamil                        | po_Verapamil 60 mg SD, Choi 2008, n=12                                 | NA                |
| Verapamil                        | po_Verapamil 60 mg SD, Choi 2008, n=12                                 | NA                |
| Verapamil                        | po_Verapamil 60 mg SD, Choi 2008, n=12                                 | NA                |
| Verapamil                        | po_Verapamil 60 mg SD, Choi 2008, n=12                                 | NA                |
| Verapamil                        | po_Verapamil 60 mg SD, Choi 2008, n=12                                 | NA                |
| Verapamil                        | po_Verapamil 60 mg SD, Choi 2008, n=12                                 | NA                |
| Verapamil                        | po_Verapamil 60 mg SD, Choi 2008, n=12                                 | NA                |
| Verapamil                        | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           | NA                |
| Verapamil                        | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           | NA                |
| Verapamil                        | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           | NA                |
| Verapamil                        | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           | NA                |
| Verapamil                        | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           | NA                |
| Verapamil                        | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           | NA                |
| Verapamil                        | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           | NA                |
| Verapamil                        | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           | NA                |
| Verapamil                        | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           | NA                |
| Verapamil                        | po_Verapamil 80 mg SD, Ratiopharm 1988, n=16                           | NA                |
| Verapamil                        | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              | NA                |
| Verapamil                        | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              | NA                |
| Verapamil                        | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              | NA                |
| Verapamil                        | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              | NA                |
| Verapamil                        | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              | NA                |
| Verapamil                        | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              | NA                |
| Verapamil                        | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              | NA                |
| Verapamil                        | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              | NA                |
| Verapamil                        | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              | NA                |
| Verapamil                        | po_Verapamil 80 mg (2 40mg tab) SD, Ratiopharm 1989, n=16              | NA                |
| Verapamil                        | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        | NA                |
| Verapamil                        | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        | NA                |
| Verapamil                        | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        | NA                |
| Verapamil                        | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        | NA                |
| Verapamil                        | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        | NA                |
| Verapamil                        | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        | NA                |
| Verapamil                        | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        | NA                |
| Verapamil                        | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        | NA                |
| Verapamil                        | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        | NA                |
| Verapamil                        | po_Verapamil 80 mg tid 7rep, Johnson 2001, n=12                        | NA                |
| Verapamil                        | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | NA                |
| Verapamil                        | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | NA                |
| Verapamil                        | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | NA                |
| Verapamil                        | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | NA                |
| Verapamil                        | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | NA                |
| Verapamil                        | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | NA                |
| Verapamil                        | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | NA                |
| Verapamil                        | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | NA                |
| Verapamil                        | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | NA                |
| Verapamil                        | po_Verapamil 120 mg (IR tab) SD, Boehringer 2018, n=12                 | NA                |
| Verapamil                        | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                | NA                |
| Verapamil                        | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                | NA                |
| Verapamil                        | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                | NA                |
| Verapamil                        | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                | NA                |
| Verapamil                        | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                | NA                |
| Verapamil                        | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                | NA                |
| Verapamil                        | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                | NA                |
| Verapamil                        | po_Verapamil 120 mg (IR) bid 3days, Haertter 2012, n=20                | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Hla 1987, n=10                                 | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Hla 1987, n=10                                 | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Hla 1987, n=10                                 | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Hla 1987, n=10                                 | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Hla 1987, n=10                                 | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Hla 1987, n=10                                 | NA                |
| Verapamil                        | po_Verapamil 120 mg MD, Hla 1987, n=10                                 | NA                |
| Verapamil                        | po_Verapamil 120 mg MD, Hla 1987, n=10                                 | NA                |
| Verapamil                        | po_Verapamil 120 mg MD, Hla 1987, n=10                                 | NA                |
| Verapamil                        | po_Verapamil 120 mg MD, Hla 1987, n=10                                 | NA                |
| Verapamil                        | po_Verapamil 120 mg MD, Hla 1987, n=10                                 | NA                |
| Verapamil                        | po_Verapamil 120 mg MD, Hla 1987, n=10                                 | NA                |
| Verapamil                        | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  | NA                |
| Verapamil                        | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  | NA                |
| Verapamil                        | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  | NA                |
| Verapamil                        | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  | NA                |
| Verapamil                        | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  | NA                |
| Verapamil                        | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  | NA                |
| Verapamil                        | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  | NA                |
| Verapamil                        | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  | NA                |
| Verapamil                        | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  | NA                |
| Verapamil                        | po_Verapamil 180mg PO BID 3days,van Haarst 2009, n=10                  | NA                |
| Verapamil                        | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     | NA                |
| Verapamil                        | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     | NA                |
| Verapamil                        | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     | NA                |
| Verapamil                        | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     | NA                |
| Verapamil                        | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     | NA                |
| Verapamil                        | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     | NA                |
| Verapamil                        | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     | NA                |
| Verapamil                        | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     | NA                |
| Verapamil                        | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     | NA                |
| Verapamil                        | po_Verapamil 80 mg SD, Blume, Mutschler 1989, n=18                     | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Blume, Mutschler 1987, n=12                    | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1990, n=24                     | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     | NA                |
| Verapamil                        | po_Verapamil 40 mg SD, Blume, Mutschler 1983, n=12                     | NA                |
| Verapamil                        | iv_R-Verapamil 5 mg (5 min), Eichelbaum 1984, n=1                      | NA                |
| Verapamil                        | iv_R-Verapamil 5 mg (5 min), Eichelbaum 1984, n=1                      | NA                |
| Verapamil                        | iv_R-Verapamil 5 mg (5 min), Eichelbaum 1984, n=1                      | NA                |
| Verapamil                        | iv_R-Verapamil 5 mg (5 min), Eichelbaum 1984, n=1                      | NA                |
| Verapamil                        | iv_R-Verapamil 25 mg (5 min), Eichelbaum 1984, n=1                     | NA                |
| Verapamil                        | iv_R-Verapamil 25 mg (5 min), Eichelbaum 1984, n=1                     | NA                |
| Verapamil                        | iv_R-Verapamil 25 mg (5 min), Eichelbaum 1984, n=1                     | NA                |
| Verapamil                        | iv_R-Verapamil 25 mg (5 min), Eichelbaum 1984, n=1                     | NA                |
| Verapamil                        | iv_S-Verapamil 5 mg SD (5min), Eichelbaum 1984, n=1                    | NA                |
| Verapamil                        | iv_S-Verapamil 5 mg SD (5min), Eichelbaum 1984, n=1                    | NA                |
| Verapamil                        | iv_S-Verapamil 5 mg SD (5min), Eichelbaum 1984, n=1                    | NA                |
| Verapamil                        | iv_S-Verapamil 5 mg SD (5min), Eichelbaum 1984, n=1                    | NA                |
| Verapamil                        | iv_S-Verapamil 7.5 mg SD (5min), Eichelbaum 1984, n=1                  | NA                |
| Verapamil                        | iv_S-Verapamil 7.5 mg SD (5min), Eichelbaum 1984, n=1                  | NA                |
| Verapamil                        | iv_S-Verapamil 7.5 mg SD (5min), Eichelbaum 1984, n=1                  | NA                |
| Verapamil                        | iv_S-Verapamil 7.5 mg SD (5min), Eichelbaum 1984, n=1                  | NA                |
| Verapamil                        | iv_S-Verapamil 10 mg SD (5min), Eichelbaum 1984, n=1                   | NA                |
| Verapamil                        | iv_S-Verapamil 10 mg SD (5min), Eichelbaum 1984, n=1                   | NA                |
| Verapamil                        | iv_S-Verapamil 10 mg SD (5min), Eichelbaum 1984, n=1                   | NA                |
| Verapamil                        | iv_S-Verapamil 10 mg SD (5min), Eichelbaum 1984, n=1                   | NA                |
| Verapamil                        | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       | NA                |
| Verapamil                        | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       | NA                |
| Verapamil                        | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       | NA                |
| Verapamil                        | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       | NA                |
| Verapamil                        | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       | NA                |
| Verapamil                        | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       | NA                |
| Verapamil                        | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       | NA                |
| Verapamil                        | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       | NA                |
| Verapamil                        | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       | NA                |
| Verapamil                        | po_Verapamil 80mg PO TID 5rep, Backman 1994, n=9                       | NA                |
| Verapamil                        | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   | NA                |
| Verapamil                        | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   | NA                |
| Verapamil                        | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   | NA                |
| Verapamil                        | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   | NA                |
| Verapamil                        | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   | NA                |
| Verapamil                        | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   | NA                |
| Verapamil                        | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   | NA                |
| Verapamil                        | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   | NA                |
| Verapamil                        | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   | NA                |
| Verapamil                        | po_Verapamil 80mg SD, McAllister, Kirsten 1982, n=20                   | NA                |
| Verapamil                        | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  | NA                |
| Verapamil                        | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  | NA                |
| Verapamil                        | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  | NA                |
| Verapamil                        | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  | NA                |
| Verapamil                        | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  | NA                |
| Verapamil                        | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  | NA                |
| Verapamil                        | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  | NA                |
| Verapamil                        | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  | NA                |
| Verapamil                        | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  | NA                |
| Verapamil                        | po_Verapamil 120mg SD, McAllister, Kirsten 1982, n=20                  | NA                |
| Verapamil                        | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  | NA                |
| Verapamil                        | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  | NA                |
| Verapamil                        | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  | NA                |
| Verapamil                        | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  | NA                |
| Verapamil                        | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  | NA                |
| Verapamil                        | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  | NA                |
| Verapamil                        | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  | NA                |
| Verapamil                        | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  | NA                |
| Verapamil                        | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  | NA                |
| Verapamil                        | po_Verapamil 160mg SD, McAllister, Kirsten 1982, n=20                  | NA                |
| Verapamil                        | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  | NA                |
| Verapamil                        | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  | NA                |
| Verapamil                        | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  | NA                |
| Verapamil                        | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  | NA                |
| Verapamil                        | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  | NA                |
| Verapamil                        | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  | NA                |
| Verapamil                        | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  | NA                |
| Verapamil                        | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  | NA                |
| Verapamil                        | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  | NA                |
| Verapamil                        | po_Verapamil 120mg PO BID 8days, Jorgensen 1988, n=12                  | NA                |
| Verapamil                        | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 | NA                |
| Verapamil                        | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 | NA                |
| Verapamil                        | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 | NA                |
| Verapamil                        | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 | NA                |
| Verapamil                        | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 | NA                |
| Verapamil                        | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 | NA                |
| Verapamil                        | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 | NA                |
| Verapamil                        | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 | NA                |
| Verapamil                        | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 | NA                |
| Verapamil                        | po_Verapamil 240mg PO OD 8days sustained realese, Jorgensen 1988, n=12 | NA                |
| Verapamil                        | po_Verapamil 240 mg SD, Karim 1995, n=12                               | NA                |
| Verapamil                        | po_Verapamil 240 mg SD, Karim 1995, n=12                               | NA                |
| Verapamil                        | po_Verapamil 240 mg SD, Karim 1995, n=12                               | NA                |
| Verapamil                        | po_Verapamil 240 mg SD, Karim 1995, n=12                               | NA                |
| Verapamil                        | po_Verapamil 240 mg SD, Karim 1995, n=12                               | NA                |
| Verapamil                        | po_Verapamil 240 mg SD, Karim 1995, n=12                               | NA                |
| Verapamil                        | po_Verapamil 240 mg SD, Karim 1995, n=12                               | NA                |
| Verapamil                        | po_Verapamil 240 mg SD, Karim 1995, n=12                               | NA                |
| Verapamil                        | po_Verapamil 240 mg SD, Karim 1995, n=12                               | NA                |
| Verapamil                        | po_Verapamil 240 mg SD, Karim 1995, n=12                               | NA                |
| Verapamil                        | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        | NA                |
| Verapamil                        | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        | NA                |
| Verapamil                        | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        | NA                |
| Verapamil                        | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        | NA                |
| Verapamil                        | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        | NA                |
| Verapamil                        | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        | NA                |
| Verapamil                        | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        | NA                |
| Verapamil                        | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        | NA                |
| Verapamil                        | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        | NA                |
| Verapamil                        | po_Verapamil 120mg PO TID 7rep, Shand 1981, n=6                        | NA                |
| Verapamil                        | iv_Verapamil 10 mg (bol), Smith 1984, n=8                              | NA                |
| Verapamil                        | iv_Verapamil 10 mg (bol), Smith 1984, n=8                              | NA                |
| Verapamil                        | iv_Verapamil 10 mg (bol), Smith 1984, n=8                              | NA                |
| Verapamil                        | iv_Verapamil 10 mg (bol), Smith 1984, n=8                              | NA                |
| Verapamil                        | iv_Verapamil 10 mg (bol), Smith 1984, n=8                              | NA                |
| Verapamil                        | iv_Verapamil 10 mg (bol), Smith 1984, n=8                              | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Smith 1984, n=8                                | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Smith 1984, n=8                                | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Smith 1984, n=8                                | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Smith 1984, n=8                                | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Smith 1984, n=8                                | NA                |
| Verapamil                        | po_Verapamil 120 mg SD, Smith 1984, n=8                                | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           | NA                |
| Verapamil                        | iv_Verapamil 10mg SD (10min), Wing 1985, n=1                           | NA                |
| Verapamil                        | po_Verapamil 80mg SD, Wing 1985, n=1                                   | NA                |
| Verapamil                        | po_Verapamil 80mg SD, Wing 1985, n=1                                   | NA                |
| Verapamil                        | po_Verapamil 80mg SD, Wing 1985, n=1                                   | NA                |
| Verapamil                        | po_Verapamil 80mg SD, Wing 1985, n=1                                   | NA                |
| Verapamil                        | po_Verapamil 80mg SD, Wing 1985, n=1                                   | NA                |
| Verapamil                        | po_Verapamil 80mg SD, Wing 1985, n=1                                   | NA                |
| Verapamil                        | po_Verapamil 80mg SD, Wing 1985, n=1                                   | NA                |
| Verapamil                        | po_Verapamil 80mg SD, Wing 1985, n=1                                   | NA                |
| Verapamil                        | po_Verapamil 80mg SD, Wing 1985, n=1                                   | NA                |
| Verapamil                        | po_Verapamil 80mg SD, Wing 1985, n=1                                   | NA                |
| Verapamil                        | po_Verapamil 160 mg SD, Mikus 1990, n=1                                | NA                |
| Verapamil                        | po_Verapamil 160 mg SD, Mikus 1990, n=1                                | NA                |
| Verapamil                        | po_Verapamil 160 mg SD, Mikus 1990, n=1                                | NA                |
| Verapamil                        | po_Verapamil 160 mg SD, Mikus 1990, n=1                                | NA                |
| Verapamil                        | po_Verapamil 160 mg SD, Mikus 1990, n=1                                | NA                |
| Verapamil                        | po_Verapamil 160 mg SD, Mikus 1990, n=1                                | NA                |
| Verapamil                        | po_Verapamil 160 mg SD, Mikus 1990, n=1                                | NA                |
| Verapamil                        | po_Verapamil 160 mg SD, Mikus 1990, n=1                                | NA                |
| Verapamil                        | po_Verapamil 160 mg SD, Mikus 1990, n=1                                | NA                |
| Verapamil                        | po_Verapamil 160 mg SD, Mikus 1990, n=1                                | NA                |

| Title               | Section.Reference                | Simulation.Duration | TimeUnit | ChartWidth | ChartHeight | AxisSize | LegendSize | OriginSize | FontFamilyName | WatermarkSize | X_Dimension | X_GridLines | X_Scaling | Y_Dimension | Y_GridLines | Y_Scaling |
|:--------------------|:---------------------------------|--------------------:|:---------|-----------:|------------:|---------:|-----------:|-----------:|---------------:|--------------:|------------:|------------:|----------:|------------:|------------:|----------:|
| Iwamoto 2008        | atazanavir-raltegravir-ddi       |                 176 | h        |         NA |          NA |       NA |         NA |         NA |             NA |            NA |          NA |          NA |        NA |          NA |          NA |        NA |
| Krishna 2016        | atazanavir-raltegravir-ddi       |                 216 | h        |         NA |          NA |       NA |         NA |         NA |             NA |            NA |          NA |          NA |        NA |          NA |          NA |        NA |
| Neely 2010          | atazanavir-raltegravir-ddi       |                 192 | h        |         NA |          NA |       NA |         NA |         NA |             NA |            NA |          NA |          NA |        NA |          NA |          NA |        NA |
| Zhu 2010            | atazanavir-raltegravir-ddi       |                 612 | h        |         NA |          NA |       NA |         NA |         NA |             NA |            NA |          NA |          NA |        NA |          NA |          NA |        NA |
| Kasichayanula 2013a | mefenamic-acid-dapagliflozin-ddi |                  48 | h        |         NA |          NA |       NA |         NA |         NA |             NA |            NA |          NA |          NA |        NA |          NA |          NA |        NA |

| Project                          | Simulation                                                         | Output                                                                           | Observed.data                                                                                                                           | Plot.Title          | StartTime | TimeUnit | Color    | Caption                          | Symbol |
|:---------------------------------|:-------------------------------------------------------------------|:---------------------------------------------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------|:--------------------|----------:|:---------|:---------|:---------------------------------|:-------|
| Atazanavir-Raltegravir-DDI       | Iwamoto2008_Raltegravir                                            | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)   | Iwamoto 2008 - Study I, Period 1 (control) - Raltegravir - PO - 100 mg - Plasma - agg. (n=10)                                           | Iwamoto 2008        |         0 | h        | \#2166ac | Control (without atazanavir)     | Circle |
| Atazanavir-Raltegravir-DDI       | Iwamoto2008_Raltegravir+Atazanavir                                 | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)   | Iwamoto 2008 - Study I, Period 2 (ATV treatment) - Raltegravir - PO - 100 mg - Plasma - agg. (n=10)                                     | Iwamoto 2008        |       144 | h        | \#b2182b | Treatment (with atazanavir)      | Square |
| Atazanavir-Raltegravir-DDI       | Krishna2016_Raltegravir                                            | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)   | Krishna 2016 - Period 1, Day 1 (1200 mg raltegravir SD) - Raltegravir - PO - 1200 mg - Plasma - agg. (n=14)                             | Krishna 2016        |         0 | h        | \#2166ac | Control (without atazanavir)     | Circle |
| Atazanavir-Raltegravir-DDI       | Krishna2016_Raltegravir+Atazanavir                                 | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)   | Krishna 2016 - Period 2, Day 7 (1200 mg raltegravir SD with OD doses of 400 mg ATV) - Raltegravir - PO - 1200 mg - Plasma - agg. (n=12) | Krishna 2016        |       144 | h        | \#b2182b | Treatment (with atazanavir)      | Square |
| Atazanavir-Raltegravir-DDI       | Neely2010_Raltegravir                                              | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)   | Neely 2010 - Study arm A (Raltegravir 400mg BID) - Raltegravir - PO - 400 mg - Plasma - agg. (n=20)                                     | Neely 2010          |       168 | h        | \#2166ac | Control (without atazanavir)     | Circle |
| Atazanavir-Raltegravir-DDI       | Neely2010_Raltegravir+Atazanavir                                   | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)   | Neely 2010 - Study arm B (Raltegravir 400mg OD + Atazanavir 400 mg OD) - Raltegravir - PO - 400 mg - Plasma - agg. (n=19)               | Neely 2010          |       168 | h        | \#b2182b | Treatment (with atazanavir)      | Square |
| Atazanavir-Raltegravir-DDI       | Zhu2010_Raltegravir                                                | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)   | Zhu 2010 - Raltegravir 400 mg twice daily - Raltegravir - PO - 400 mg - Plasma - agg. (n=22)                                            | Zhu 2010            |        96 | h        | \#2166ac | Control (without atazanavir)     | Circle |
| Atazanavir-Raltegravir-DDI       | Zhu2010_Raltegravir+Atazanavir                                     | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)   | Zhu 2010 - Raltegravir 400 mg twice daily plus atazanavir 300 mg twice daily - Raltegravir - PO - 400 mg - Plasma - agg. (n=19)         | Zhu 2010            |       600 | h        | \#b2182b | Treatment (with atazanavir)      | Square |
| Mefenamic_acid-Dapagliflozin-DDI | DDI Control - Dapagliflozin - Kasichayanula 2013a                  | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood) | Kasichayanula 2013a - Study 2: Control (Perpetrator Placebo) - Dapagliflozin - PO - 10 mg - Plasma - agg. (n=16)                        | Kasichayanula 2013a |         0 | h        | \#2166ac | Control (without mefenamic acid) | Circle |
| Mefenamic_acid-Dapagliflozin-DDI | DDI Treatment - Mefenamic acid/Dapagliflozin - Kasichayanula 2013a | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood) | Kasichayanula 2013a - Study 2: with Perpetrator (Mefenamic Acid) - Dapagliflozin - PO - 10 mg - Plasma - agg. (n=16)                    | Kasichayanula 2013a |        24 | h        | \#b2182b | Treatment (with mefenamic acid)  | Square |

| Title | Section.Reference | Plot.Type | Artifacts | Group.Caption | Group.Symbol | ChartWidth | ChartHeight | AxisSize | LegendSize | OriginSize | FontFamilyName | WatermarkSize | X_Dimension | X_GridLines | X_Scaling | Y_Dimension | Y_GridLines | Y_Scaling |
|-------|-------------------|-----------|-----------|---------------|--------------|------------|-------------|----------|------------|------------|----------------|---------------|-------------|-------------|-----------|-------------|-------------|-----------|

| Project | Simulation | Output | Observed.data | Plot.Title | Group.Title | Color |
|---------|------------|--------|---------------|------------|-------------|-------|

| Title                            | Section.Ref                       | PK-Parameter | Plot.Type           | Subunits | Artifacts | Group.Caption                  | Group.Color | Group.Symbol | ChartWidth | ChartHeight | AxisSize | LegendSize | OriginSize | FontFamilyName | WatermarkSize | X_Dimension | X_GridLines | X_Scaling | Y_Dimension | Y_GridLines | Y_Scaling |
|:---------------------------------|:----------------------------------|:-------------|:--------------------|---------:|:----------|:-------------------------------|:------------|:-------------|-----------:|------------:|---------:|-----------:|-----------:|---------------:|--------------:|------------:|------------:|----------:|------------:|------------:|----------:|
| UGT1A1 and UGT1A9 Inhibition DDI | qualification-of-ugt-mediated-ddi | AUC          | predictedVsObserved |       NA | Plot      | Atazanavir + Raltegravir       | \#b2182b    | Circle       |         NA |          NA |       NA |         NA |         NA |             NA |            NA |          NA |          NA |        NA |          NA |          NA |        NA |
| NA                               | NA                                | CMAX         | residualsVsObserved |       NA | GMFE      | Mefenamic acid + Dapagliflozin | \#2166ac    | Square       |         NA |          NA |       NA |         NA |         NA |             NA |            NA |          NA |          NA |        NA |          NA |          NA |        NA |
| NA                               | NA                                | NA           | NA                  |       NA | Measure   | NA                             | NA          | NA           |         NA |          NA |       NA |         NA |         NA |             NA |            NA |          NA |          NA |        NA |          NA |          NA |        NA |
| NA                               | NA                                | NA           | NA                  |       NA | Table     | NA                             | NA          | NA           |         NA |          NA |       NA |         NA |         NA |             NA |            NA |          NA |          NA |        NA |          NA |          NA |        NA |

| Project                          | Simulation_Control                                | Control.StartTime | Control.EndTime | Control.TimeUnit | Simulation_Treatment                                               | Treatment.StartTime | Treatment.EndTime | Treatment.TimeUnit | Output                                                                           | Plot.Title                       | Group.Title                    | Observed.data | ObsDataRecordID |
|:---------------------------------|:--------------------------------------------------|------------------:|----------------:|:-----------------|:-------------------------------------------------------------------|--------------------:|------------------:|:-------------------|:---------------------------------------------------------------------------------|:---------------------------------|:-------------------------------|:--------------|----------------:|
| Atazanavir-Raltegravir-DDI       | Iwamoto2008_Raltegravir                           |                 0 |            9999 | h                | Iwamoto2008_Raltegravir+Atazanavir                                 |                 144 |              9999 | h                  | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)   | UGT1A1 and UGT1A9 Inhibition DDI | Atazanavir + Raltegravir       | DDI Ratios    |             571 |
| Atazanavir-Raltegravir-DDI       | Krishna2016_Raltegravir                           |                 0 |            9999 | h                | Krishna2016_Raltegravir+Atazanavir                                 |                 144 |              9999 | h                  | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)   | UGT1A1 and UGT1A9 Inhibition DDI | Atazanavir + Raltegravir       | DDI Ratios    |             575 |
| Atazanavir-Raltegravir-DDI       | Neely2010_Raltegravir                             |               168 |             180 | h                | Neely2010_Raltegravir+Atazanavir                                   |                 168 |               192 | h                  | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)   | UGT1A1 and UGT1A9 Inhibition DDI | Atazanavir + Raltegravir       | DDI Ratios    |             573 |
| Atazanavir-Raltegravir-DDI       | Zhu2010_Raltegravir                               |                96 |             108 | h                | Zhu2010_Raltegravir+Atazanavir                                     |                 600 |               612 | h                  | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)   | UGT1A1 and UGT1A9 Inhibition DDI | Atazanavir + Raltegravir       | DDI Ratios    |             579 |
| Mefenamic_acid-Dapagliflozin-DDI | DDI Control - Dapagliflozin - Kasichayanula 2013a |                 0 |            9999 | h                | DDI Treatment - Mefenamic acid/Dapagliflozin - Kasichayanula 2013a |                  24 |              9999 | h                  | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood) | UGT1A1 and UGT1A9 Inhibition DDI | Mefenamic acid + Dapagliflozin | DDI Ratios    |             642 |

| Title | Section.Reference | PK-Parameter | Artifacts | Group.Caption | Group.Color | Group.Symbol | ChartWidth | ChartHeight | AxisSize | LegendSize | OriginSize | FontFamilyName | WatermarkSize | X_Dimension | X_GridLines | X_Scaling | Y_Dimension | Y_GridLines | Y_Scaling |
|-------|-------------------|--------------|-----------|---------------|-------------|--------------|------------|-------------|----------|------------|------------|----------------|---------------|-------------|-------------|-----------|-------------|-------------|-----------|

| Project | Simulation | Output | Observed.data | ObservedDataRecordId | Plot.Title | Group.Title |
|---------|------------|--------|---------------|----------------------|------------|-------------|

| Section.Reference                        | Title                                                 | Content                                                                                                                             | Parent.Section  |
|:-----------------------------------------|:------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------|:----------------|
| introduction                             | Introduction                                          | NA                                                                                                                                  | NA              |
| objective                                | Objective                                             | Content/Qualification_DDI_UGT_objective.md                                                                                          | introduction    |
| ugt-ddi-network                          | UGT DDI Network                                       | Content/Qualification_DDI_UGT_network_description.md                                                                                | introduction    |
| network-atazanavir-raltegravir-ddi       | Atazanavir - Raltegravir DDI                          | Content/ATV-RAL-DDI.md                                                                                                              | ugt-ddi-network |
| network-mefenamic-acid-dapagliflozin-ddi | Mefenamic acid - Dapagliflozin DDI                    | Content/MEFA-Dapa-DDI.md                                                                                                            | ugt-ddi-network |
| qualification-of-ugt-mediated-ddi        | Qualification of Use Case UGT-mediated DDI            | Content/Intro_evaluation_DDI_network.md                                                                                             | NA              |
| ct-profiles                              | Concentration-Time Profiles                           | Content/Intro_evaluation_CTprofiles.md                                                                                              | NA              |
| atazanavir-raltegravir-ddi               | Atazanavir - Raltegravir DDI                          | NA                                                                                                                                  | ct-profiles     |
| mefenamic-acid-dapagliflozin-ddi         | Mefenamic acid - Dapagliflozin DDI                    | NA                                                                                                                                  | ct-profiles     |
| main-references                          | References                                            | Content/References.md                                                                                                               | NA              |
| appendix                                 | Appendix                                              | NA                                                                                                                                  | NA              |
| osp-introduction                         | Open Systems Pharmacology Suite (OSPS) Introduction   | <https://raw.githubusercontent.com/Open-Systems-Pharmacology/Qualification-text-modules/v1.3/OSPS_Introduction.md>                  | appendix        |
| mathematical-implementation-of-ddi       | Mathematical Implementation of Drug-Drug Interactions | <https://raw.githubusercontent.com/Open-Systems-Pharmacology/Qualification-text-modules/v1.3/Mathematical_Implementation_of_DDI.md> | appendix        |
| automatic-requalification-workflow       | Automatic (re)-qualification workflow                 | <https://raw.githubusercontent.com/Open-Systems-Pharmacology/Qualification-text-modules/v1.3/Qualification_Workflow.md>             | appendix        |

| Path                 |
|:---------------------|
| Content/titlepage.md |

| Project | BB-Type | BB-Name | Section.Reference |
|---------|---------|---------|-------------------|

| ChartWidth | ChartHeight | AxisSize | LegendSize | OriginSize | FontFamilyName | WatermarkSize |
|-----------:|------------:|---------:|-----------:|-----------:|:---------------|--------------:|
|        500 |         400 |       11 |          9 |          9 | Arial          |            40 |

| Plot                              | Type | Dimension            | Unit  | GridLines | Scaling |
|:----------------------------------|:-----|:---------------------|:------|:---------:|:--------|
| GOFMergedPlotsPredictedVsObserved | X    | NA                   | NA    |    NA     | NA      |
| GOFMergedPlotsPredictedVsObserved | Y    | NA                   | NA    |    NA     | NA      |
| GOFMergedPlotsResidualsOverTime   | X    | NA                   | NA    |    NA     | NA      |
| GOFMergedPlotsResidualsOverTime   | Y    | NA                   | NA    |    NA     | NA      |
| DDIRatioPlotsPredictedVsObserved  | X    | Dimensionless        |       |   FALSE   | Log     |
| DDIRatioPlotsPredictedVsObserved  | Y    | Dimensionless        |       |   FALSE   | Log     |
| DDIRatioPlotsResidualsVsObserved  | X    | Dimensionless        |       |   FALSE   | Log     |
| DDIRatioPlotsResidualsVsObserved  | Y    | Dimensionless        |       |   FALSE   | Log     |
| ComparisonTimeProfile             | X    | Time                 | h     |   FALSE   | Linear  |
| ComparisonTimeProfile             | Y    | Concentration (mass) | ng/ml |   FALSE   | Log     |
| PKRatioPlots                      | X    | NA                   | NA    |    NA     | NA      |
| PKRatioPlots                      | Y    | NA                   | NA    |    NA     | NA      |

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

- **Review green rows thoroughly**: These represent new content that
  will be added to your plan
- **Verify yellow rows**: Ensure version/path changes are intentional
- **Maintain section consistency**: Use existing section references for
  new content to maintain report organization
- **Test building block inheritance**: Ensure parent-child relationships
  are correctly defined
- **Check for duplicates**: Verify you’re not accidentally duplicating
  content
- **Preserve existing evaluations**: Don’t delete or modify existing
  plot configurations unless intentional

For detailed information about each worksheet and editing guidelines,
see the [Excel Template
Documentation](https://www.open-systems-pharmacology.org/OSPSuite.QualificationPlanEditor/articles/excel-template.md).

## Step 4: Convert Back to JSON

After editing and integrating the new project, convert the Excel file
back to JSON:

``` r
excelToQualificationPlan(
  excelFile = excelFile,
  qualificationPlan = paste0("updated-", qualificationPlan)
)
```

**Note**: We’re using a new filename (`updated-` prefix) to preserve the
original qualification plan. This is recommended for safety.

### Validation

The conversion function will validate your changes: - Section references
must match sections defined in the Sections sheet - Project and
simulation names must match those in the definition sheets - Building
block parent references must point to valid projects - All required
columns must be present

If validation fails, error messages will guide you to fix the issues.

### Result

A successful conversion produces an updated qualification plan JSON file
that includes: - The new project(s) from your snapshot(s) - All existing
projects and evaluations - New evaluations and configurations you added
for the new project - Updated building block and parameter inheritance
relationships

## Next Steps

After integrating the snapshot:

1.  **Test the qualification plan**: Run it with the OSP Suite
    Qualification Runner
2.  **Review the report**: Verify the new project is properly integrated
3.  **Iterate if needed**: If adjustments are required, convert back to
    Excel and edit again
4.  **Update documentation**: Consider updating your qualification plan
    documentation to reflect the addition

## Adding Multiple Projects

To add multiple projects at once:

``` r
snapshotPaths <- list(
  "Project-A" = "path/to/project-a.json",
  "Project-B" = "path/to/project-b.json",
  "Project-C" = "https://raw.githubusercontent.com/Org/Repo/main/project-c.json"
)

toExcelEditor(
  fileName = "updated-qualification.xlsx",
  snapshotPaths = snapshotPaths,
  qualificationPlan = "existing-qualification.json"
)
```

All new projects will be highlighted in green, making it easy to review
and integrate them.

## Adding Observed Data

You can also add new observed data files when integrating projects:

``` r
observedDataPaths <- list(
  "New Clinical Data" = list(
    Path = "path/to/clinical_data.csv",
    Type = "TimeProfile"
  ),
  "DDI Ratios" = list(
    Path = "path/to/ddi_data.csv",
    Type = "DDIRatio"
  )
)

toExcelEditor(
  fileName = excelFile,
  snapshotPaths = snapshotPaths,
  observedDataPaths = observedDataPaths,
  qualificationPlan = qualificationPlan
)
```

The new observed data will be available for use in plot mappings.

## Common Integration Scenarios

### Scenario 1: Adding a DDI Perpetrator Model

When adding a perpetrator model to an existing victim model
qualification: 1. Add the perpetrator snapshot 2. In BB sheet, configure
building block inheritance so victim simulations use perpetrator
compounds 3. Create CT plots comparing perpetrator+victim simulations
with DDI observed data 4. Add DDIRatio plots to show interaction effects

### Scenario 2: Adding a New Population

When adding a new population (e.g., pediatric) to an adult model: 1. Add
the pediatric snapshot 2. Configure individual building block
inheritance from the adult model 3. Create separate sections for
pediatric results 4. Add CT plots comparing pediatric simulations with
pediatric observed data 5. Optionally create comparison plots showing
adult vs. pediatric predictions

### Scenario 3: Model Version Update

When replacing an old model version with a new one: 1. Add the new
version snapshot (it will be marked yellow if same project name) 2.
Review Simulations_Outputs to check for changes in available outputs 3.
Verify existing plot configurations still work with new version 4.
Update evaluations if simulation names or outputs changed

## Related Articles

- [Excel Template
  Documentation](https://www.open-systems-pharmacology.org/OSPSuite.QualificationPlanEditor/articles/excel-template.md):
  Comprehensive guide to Excel worksheets
- [Create Qualification from
  Snapshot](https://www.open-systems-pharmacology.org/OSPSuite.QualificationPlanEditor/articles/no-qualification.md):
  Starting from scratch
- [Update Qualification Plan
  Evaluations](https://www.open-systems-pharmacology.org/OSPSuite.QualificationPlanEditor/articles/update-qualification.md):
  Modifying existing evaluations
