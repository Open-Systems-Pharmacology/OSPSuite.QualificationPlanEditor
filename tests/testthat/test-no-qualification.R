snapshotPaths <- list(
  "Raltegravir" = paste0(ospURL, "/Raltegravir-Model/v1.2/Raltegravir-Model.json"),
  "Atazanavir" = paste0(ospURL, "/Atazanavir-Model/v1.2/Atazanavir-Model.json")
)

test_that("Workflow creation from editor does not require a previous qualification plan", {
  toExcelEditor(
    fileName = "test-no-qualification.xlsx",
    snapshotPaths = snapshotPaths
  )
  excelToQualificationPlan(
    excelFile = "test-no-qualification.xlsx",
    qualificationPlan = "test-no-qualification.json"
  )
  expect_true(file.exists("test-no-qualification.xlsx"))
  expect_true(file.exists("test-no-qualification.json"))
  expect_snapshot_output(readLines("test-no-qualification.json"))
})
