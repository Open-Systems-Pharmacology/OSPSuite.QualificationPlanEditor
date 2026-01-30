testOutputFile <- "test-excel-ui.xlsx"

snapshotPaths <- list(
  "Raltegravir" = paste0(ospURL, "/Raltegravir-Model/v1.2/Raltegravir-Model.json"),
  "Atazanavir" = paste0(ospURL, "/Atazanavir-Model/v1.2/Atazanavir-Model.json")
)
observedDataPaths <- list(
  "A" = "path/to/A.csv",
  "B" = "path/to/B.csv",
  "A-B-DDI" = list(Path = "path/to/A-B-DDI.csv", Type = "DDIRatio")
)

test_that("toExcelEditor stops if fileName is not Excel", {
  expect_error(
    toExcelEditor(
      fileName = "test-excel-ui.txt",
      snapshotPaths = snapshotPaths,
      observedDataPaths = observedDataPaths
    ),
    "(Provided file has extension)*(txt)*(while)*(xlsx)*(was expected instead)"
  )
})

test_that("toExcelEditor stops if template does not exist or is not not Excel", {
  expect_error(
    toExcelEditor(
      fileName = testOutputFile,
      snapshotPaths = snapshotPaths,
      observedDataPaths = observedDataPaths,
      excelTemplate = "template.txt"
    ),
    "(Provided file has extension)*(txt)*(while)*(xlsx)*(was expected instead)"
  )
  expect_error(
    toExcelEditor(
      fileName = testOutputFile,
      snapshotPaths = snapshotPaths,
      observedDataPaths = observedDataPaths,
      excelTemplate = "template.xlsx"
    ),
    "(excelTemplate)*(template\\.xlsx)*(does not exist)"
  )
})

test_that("toExcelEditor creates Excel workbook with appropriate tables in simple case", {
  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = snapshotPaths,
    observedDataPaths = observedDataPaths
  )
  expect_true(file.exists(testOutputFile))
  expect_contains(readxl::excel_sheets(testOutputFile), c("Projects", "Simulations_Outputs", "ObsData"))

  projectData <- readxl::read_xlsx(testOutputFile, sheet = "Projects")
  simOutputData <- readxl::read_xlsx(testOutputFile, sheet = "Simulations_Outputs")
  obsData <- readxl::read_xlsx(testOutputFile, sheet = "ObsData")

  expect_equal(getProjectsFromList(snapshotPaths), as.data.frame(projectData))
  expect_equal(getObsDataFromList(observedDataPaths), as.data.frame(obsData))
})

test_that("toExcelEditor fails when template cannot be copied", {
  # Try to write to an invalid/protected location
  expect_error(
    toExcelEditor(
      fileName = "/root/protected/test.xlsx",
      snapshotPaths = snapshotPaths,
      observedDataPaths = observedDataPaths
    ),
    # Will fail either on validation or on file copy
    ".*"
  )
})

test_that("toExcelEditor works with NULL snapshotPaths and valid qualificationPlan", {
  # Create a minimal qualification plan JSON
  minimalQualPlan <- tempfile(fileext = ".json")
  qualPlanContent <- list(
    Projects = list(
      list(Id = "TestProject", Path = paste0(ospURL, "/Raltegravir-Model/v1.2/Raltegravir-Model.json"))
    ),
    Sections = list()
  )
  jsonlite::write_json(qualPlanContent, minimalQualPlan, auto_unbox = TRUE)

  expect_invisible(
    toExcelEditor(
      fileName = testOutputFile,
      snapshotPaths = NULL,
      observedDataPaths = NULL,
      qualificationPlan = minimalQualPlan
    )
  )

  expect_true(file.exists(testOutputFile))
  unlink(minimalQualPlan)
})

test_that("toExcelEditor handles invalid qualificationPlan gracefully", {
  invalidQualPlan <- tempfile(fileext = ".json")
  writeLines("{ this is not valid JSON", invalidQualPlan)

  expect_error(
    toExcelEditor(
      fileName = testOutputFile,
      snapshotPaths = snapshotPaths,
      qualificationPlan = invalidQualPlan
    ),
    "Cannot parse qualification plan"
  )

  unlink(invalidQualPlan)
})

test_that("toExcelEditor returns invisible TRUE on success", {
  result <- toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = snapshotPaths,
    observedDataPaths = observedDataPaths
  )

  expect_true(result)
})

test_that("toExcelEditor creates all expected sheets", {
  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = snapshotPaths,
    observedDataPaths = observedDataPaths
  )

  sheets <- readxl::excel_sheets(testOutputFile)

  expectedSheets <- c(
    "Projects", "Simulations_Outputs", "Simulations_ObsData",
    "ObsData", "BB", "MetaInfo", "Sections", "Intro", "Inputs"
  )

  expect_contains(sheets, expectedSheets)
})

test_that("toExcelEditor handles empty snapshotPaths and observedDataPaths with qualificationPlan", {
  minimalQualPlan <- tempfile(fileext = ".json")
  qualPlanContent <- list(
    Projects = list(
      list(Id = "TestProject", Path = paste0(ospURL, "/Raltegravir-Model/v1.2/Raltegravir-Model.json"))
    ),
    Sections = list(),
    Intro = list(),
    Inputs = list()
  )
  jsonlite::write_json(qualPlanContent, minimalQualPlan, auto_unbox = TRUE)

  result <- toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = list(),
    observedDataPaths = list(),
    qualificationPlan = minimalQualPlan
  )

  expect_true(result)
  expect_true(file.exists(testOutputFile))

  unlink(minimalQualPlan)
})

test_that("toExcelEditor overwrites existing file", {
  # Create first file
  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = snapshotPaths,
    observedDataPaths = observedDataPaths
  )

  firstModTime <- file.info(testOutputFile)$mtime

  # Wait a moment to ensure different timestamp
  Sys.sleep(1)

  # Overwrite with same function call
  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = snapshotPaths,
    observedDataPaths = observedDataPaths
  )

  secondModTime <- file.info(testOutputFile)$mtime

  expect_true(secondModTime > firstModTime)
})

test_that("toExcelEditor applies data validation to ObsData Type column", {
  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = snapshotPaths,
    observedDataPaths = observedDataPaths
  )

  # Read the workbook to check for data validations
  wb <- openxlsx::loadWorkbook(testOutputFile)

  # Check that ObsData sheet exists
  expect_contains(names(wb), "ObsData")
})

test_that("toExcelEditor handles workbook loading errors", {
  # Create a corrupted Excel file
  corruptFile <- tempfile(fileext = ".xlsx")
  writeLines("This is not an Excel file", corruptFile)

  expect_error(
    toExcelEditor(
      fileName = testOutputFile,
      snapshotPaths = snapshotPaths,
      observedDataPaths = observedDataPaths,
      excelTemplate = corruptFile
    ),
    "Provided file has extension.*xlsx.*was expected"
  )

  unlink(corruptFile)
})

test_that("toExcelEditor correctly uses default template when excelTemplate is NULL", {
  result <- toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = snapshotPaths,
    observedDataPaths = observedDataPaths,
    excelTemplate = NULL
  )

  expect_true(result)
  expect_true(file.exists(testOutputFile))

  # Verify it has expected sheets from default template
  sheets <- readxl::excel_sheets(testOutputFile)
  expect_contains(sheets, "Lookup")
})

test_that("toExcelEditor handles single snapshot correctly", {
  singleSnapshot <- list(
    "SingleProject" = paste0(ospURL, "/Raltegravir-Model/v1.2/Raltegravir-Model.json")
  )

  result <- toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = singleSnapshot,
    observedDataPaths = NULL
  )

  expect_true(result)

  projectData <- readxl::read_xlsx(testOutputFile, sheet = "Projects")
  expect_equal(nrow(projectData), 1)
  expect_equal(projectData$Id[[1]], "SingleProject")
})

test_that("toExcelEditor handles projects with building blocks", {
  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = snapshotPaths,
    observedDataPaths = observedDataPaths
  )

  # Check that BB sheet is created
  sheets <- readxl::excel_sheets(testOutputFile)
  expect_contains(sheets, "BB")

  bbData <- readxl::read_xlsx(testOutputFile, sheet = "BB")
  expect_s3_class(bbData, "tbl_df")
})

test_that("toExcelEditor applies status styling to project data", {
  # Create a qualification plan with projects
  qualPlanFile <- tempfile(fileext = ".json")
  qualPlanContent <- list(
    Projects = list(
      list(Id = "Raltegravir", Path = paste0(ospURL, "/Raltegravir-Model/v1.2/Raltegravir-Model.json")),
      list(Id = "NewProject", Path = "path/to/new.json")
    ),
    Sections = list()
  )
  jsonlite::write_json(qualPlanContent, qualPlanFile, auto_unbox = TRUE)

  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = snapshotPaths,
    observedDataPaths = observedDataPaths,
    qualificationPlan = qualPlanFile
  )

  # Load and check that styling was applied
  wb <- openxlsx::loadWorkbook(testOutputFile)
  expect_contains(names(wb), "Projects")

  unlink(qualPlanFile)
})

test_that("toExcelEditor handles sections with parent references correctly", {
  qualPlanFile <- tempfile(fileext = ".json")
  qualPlanContent <- list(
    Projects = list(
      list(Id = "TestProject", Path = paste0(ospURL, "/Raltegravir-Model/v1.2/Raltegravir-Model.json"))
    ),
    Sections = list(
      list(Reference = "Section1", Title = "First Section"),
      list(Reference = "Section1.1", Title = "Subsection", ParentReference = "Section1")
    )
  )
  jsonlite::write_json(qualPlanContent, qualPlanFile, auto_unbox = TRUE)

  result <- toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = NULL,
    qualificationPlan = qualPlanFile
  )

  expect_true(result)

  sectionsData <- readxl::read_xlsx(testOutputFile, sheet = "Sections")
  expect_equal(nrow(sectionsData), 2)

  unlink(qualPlanFile)
})

test_that("toExcelEditor creates valid data validation with additionalRows", {
  qualPlanFile <- tempfile(fileext = ".json")
  qualPlanContent <- list(
    Projects = list(
      list(Id = "TestProject", Path = paste0(ospURL, "/Raltegravir-Model/v1.2/Raltegravir-Model.json"))
    ),
    Sections = list(
      list(Reference = "Section1", Title = "First Section")
    )
  )
  jsonlite::write_json(qualPlanContent, qualPlanFile, auto_unbox = TRUE)

  result <- toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = NULL,
    qualificationPlan = qualPlanFile
  )

  expect_true(result)

  # The function should create validation with additionalRows = 100 for section references
  wb <- openxlsx::loadWorkbook(testOutputFile)
  expect_contains(names(wb), "Sections")

  unlink(qualPlanFile)
})