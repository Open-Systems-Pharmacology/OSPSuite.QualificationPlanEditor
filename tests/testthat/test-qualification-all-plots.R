testEmptyAllPlotsData <- data.frame(
  "Project" = character(), 
  "Simulation" = character(), 
  "Section Reference" = character(), 
  check.names = FALSE
  )
testAllPlotsDataMissingSectionRef <- data.frame(
  "Project" = c("A", "A", "B", "C"), 
  "Simulation" = c("One", "Two", "One", "Two"), 
  "Section Reference" = c("section-1", "section-1", NA, "section-2"), 
  check.names = FALSE
  )

test_that("Empty Excel sheet leads to NA", {
  expect_equal(
    ospsuite.qualificationplaneditor:::getAllPlotsFromExcel(testEmptyAllPlotsData),
    list()
  )
})


test_that("AllPlots without reference are not exported", {
  expect_equal(
    ospsuite.qualificationplaneditor:::getAllPlotsFromExcel(testAllPlotsDataMissingSectionRef),
    data.frame(
      "Project" = c("A", "A", "C"), 
      "Simulation" = c("One", "Two", "Two"), 
      "SectionReference" = c("section-1", "section-1", "section-2")
    )
  )
  testAllPlotsDataMissingSectionRef[["Section Reference"]] <- NA
  
  expect_equal(
    ospsuite.qualificationplaneditor:::getAllPlotsFromExcel(testAllPlotsDataMissingSectionRef),
    list()
  )
    
})
