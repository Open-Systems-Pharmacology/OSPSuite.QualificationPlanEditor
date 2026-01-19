# getSimulationsOutputsFromProjects

Get a data.frame of projects, simulations and outputs

## Usage

``` r
getSimulationsOutputsFromProjects(projectData)
```

## Arguments

- projectData:

  A data.frame of project snapshots

## Value

A data.frame with columns \`Project\`, \`Simulation\` and \`Output\`

## Examples

``` r
# Get the project data from a list of paths
snapshotPaths <- list(
  "Raltegravir" = file.path(
    "https://raw.githubusercontent.com",
    "Open-Systems-Pharmacology",
    "Raltegravir-Model",
    "v1.2",
    "Raltegravir-Model.json"
  ),
  "Atazanavir" = file.path(
    "https://raw.githubusercontent.com",
    "Open-Systems-Pharmacology",
    "Atazanavir-Model",
    "v1.2",
    "Atazanavir-Model.json"
  )
)
projectData <- getProjectsFromList(snapshotPaths)

# Get the simulations outputs from the projects
getSimulationsOutputsFromProjects(projectData)
#>        Project                                         Simulation
#> 1  Raltegravir          Raltegravir 800 mg  (lactose formulation)
#> 2  Raltegravir          Raltegravir 10 mg   (lactose formulation)
#> 3  Raltegravir          Raltegravir 100 mg  (lactose formulation)
#> 4  Raltegravir        Raltegravir 1200 mg   (lactose formulation)
#> 5  Raltegravir         Raltegravir 1600 mg  (lactose formulation)
#> 6  Raltegravir         Raltegravir 200 mg   (lactose formulation)
#> 7  Raltegravir           Raltegravir 25 mg  (lactose formulation)
#> 8  Raltegravir           Raltegravir 50 mg  (lactose formulation)
#> 9  Raltegravir                  Raltegravir 400mg chewable fasted
#> 10 Raltegravir                Raltegravir 400mg filmcoated tablet
#> 11 Raltegravir            Raltegravir 400mg (lactose formulation)
#> 12 Raltegravir            Raltegravir 100 mg filmcoated tablet md
#> 13 Raltegravir            Raltegravir 200 mg filmcoated tablet md
#> 14 Raltegravir            Raltegravir 400 mg filmcoated tablet md
#> 15 Raltegravir         Raltegravir 400mg (granules in suspension)
#> 16 Raltegravir                     Raltegravir 400mg chewable fed
#> 17  Atazanavir                                   Acosta2007_300mg
#> 18  Atazanavir                                 Agarwala2003_400mg
#> 19  Atazanavir                                Agarwala2005a_400mg
#> 20  Atazanavir                                Agarwala2005b_400mg
#> 21  Atazanavir                                   Martin2008_400mg
#> 22  Atazanavir                                      Zhu2011_400mg
#> 23  Atazanavir   FDA-ClinPharmReview_AI424-014_400mg_YoungFemales
#> 24  Atazanavir                FDA-ClinPharmReview_AI424-028_200mg
#> 25  Atazanavir                FDA-ClinPharmReview_AI424-028_400mg
#> 26  Atazanavir                FDA-ClinPharmReview_AI424-040_200mg
#> 27  Atazanavir                FDA-ClinPharmReview_AI424-040_400mg
#> 28  Atazanavir                FDA-ClinPharmReview_AI424-040_800mg
#> 29  Atazanavir                FDA-ClinPharmReview_AI424-056_300mg
#> 30  Atazanavir                FDA-ClinPharmReview_AI424-076_400mg
#> 31  Atazanavir                FDA-ClinPharmReview_AI424-076_800mg
#> 32  Atazanavir                           Zhu2010_300mg_Atazanavir
#> 33  Atazanavir     FDA-ClinPharmReview_AI424-004_400mg_TreatmentA
#> 34  Atazanavir     FDA-ClinPharmReview_AI424-014_400mg_YoungMales
#> 35  Atazanavir     FDA-ClinPharmReview_AI424-014_400mg_YoungMales
#> 36  Atazanavir FDA-ClinPharmReview_AI424-015_400mg_NormalSubjects
#>                                                                         Output
#> 1  Organism|PeripheralVenousBlood|Raltegravir|Plasma (Peripheral Venous Blood)
#> 2  Organism|PeripheralVenousBlood|Raltegravir|Plasma (Peripheral Venous Blood)
#> 3  Organism|PeripheralVenousBlood|Raltegravir|Plasma (Peripheral Venous Blood)
#> 4  Organism|PeripheralVenousBlood|Raltegravir|Plasma (Peripheral Venous Blood)
#> 5  Organism|PeripheralVenousBlood|Raltegravir|Plasma (Peripheral Venous Blood)
#> 6  Organism|PeripheralVenousBlood|Raltegravir|Plasma (Peripheral Venous Blood)
#> 7  Organism|PeripheralVenousBlood|Raltegravir|Plasma (Peripheral Venous Blood)
#> 8  Organism|PeripheralVenousBlood|Raltegravir|Plasma (Peripheral Venous Blood)
#> 9  Organism|PeripheralVenousBlood|Raltegravir|Plasma (Peripheral Venous Blood)
#> 10 Organism|PeripheralVenousBlood|Raltegravir|Plasma (Peripheral Venous Blood)
#> 11 Organism|PeripheralVenousBlood|Raltegravir|Plasma (Peripheral Venous Blood)
#> 12 Organism|PeripheralVenousBlood|Raltegravir|Plasma (Peripheral Venous Blood)
#> 13 Organism|PeripheralVenousBlood|Raltegravir|Plasma (Peripheral Venous Blood)
#> 14 Organism|PeripheralVenousBlood|Raltegravir|Plasma (Peripheral Venous Blood)
#> 15 Organism|PeripheralVenousBlood|Raltegravir|Plasma (Peripheral Venous Blood)
#> 16 Organism|PeripheralVenousBlood|Raltegravir|Plasma (Peripheral Venous Blood)
#> 17  Organism|PeripheralVenousBlood|Atazanavir|Plasma (Peripheral Venous Blood)
#> 18  Organism|PeripheralVenousBlood|Atazanavir|Plasma (Peripheral Venous Blood)
#> 19  Organism|PeripheralVenousBlood|Atazanavir|Plasma (Peripheral Venous Blood)
#> 20  Organism|PeripheralVenousBlood|Atazanavir|Plasma (Peripheral Venous Blood)
#> 21  Organism|PeripheralVenousBlood|Atazanavir|Plasma (Peripheral Venous Blood)
#> 22  Organism|PeripheralVenousBlood|Atazanavir|Plasma (Peripheral Venous Blood)
#> 23  Organism|PeripheralVenousBlood|Atazanavir|Plasma (Peripheral Venous Blood)
#> 24  Organism|PeripheralVenousBlood|Atazanavir|Plasma (Peripheral Venous Blood)
#> 25  Organism|PeripheralVenousBlood|Atazanavir|Plasma (Peripheral Venous Blood)
#> 26  Organism|PeripheralVenousBlood|Atazanavir|Plasma (Peripheral Venous Blood)
#> 27  Organism|PeripheralVenousBlood|Atazanavir|Plasma (Peripheral Venous Blood)
#> 28  Organism|PeripheralVenousBlood|Atazanavir|Plasma (Peripheral Venous Blood)
#> 29  Organism|PeripheralVenousBlood|Atazanavir|Plasma (Peripheral Venous Blood)
#> 30  Organism|PeripheralVenousBlood|Atazanavir|Plasma (Peripheral Venous Blood)
#> 31  Organism|PeripheralVenousBlood|Atazanavir|Plasma (Peripheral Venous Blood)
#> 32  Organism|PeripheralVenousBlood|Atazanavir|Plasma (Peripheral Venous Blood)
#> 33  Organism|PeripheralVenousBlood|Atazanavir|Plasma (Peripheral Venous Blood)
#> 34  Organism|PeripheralVenousBlood|Atazanavir|Plasma (Peripheral Venous Blood)
#> 35                 Organism|Kidney|Urine|Atazanavir|Fraction excreted to urine
#> 36  Organism|PeripheralVenousBlood|Atazanavir|Plasma (Peripheral Venous Blood)
```
