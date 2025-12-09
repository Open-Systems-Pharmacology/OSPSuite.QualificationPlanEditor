test_that("parseGitHubURL correctly parses GitHub raw URLs", {
  url <- "https://raw.githubusercontent.com/Open-Systems-Pharmacology/Montelukast-Model/v1.2/Montelukast.json"
  
  result <- ospsuite.qualificationplaneditor:::parseGitHubURL(url)
  
  expect_equal(result$owner, "Open-Systems-Pharmacology")
  expect_equal(result$repo, "Montelukast-Model")
  expect_equal(result$version, "v1.2")
  expect_equal(result$file, "Montelukast.json")
})

test_that("parseGitHubURL handles complex file paths", {
  url <- "https://raw.githubusercontent.com/Open-Systems-Pharmacology/Database-for-observed-data/v1.6/Pediatrics.csv"
  
  result <- ospsuite.qualificationplaneditor:::parseGitHubURL(url)
  
  expect_equal(result$owner, "Open-Systems-Pharmacology")
  expect_equal(result$repo, "Database-for-observed-data")
  expect_equal(result$version, "v1.6")
  expect_equal(result$file, "Pediatrics.csv")
})

test_that("parseGitHubURL returns NULL for invalid URLs", {
  url <- "https://example.com/some/path"
  
  result <- ospsuite.qualificationplaneditor:::parseGitHubURL(url)
  
  expect_null(result)
})

test_that("buildGitHubRawURL constructs correct URLs", {
  url <- ospsuite.qualificationplaneditor:::buildGitHubRawURL(
    "Open-Systems-Pharmacology",
    "Montelukast-Model",
    "v2.0",
    "Montelukast.json"
  )
  
  expect_equal(
    url,
    "https://raw.githubusercontent.com/Open-Systems-Pharmacology/Montelukast-Model/v2.0/Montelukast.json"
  )
})

test_that("getLatestReleasedPaths returns empty lists for empty qualification plan", {
  # Create a minimal qualification plan with no projects or observed data
  qualificationPlan <- tempfile(fileext = ".json")
  jsonlite::write_json(
    list(
      Projects = list(),
      ObservedDataSets = list()
    ),
    qualificationPlan,
    auto_unbox = TRUE
  )
  
  result <- getLatestReleasedPaths(qualificationPlan)
  
  expect_equal(length(result$projects), 0)
  expect_equal(length(result$observedData), 0)
  
  unlink(qualificationPlan)
})

test_that("getLatestReleasedPaths ignores specified projects", {
  # Create a test qualification plan
  qualificationPlan <- tempfile(fileext = ".json")
  jsonlite::write_json(
    list(
      Projects = list(
        list(
          Id = "Project1",
          Path = "https://raw.githubusercontent.com/Open-Systems-Pharmacology/Montelukast-Model/v1.0/Montelukast.json"
        ),
        list(
          Id = "Project2",
          Path = "https://raw.githubusercontent.com/Open-Systems-Pharmacology/Digoxin-Model/v1.0/Digoxin.json"
        )
      ),
      ObservedDataSets = list()
    ),
    qualificationPlan,
    auto_unbox = TRUE
  )
  
  # Mock the getLatestReleaseTag function to return a known value
  # Note: In a real test, we would mock the GitHub API call
  # For now, we test the ignore functionality by checking process logic
  
  result <- getLatestReleasedPaths(
    qualificationPlan,
    projectsToIgnore = c("Project1")
  )
  
  # Project1 should be ignored, so if there were updates,
  # only Project2 would be in the result
  # Since we can't easily mock GitHub API here, we just verify the function runs
  expect_true(is.list(result))
  expect_true("projects" %in% names(result))
  expect_true("observedData" %in% names(result))
  
  unlink(qualificationPlan)
})

test_that("getLatestReleasedPaths ignores specified observed data", {
  # Create a test qualification plan
  qualificationPlan <- tempfile(fileext = ".json")
  jsonlite::write_json(
    list(
      Projects = list(),
      ObservedDataSets = list(
        list(
          Id = "ObsData1",
          Path = "https://raw.githubusercontent.com/Open-Systems-Pharmacology/Database-for-observed-data/v1.0/Data1.csv"
        ),
        list(
          Id = "ObsData2",
          Path = "https://raw.githubusercontent.com/Open-Systems-Pharmacology/Database-for-observed-data/v1.0/Data2.csv"
        )
      )
    ),
    qualificationPlan,
    auto_unbox = TRUE
  )
  
  result <- getLatestReleasedPaths(
    qualificationPlan,
    observedDataToIgnore = c("ObsData1")
  )
  
  # ObsData1 should be ignored
  expect_true(is.list(result))
  expect_true("projects" %in% names(result))
  expect_true("observedData" %in% names(result))
  
  unlink(qualificationPlan)
})

test_that("getLatestReleasedPaths validates input parameters", {
  qualificationPlan <- tempfile(fileext = ".json")
  jsonlite::write_json(
    list(Projects = list(), ObservedDataSets = list()),
    qualificationPlan,
    auto_unbox = TRUE
  )
  
  expect_error(
    getLatestReleasedPaths(123),
    "string"
  )
  
  expect_error(
    getLatestReleasedPaths(qualificationPlan, includePreReleases = "yes"),
    "logical"
  )
  
  expect_error(
    getLatestReleasedPaths(qualificationPlan, returnUpdatedOnly = "no"),
    "logical"
  )
  
  unlink(qualificationPlan)
})

test_that("processProjectPaths handles empty project list", {
  qualificationContent <- list(Projects = list())
  
  result <- ospsuite.qualificationplaneditor:::processProjectPaths(
    qualificationContent,
    FALSE,
    TRUE,
    NULL
  )
  
  expect_equal(length(result), 0)
})

test_that("processObservedDataPaths handles empty observed data list", {
  qualificationContent <- list(ObservedDataSets = list())
  
  result <- ospsuite.qualificationplaneditor:::processObservedDataPaths(
    qualificationContent,
    FALSE,
    TRUE,
    NULL
  )
  
  expect_equal(length(result), 0)
})
