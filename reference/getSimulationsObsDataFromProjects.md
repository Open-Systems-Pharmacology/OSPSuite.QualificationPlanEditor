# getSimulationsObsDataFromProjects

Get a data.frame of projects, simulations and observed data

## Usage

``` r
getSimulationsObsDataFromProjects(projectData)
```

## Arguments

- projectData:

  A data.frame of project snapshots

## Value

A data.frame with columns \`Project\`, \`Simulation\` and
\`ObservedData\`

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

# Get the simulations Observed Data from the projects
getSimulationsObsDataFromProjects(projectData)
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
#> 11 Raltegravir                Raltegravir 400mg filmcoated tablet
#> 12 Raltegravir                Raltegravir 400mg filmcoated tablet
#> 13 Raltegravir            Raltegravir 400mg (lactose formulation)
#> 14 Raltegravir            Raltegravir 100 mg filmcoated tablet md
#> 15 Raltegravir            Raltegravir 200 mg filmcoated tablet md
#> 16 Raltegravir            Raltegravir 200 mg filmcoated tablet md
#> 17 Raltegravir            Raltegravir 400 mg filmcoated tablet md
#> 18 Raltegravir         Raltegravir 400mg (granules in suspension)
#> 19 Raltegravir                     Raltegravir 400mg chewable fed
#> 20  Atazanavir                                   Acosta2007_300mg
#> 21  Atazanavir                                 Agarwala2003_400mg
#> 22  Atazanavir                                Agarwala2005a_400mg
#> 23  Atazanavir                                Agarwala2005b_400mg
#> 24  Atazanavir                                   Martin2008_400mg
#> 25  Atazanavir                                      Zhu2011_400mg
#> 26  Atazanavir                                      Zhu2011_400mg
#> 27  Atazanavir   FDA-ClinPharmReview_AI424-014_400mg_YoungFemales
#> 28  Atazanavir                FDA-ClinPharmReview_AI424-028_200mg
#> 29  Atazanavir                FDA-ClinPharmReview_AI424-028_200mg
#> 30  Atazanavir                FDA-ClinPharmReview_AI424-028_400mg
#> 31  Atazanavir                FDA-ClinPharmReview_AI424-028_400mg
#> 32  Atazanavir                FDA-ClinPharmReview_AI424-040_200mg
#> 33  Atazanavir                FDA-ClinPharmReview_AI424-040_400mg
#> 34  Atazanavir                FDA-ClinPharmReview_AI424-040_800mg
#> 35  Atazanavir                FDA-ClinPharmReview_AI424-056_300mg
#> 36  Atazanavir                FDA-ClinPharmReview_AI424-076_400mg
#> 37  Atazanavir                FDA-ClinPharmReview_AI424-076_800mg
#> 38  Atazanavir                           Zhu2010_300mg_Atazanavir
#> 39  Atazanavir     FDA-ClinPharmReview_AI424-004_400mg_TreatmentA
#> 40  Atazanavir     FDA-ClinPharmReview_AI424-014_400mg_YoungMales
#> 41  Atazanavir     FDA-ClinPharmReview_AI424-014_400mg_YoungMales
#> 42  Atazanavir FDA-ClinPharmReview_AI424-015_400mg_NormalSubjects
#>                                                                                                                   ObservedData
#> 1                                                      Iwamoto 2008 - 800mg - Raltegravir - PO - 800 mg - Plasma - agg. (n=24)
#> 2                                                        Iwamoto 2008 - 10mg - Raltegravir - PO - 10 mg - Plasma - agg. (n=24)
#> 3                                                      Iwamoto 2008 - 100mg - Raltegravir - PO - 100 mg - Plasma - agg. (n=24)
#> 4                                                    Iwamoto 2008 - 1200mg - Raltegravir - PO - 1200 mg - Plasma - agg. (n=24)
#> 5                                                    Iwamoto 2008 - 1600mg - Raltegravir - PO - 1600 mg - Plasma - agg. (n=24)
#> 6                                                      Iwamoto 2008 - 200mg - Raltegravir - PO - 200 mg - Plasma - agg. (n=24)
#> 7                                                        Iwamoto 2008 - 25mg - Raltegravir - PO - 25 mg - Plasma - agg. (n=24)
#> 8                                                        Iwamoto 2008 - 50mg - Raltegravir - PO - 50 mg - Plasma - agg. (n=24)
#> 9                                        Rhee 2014 - Chewable tablet fasted - Raltegravir - po - 400 mg - Plasma - agg. (n=12)
#> 10                                            Rhee 2014 - filmcoated tablet - Raltegravir - po - 400 mg - Plasma - agg. (n=12)
#> 11                                                     Wenning 2009 - 400mg - Raltegravir - PO - 400 mg - Plasma - agg. (n=10)
#> 12                                                 Iwamoto 2008 - 400mg FCT - Raltegravir - PO - 400 mg - Plasma - agg. (n=14)
#> 13                                                     Iwamoto 2008 - 400mg - Raltegravir - PO - 400 mg - Plasma - agg. (n=24)
#> 14                                             Markowitz 2006 - 100mg FCT MD - Raltegravir - PO - 100 mg - Plasma - agg. (n=7)
#> 15                                             Markowitz 2006 - 200mg FCT MD - Raltegravir - PO - 200 mg - Plasma - agg. (n=7)
#> 16                                              Kassahun 2007 - 200mg FCT SD - Raltegravir - PO - 200 mg - Plasma - agg. (n=8)
#> 17                                             Markowitz 2006 - 400mg FCT MD - Raltegravir - PO - 400 mg - Plasma - agg. (n=6)
#> 18                                          Rhee 2014 - granules suspension - Raltegravir - po - 400 mg - Plasma - agg. (n=12)
#> 19                                          Rhee 2014 - Chewable tablet fed - Raltegravir - po - 400 mg - Plasma - agg. (n=12)
#> 20                                                    Acosta 2007 - Period 1 - Atazanavir - PO - 300 mg - Plasma - agg. (n=10)
#> 21                                                     Agarwala 2003 - Day 6 - Atazanavir - PO - 400 mg - Plasma - agg. (n=65)
#> 22                                     Agarwala 2005a - ATV 400 mg AM (N=15) - Atazanavir - PO - 400 mg - Plasma - agg. (n=15)
#> 23                                 Agarwala 2005b - ATV 400 mg (Treatment A) - Atazanavir - PO - 400 mg - Plasma - agg. (n=16)
#> 24                             Martin 2008 - Atazanavir monotherapy (n = 24) - Atazanavir - PO - 400 mg - Plasma - agg. (n=24)
#> 25                             Zhu 2011 - Treatment A: Atazanavir 400 mg QPM - Atazanavir - PO - 400 mg - Plasma - agg. (n=28)
#> 26                             Zhu 2011 - Treatment B: Atazanavir 400 mg QAM - Atazanavir - PO - 400 mg - Plasma - agg. (n=28)
#> 27                         ClinPharmReview, AI424-014, p. 77 - Young Females - Atazanavir - PO - 400 mg - Plasma - agg. (n=14)
#> 28                               ClinPharmReview, AI424-028, p. 128 - A-Day 6 - Atazanavir - PO - 200 mg - Plasma - agg. (n=8)
#> 29                               ClinPharmReview, AI424-028, p. 128 - B-Day 6 - Atazanavir - PO - 200 mg - Plasma - agg. (n=8)
#> 30                               ClinPharmReview, AI424-028, p. 128 - C-Day 6 - Atazanavir - PO - 400 mg - Plasma - agg. (n=8)
#> 31                               ClinPharmReview, AI424-028, p. 128 - D-Day 6 - Atazanavir - PO - 400 mg - Plasma - agg. (n=8)
#> 32                                ClinPharmReview, AI424-040, p. 64 - 200 mg - Atazanavir - PO - 200 mg - Plasma - agg. (n=20)
#> 33                                ClinPharmReview, AI424-040, p. 64 - 400 mg - Atazanavir - PO - 400 mg - Plasma - agg. (n=20)
#> 34                                ClinPharmReview, AI424-040, p. 64 - 800 mg - Atazanavir - PO - 800 mg - Plasma - agg. (n=20)
#> 35 ClinPharmReview, AI424-056, p. 134 - Atazanavir without ritonavir, Day 10 - Atazanavir - PO - 300 mg - Plasma - agg. (n=30)
#> 36                               ClinPharmReview, AI424-076, p. 178 - 400 mg - Atazanavir - PO - 400 mg - Plasma - agg. (n=65)
#> 37                               ClinPharmReview, AI424-076, p. 178 - 800 mg - Atazanavir - PO - 800 mg - Plasma - agg. (n=66)
#> 38                                   Zhu 2010 - Atazanvir 300 mg twice daily - Atazanavir - PO - 300 mg - Plasma - agg. (n=22)
#> 39                           ClinPharmReview, AI424-004, p. 94 - Treatment A - Atazanavir - PO - 400 mg - Plasma - agg. (n=32)
#> 40                    ClinPharmReview, AI424-029, p. 47 - Urinary radioactivity - Atazanavir - PO - 400  - Urine - agg. (n=12)
#> 41                           ClinPharmReview, AI424-014, p. 77 - Young Males - Atazanavir - PO - 400 mg - Plasma - agg. (n=15)
#> 42                       ClinPharmReview, AI424-015, p. 81 - Normal subjects - Atazanavir - PO - 400 mg - Plasma - agg. (n=16)
```
