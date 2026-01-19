# getLatestReleasedPaths

Get the latest released paths for projects and observed data sets in a
qualification plan

## Usage

``` r
getLatestReleasedPaths(
  qualificationPlan,
  includePreReleases = FALSE,
  returnUpdatedOnly = TRUE,
  projectsToIgnore = NULL,
  observedDataToIgnore = NULL
)
```

## Arguments

- qualificationPlan:

  Path or URL to the qualification plan JSON file

- includePreReleases:

  Logical indicating whether to include pre-releases (default: FALSE)

- returnUpdatedOnly:

  Logical indicating whether to return only updated paths (default:
  TRUE)

- projectsToIgnore:

  Character vector of project IDs to ignore (default: NULL)

- observedDataToIgnore:

  Character vector of observed data IDs to ignore (default: NULL)

## Value

A list with two elements: - \`projects\`: Character vector of project
URLs with latest releases - \`observedData\`: Character vector of
observed data URLs with latest releases

## Examples

``` r
if (FALSE) { # \dontrun{
# Get latest released paths for all projects
result <- getLatestReleasedPaths("path/to/qualification_plan.json")

# Include pre-releases and return all paths (not just updated)
result <- getLatestReleasedPaths(
  "path/to/qualification_plan.json",
  includePreReleases = TRUE,
  returnUpdatedOnly = FALSE
)

# Ignore specific projects
result <- getLatestReleasedPaths(
  "path/to/qualification_plan.json",
  projectsToIgnore = c("Project1", "Project2")
)
} # }
```
