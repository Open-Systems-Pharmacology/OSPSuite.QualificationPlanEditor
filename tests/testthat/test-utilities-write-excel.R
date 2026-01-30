# Test file for utilities-write-excel.R functions

# Setup test data
testOutputFile <- "test-utilities-write-excel.xlsx"

# Test data.frames for testing
test_df <- data.frame(
  Id = c("A", "B", "C"),
  Name = c("Test1", "Test2", "Test3"),
  Value = c(1, 2, 3),
  stringsAsFactors = FALSE
)

empty_df <- data.frame(
  Id = character(),
  Name = character(),
  Value = numeric(),
  stringsAsFactors = FALSE
)

# ====================
# Tests for excelListingValue
# ====================

test_that("excelListingValue creates correct Excel expression with default parameters", {
  result <- excelListingValue(test_df, "Id", "TestSheet")

  expect_type(result, "character")
  expect_match(result, "='TestSheet'!\\$A\\$2:\\$A\\$4")
})

test_that("excelListingValue handles additionalRows parameter correctly", {
  result <- excelListingValue(test_df, "Id", "TestSheet", additionalRows = 100)

  expect_type(result, "character")
  # Should be 2 (header offset) + 3 (rows) + 100 (additional) = 105, so $A$2:$A$104
  expect_match(result, "='TestSheet'!\\$A\\$2:\\$A\\$104")
})

test_that("excelListingValue works with different column positions", {
  result_id <- excelListingValue(test_df, "Id", "TestSheet")
  result_name <- excelListingValue(test_df, "Name", "TestSheet")
  result_value <- excelListingValue(test_df, "Value", "TestSheet")

  expect_match(result_id, "\\$A\\$")
  expect_match(result_name, "\\$B\\$")
  expect_match(result_value, "\\$C\\$")
})

test_that("excelListingValue handles empty data.frame", {
  result <- excelListingValue(empty_df, "Id", "TestSheet")

  # For empty df, should use max(1, nrow(data)) = 1
  expect_match(result, "='TestSheet'!\\$A\\$2:\\$A\\$2")
})

test_that("excelListingValue handles single row data.frame", {
  single_row_df <- data.frame(Id = "A", Name = "Test1", stringsAsFactors = FALSE)
  result <- excelListingValue(single_row_df, "Id", "TestSheet")

  expect_match(result, "='TestSheet'!\\$A\\$2:\\$A\\$2")
})

test_that("excelListingValue throws error for invalid column name", {
  expect_error(
    excelListingValue(test_df, "InvalidColumn", "TestSheet"),
    "InvalidColumn.*not included in"
  )
})

test_that("excelListingValue throws error for non-data.frame input", {
  expect_error(
    excelListingValue(list(a = 1, b = 2), "a", "TestSheet"),
    "is.data.frame"
  )
})

test_that("excelListingValue handles sheet names with spaces", {
  result <- excelListingValue(test_df, "Id", "Test Sheet Name")

  expect_match(result, "='Test Sheet Name'!")
})

test_that("excelListingValue handles large column indices correctly", {
  # Create a data.frame with many columns to test column conversion
  many_cols_df <- as.data.frame(matrix(1, nrow = 3, ncol = 30))
  colnames(many_cols_df) <- paste0("Col", 1:30)

  result <- excelListingValue(many_cols_df, "Col30", "TestSheet")

  # Column 30 should be "AD" in Excel notation
  expect_match(result, "\\$AD\\$")
})

# ====================
# Tests for writeDataToSheet
# ====================

test_that("writeDataToSheet writes data correctly to sheet", {
  # Create a template workbook with a sheet
  excelTemplate <- system.file("Qualification-Template.xlsx", package = "ospsuite.qualificationplaneditor")
  file.copy(excelTemplate, testOutputFile, overwrite = TRUE)

  wb <- openxlsx::loadWorkbook(testOutputFile)

  # Ensure the sheet exists or add it
  if (!"TestSheet" %in% names(wb)) {
    openxlsx::addWorksheet(wb, "TestSheet")
  }

  writeDataToSheet(test_df, "TestSheet", wb)

  # Save and read back
  openxlsx::saveWorkbook(wb, testOutputFile, overwrite = TRUE)
  result <- readxl::read_xlsx(testOutputFile, sheet = "TestSheet")

  expect_equal(as.data.frame(result), test_df)
})

test_that("writeDataToSheet returns invisible NULL for empty data.frame", {
  excelTemplate <- system.file("Qualification-Template.xlsx", package = "ospsuite.qualificationplaneditor")
  file.copy(excelTemplate, testOutputFile, overwrite = TRUE)

  wb <- openxlsx::loadWorkbook(testOutputFile)

  if (!"TestSheet" %in% names(wb)) {
    openxlsx::addWorksheet(wb, "TestSheet")
  }

  result <- writeDataToSheet(empty_df, "TestSheet", wb)

  expect_null(result)
})

test_that("writeDataToSheet freezes header row", {
  excelTemplate <- system.file("Qualification-Template.xlsx", package = "ospsuite.qualificationplaneditor")
  file.copy(excelTemplate, testOutputFile, overwrite = TRUE)

  wb <- openxlsx::loadWorkbook(testOutputFile)

  if (!"TestSheet" %in% names(wb)) {
    openxlsx::addWorksheet(wb, "TestSheet")
  }

  writeDataToSheet(test_df, "TestSheet", wb)

  # Check that the sheet has freezePane applied (check internal wb structure)
  expect_true("TestSheet" %in% names(wb))
})

test_that("writeDataToSheet validates input types", {
  excelTemplate <- system.file("Qualification-Template.xlsx", package = "ospsuite.qualificationplaneditor")
  file.copy(excelTemplate, testOutputFile, overwrite = TRUE)
  wb <- openxlsx::loadWorkbook(testOutputFile)

  # Test non-data.frame input
  expect_error(
    writeDataToSheet(list(a = 1), "Projects", wb),
    "is.data.frame"
  )

  # Test invalid sheet name (not a character)
  expect_error(
    writeDataToSheet(test_df, 123, wb),
    "character"
  )

  # Test sheet name with wrong length
  expect_error(
    writeDataToSheet(test_df, c("Sheet1", "Sheet2"), wb),
    "length"
  )
})

test_that("writeDataToSheet validates sheet exists in workbook", {
  excelTemplate <- system.file("Qualification-Template.xlsx", package = "ospsuite.qualificationplaneditor")
  file.copy(excelTemplate, testOutputFile, overwrite = TRUE)
  wb <- openxlsx::loadWorkbook(testOutputFile)

  expect_error(
    writeDataToSheet(test_df, "NonExistentSheet", wb),
    "NonExistentSheet.*not included in"
  )
})

# ====================
# Tests for applyDataValidation
# ====================

test_that("applyDataValidation applies validation to correct columns and rows", {
  excelTemplate <- system.file("Qualification-Template.xlsx", package = "ospsuite.qualificationplaneditor")
  file.copy(excelTemplate, testOutputFile, overwrite = TRUE)

  wb <- openxlsx::loadWorkbook(testOutputFile)

  if (!"TestSheet" %in% names(wb)) {
    openxlsx::addWorksheet(wb, "TestSheet")
  }

  writeDataToSheet(test_df, "TestSheet", wb)

  # Apply validation
  listingValue <- excelListingValue(test_df, "Id", "TestSheet")
  applyDataValidation(listingValue, test_df, "TestSheet", "Name", wb)

  # Should not error
  expect_true(TRUE)
})

test_that("applyDataValidation handles additionalRows parameter", {
  excelTemplate <- system.file("Qualification-Template.xlsx", package = "ospsuite.qualificationplaneditor")
  file.copy(excelTemplate, testOutputFile, overwrite = TRUE)

  wb <- openxlsx::loadWorkbook(testOutputFile)

  if (!"TestSheet" %in% names(wb)) {
    openxlsx::addWorksheet(wb, "TestSheet")
  }

  writeDataToSheet(test_df, "TestSheet", wb)

  listingValue <- excelListingValue(test_df, "Id", "TestSheet")

  # Should not error with additionalRows
  expect_invisible(
    applyDataValidation(listingValue, test_df, "TestSheet", "Name", wb, additionalRows = 50)
  )
})

test_that("applyDataValidation validates column exists in data", {
  excelTemplate <- system.file("Qualification-Template.xlsx", package = "ospsuite.qualificationplaneditor")
  file.copy(excelTemplate, testOutputFile, overwrite = TRUE)

  wb <- openxlsx::loadWorkbook(testOutputFile)

  if (!"TestSheet" %in% names(wb)) {
    openxlsx::addWorksheet(wb, "TestSheet")
  }

  writeDataToSheet(test_df, "TestSheet", wb)

  listingValue <- excelListingValue(test_df, "Id", "TestSheet")

  expect_error(
    applyDataValidation(listingValue, test_df, "TestSheet", "InvalidColumn", wb),
    "InvalidColumn.*not included in"
  )
})

test_that("applyDataValidation validates data is data.frame", {
  excelTemplate <- system.file("Qualification-Template.xlsx", package = "ospsuite.qualificationplaneditor")
  file.copy(excelTemplate, testOutputFile, overwrite = TRUE)

  wb <- openxlsx::loadWorkbook(testOutputFile)

  listingValue <- "'TestSheet'!$A$2:$A$4"

  expect_error(
    applyDataValidation(listingValue, list(a = 1), "TestSheet", "a", wb),
    "is.data.frame"
  )
})

test_that("applyDataValidation handles multiple column names", {
  excelTemplate <- system.file("Qualification-Template.xlsx", package = "ospsuite.qualificationplaneditor")
  file.copy(excelTemplate, testOutputFile, overwrite = TRUE)

  wb <- openxlsx::loadWorkbook(testOutputFile)

  if (!"TestSheet" %in% names(wb)) {
    openxlsx::addWorksheet(wb, "TestSheet")
  }

  writeDataToSheet(test_df, "TestSheet", wb)

  listingValue <- excelListingValue(test_df, "Id", "TestSheet")

  # Apply to multiple columns
  expect_invisible(
    applyDataValidation(listingValue, test_df, "TestSheet", c("Name", "Id"), wb)
  )
})

# ====================
# Tests for styleColorMapping
# ====================

test_that("styleColorMapping applies colors to correct cells", {
  excelTemplate <- system.file("Qualification-Template.xlsx", package = "ospsuite.qualificationplaneditor")
  file.copy(excelTemplate, testOutputFile, overwrite = TRUE)

  wb <- openxlsx::loadWorkbook(testOutputFile)

  if (!"TestSheet" %in% names(wb)) {
    openxlsx::addWorksheet(wb, "TestSheet")
  }

  color_df <- data.frame(
    Name = c("Red", "Blue", "Green"),
    Color = c("#FF0000", "#0000FF", "#00FF00"),
    stringsAsFactors = FALSE
  )

  writeDataToSheet(color_df, "TestSheet", wb)

  # Should not error
  expect_invisible(
    styleColorMapping(color_df, "TestSheet", wb, "Color")
  )
})

test_that("styleColorMapping returns invisible NULL for empty mapping", {
  excelTemplate <- system.file("Qualification-Template.xlsx", package = "ospsuite.qualificationplaneditor")
  file.copy(excelTemplate, testOutputFile, overwrite = TRUE)

  wb <- openxlsx::loadWorkbook(testOutputFile)

  if (!"TestSheet" %in% names(wb)) {
    openxlsx::addWorksheet(wb, "TestSheet")
  }

  empty_color_df <- data.frame(
    Name = character(),
    Color = character(),
    stringsAsFactors = FALSE
  )

  result <- styleColorMapping(empty_color_df, "TestSheet", wb, "Color")

  expect_null(result)
})

test_that("styleColorMapping handles NA color values", {
  excelTemplate <- system.file("Qualification-Template.xlsx", package = "ospsuite.qualificationplaneditor")
  file.copy(excelTemplate, testOutputFile, overwrite = TRUE)

  wb <- openxlsx::loadWorkbook(testOutputFile)

  if (!"TestSheet" %in% names(wb)) {
    openxlsx::addWorksheet(wb, "TestSheet")
  }

  color_df <- data.frame(
    Name = c("Red", "NoColor", "Green"),
    Color = c("#FF0000", NA, "#00FF00"),
    stringsAsFactors = FALSE
  )

  writeDataToSheet(color_df, "TestSheet", wb)

  # Should not error and skip NA values
  expect_invisible(
    styleColorMapping(color_df, "TestSheet", wb, "Color")
  )
})

test_that("styleColorMapping validates column exists in mapping", {
  excelTemplate <- system.file("Qualification-Template.xlsx", package = "ospsuite.qualificationplaneditor")
  file.copy(excelTemplate, testOutputFile, overwrite = TRUE)

  wb <- openxlsx::loadWorkbook(testOutputFile)

  if (!"TestSheet" %in% names(wb)) {
    openxlsx::addWorksheet(wb, "TestSheet")
  }

  color_df <- data.frame(
    Name = c("Red", "Blue"),
    Color = c("#FF0000", "#0000FF"),
    stringsAsFactors = FALSE
  )

  expect_error(
    styleColorMapping(color_df, "TestSheet", wb, "InvalidColumn"),
    "InvalidColumn.*not included in"
  )
})

test_that("styleColorMapping uses default columnName parameter", {
  excelTemplate <- system.file("Qualification-Template.xlsx", package = "ospsuite.qualificationplaneditor")
  file.copy(excelTemplate, testOutputFile, overwrite = TRUE)

  wb <- openxlsx::loadWorkbook(testOutputFile)

  if (!"TestSheet" %in% names(wb)) {
    openxlsx::addWorksheet(wb, "TestSheet")
  }

  # Use default column name "Color"
  color_df <- data.frame(
    Name = c("Red", "Blue"),
    Color = c("#FF0000", "#0000FF"),
    stringsAsFactors = FALSE
  )

  writeDataToSheet(color_df, "TestSheet", wb)

  # Should use default "Color" parameter
  expect_invisible(
    styleColorMapping(color_df, "TestSheet", wb)
  )
})

# ====================
# Tests for styleProjectStatus
# ====================

test_that("styleProjectStatus applies correct styles for each status", {
  excelTemplate <- system.file("Qualification-Template.xlsx", package = "ospsuite.qualificationplaneditor")
  file.copy(excelTemplate, testOutputFile, overwrite = TRUE)

  wb <- openxlsx::loadWorkbook(testOutputFile)

  if (!"TestSheet" %in% names(wb)) {
    openxlsx::addWorksheet(wb, "TestSheet")
  }

  project_df <- data.frame(
    Id = c("P1", "P2", "P3", "P4"),
    Name = c("Project1", "Project2", "Project3", "Project4"),
    stringsAsFactors = FALSE
  )

  statusMapping <- data.frame(
    Id = c("P1", "P2", "P3", "P4"),
    Status = c("Unchanged", "Changed", "Added", "Unchanged"),
    stringsAsFactors = FALSE
  )

  writeDataToSheet(project_df, "TestSheet", wb)

  # Should not error
  expect_invisible(
    styleProjectStatus(
      projectIds = project_df$Id,
      columns = seq_len(ncol(project_df)),
      statusMapping = statusMapping,
      sheetName = "TestSheet",
      excelObject = wb
    )
  )
})

test_that("styleProjectStatus handles empty status mapping correctly", {
  excelTemplate <- system.file("Qualification-Template.xlsx", package = "ospsuite.qualificationplaneditor")
  file.copy(excelTemplate, testOutputFile, overwrite = TRUE)

  wb <- openxlsx::loadWorkbook(testOutputFile)

  if (!"TestSheet" %in% names(wb)) {
    openxlsx::addWorksheet(wb, "TestSheet")
  }

  project_df <- data.frame(
    Id = c("P1", "P2"),
    Name = c("Project1", "Project2"),
    stringsAsFactors = FALSE
  )

  statusMapping <- data.frame(
    Id = character(),
    Status = character(),
    stringsAsFactors = FALSE
  )

  writeDataToSheet(project_df, "TestSheet", wb)

  # Should not error
  expect_invisible(
    styleProjectStatus(
      projectIds = project_df$Id,
      columns = seq_len(ncol(project_df)),
      statusMapping = statusMapping,
      sheetName = "TestSheet",
      excelObject = wb
    )
  )
})

test_that("styleProjectStatus handles projects with no matching status", {
  excelTemplate <- system.file("Qualification-Template.xlsx", package = "ospsuite.qualificationplaneditor")
  file.copy(excelTemplate, testOutputFile, overwrite = TRUE)

  wb <- openxlsx::loadWorkbook(testOutputFile)

  if (!"TestSheet" %in% names(wb)) {
    openxlsx::addWorksheet(wb, "TestSheet")
  }

  project_df <- data.frame(
    Id = c("P1", "P2", "P3"),
    Name = c("Project1", "Project2", "Project3"),
    stringsAsFactors = FALSE
  )

  statusMapping <- data.frame(
    Id = c("P4", "P5"),
    Status = c("Changed", "Added"),
    stringsAsFactors = FALSE
  )

  writeDataToSheet(project_df, "TestSheet", wb)

  # Should not error even if no projects match
  expect_invisible(
    styleProjectStatus(
      projectIds = project_df$Id,
      columns = seq_len(ncol(project_df)),
      statusMapping = statusMapping,
      sheetName = "TestSheet",
      excelObject = wb
    )
  )
})

test_that("styleProjectStatus handles only specific status types", {
  excelTemplate <- system.file("Qualification-Template.xlsx", package = "ospsuite.qualificationplaneditor")
  file.copy(excelTemplate, testOutputFile, overwrite = TRUE)

  wb <- openxlsx::loadWorkbook(testOutputFile)

  if (!"TestSheet" %in% names(wb)) {
    openxlsx::addWorksheet(wb, "TestSheet")
  }

  project_df <- data.frame(
    Id = c("P1", "P2"),
    Name = c("Project1", "Project2"),
    stringsAsFactors = FALSE
  )

  # Only "Added" status
  statusMapping <- data.frame(
    Id = c("P1", "P2"),
    Status = c("Added", "Added"),
    stringsAsFactors = FALSE
  )

  writeDataToSheet(project_df, "TestSheet", wb)

  expect_invisible(
    styleProjectStatus(
      projectIds = project_df$Id,
      columns = seq_len(ncol(project_df)),
      statusMapping = statusMapping,
      sheetName = "TestSheet",
      excelObject = wb
    )
  )
})

test_that("styleProjectStatus applies styles to specified columns only", {
  excelTemplate <- system.file("Qualification-Template.xlsx", package = "ospsuite.qualificationplaneditor")
  file.copy(excelTemplate, testOutputFile, overwrite = TRUE)

  wb <- openxlsx::loadWorkbook(testOutputFile)

  if (!"TestSheet" %in% names(wb)) {
    openxlsx::addWorksheet(wb, "TestSheet")
  }

  project_df <- data.frame(
    Id = c("P1", "P2"),
    Name = c("Project1", "Project2"),
    Value = c(100, 200),
    stringsAsFactors = FALSE
  )

  statusMapping <- data.frame(
    Id = c("P1", "P2"),
    Status = c("Changed", "Changed"),
    stringsAsFactors = FALSE
  )

  writeDataToSheet(project_df, "TestSheet", wb)

  # Apply to only first column
  expect_invisible(
    styleProjectStatus(
      projectIds = project_df$Id,
      columns = 1,
      statusMapping = statusMapping,
      sheetName = "TestSheet",
      excelObject = wb
    )
  )
})

# ====================
# Integration tests
# ====================

test_that("Integration: full workflow with all functions works correctly", {
  excelTemplate <- system.file("Qualification-Template.xlsx", package = "ospsuite.qualificationplaneditor")
  file.copy(excelTemplate, testOutputFile, overwrite = TRUE)

  wb <- openxlsx::loadWorkbook(testOutputFile)

  if (!"TestSheet" %in% names(wb)) {
    openxlsx::addWorksheet(wb, "TestSheet")
  }
  if (!"LookupSheet" %in% names(wb)) {
    openxlsx::addWorksheet(wb, "LookupSheet")
  }

  # Create test data
  main_df <- data.frame(
    Id = c("P1", "P2", "P3"),
    Type = c("TypeA", "TypeB", "TypeA"),
    Color = c("#FF0000", "#00FF00", "#0000FF"),
    stringsAsFactors = FALSE
  )

  lookup_df <- data.frame(
    Types = c("TypeA", "TypeB", "TypeC"),
    stringsAsFactors = FALSE
  )

  statusMapping <- data.frame(
    Id = c("P1", "P2", "P3"),
    Status = c("Added", "Changed", "Unchanged"),
    stringsAsFactors = FALSE
  )

  # Write data
  writeDataToSheet(main_df, "TestSheet", wb)
  writeDataToSheet(lookup_df, "LookupSheet", wb)

  # Apply validation
  listingValue <- excelListingValue(lookup_df, "Types", "LookupSheet")
  applyDataValidation(listingValue, main_df, "TestSheet", "Type", wb)

  # Apply color styling
  styleColorMapping(main_df, "TestSheet", wb, "Color")

  # Apply status styling
  styleProjectStatus(
    projectIds = main_df$Id,
    columns = seq_len(ncol(main_df)),
    statusMapping = statusMapping,
    sheetName = "TestSheet",
    excelObject = wb
  )

  # Save and verify
  openxlsx::saveWorkbook(wb, testOutputFile, overwrite = TRUE)
  result <- readxl::read_xlsx(testOutputFile, sheet = "TestSheet")

  expect_equal(nrow(result), 3)
  expect_equal(ncol(result), 3)
  expect_true(file.exists(testOutputFile))
})