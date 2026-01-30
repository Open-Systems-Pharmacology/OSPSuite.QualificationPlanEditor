# Update my Qualification Plan Evaluations

``` r
library(ospsuite.qualificationplaneditor)
```

## Overview

This tutorial demonstrates how to review and update evaluations in an
existing qualification plan without adding or changing project
snapshots. This is useful when:

- You want to modify plot configurations
- You need to reorganize report sections
- You’re updating plot assignments or building block references
- You want to add or modify comparison plots (CT, GOF, DDI, PK ratio
  plots)
- You need to adjust building block or parameter inheritance

This is the most common workflow when maintaining an established
qualification plan where the underlying models haven’t changed, but the
qualification report structure or evaluations need updates.

We’ll use the qualification plan for UGT1A1- and UGT1A9-mediated
drug-drug interactions (DDI) from the
[Qualification-DDI-UGT](https://github.com/Open-Systems-Pharmacology/Qualification-DDI-UGT)
repository as our example.

## Prerequisites

- The `ospsuite.qualificationplaneditor` package installed
- An existing qualification plan JSON file
- Understanding of what evaluations you want to modify

## Workflow Overview

Updating a qualification plan involves:

1.  **Load the qualification plan**: Convert the existing plan to Excel
2.  **Edit evaluations**: Modify plot configurations, sections, and
    assignments
3.  **Convert back to JSON**: Generate the updated qualification plan
4.  **Test and validate**: Run the updated plan to verify changes

## Step 1: Define File Paths

Start by specifying your qualification plan and output files:

``` r
# Existing qualification plan (included with package for this example)
qualificationPlan <- "qualification_ugt.json"

# Output Excel file name
excelFile <- "qualification_ugt.xlsx"
```

**Note**: For your own projects, replace `"qualification_ugt.json"` with
the path to your qualification plan. This can be: - A local file path:
`"C:/Projects/MyQualification/plan.json"` - A GitHub URL:
`"https://raw.githubusercontent.com/Org/Repo/main/qualification_plan.json"`

## Step 2: Convert Qualification Plan to Excel

Convert your qualification plan to Excel format. Notice that we **only**
provide the `qualificationPlan` parameter - we do **not** provide
`snapshotPaths` since we’re not adding or changing projects:

``` r
toExcelEditor(
  fileName = excelFile, 
  qualificationPlan = qualificationPlan
)
#> 
#> ── Exporting to Excel Editor ───────────────────────────────────────────────────
#> ℹ Copying Excel Template to qualification_ugt.xlsx
#> ✔ Copying Excel Template to qualification_ugt.xlsx [187ms]
#> 
#> ℹ Checking for Qualification Plan
#> ℹ Qualification Plan: qualification_ugt.json
#> ℹ Checking for Qualification Plan✔ Checking for Qualification Plan [31ms]
#> 
#> ℹ Exporting Projects Data
#> ✔ Exporting Projects Data [62ms]
#> 
#> ℹ Exporting Simulation Outputs Data
#> ✔ Exporting Simulation Outputs Data [670ms]
#> 
#> ℹ Exporting Simulation Observed Data
#> ✔ Exporting Simulation Observed Data [359ms]
#> 
#> ℹ Exporting Observed Data
#> ✔ Exporting Observed Data [31ms]
#> 
#> ℹ Exporting Building Block Data
#> 
#> ℹ Exporting Building Block Data── Qualification Plan ──
#> ℹ Exporting Building Block Data
#> ℹ Exporting Building Block Data✔ Exporting Building Block Data [398ms]
#> 
#> ℹ Exporting Schema Data
#> ✔ Exporting Schema Data [20ms]
#> 
#> ℹ Exporting Sections
#> ✔ Exporting Sections [24ms]
#> 
#> ℹ Exporting Intro and Inputs
#> ✔ Exporting Intro and Inputs [22ms]
#> 
#> ℹ Exporting Simulation Parameters Settings
#> ✔ Exporting Simulation Parameters Settings [26ms]
#> 
#> ℹ Exporting All Plots Settings
#> ✔ Exporting All Plots Settings [27ms]
#> 
#> ℹ Exporting Comparison Time Profile Plot Settings
#> ✔ Exporting Comparison Time Profile Plot Settings [56ms]
#> 
#> ℹ Exporting GOF Merged Plot Settings
#> ✔ Exporting GOF Merged Plot Settings [29ms]
#> 
#> ℹ Exporting DDI Ratio Plot Settings
#> ✔ Exporting DDI Ratio Plot Settings [65ms]
#> 
#> ℹ Exporting Global Plot Settings
#> ✔ Exporting Global Plot Settings [21ms]
#> 
#> ℹ Exporting Global Axes Settings
#> ✔ Exporting Global Axes Settings [39ms]
#> 
#> ℹ Saving extracted data into qualification_ugt.xlsx
#> ✔ Saving extracted data into qualification_ugt.xlsx [412ms]
```

### What This Does

When you convert without snapshots, the function:

1.  **Reads the qualification plan**: Parses the JSON file
2.  **Extracts all content**:
    - Projects and their metadata
    - All evaluations (plots, sections, inputs)
    - Building block and parameter inheritance
    - Plot configurations and mappings
    - Report structure (sections, introduction)
    - Global settings
3.  **Populates Excel worksheets**: Creates editable sheets for:
    - **MetaInfo**: Schema version
    - **Projects**: All project definitions (read-only, shown in grey)
    - **Simulations_Outputs**: Available outputs (read-only)
    - **Simulations_ObsData**: Observed data links (read-only)
    - **ObsData**: Observed dataset definitions (Type is editable)
    - **BB**: Building block inheritance (fully editable)
    - **SimParam**: Parameter inheritance (fully editable)
    - **All_Plots**: Individual plot evaluations (fully editable)
    - **CT_Plots/CT_Mapping**: Comparison time profile plots (fully
      editable)
    - **GOF_Plots/GOF_Mapping**: Goodness of fit plots (fully editable)
    - **DDIRatio_Plots/DDIRatio_Mapping**: DDI ratio plots (fully
      editable)
    - **PKRatio_Plots/PKRatio_Mapping**: PK ratio plots (fully editable)
    - **Sections**: Report section structure (fully editable)
    - **Intro**: Introduction file reference (fully editable)
    - **Inputs**: Building block documentation (fully editable)
    - **GlobalPlotSettings**: Plot appearance settings (fully editable)
    - **GlobalAxesSettings**: Axis configuration (fully editable)
    - **Lookup**: Reference tables (read-only)
4.  **Applies formatting**:
    - All projects will be **grey** (unchanged) since no new snapshots
      were provided
    - Data validation dropdowns are enabled
    - Read-only sheets should not be edited; modifying them can cause
      validation or conversion errors when the Excel file is imported
      back into the tool

### Expected Result

The Excel file is now ready for editing. All existing content is
preserved and can be modified as needed.

## Step 3: Edit the Excel File

Open the Excel file to review and modify evaluations:

``` r
utils::browseURL(excelFile)
```

### Common Evaluation Updates

Here are the most common types of updates when maintaining a
qualification plan:

#### A. Reorganize Report Sections (Sections sheet)

**Add new sections:**

    Section Reference | Section Title           | Parent Section
    ------------------|-------------------------|---------------
    3.1-new          | New Results Section     | 3-results
    3.1.1-subsection | Detailed Analysis       | 3.1-new

**Rename or restructure:** - Modify section titles for clarity - Change
parent-child relationships - Reorder by changing section references

#### B. Reassign Plots to Different Sections (All_Plots sheet)

**Before:**

    Project  | Simulation | Output       | Section Reference
    ---------|------------|--------------|------------------
    Project1 | Sim1       | Concentration| 2-methods

**After (moved to results):**

    Project  | Simulation | Output       | Section Reference
    ---------|------------|--------------|------------------
    Project1 | Sim1       | Concentration| 3-results

**Or remove from report (leave section empty):**

    Project  | Simulation | Output       | Section Reference
    ---------|------------|--------------|------------------
    Project1 | Sim1       | Concentration| [empty - excluded]

#### C. Modify Comparison Time Profile Plots (CT_Plots and CT_Mapping)

**Update plot properties (CT_Plots):** - Change axes labels, titles, or
descriptions - Modify scaling (linear vs. logarithmic) - Update section
assignments - Change plot dimensions

**Update plot mappings (CT_Mapping):** - Add or remove simulation
outputs from plots - Change which observed data is compared - Modify
plot groupings

**Example - Adding a simulation to an existing plot:** In CT_Mapping,
add a row:

    PlotId | Project  | Simulation | Output       | ObservedData
    -------|----------|------------|--------------|-------------
    CT-01  | Project2 | NewSim     | Concentration| ObsData-X

#### D. Create or Modify GOF Plots (GOF_Plots and GOF_Mapping)

Goodness of fit plots typically require:

**In GOF_Plots**: Define the plot with settings

    PlotId   | Title                    | Section Reference
    ---------|--------------------------|------------------
    GOF-01   | Model Validation Summary | 3.2-validation

**In GOF_Mapping**: Map simulation-observation pairs

    PlotId | Project  | Simulation | Output       | ObservedData
    -------|----------|------------|--------------|-------------
    GOF-01 | Project1 | Sim1       | AUC          | Clinical-AUC
    GOF-01 | Project1 | Sim2       | Cmax         | Clinical-Cmax
    GOF-01 | Project2 | Sim3       | AUC          | Clinical-AUC

#### E. Configure Building Block Inheritance (BB sheet)

**Add inheritance:**

    Project  | BB-Type    | BB-Name    | Parent-Project
    ---------|------------|------------|---------------
    Project2 | Compound   | Drug-A     | Project1

**Remove inheritance (leave Parent-Project empty):**

    Project  | BB-Type    | BB-Name    | Parent-Project
    ---------|------------|------------|---------------
    Project2 | Compound   | Drug-A     | [empty]

#### F. Update Parameter Inheritance (SimParam sheet)

Specify parameter inheritance between simulations:

    Project  | Parent Project | Parent Simulation | TargetSimulation | Path
    ---------|----------------|-------------------|------------------|-----
    Project2 | Project1       | Sim-Control       | Sim-DDI          | Organism|*|Parameter

#### G. Add Building Block Documentation (Inputs sheet)

Include building block details in report:

    Project  | BB-Type    | BB-Name      | Section Reference
    ---------|------------|--------------|------------------
    Project1 | Compound   | Verapamil    | 2.1-compounds
    Project1 | Individual | European-Pop | 2.2-populations

#### H. Adjust Plot Settings (GlobalPlotSettings and GlobalAxesSettings)

**GlobalPlotSettings**: Modify figure dimensions, fonts, resolution

**GlobalAxesSettings**: Change default units, scales, or dimension
mappings

#### I. Update Schema Version (MetaInfo sheet)

If updating to work with a newer OSP Suite version:

    Change from: 2.2
    Change to:   2.3

**Important**: Only change this if you know the new version is
compatible with your qualification framework.

### Excel File Content

The Excel file contains all existing evaluations:

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
- Editing Best Practices

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

| Project                          | Simulation                                                         | Output                                                                                         |
|:---------------------------------|:-------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------|
| Mefenamic_acid                   | PO MD 500 mg loading / 250 mg every 6 h                            | Organism\|PeripheralVenousBlood\|Mefenamic acid\|Plasma (Peripheral Venous Blood)              |
| Mefenamic_acid                   | PO SD 250 mg                                                       | Organism\|PeripheralVenousBlood\|Mefenamic acid\|Plasma (Peripheral Venous Blood)              |
| Mefenamic_acid                   | PO SD 500 mg                                                       | Organism\|PeripheralVenousBlood\|Mefenamic acid\|Plasma (Peripheral Venous Blood)              |
| Dapagliflozin                    | IV 0.08 mg (perm)                                                  | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)               |
| Dapagliflozin                    | PO SD 10 mg (perm)                                                 | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)               |
| Dapagliflozin                    | PO SD 10 mg (perm)                                                 | Organism\|Kidney\|Urine\|Dapagliflozin\|Fraction excreted to urine                             |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                 | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)               |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                 | Organism\|Dapagliflozin-UGT1A9-Optimized Metabolite\|Total fraction of dose-Dapagliflozin      |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                 | Organism\|Dapagliflozin-UGT2B7-Optimized Metabolite\|Total fraction of dose-Dapagliflozin      |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                 | Organism\|Dapagliflozin-Hepatic-CYP-Optimized Metabolite\|Total fraction of dose-Dapagliflozin |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                 | Organism\|Lumen\|Feces\|Dapagliflozin\|Fraction excreted to feces                              |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                 | Organism\|Kidney\|Urine\|Dapagliflozin\|Fraction excreted to urine                             |
| Dapagliflozin                    | PO SD 2.5 mg (perm)                                                | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)               |
| Dapagliflozin                    | PO SD 2.5 mg (perm)                                                | Organism\|Kidney\|Urine\|Dapagliflozin\|Fraction excreted to urine                             |
| Dapagliflozin                    | PO SD 5 mg (perm)                                                  | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)               |
| Dapagliflozin                    | PO SD 5 mg (perm)                                                  | Organism\|Kidney\|Urine\|Dapagliflozin\|Fraction excreted to urine                             |
| Dapagliflozin                    | PO SD 20 mg (perm)                                                 | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)               |
| Dapagliflozin                    | PO SD 20 mg (perm)                                                 | Organism\|Kidney\|Urine\|Dapagliflozin\|Fraction excreted to urine                             |
| Dapagliflozin                    | PO SD 100 mg (perm)                                                | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)               |
| Dapagliflozin                    | PO SD 100 mg (perm)                                                | Organism\|Kidney\|Urine\|Dapagliflozin\|Fraction excreted to urine                             |
| Dapagliflozin                    | PO SD 250 mg (perm)                                                | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)               |
| Dapagliflozin                    | PO SD 250 mg (perm)                                                | Organism\|Kidney\|Urine\|Dapagliflozin\|Fraction excreted to urine                             |
| Dapagliflozin                    | PO SD 500 mg (perm)                                                | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)               |
| Dapagliflozin                    | PO SD 500 mg (perm)                                                | Organism\|Kidney\|Urine\|Dapagliflozin\|Fraction excreted to urine                             |
| Dapagliflozin                    | PO SD 5 mg IC tablet (Chang 2015) (perm)                           | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)               |
| Dapagliflozin                    | PO SD 250 mg fed (perm)                                            | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)               |
| Dapagliflozin                    | PO SD 250 mg fed (perm)                                            | Organism\|Kidney\|Urine\|Dapagliflozin\|Fraction excreted to urine                             |
| Dapagliflozin                    | PO SD 10 mg IC tablet (Chang 2015) (perm)                          | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)               |
| Dapagliflozin                    | PO MD 10 mg (perm)                                                 | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)               |
| Dapagliflozin                    | PO MD 10 mg (perm)                                                 | Organism\|Kidney\|Urine\|Dapagliflozin\|Fraction excreted to urine                             |
| Dapagliflozin                    | PO MD 100 mg (perm)                                                | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)               |
| Dapagliflozin                    | PO MD 100 mg (perm)                                                | Organism\|Kidney\|Urine\|Dapagliflozin\|Fraction excreted to urine                             |
| Dapagliflozin                    | PO MD 2.5 mg (perm)                                                | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)               |
| Dapagliflozin                    | PO MD 2.5 mg (perm)                                                | Organism\|Kidney\|Urine\|Dapagliflozin\|Fraction excreted to urine                             |
| Dapagliflozin                    | PO MD 20 mg (perm)                                                 | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)               |
| Dapagliflozin                    | PO MD 20 mg (perm)                                                 | Organism\|Kidney\|Urine\|Dapagliflozin\|Fraction excreted to urine                             |
| Dapagliflozin                    | PO MD 50 mg (perm)                                                 | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)               |
| Dapagliflozin                    | PO MD 50 mg (perm)                                                 | Organism\|Kidney\|Urine\|Dapagliflozin\|Fraction excreted to urine                             |
| Raltegravir                      | Raltegravir 800 mg (lactose formulation)                           | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                 |
| Raltegravir                      | Raltegravir 10 mg (lactose formulation)                            | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                 |
| Raltegravir                      | Raltegravir 100 mg (lactose formulation)                           | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                 |
| Raltegravir                      | Raltegravir 1200 mg (lactose formulation)                          | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                 |
| Raltegravir                      | Raltegravir 1600 mg (lactose formulation)                          | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                 |
| Raltegravir                      | Raltegravir 200 mg (lactose formulation)                           | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                 |
| Raltegravir                      | Raltegravir 25 mg (lactose formulation)                            | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                 |
| Raltegravir                      | Raltegravir 50 mg (lactose formulation)                            | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                 |
| Raltegravir                      | Raltegravir 400mg chewable fasted                                  | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                 |
| Raltegravir                      | Raltegravir 400mg filmcoated tablet                                | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                 |
| Raltegravir                      | Raltegravir 400mg (lactose formulation)                            | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                 |
| Raltegravir                      | Raltegravir 100 mg filmcoated tablet md                            | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                 |
| Raltegravir                      | Raltegravir 200 mg filmcoated tablet md                            | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                 |
| Raltegravir                      | Raltegravir 400 mg filmcoated tablet md                            | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                 |
| Raltegravir                      | Raltegravir 400mg (granules in suspension)                         | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                 |
| Raltegravir                      | Raltegravir 400mg chewable fed                                     | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                 |
| Atazanavir                       | Acosta2007_300mg                                                   | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                  |
| Atazanavir                       | Agarwala2003_400mg                                                 | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                  |
| Atazanavir                       | Agarwala2005a_400mg                                                | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                  |
| Atazanavir                       | Agarwala2005b_400mg                                                | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                  |
| Atazanavir                       | Martin2008_400mg                                                   | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                  |
| Atazanavir                       | Zhu2011_400mg                                                      | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                  |
| Atazanavir                       | FDA-ClinPharmReview_AI424-014_400mg_YoungFemales                   | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                  |
| Atazanavir                       | FDA-ClinPharmReview_AI424-028_200mg                                | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                  |
| Atazanavir                       | FDA-ClinPharmReview_AI424-028_400mg                                | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                  |
| Atazanavir                       | FDA-ClinPharmReview_AI424-040_200mg                                | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                  |
| Atazanavir                       | FDA-ClinPharmReview_AI424-040_400mg                                | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                  |
| Atazanavir                       | FDA-ClinPharmReview_AI424-040_800mg                                | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                  |
| Atazanavir                       | FDA-ClinPharmReview_AI424-056_300mg                                | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                  |
| Atazanavir                       | FDA-ClinPharmReview_AI424-076_400mg                                | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                  |
| Atazanavir                       | FDA-ClinPharmReview_AI424-076_800mg                                | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                  |
| Atazanavir                       | Zhu2010_300mg_Atazanavir                                           | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                  |
| Atazanavir                       | FDA-ClinPharmReview_AI424-004_400mg_TreatmentA                     | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                  |
| Atazanavir                       | FDA-ClinPharmReview_AI424-014_400mg_YoungMales                     | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                  |
| Atazanavir                       | FDA-ClinPharmReview_AI424-014_400mg_YoungMales                     | Organism\|Kidney\|Urine\|Atazanavir\|Fraction excreted to urine                                |
| Atazanavir                       | FDA-ClinPharmReview_AI424-015_400mg_NormalSubjects                 | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                  |
| Mefenamic_acid-Dapagliflozin-DDI | DDI Control - Dapagliflozin - Kasichayanula 2013a                  | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)               |
| Mefenamic_acid-Dapagliflozin-DDI | DDI Treatment - Mefenamic acid/Dapagliflozin - Kasichayanula 2013a | Organism\|PeripheralVenousBlood\|Dapagliflozin\|Plasma (Peripheral Venous Blood)               |
| Mefenamic_acid-Dapagliflozin-DDI | DDI Treatment - Mefenamic acid/Dapagliflozin - Kasichayanula 2013a | Organism\|PeripheralVenousBlood\|Mefenamic acid\|Plasma (Peripheral Venous Blood)              |
| Atazanavir-Raltegravir-DDI       | Neely2010_Raltegravir                                              | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                 |
| Atazanavir-Raltegravir-DDI       | Neely2010_Raltegravir+Atazanavir                                   | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                 |
| Atazanavir-Raltegravir-DDI       | Neely2010_Raltegravir+Atazanavir                                   | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                  |
| Atazanavir-Raltegravir-DDI       | Iwamoto2008_Raltegravir                                            | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                 |
| Atazanavir-Raltegravir-DDI       | Iwamoto2008_Raltegravir+Atazanavir                                 | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                 |
| Atazanavir-Raltegravir-DDI       | Iwamoto2008_Raltegravir+Atazanavir                                 | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                  |
| Atazanavir-Raltegravir-DDI       | Krishna2016_Raltegravir                                            | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                 |
| Atazanavir-Raltegravir-DDI       | Krishna2016_Raltegravir+Atazanavir                                 | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                 |
| Atazanavir-Raltegravir-DDI       | Krishna2016_Raltegravir+Atazanavir                                 | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                  |
| Atazanavir-Raltegravir-DDI       | Zhu2010_Raltegravir                                                | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                 |
| Atazanavir-Raltegravir-DDI       | Zhu2010_Raltegravir+Atazanavir                                     | Organism\|PeripheralVenousBlood\|Atazanavir\|Plasma (Peripheral Venous Blood)                  |
| Atazanavir-Raltegravir-DDI       | Zhu2010_Raltegravir+Atazanavir                                     | Organism\|PeripheralVenousBlood\|Raltegravir\|Plasma (Peripheral Venous Blood)                 |

| Project                          | Simulation                                                         | ObservedData                                                                                                                                                        |
|:---------------------------------|:-------------------------------------------------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Mefenamic_acid                   | PO SD 250 mg                                                       | Rouini 2005 - Reference - Mefenamic acid - PO - 250 mg - Plasma - agg. (n=12)                                                                                       |
| Mefenamic_acid                   | PO SD 250 mg                                                       | Mahadik 2012 - Reference - Mefenamic acid - PO - 250 mg - Plasma - agg. (n=12)                                                                                      |
| Mefenamic_acid                   | PO SD 250 mg                                                       | Hamaguchi 1987 - Treatment 2 - fasted with 200 mL of water - Mefenamic acid - PO - 250 mg - Plasma - agg. (n=4)                                                     |
| Mefenamic_acid                   | PO SD 500 mg                                                       | Goosen 2017 - 500 mg SD - Mefenamic acid - PO - 500 mg - Plasma - agg.                                                                                              |
| Dapagliflozin                    | IV 0.08 mg (perm)                                                  | Boulton 2013 - 14C-dapagliflozin iv - Dapagliflozin - IV - 0.08 mg - Plasma - agg. (n=7)                                                                            |
| Dapagliflozin                    | PO SD 10 mg (perm)                                                 | Boulton 2013 - Dapagliflozin po - Dapagliflozin - PO - 10 mg - Plasma - agg. (n=7)                                                                                  |
| Dapagliflozin                    | PO SD 10 mg (perm)                                                 | Imamura 2013 - Control (Perpetrator Placebo) - Dapagliflozin - PO - 10 mg - Plasma - agg. (n=22)                                                                    |
| Dapagliflozin                    | PO SD 10 mg (perm)                                                 | Kasichayanula 2011a - fasted - Dapagliflozin - PO - 10 mg - Plasma - agg. (n=14)                                                                                    |
| Dapagliflozin                    | PO SD 10 mg (perm)                                                 | Kasichayanula 2013a - Study 1: Control (Perpetrator Placebo) - Dapagliflozin - PO - 10 mg - Plasma - agg. (n=14)                                                    |
| Dapagliflozin                    | PO SD 10 mg (perm)                                                 | Kasichayanula 2013a - Study 2: Control (Perpetrator Placebo) - Dapagliflozin - PO - 10 mg - Plasma - agg. (n=16)                                                    |
| Dapagliflozin                    | PO SD 10 mg (perm)                                                 | Vakkalagadda 2016 - Dapagliflozin - Dapagliflozin - PO - 10 mg - Plasma - agg. (n=42)                                                                               |
| Dapagliflozin                    | PO SD 10 mg (perm)                                                 | Kasichayanula 2011c - Healthy Volunteers - Dapagliflozin - PO - 10 mg - Plasma - agg. (n=6)                                                                         |
| Dapagliflozin                    | PO SD 10 mg (perm)                                                 | Komoroski 2009 - SAD 10 mg - Dapagliflozin - PO - 10 mg - Plasma - agg. (n=6)                                                                                       |
| Dapagliflozin                    | PO SD 10 mg (perm)                                                 | Komoroski 2009 - SAD 10 mg (Urine) - Dapagliflozin - PO - 10 mg - Urine - agg. (n=6)                                                                                |
| Dapagliflozin                    | PO SD 10 mg (perm)                                                 | Komoroski 2009 - MAD 10 mg (day 1) - Dapagliflozin - PO - 10 mg - Plasma - agg. (n=6)                                                                               |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                 | Kasichayanula 2011b - Study 1: 50 mg Control (Perpetrator Placebo) - Dapagliflozin - PO - 50 mg - Plasma - agg. (n=24)                                              |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                 | Kasichayanula 2013b - Healthy subjects with normal kidney function - Dapagliflozin - PO - 50 mg - Plasma - agg. (n=8)                                               |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                 | Kasichayanula 2008 - Mass Balance of 14C-dapagliflozin Urine - Dapagliflozin - PO - 50 mg - Urine - agg. (n=6)                                                      |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                 | Kasichayanula 2008 - Mass Balance of 14C-dapagliflozin Feces - Dapagliflozin - PO - 50 mg - Feces - agg. (n=6)                                                      |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                 | Kasichayanula 2008 - Mass Balance of 14C-dapagliflozin 3OG Gluc - Dapagliflozin-3-O-glucuronide - PO - 50 mg - Fraction - agg. (n=6)                                |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                 | Kasichayanula 2008 - Mass Balance of 14C-dapagliflozin 2OG Gluc - Dapagliflozin-2-O-glucuronide - PO - 50 mg - Fraction - agg. (n=6)                                |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                 | Kasichayanula 2008 - Mass Balance of 14C-dapagliflozin oxid Metab - Dapagliflozin oxidative metabolites - PO - 50 mg - Fraction - agg. (n=6)                        |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                 | Kasichayanula 2008 - Mass Balance of 14C-dapagliflozin 3OG Gluc (incl. unchanged feces exret.) - Dapagliflozin-3-O-glucuronide - PO - 50 mg - Fraction - agg. (n=6) |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                 | Kasichayanula 2008 - Mass Balance of 14C-dapagliflozin 2OG Gluc (incl. unchanged feces exret.) - Dapagliflozin-2-O-glucuronide - PO - 50 mg - Fraction - agg. (n=6) |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                 | Komoroski 2009 - SAD 50 mg - Dapagliflozin - PO - 50 mg - Plasma - agg. (n=6)                                                                                       |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                 | Komoroski 2009 - SAD 50 mg (Urine) - Dapagliflozin - PO - 50 mg - Urine - agg. (n=6)                                                                                |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                 | Komoroski 2009 - MAD 50 mg (day 1) - Dapagliflozin - PO - 50 mg - Plasma - agg. (n=6)                                                                               |
| Dapagliflozin                    | PO SD 2.5 mg (perm)                                                | Komoroski 2009 - SAD 2.5 mg - Dapagliflozin - PO - 2.5 mg - Plasma - agg. (n=6)                                                                                     |
| Dapagliflozin                    | PO SD 2.5 mg (perm)                                                | Komoroski 2009 - SAD 2.5 mg (Urine) - Dapagliflozin - PO - 2.5 mg - Urine - agg. (n=6)                                                                              |
| Dapagliflozin                    | PO SD 2.5 mg (perm)                                                | Komoroski 2009 - MAD 2.5 mg (day 1) - Dapagliflozin - PO - 2.5 mg - Plasma - agg. (n=6)                                                                             |
| Dapagliflozin                    | PO SD 5 mg (perm)                                                  | Komoroski 2009 - SAD 5 mg - Dapagliflozin - PO - 5 mg - Plasma - agg. (n=6)                                                                                         |
| Dapagliflozin                    | PO SD 5 mg (perm)                                                  | Komoroski 2009 - SAD 5 mg (Urine) - Dapagliflozin - PO - 5 mg - Urine - agg. (n=6)                                                                                  |
| Dapagliflozin                    | PO SD 20 mg (perm)                                                 | Kasichayanula 2012 - Study 1: Control (Perpetrator Placebo) - Dapagliflozin - PO - 20 mg - Plasma - agg. (n=24)                                                     |
| Dapagliflozin                    | PO SD 20 mg (perm)                                                 | Komoroski 2009 - SAD 20 mg - Dapagliflozin - PO - 20 mg - Plasma - agg. (n=6)                                                                                       |
| Dapagliflozin                    | PO SD 20 mg (perm)                                                 | Komoroski 2009 - SAD 20 mg (Urine) - Dapagliflozin - PO - 20 mg - Urine - agg. (n=6)                                                                                |
| Dapagliflozin                    | PO SD 20 mg (perm)                                                 | Komoroski 2009 - MAD 20 mg (day 1) - Dapagliflozin - PO - 20 mg - Plasma - agg. (n=6)                                                                               |
| Dapagliflozin                    | PO SD 20 mg (perm)                                                 | Kasichayanula 2011b - Study 2: 20 mg Control (Perpetrator Placebo) - Dapagliflozin - PO - 20 mg - Plasma - agg. (n=18)                                              |
| Dapagliflozin                    | PO SD 20 mg (perm)                                                 | Kasichayanula 2011b - Study 3: 20 mg Control (Perpetrator Placebo) - Dapagliflozin - PO - 20 mg - Plasma - agg. (n=18)                                              |
| Dapagliflozin                    | PO SD 100 mg (perm)                                                | Komoroski 2009 - SAD 100 mg - Dapagliflozin - PO - 100 mg - Plasma - agg. (n=6)                                                                                     |
| Dapagliflozin                    | PO SD 100 mg (perm)                                                | Komoroski 2009 - SAD 100 mg (Urine) - Dapagliflozin - PO - 100 mg - Urine - agg. (n=6)                                                                              |
| Dapagliflozin                    | PO SD 100 mg (perm)                                                | Komoroski 2009 - MAD 100 mg (day 1) - Dapagliflozin - PO - 100 mg - Plasma - agg. (n=6)                                                                             |
| Dapagliflozin                    | PO SD 250 mg (perm)                                                | Komoroski 2009 - SAD 250 mg fasted - Dapagliflozin - PO - 250 mg - Plasma - agg. (n=6)                                                                              |
| Dapagliflozin                    | PO SD 250 mg (perm)                                                | Komoroski 2009 - SAD 250 mg fasted (Urine) - Dapagliflozin - PO - 250 mg - Urine - agg. (n=6)                                                                       |
| Dapagliflozin                    | PO SD 500 mg (perm)                                                | Komoroski 2009 - SAD 500 mg - Dapagliflozin - PO - 500 mg - Plasma - agg. (n=6)                                                                                     |
| Dapagliflozin                    | PO SD 500 mg (perm)                                                | Komoroski 2009 - SAD 500 mg (Urine) - Dapagliflozin - PO - 500 mg - Urine - agg. (n=6)                                                                              |
| Dapagliflozin                    | PO SD 5 mg IC tablet (Chang 2015) (perm)                           | Chang 2015 - Study 1 Treatment A (single oral doses) - Dapagliflozin - PO - 5 mg - Plasma - agg. (n=36)                                                             |
| Dapagliflozin                    | PO SD 250 mg fed (perm)                                            | Komoroski 2009 - SAD 250 mg fed - Dapagliflozin - PO - 250 mg - Plasma - agg. (n=6)                                                                                 |
| Dapagliflozin                    | PO SD 10 mg IC tablet (Chang 2015) (perm)                          | Chang 2015 - Study 2 Treatment A (single oral doses) - Dapagliflozin - PO - 10 mg - Plasma - agg. (n=36)                                                            |
| Dapagliflozin                    | PO MD 10 mg (perm)                                                 | Komoroski 2009 - MAD 10 mg (day 1) - Dapagliflozin - PO - 10 mg - Plasma - agg. (n=6)                                                                               |
| Dapagliflozin                    | PO MD 10 mg (perm)                                                 | Komoroski 2009 - MAD 10 mg (day 7 and day 14) - Dapagliflozin - PO - 10 mg - Plasma - agg. (n=6)                                                                    |
| Dapagliflozin                    | PO MD 100 mg (perm)                                                | Komoroski 2009 - MAD 100 mg (day 1) - Dapagliflozin - PO - 100 mg - Plasma - agg. (n=6)                                                                             |
| Dapagliflozin                    | PO MD 100 mg (perm)                                                | Komoroski 2009 - MAD 100 mg (day 7 and day 14) - Dapagliflozin - PO - 100 mg - Plasma - agg. (n=6)                                                                  |
| Dapagliflozin                    | PO MD 2.5 mg (perm)                                                | Komoroski 2009 - MAD 2.5 mg (day 7 and day 14) - Dapagliflozin - PO - 2.5 mg - Plasma - agg. (n=6)                                                                  |
| Dapagliflozin                    | PO MD 2.5 mg (perm)                                                | Komoroski 2009 - MAD 2.5 mg (day 1) - Dapagliflozin - PO - 2.5 mg - Plasma - agg. (n=6)                                                                             |
| Dapagliflozin                    | PO MD 20 mg (perm)                                                 | Komoroski 2009 - MAD 20 mg (day 1) - Dapagliflozin - PO - 20 mg - Plasma - agg. (n=6)                                                                               |
| Dapagliflozin                    | PO MD 20 mg (perm)                                                 | Komoroski 2009 - MAD 20 mg (day 7 and day 14) - Dapagliflozin - PO - 20 mg - Plasma - agg. (n=6)                                                                    |
| Dapagliflozin                    | PO MD 50 mg (perm)                                                 | Komoroski 2009 - MAD 50 mg (day 1) - Dapagliflozin - PO - 50 mg - Plasma - agg. (n=6)                                                                               |
| Dapagliflozin                    | PO MD 50 mg (perm)                                                 | Komoroski 2009 - MAD 50 mg (day 7 and day 14) - Dapagliflozin - PO - 50 mg - Plasma - agg. (n=6)                                                                    |
| Raltegravir                      | Raltegravir 800 mg (lactose formulation)                           | Iwamoto 2008 - 800mg - Raltegravir - PO - 800 mg - Plasma - agg. (n=24)                                                                                             |
| Raltegravir                      | Raltegravir 10 mg (lactose formulation)                            | Iwamoto 2008 - 10mg - Raltegravir - PO - 10 mg - Plasma - agg. (n=24)                                                                                               |
| Raltegravir                      | Raltegravir 100 mg (lactose formulation)                           | Iwamoto 2008 - 100mg - Raltegravir - PO - 100 mg - Plasma - agg. (n=24)                                                                                             |
| Raltegravir                      | Raltegravir 1200 mg (lactose formulation)                          | Iwamoto 2008 - 1200mg - Raltegravir - PO - 1200 mg - Plasma - agg. (n=24)                                                                                           |
| Raltegravir                      | Raltegravir 1600 mg (lactose formulation)                          | Iwamoto 2008 - 1600mg - Raltegravir - PO - 1600 mg - Plasma - agg. (n=24)                                                                                           |
| Raltegravir                      | Raltegravir 200 mg (lactose formulation)                           | Iwamoto 2008 - 200mg - Raltegravir - PO - 200 mg - Plasma - agg. (n=24)                                                                                             |
| Raltegravir                      | Raltegravir 25 mg (lactose formulation)                            | Iwamoto 2008 - 25mg - Raltegravir - PO - 25 mg - Plasma - agg. (n=24)                                                                                               |
| Raltegravir                      | Raltegravir 50 mg (lactose formulation)                            | Iwamoto 2008 - 50mg - Raltegravir - PO - 50 mg - Plasma - agg. (n=24)                                                                                               |
| Raltegravir                      | Raltegravir 400mg chewable fasted                                  | Rhee 2014 - Chewable tablet fasted - Raltegravir - po - 400 mg - Plasma - agg. (n=12)                                                                               |
| Raltegravir                      | Raltegravir 400mg filmcoated tablet                                | Rhee 2014 - filmcoated tablet - Raltegravir - po - 400 mg - Plasma - agg. (n=12)                                                                                    |
| Raltegravir                      | Raltegravir 400mg filmcoated tablet                                | Wenning 2009 - 400mg - Raltegravir - PO - 400 mg - Plasma - agg. (n=10)                                                                                             |
| Raltegravir                      | Raltegravir 400mg filmcoated tablet                                | Iwamoto 2008 - 400mg FCT - Raltegravir - PO - 400 mg - Plasma - agg. (n=14)                                                                                         |
| Raltegravir                      | Raltegravir 400mg (lactose formulation)                            | Iwamoto 2008 - 400mg - Raltegravir - PO - 400 mg - Plasma - agg. (n=24)                                                                                             |
| Raltegravir                      | Raltegravir 100 mg filmcoated tablet md                            | Markowitz 2006 - 100mg FCT MD - Raltegravir - PO - 100 mg - Plasma - agg. (n=7)                                                                                     |
| Raltegravir                      | Raltegravir 200 mg filmcoated tablet md                            | Markowitz 2006 - 200mg FCT MD - Raltegravir - PO - 200 mg - Plasma - agg. (n=7)                                                                                     |
| Raltegravir                      | Raltegravir 200 mg filmcoated tablet md                            | Kassahun 2007 - 200mg FCT SD - Raltegravir - PO - 200 mg - Plasma - agg. (n=8)                                                                                      |
| Raltegravir                      | Raltegravir 400 mg filmcoated tablet md                            | Markowitz 2006 - 400mg FCT MD - Raltegravir - PO - 400 mg - Plasma - agg. (n=6)                                                                                     |
| Raltegravir                      | Raltegravir 400mg (granules in suspension)                         | Rhee 2014 - granules suspension - Raltegravir - po - 400 mg - Plasma - agg. (n=12)                                                                                  |
| Raltegravir                      | Raltegravir 400mg chewable fed                                     | Rhee 2014 - Chewable tablet fed - Raltegravir - po - 400 mg - Plasma - agg. (n=12)                                                                                  |
| Atazanavir                       | Acosta2007_300mg                                                   | Acosta 2007 - Period 1 - Atazanavir - PO - 300 mg - Plasma - agg. (n=10)                                                                                            |
| Atazanavir                       | Agarwala2003_400mg                                                 | Agarwala 2003 - Day 6 - Atazanavir - PO - 400 mg - Plasma - agg. (n=65)                                                                                             |
| Atazanavir                       | Agarwala2005a_400mg                                                | Agarwala 2005a - ATV 400 mg AM (N=15) - Atazanavir - PO - 400 mg - Plasma - agg. (n=15)                                                                             |
| Atazanavir                       | Agarwala2005b_400mg                                                | Agarwala 2005b - ATV 400 mg (Treatment A) - Atazanavir - PO - 400 mg - Plasma - agg. (n=16)                                                                         |
| Atazanavir                       | Martin2008_400mg                                                   | Martin 2008 - Atazanavir monotherapy (n = 24) - Atazanavir - PO - 400 mg - Plasma - agg. (n=24)                                                                     |
| Atazanavir                       | Zhu2011_400mg                                                      | Zhu 2011 - Treatment A: Atazanavir 400 mg QPM - Atazanavir - PO - 400 mg - Plasma - agg. (n=28)                                                                     |
| Atazanavir                       | Zhu2011_400mg                                                      | Zhu 2011 - Treatment B: Atazanavir 400 mg QAM - Atazanavir - PO - 400 mg - Plasma - agg. (n=28)                                                                     |
| Atazanavir                       | FDA-ClinPharmReview_AI424-014_400mg_YoungFemales                   | ClinPharmReview, AI424-014, p. 77 - Young Females - Atazanavir - PO - 400 mg - Plasma - agg. (n=14)                                                                 |
| Atazanavir                       | FDA-ClinPharmReview_AI424-028_200mg                                | ClinPharmReview, AI424-028, p. 128 - A-Day 6 - Atazanavir - PO - 200 mg - Plasma - agg. (n=8)                                                                       |
| Atazanavir                       | FDA-ClinPharmReview_AI424-028_200mg                                | ClinPharmReview, AI424-028, p. 128 - B-Day 6 - Atazanavir - PO - 200 mg - Plasma - agg. (n=8)                                                                       |
| Atazanavir                       | FDA-ClinPharmReview_AI424-028_400mg                                | ClinPharmReview, AI424-028, p. 128 - C-Day 6 - Atazanavir - PO - 400 mg - Plasma - agg. (n=8)                                                                       |
| Atazanavir                       | FDA-ClinPharmReview_AI424-028_400mg                                | ClinPharmReview, AI424-028, p. 128 - D-Day 6 - Atazanavir - PO - 400 mg - Plasma - agg. (n=8)                                                                       |
| Atazanavir                       | FDA-ClinPharmReview_AI424-040_200mg                                | ClinPharmReview, AI424-040, p. 64 - 200 mg - Atazanavir - PO - 200 mg - Plasma - agg. (n=20)                                                                        |
| Atazanavir                       | FDA-ClinPharmReview_AI424-040_400mg                                | ClinPharmReview, AI424-040, p. 64 - 400 mg - Atazanavir - PO - 400 mg - Plasma - agg. (n=20)                                                                        |
| Atazanavir                       | FDA-ClinPharmReview_AI424-040_800mg                                | ClinPharmReview, AI424-040, p. 64 - 800 mg - Atazanavir - PO - 800 mg - Plasma - agg. (n=20)                                                                        |
| Atazanavir                       | FDA-ClinPharmReview_AI424-056_300mg                                | ClinPharmReview, AI424-056, p. 134 - Atazanavir without ritonavir, Day 10 - Atazanavir - PO - 300 mg - Plasma - agg. (n=30)                                         |
| Atazanavir                       | FDA-ClinPharmReview_AI424-076_400mg                                | ClinPharmReview, AI424-076, p. 178 - 400 mg - Atazanavir - PO - 400 mg - Plasma - agg. (n=65)                                                                       |
| Atazanavir                       | FDA-ClinPharmReview_AI424-076_800mg                                | ClinPharmReview, AI424-076, p. 178 - 800 mg - Atazanavir - PO - 800 mg - Plasma - agg. (n=66)                                                                       |
| Atazanavir                       | Zhu2010_300mg_Atazanavir                                           | Zhu 2010 - Atazanvir 300 mg twice daily - Atazanavir - PO - 300 mg - Plasma - agg. (n=22)                                                                           |
| Atazanavir                       | FDA-ClinPharmReview_AI424-004_400mg_TreatmentA                     | ClinPharmReview, AI424-004, p. 94 - Treatment A - Atazanavir - PO - 400 mg - Plasma - agg. (n=32)                                                                   |
| Atazanavir                       | FDA-ClinPharmReview_AI424-014_400mg_YoungMales                     | ClinPharmReview, AI424-029, p. 47 - Urinary radioactivity - Atazanavir - PO - 400 - Urine - agg. (n=12)                                                             |
| Atazanavir                       | FDA-ClinPharmReview_AI424-014_400mg_YoungMales                     | ClinPharmReview, AI424-014, p. 77 - Young Males - Atazanavir - PO - 400 mg - Plasma - agg. (n=15)                                                                   |
| Atazanavir                       | FDA-ClinPharmReview_AI424-015_400mg_NormalSubjects                 | ClinPharmReview, AI424-015, p. 81 - Normal subjects - Atazanavir - PO - 400 mg - Plasma - agg. (n=16)                                                               |
| Mefenamic_acid-Dapagliflozin-DDI | DDI Control - Dapagliflozin - Kasichayanula 2013a                  | Kasichayanula 2013a - Study 2: Control (Perpetrator Placebo) - Dapagliflozin - PO - 10 mg - Plasma - agg. (n=16)                                                    |
| Mefenamic_acid-Dapagliflozin-DDI | DDI Treatment - Mefenamic acid/Dapagliflozin - Kasichayanula 2013a | Kasichayanula 2013a - Study 2: with Perpetrator (Mefenamic Acid) - Dapagliflozin - PO - 10 mg - Plasma - agg. (n=16)                                                |
| Atazanavir-Raltegravir-DDI       | Neely2010_Raltegravir                                              | Neely 2010 - Study arm A (Raltegravir 400mg BID) - Raltegravir - PO - 400 mg - Plasma - agg. (n=20)                                                                 |
| Atazanavir-Raltegravir-DDI       | Neely2010_Raltegravir+Atazanavir                                   | Neely 2010 - Study arm B (Raltegravir 400mg OD + Atazanavir 400 mg OD) - Raltegravir - PO - 400 mg - Plasma - agg. (n=19)                                           |
| Atazanavir-Raltegravir-DDI       | Iwamoto2008_Raltegravir                                            | Iwamoto 2008 - Study I, Period 1 (control) - Raltegravir - PO - 100 mg - Plasma - agg. (n=10)                                                                       |
| Atazanavir-Raltegravir-DDI       | Iwamoto2008_Raltegravir+Atazanavir                                 | Iwamoto 2008 - Study I, Period 2 (ATV treatment) - Raltegravir - PO - 100 mg - Plasma - agg. (n=10)                                                                 |
| Atazanavir-Raltegravir-DDI       | Krishna2016_Raltegravir                                            | Krishna 2016 - Period 1, Day 1 (1200 mg raltegravir SD) - Raltegravir - PO - 1200 mg - Plasma - agg. (n=14)                                                         |
| Atazanavir-Raltegravir-DDI       | Krishna2016_Raltegravir+Atazanavir                                 | Krishna 2016 - Period 2, Day 7 (1200 mg raltegravir SD with OD doses of 400 mg ATV) - Raltegravir - PO - 1200 mg - Plasma - agg. (n=12)                             |
| Atazanavir-Raltegravir-DDI       | Zhu2010_Raltegravir                                                | Zhu 2010 - Raltegravir 400 mg twice daily - Raltegravir - PO - 400 mg - Plasma - agg. (n=22)                                                                        |
| Atazanavir-Raltegravir-DDI       | Zhu2010_Raltegravir+Atazanavir                                     | Zhu 2010 - Raltegravir 400 mg twice daily plus atazanavir 300 mg twice daily - Raltegravir - PO - 400 mg - Plasma - agg. (n=19)                                     |
| Atazanavir-Raltegravir-DDI       | Zhu2010_Raltegravir+Atazanavir                                     | Zhu 2010 - Atazanvir 300 mg twice daily plus raltegravir 400 mg twice daily - Atazanavir - PO - 300 mg - Plasma - agg. (n=19)                                       |

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

| Project                          | Parent.Project | Parent.Simulation  | Path                                            | TargetSimulation                                                   |
|:---------------------------------|:---------------|:-------------------|:------------------------------------------------|:-------------------------------------------------------------------|
| Mefenamic_acid-Dapagliflozin-DDI | Dapagliflozin  | PO SD 10 mg (perm) | Dapagliflozin\|logP (veg.oil/water)             | DDI Control - Dapagliflozin - Kasichayanula 2013a                  |
| Mefenamic_acid-Dapagliflozin-DDI | Dapagliflozin  | PO SD 10 mg (perm) | Dapagliflozin\|logP (veg.oil/water)             | DDI Treatment - Mefenamic acid/Dapagliflozin - Kasichayanula 2013a |
| Mefenamic_acid-Dapagliflozin-DDI | Dapagliflozin  | PO SD 10 mg (perm) | Dapagliflozin\|Blood/Plasma concentration ratio | DDI Control - Dapagliflozin - Kasichayanula 2013a                  |
| Mefenamic_acid-Dapagliflozin-DDI | Dapagliflozin  | PO SD 10 mg (perm) | Dapagliflozin\|Blood/Plasma concentration ratio | DDI Treatment - Mefenamic acid/Dapagliflozin - Kasichayanula 2013a |

| Project                          | Simulation                                                         | Section.Reference |
|:---------------------------------|:-------------------------------------------------------------------|:------------------|
| Raltegravir                      | tralala                                                            | introduction      |
| Mefenamic_acid                   | PO MD 500 mg loading / 250 mg every 6 h                            | NA                |
| Mefenamic_acid                   | PO SD 250 mg                                                       | NA                |
| Mefenamic_acid                   | PO SD 500 mg                                                       | NA                |
| Dapagliflozin                    | IV 0.08 mg (perm)                                                  | NA                |
| Dapagliflozin                    | PO SD 10 mg (perm)                                                 | NA                |
| Dapagliflozin                    | PO SD 10 mg (perm)                                                 | NA                |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                 | NA                |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                 | NA                |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                 | NA                |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                 | NA                |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                 | NA                |
| Dapagliflozin                    | PO SD 50 mg (perm)                                                 | NA                |
| Dapagliflozin                    | PO SD 2.5 mg (perm)                                                | NA                |
| Dapagliflozin                    | PO SD 2.5 mg (perm)                                                | NA                |
| Dapagliflozin                    | PO SD 5 mg (perm)                                                  | NA                |
| Dapagliflozin                    | PO SD 5 mg (perm)                                                  | NA                |
| Dapagliflozin                    | PO SD 20 mg (perm)                                                 | NA                |
| Dapagliflozin                    | PO SD 20 mg (perm)                                                 | NA                |
| Dapagliflozin                    | PO SD 100 mg (perm)                                                | NA                |
| Dapagliflozin                    | PO SD 100 mg (perm)                                                | NA                |
| Dapagliflozin                    | PO SD 250 mg (perm)                                                | NA                |
| Dapagliflozin                    | PO SD 250 mg (perm)                                                | NA                |
| Dapagliflozin                    | PO SD 500 mg (perm)                                                | NA                |
| Dapagliflozin                    | PO SD 500 mg (perm)                                                | NA                |
| Dapagliflozin                    | PO SD 5 mg IC tablet (Chang 2015) (perm)                           | NA                |
| Dapagliflozin                    | PO SD 250 mg fed (perm)                                            | NA                |
| Dapagliflozin                    | PO SD 250 mg fed (perm)                                            | NA                |
| Dapagliflozin                    | PO SD 10 mg IC tablet (Chang 2015) (perm)                          | NA                |
| Dapagliflozin                    | PO MD 10 mg (perm)                                                 | NA                |
| Dapagliflozin                    | PO MD 10 mg (perm)                                                 | NA                |
| Dapagliflozin                    | PO MD 100 mg (perm)                                                | NA                |
| Dapagliflozin                    | PO MD 100 mg (perm)                                                | NA                |
| Dapagliflozin                    | PO MD 2.5 mg (perm)                                                | NA                |
| Dapagliflozin                    | PO MD 2.5 mg (perm)                                                | NA                |
| Dapagliflozin                    | PO MD 20 mg (perm)                                                 | NA                |
| Dapagliflozin                    | PO MD 20 mg (perm)                                                 | NA                |
| Dapagliflozin                    | PO MD 50 mg (perm)                                                 | NA                |
| Dapagliflozin                    | PO MD 50 mg (perm)                                                 | NA                |
| Raltegravir                      | Raltegravir 800 mg (lactose formulation)                           | NA                |
| Raltegravir                      | Raltegravir 10 mg (lactose formulation)                            | NA                |
| Raltegravir                      | Raltegravir 100 mg (lactose formulation)                           | NA                |
| Raltegravir                      | Raltegravir 1200 mg (lactose formulation)                          | NA                |
| Raltegravir                      | Raltegravir 1600 mg (lactose formulation)                          | NA                |
| Raltegravir                      | Raltegravir 200 mg (lactose formulation)                           | NA                |
| Raltegravir                      | Raltegravir 25 mg (lactose formulation)                            | NA                |
| Raltegravir                      | Raltegravir 50 mg (lactose formulation)                            | NA                |
| Raltegravir                      | Raltegravir 400mg chewable fasted                                  | NA                |
| Raltegravir                      | Raltegravir 400mg filmcoated tablet                                | NA                |
| Raltegravir                      | Raltegravir 400mg (lactose formulation)                            | NA                |
| Raltegravir                      | Raltegravir 100 mg filmcoated tablet md                            | NA                |
| Raltegravir                      | Raltegravir 200 mg filmcoated tablet md                            | NA                |
| Raltegravir                      | Raltegravir 400 mg filmcoated tablet md                            | NA                |
| Raltegravir                      | Raltegravir 400mg (granules in suspension)                         | NA                |
| Raltegravir                      | Raltegravir 400mg chewable fed                                     | NA                |
| Atazanavir                       | Acosta2007_300mg                                                   | NA                |
| Atazanavir                       | Agarwala2003_400mg                                                 | NA                |
| Atazanavir                       | Agarwala2005a_400mg                                                | NA                |
| Atazanavir                       | Agarwala2005b_400mg                                                | NA                |
| Atazanavir                       | Martin2008_400mg                                                   | NA                |
| Atazanavir                       | Zhu2011_400mg                                                      | NA                |
| Atazanavir                       | FDA-ClinPharmReview_AI424-014_400mg_YoungFemales                   | NA                |
| Atazanavir                       | FDA-ClinPharmReview_AI424-028_200mg                                | NA                |
| Atazanavir                       | FDA-ClinPharmReview_AI424-028_400mg                                | NA                |
| Atazanavir                       | FDA-ClinPharmReview_AI424-040_200mg                                | NA                |
| Atazanavir                       | FDA-ClinPharmReview_AI424-040_400mg                                | NA                |
| Atazanavir                       | FDA-ClinPharmReview_AI424-040_800mg                                | NA                |
| Atazanavir                       | FDA-ClinPharmReview_AI424-056_300mg                                | NA                |
| Atazanavir                       | FDA-ClinPharmReview_AI424-076_400mg                                | NA                |
| Atazanavir                       | FDA-ClinPharmReview_AI424-076_800mg                                | NA                |
| Atazanavir                       | Zhu2010_300mg_Atazanavir                                           | NA                |
| Atazanavir                       | FDA-ClinPharmReview_AI424-004_400mg_TreatmentA                     | NA                |
| Atazanavir                       | FDA-ClinPharmReview_AI424-014_400mg_YoungMales                     | NA                |
| Atazanavir                       | FDA-ClinPharmReview_AI424-014_400mg_YoungMales                     | NA                |
| Atazanavir                       | FDA-ClinPharmReview_AI424-015_400mg_NormalSubjects                 | NA                |
| Mefenamic_acid-Dapagliflozin-DDI | DDI Control - Dapagliflozin - Kasichayanula 2013a                  | NA                |
| Mefenamic_acid-Dapagliflozin-DDI | DDI Treatment - Mefenamic acid/Dapagliflozin - Kasichayanula 2013a | NA                |
| Mefenamic_acid-Dapagliflozin-DDI | DDI Treatment - Mefenamic acid/Dapagliflozin - Kasichayanula 2013a | NA                |
| Atazanavir-Raltegravir-DDI       | Neely2010_Raltegravir                                              | NA                |
| Atazanavir-Raltegravir-DDI       | Neely2010_Raltegravir+Atazanavir                                   | NA                |
| Atazanavir-Raltegravir-DDI       | Neely2010_Raltegravir+Atazanavir                                   | NA                |
| Atazanavir-Raltegravir-DDI       | Iwamoto2008_Raltegravir                                            | NA                |
| Atazanavir-Raltegravir-DDI       | Iwamoto2008_Raltegravir+Atazanavir                                 | NA                |
| Atazanavir-Raltegravir-DDI       | Iwamoto2008_Raltegravir+Atazanavir                                 | NA                |
| Atazanavir-Raltegravir-DDI       | Krishna2016_Raltegravir                                            | NA                |
| Atazanavir-Raltegravir-DDI       | Krishna2016_Raltegravir+Atazanavir                                 | NA                |
| Atazanavir-Raltegravir-DDI       | Krishna2016_Raltegravir+Atazanavir                                 | NA                |
| Atazanavir-Raltegravir-DDI       | Zhu2010_Raltegravir                                                | NA                |
| Atazanavir-Raltegravir-DDI       | Zhu2010_Raltegravir+Atazanavir                                     | NA                |
| Atazanavir-Raltegravir-DDI       | Zhu2010_Raltegravir+Atazanavir                                     | NA                |

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
| ComparisonTimeProfile             | Y    | Concentration (mass) | ng/ml   |   FALSE   | Log     |
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

- **Use data validation dropdowns**: Don’t type free text where
  dropdowns exist (section references, projects, simulations)
- **Check dependencies**: If you rename or delete sections, update
  references to them in plot sheets
- **Test incrementally**: After major changes, convert to JSON and test
  before making more edits
- **Keep backups**: Save a copy before making extensive changes
- **Document rationale**: Use Excel comments to note why changes were
  made
- **Validate section references**: Ensure all section references in
  evaluation sheets match defined sections

For detailed worksheet descriptions, see the [Excel Template
Documentation](https://www.open-systems-pharmacology.org/OSPSuite.QualificationPlanEditor/articles/excel-template.md).

## Step 4: Convert Back to JSON

After editing, convert the Excel file back to a JSON qualification plan:

``` r
excelToQualificationPlan(
  excelFile = excelFile,
  qualificationPlan = paste0("updated-", qualificationPlan)
)
```

**Note**: Using `paste0("updated-", qualificationPlan)` creates a new
file with an “updated-” prefix, preserving your original. This is
recommended for safety.

### Validation Process

The function validates your edits:

- **Section references**: All references must match sections in the
  Sections sheet
- **Project/simulation names**: Must match definitions in the
  `Projects`, `Simulations_Outputs`, and `Simulations_ObsData` sheets
- **Building block references**: Parent projects must exist
- **Required columns**: All mandatory columns must be present
- **Lookup values**: Values must match allowed options in Lookup sheet

### Handling Validation Errors

If validation fails, you’ll see error messages like:

    Error: Invalid section reference 'old-section' in All_Plots sheet
    Error: Project 'NonExistent' not found in Projects sheet
    Error: Missing required column 'Section Reference' in CT_Plots sheet

**To fix**: 1. Open the Excel file 2. Navigate to the problematic sheet
3. Correct the error (use data validation dropdowns when available) 4.
Save and convert again

### Successful Conversion

Upon success, you’ll see a confirmation message. The updated
qualification plan JSON is ready for use with the OSP Suite
Qualification Runner.

## Next Steps

After updating your qualification plan:

1.  **Run the qualification**: Execute with the OSP Suite Qualification
    Runner
2.  **Review the generated report**: Verify changes appear as expected
3.  **Check plots and sections**: Ensure evaluations are in the right
    sections with correct configurations
4.  **Iterate if needed**: If further adjustments are required, convert
    back to Excel and edit again

## Common Update Scenarios

### Scenario 1: Reorganizing Report Structure

**Goal**: Move validation results from “Methods” to a new “Validation”
section

**Steps**: 1. In Sections sheet, create new “Validation” section 2. In
All_Plots, CT_Plots, GOF_Plots, update Section Reference for validation
plots 3. Convert and verify

### Scenario 2: Excluding Certain Plots

**Goal**: Remove specific simulation outputs from the report

**Steps**: 1. In All_Plots sheet, find the outputs to exclude 2. Clear
the Section Reference column for those rows 3. Convert - plots without
section references are excluded

### Scenario 3: Adding New Comparison Plots

**Goal**: Create a new CT plot comparing multiple simulations

**Steps**: 1. In CT_Plots, add a row with unique PlotId and
configuration 2. In CT_Mapping, add rows mapping simulations and
observed data to this PlotId 3. Assign the plot to a section using
Section Reference 4. Convert and test

### Scenario 4: Updating Building Block Inheritance

**Goal**: Change a project to inherit a compound from a different parent

**Steps**: 1. In BB sheet, find the building block row 2. Change the
Parent-Project column value 3. Verify the parent project exists and has
the building block 4. Convert and test

### Scenario 5: Changing Plot Appearance

**Goal**: Make all plots larger and higher resolution

**Steps**: 1. In GlobalPlotSettings, update Width, Height, and
Resolution 2. Optionally update font sizes 3. Convert - all plots will
use new settings

## Troubleshooting

### Issue: “Section reference not found”

**Cause**: You referenced a section that doesn’t exist

**Fix**: Check the Sections sheet for valid section references and
update your references

### Issue: “Invalid project name in mapping”

**Cause**: You typed a project name that doesn’t match the Projects
sheet

**Fix**: Use the data validation dropdown to select from valid projects

### Issue: “Building block inheritance creates circular dependency”

**Cause**: Project A inherits from Project B, which inherits from
Project A

**Fix**: Review the BB sheet and remove circular inheritance

### Issue: “Plot appears in wrong section in report”

**Cause**: Section reference is incorrect or section hierarchy is wrong

**Fix**: Verify section references and parent-child relationships in
Sections sheet

## Advanced Tips

- **Bulk updates**: Use Excel’s find-and-replace to update multiple
  section references at once
- **Copy plot configurations**: Duplicate rows in plot sheets to create
  similar plots quickly
- **Filter and sort**: Use Excel’s filter feature to focus on specific
  projects or sections
- **Conditional formatting**: Add your own conditional formatting to
  highlight specific items
- **Freeze panes**: Freeze header rows to keep column names visible
  while scrolling

## Related Articles

- [Excel Template
  Documentation](https://www.open-systems-pharmacology.org/OSPSuite.QualificationPlanEditor/articles/excel-template.md):
  Comprehensive worksheet guide
- [Add a Snapshot to Qualification
  Plan](https://www.open-systems-pharmacology.org/OSPSuite.QualificationPlanEditor/articles/snapshot-qualification.md):
  Adding new projects
- [Create Qualification from
  Snapshot](https://www.open-systems-pharmacology.org/OSPSuite.QualificationPlanEditor/articles/no-qualification.md):
  Starting from scratch
