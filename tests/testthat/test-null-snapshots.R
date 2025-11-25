testOutputFile <- "test-excel-ui.xlsx"
testInputPlan <- system.file("test-qualification-plan.json", package = "ospsuite.qualificationplaneditor")

test_that("Without qualification, empty snapshot and obs data paths result in Excel sheet headers only", {
  excelUI(
    fileName = testOutputFile,
    snapshotPaths = NULL,
    observedDataPaths = NULL,
    qualificationPlan = NULL
  )

  expect_true(file.exists(testOutputFile))
  expect_contains(readxl::excel_sheets(testOutputFile), c("Projects", "Simulations_Outputs", "ObsData"))

  projectData <- readxl::read_xlsx(testOutputFile, sheet = "Projects")
  simOutputData <- readxl::read_xlsx(testOutputFile, sheet = "Simulations_Outputs")
  obsData <- readxl::read_xlsx(testOutputFile, sheet = "ObsData")

  expect_s3_class(projectData, "data.frame")
  expect_s3_class(simOutputData, "data.frame")
  expect_s3_class(obsData, "data.frame")

  expect_equal(nrow(projectData), 0)
  expect_equal(nrow(simOutputData), 0)
  expect_equal(nrow(obsData), 0)

  expect_equal(names(projectData), c("Id", "Path"))
  expect_equal(names(simOutputData), c("Project", "Simulation", "Output"))
  expect_equal(names(obsData), c("ID", "Path", "Type"))

  unlink(testOutputFile)
})

test_that("With qualification, empty snapshot and obs data paths result in Excel sheet from qualification only", {
  excelUI(
    fileName = testOutputFile,
    snapshotPaths = NULL,
    observedDataPaths = NULL,
    qualificationPlan = testInputPlan
  )

  expect_true(file.exists(testOutputFile))
  expect_contains(readxl::excel_sheets(testOutputFile), c("Projects", "Simulations_Outputs", "ObsData"))

  projectData <- as.data.frame(readxl::read_xlsx(testOutputFile, sheet = "Projects"))
  obsData <- as.data.frame(readxl::read_xlsx(testOutputFile, sheet = "ObsData"))

  qualificationContent <- jsonlite::fromJSON(testInputPlan, simplifyVector = FALSE)
  expect_equal(projectData, getProjectsFromQualification(qualificationContent))
  expect_equal(obsData, getObsDataFromQualification(qualificationContent))

  unlink(testOutputFile)
})
