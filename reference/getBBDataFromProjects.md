# getBBDataFromProjects

Get a data.frame of projects, type, name and parent project

## Usage

``` r
getBBDataFromProjects(projectData)
```

## Arguments

- projectData:

  A data.frame of project snapshots

## Value

A data.frame with columns \`Project\`, \`BB-Type\`, \`BB-Name\`,
\`Parent-Project\`

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
getBBDataFromProjects(projectData)
#>        Project     BB-Type
#> 1  Raltegravir  Individual
#> 2  Raltegravir    Compound
#> 3  Raltegravir    Protocol
#> 4  Raltegravir    Protocol
#> 5  Raltegravir    Protocol
#> 6  Raltegravir    Protocol
#> 7  Raltegravir    Protocol
#> 8  Raltegravir    Protocol
#> 9  Raltegravir    Protocol
#> 10 Raltegravir    Protocol
#> 11 Raltegravir    Protocol
#> 12 Raltegravir    Protocol
#> 13 Raltegravir    Protocol
#> 14 Raltegravir    Protocol
#> 15 Raltegravir       Event
#> 16 Raltegravir Formulation
#> 17 Raltegravir Formulation
#> 18 Raltegravir Formulation
#> 19 Raltegravir Formulation
#> 20  Atazanavir  Individual
#> 21  Atazanavir  Individual
#> 22  Atazanavir  Individual
#> 23  Atazanavir  Individual
#> 24  Atazanavir  Individual
#> 25  Atazanavir  Individual
#> 26  Atazanavir  Individual
#> 27  Atazanavir  Individual
#> 28  Atazanavir  Individual
#> 29  Atazanavir    Compound
#> 30  Atazanavir    Protocol
#> 31  Atazanavir    Protocol
#> 32  Atazanavir    Protocol
#> 33  Atazanavir    Protocol
#> 34  Atazanavir    Protocol
#> 35  Atazanavir    Protocol
#> 36  Atazanavir    Protocol
#> 37  Atazanavir    Protocol
#> 38  Atazanavir    Protocol
#> 39  Atazanavir    Protocol
#> 40  Atazanavir    Protocol
#> 41  Atazanavir       Event
#> 42  Atazanavir       Event
#> 43  Atazanavir Formulation
#>                                                           BB-Name
#> 1                                  Standard European Male for PEQ
#> 2                                                     Raltegravir
#> 3               Iwamoto 2008 400mg PO (Figure 1) omeprazole study
#> 4    Iwamoto 2008 10mg PO (Figure 2) Safety-Tolerability-PK study
#> 5    Iwamoto 2008 25mg PO (Figure 2) Safety-Tolerability-PK study
#> 6    Iwamoto 2008 50mg PO (Figure 2) Safety-Tolerability-PK study
#> 7   Iwamoto 2008 100mg PO (Figure 2) Safety-Tolerability-PK study
#> 8   Iwamoto 2008 200mg PO (Figure 2) Safety-Tolerability-PK study
#> 9   Iwamoto 2008 800mg PO (Figure 2) Safety-Tolerability-PK study
#> 10 Iwamoto 2008 1200mg PO (Figure 2) Safety-Tolerability-PK study
#> 11 Iwamoto 2008 1600mg PO (Figure 2) Safety-Tolerability-PK study
#> 12                                   Markowitz 2006 100mg bid 10d
#> 13                                   Markowitz 2006 200mg bid 10d
#> 14                                   Markowitz 2006 400mg bid 10d
#> 15                                                           Food
#> 16                                  Weibull (lactose formulation)
#> 17                                                chewable tablet
#> 18                 filmcoated tablet (original Merck formulation)
#> 19                                             Weibull (granules)
#> 20                                                   Agarwala2003
#> 21                                                  Agarwala2005a
#> 22                                                  Agarwala2005b
#> 23                                                     Martin2008
#> 24                                                        Zhu2011
#> 25                                              WhiteAmericanMale
#> 26                                            WhiteAmericanFemale
#> 27                                                        Zhu2010
#> 28                                                     Acosta2007
#> 29                                                     Atazanavir
#> 30                                                 400mg_QD_7days
#> 31                                                 400mg_QD_6days
#> 32                                                 400mg_QD_5days
#> 33                                                 200mg_QD_5days
#> 34                                                 800mg_QD_5days
#> 35                                                       400mg_SD
#> 36                                         300mg_BID_7days_at120h
#> 37                                                      300mg_BID
#> 38                                                 200mg_QD_6days
#> 39                                                300mg_QD_10days
#> 40                                                 800mg_QD_6days
#> 41                                             High-fat breakfast
#> 42                                                     Light meal
#> 43                                                Reyataz capsule
#>    Parent-Project
#> 1                
#> 2                
#> 3                
#> 4                
#> 5                
#> 6                
#> 7                
#> 8                
#> 9                
#> 10               
#> 11               
#> 12               
#> 13               
#> 14               
#> 15               
#> 16               
#> 17               
#> 18               
#> 19               
#> 20               
#> 21               
#> 22               
#> 23               
#> 24               
#> 25               
#> 26               
#> 27               
#> 28               
#> 29               
#> 30               
#> 31               
#> 32               
#> 33               
#> 34               
#> 35               
#> 36               
#> 37               
#> 38               
#> 39               
#> 40               
#> 41               
#> 42               
#> 43               
```
