#' @title getLatestReleasedPaths
#' @description
#' Get the latest released paths for projects and observed data sets in a qualification plan
#' @param qualificationPlan Path or URL to the qualification plan JSON file
#' @param includePreReleases Logical indicating whether to include pre-releases (default: FALSE)
#' @param returnUpdatedOnly Logical indicating whether to return only updated paths (default: TRUE)
#' @param projectsToIgnore Character vector of project IDs to ignore (default: NULL)
#' @param observedDataToIgnore Character vector of observed data IDs to ignore (default: NULL)
#' @return A list with two elements:
#'   - `projects`: Character vector of project URLs with latest releases
#'   - `observedData`: Character vector of observed data URLs with latest releases
#' @export
#' @examples
#' \dontrun{
#' # Get latest released paths for all projects
#' result <- getLatestReleasedPaths("path/to/qualification_plan.json")
#' 
#' # Include pre-releases and return all paths (not just updated)
#' result <- getLatestReleasedPaths(
#'   "path/to/qualification_plan.json",
#'   includePreReleases = TRUE,
#'   returnUpdatedOnly = FALSE
#' )
#' 
#' # Ignore specific projects
#' result <- getLatestReleasedPaths(
#'   "path/to/qualification_plan.json",
#'   projectsToIgnore = c("Project1", "Project2")
#' )
#' }
getLatestReleasedPaths <- function(qualificationPlan,
                                    includePreReleases = FALSE,
                                    returnUpdatedOnly = TRUE,
                                    projectsToIgnore = NULL,
                                    observedDataToIgnore = NULL) {
  # Validate inputs
  ospsuite.utils::validateIsString(qualificationPlan)
  ospsuite.utils::validateIsLogical(includePreReleases)
  ospsuite.utils::validateIsLogical(returnUpdatedOnly)
  
  # Read qualification plan
  qualificationContent <- tryCatch(
    {
      jsonlite::fromJSON(qualificationPlan, simplifyVector = FALSE)
    },
    error = function(e) {
      cli::cli_abort("Failed to read qualification plan from {.file {qualificationPlan}}: {e$message}")
    }
  )
  
  # Process projects
  projectPaths <- processProjectPaths(
    qualificationContent,
    includePreReleases,
    returnUpdatedOnly,
    projectsToIgnore
  )
  
  # Process observed data
  observedDataPaths <- processObservedDataPaths(
    qualificationContent,
    includePreReleases,
    returnUpdatedOnly,
    observedDataToIgnore
  )
  
  return(list(
    projects = projectPaths,
    observedData = observedDataPaths
  ))
}

#' @title processProjectPaths
#' @description Process project paths to get latest releases
#' @param qualificationContent Content of qualification plan
#' @param includePreReleases Logical indicating whether to include pre-releases
#' @param returnUpdatedOnly Logical indicating whether to return only updated paths
#' @param projectsToIgnore Character vector of project IDs to ignore
#' @return Character vector of project URLs with latest releases
#' @keywords internal
processProjectPaths <- function(qualificationContent,
                                 includePreReleases,
                                 returnUpdatedOnly,
                                 projectsToIgnore) {
  if (ospsuite.utils::isEmpty(qualificationContent$Projects)) {
    return(character(0))
  }
  
  projectPaths <- character(0)
  
  for (project in qualificationContent$Projects) {
    # Skip if project ID is in ignore list
    if (!is.null(projectsToIgnore) && project$Id %in% projectsToIgnore) {
      next
    }
    
    # Get the project path
    projectPath <- project$Path
    
    # Parse GitHub URL and get latest release
    latestPath <- updatePathWithLatestRelease(
      projectPath,
      includePreReleases,
      returnUpdatedOnly
    )
    
    # Add to result if not NULL
    if (!is.null(latestPath)) {
      projectPaths <- c(projectPaths, latestPath)
    }
  }
  
  return(projectPaths)
}

#' @title processObservedDataPaths
#' @description Process observed data paths to get latest releases
#' @param qualificationContent Content of qualification plan
#' @param includePreReleases Logical indicating whether to include pre-releases
#' @param returnUpdatedOnly Logical indicating whether to return only updated paths
#' @param observedDataToIgnore Character vector of observed data IDs to ignore
#' @return Character vector of observed data URLs with latest releases
#' @keywords internal
processObservedDataPaths <- function(qualificationContent,
                                      includePreReleases,
                                      returnUpdatedOnly,
                                      observedDataToIgnore) {
  if (ospsuite.utils::isEmpty(qualificationContent$ObservedDataSets)) {
    return(character(0))
  }
  
  observedDataPaths <- character(0)
  
  for (obsData in qualificationContent$ObservedDataSets) {
    # Skip if observed data ID is in ignore list
    if (!is.null(observedDataToIgnore) && obsData$Id %in% observedDataToIgnore) {
      next
    }
    
    # Get the observed data path
    obsDataPath <- obsData$Path
    
    # Parse GitHub URL and get latest release
    latestPath <- updatePathWithLatestRelease(
      obsDataPath,
      includePreReleases,
      returnUpdatedOnly
    )
    
    # Add to result if not NULL
    if (!is.null(latestPath)) {
      observedDataPaths <- c(observedDataPaths, latestPath)
    }
  }
  
  return(observedDataPaths)
}

#' @title updatePathWithLatestRelease
#' @description Update a GitHub raw URL with the latest release tag
#' @param path Original GitHub raw URL
#' @param includePreReleases Logical indicating whether to include pre-releases
#' @param returnUpdatedOnly Logical indicating whether to return only updated paths
#' @return Updated URL with latest release tag, or NULL if no update needed
#' @keywords internal
updatePathWithLatestRelease <- function(path, includePreReleases, returnUpdatedOnly) {
  # Parse GitHub URL
  githubInfo <- parseGitHubURL(path)
  
  if (is.null(githubInfo)) {
    cli::cli_warn("Could not parse GitHub URL: {.url {path}}")
    return(NULL)
  }
  
  # Get latest release tag
  latestTag <- getLatestReleaseTag(
    githubInfo$owner,
    githubInfo$repo,
    includePreReleases
  )
  
  if (is.null(latestTag)) {
    cli::cli_warn("Could not fetch latest release for {.val {githubInfo$owner}/{githubInfo$repo}}")
    return(NULL)
  }
  
  # Check if version has changed
  if (returnUpdatedOnly && githubInfo$version == latestTag) {
    return(NULL)
  }
  
  # Build new path with latest version
  newPath <- buildGitHubRawURL(
    githubInfo$owner,
    githubInfo$repo,
    latestTag,
    githubInfo$file
  )
  
  return(newPath)
}

#' @title parseGitHubURL
#' @description Parse a GitHub raw URL to extract owner, repo, version, and file
#' @param url GitHub raw URL
#' @return A list with owner, repo, version, and file, or NULL if parsing fails
#' @keywords internal
parseGitHubURL <- function(url) {
  # Expected format: https://raw.githubusercontent.com/<owner>/<repo>/<version>/<file>
  pattern <- "^https://raw\\.githubusercontent\\.com/([^/]+)/([^/]+)/([^/]+)/(.+)$"
  
  matches <- regmatches(url, regexec(pattern, url))
  
  if (length(matches[[1]]) == 0) {
    return(NULL)
  }
  
  return(list(
    owner = matches[[1]][2],
    repo = matches[[1]][3],
    version = matches[[1]][4],
    file = matches[[1]][5]
  ))
}

#' @title getLatestReleaseTag
#' @description Get the latest release tag from a GitHub repository
#' @param owner Repository owner
#' @param repo Repository name
#' @param includePreReleases Logical indicating whether to include pre-releases
#' @return Latest release tag name, or NULL if fetch fails
#' @keywords internal
getLatestReleaseTag <- function(owner, repo, includePreReleases) {
  # GitHub API endpoint for releases
  apiUrl <- sprintf("https://api.github.com/repos/%s/%s/releases", owner, repo)
  
  # Fetch releases
  releases <- tryCatch(
    {
      jsonlite::fromJSON(apiUrl, simplifyVector = TRUE)
    },
    error = function(e) {
      cli::cli_warn("Failed to fetch releases from GitHub API: {e$message}")
      return(NULL)
    }
  )
  
  if (is.null(releases) || length(releases) == 0) {
    return(NULL)
  }
  
  # Filter releases based on includePreReleases
  if (!includePreReleases) {
    # Filter out pre-releases
    releases <- releases[!releases$prerelease, ]
  }
  
  if (nrow(releases) == 0) {
    return(NULL)
  }
  
  # Sort by published_at (chronologically latest first)
  releases <- releases[order(as.POSIXct(releases$published_at), decreasing = TRUE), ]
  
  # Return the tag name of the latest release
  return(releases$tag_name[1])
}

#' @title buildGitHubRawURL
#' @description Build a GitHub raw URL from components
#' @param owner Repository owner
#' @param repo Repository name
#' @param version Version/tag
#' @param file File path within the repository
#' @return GitHub raw URL
#' @keywords internal
buildGitHubRawURL <- function(owner, repo, version, file) {
  sprintf("https://raw.githubusercontent.com/%s/%s/%s/%s", owner, repo, version, file)
}
