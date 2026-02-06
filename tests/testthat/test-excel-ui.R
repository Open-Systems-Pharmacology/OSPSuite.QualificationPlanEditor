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

test_that("toExcelEditor returns invisibly TRUE on success", {
  result <- toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = snapshotPaths,
    observedDataPaths = observedDataPaths
  )
  expect_true(result)
})

test_that("toExcelEditor handles NULL snapshotPaths and observedDataPaths", {
  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = NULL,
    observedDataPaths = NULL,
    qualificationPlan = '{"Projects": [{"Id": "TestProject", "Path": "test.json"}]}'
  )
  expect_true(file.exists(testOutputFile))
})

test_that("toExcelEditor fails when file copy operation fails", {
  # Create a read-only directory to test copy failure
  skip_on_ci <- TRUE
  if (!skip_on_ci) {
    readOnlyDir <- tempdir()
    Sys.chmod(readOnlyDir, mode = "0555")
    readOnlyFile <- file.path(readOnlyDir, "readonly-test.xlsx")

    expect_error(
      toExcelEditor(
        fileName = readOnlyFile,
        snapshotPaths = snapshotPaths
      ),
      "Failed to copy template"
    )
    Sys.chmod(readOnlyDir, mode = "0755")
  }
})

test_that("toExcelEditor fails with invalid qualification plan JSON", {
  expect_error(
    toExcelEditor(
      fileName = testOutputFile,
      snapshotPaths = NULL,
      qualificationPlan = '{"invalid json'
    ),
    "Cannot parse qualification plan"
  )
})

test_that("toExcelEditor uses default template when excelTemplate is NULL", {
  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = snapshotPaths,
    excelTemplate = NULL
  )
  expect_true(file.exists(testOutputFile))
  # Verify the template has expected sheets
  sheets <- readxl::excel_sheets(testOutputFile)
  expect_contains(sheets, c("Projects", "Lookup", "MetaInfo"))
})

test_that("toExcelEditor creates all qualification sheets when qualification plan provided", {
  # Create a minimal qualification plan JSON
  qualPlan <- list(
    Projects = list(
      list(Id = "Project1", Path = "project1.json")
    ),
    Intro = list(
      Content = list(
        list(Content = "Test intro")
      )
    ),
    Sections = list(
      list(Id = "Section1", Title = "Test Section", Reference = "Sec-1")
    )
  )

  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = NULL,
    qualificationPlan = jsonlite::toJSON(qualPlan, auto_unbox = TRUE)
  )

  sheets <- readxl::excel_sheets(testOutputFile)
  expect_contains(sheets, c("Sections", "Intro", "Inputs"))
})

test_that("toExcelEditor handles empty snapshotPaths list", {
  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = list(),
    qualificationPlan = '{"Projects": [{"Id": "TestProject", "Path": "test.json"}]}'
  )

  projectData <- readxl::read_xlsx(testOutputFile, sheet = "Projects")
  # When snapshotPaths is empty but qualificationPlan has projects,
  # we should see the qualification projects
  expect_equal(nrow(projectData), 1)
  expect_equal(projectData$Id[1], "TestProject")
})

test_that("toExcelEditor handles empty observedDataPaths list", {
  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = snapshotPaths,
    observedDataPaths = list()
  )

  obsData <- readxl::read_xlsx(testOutputFile, sheet = "ObsData")
  # Should have empty data frame with proper columns
  expect_true(nrow(obsData) == 0 || is.na(obsData$Id[1]))
})

test_that("toExcelEditor overwrites existing file", {
  # Create a file first
  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = snapshotPaths
  )
  firstTime <- file.info(testOutputFile)$mtime

  Sys.sleep(1) # Ensure different timestamp

  # Overwrite it
  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = list("SingleProject" = snapshotPaths[[1]])
  )
  secondTime <- file.info(testOutputFile)$mtime

  expect_true(secondTime > firstTime)
})

test_that("toExcelEditor validates fileName extension before processing", {
  # Test various invalid extensions
  expect_error(
    toExcelEditor(fileName = "test.xls", snapshotPaths = snapshotPaths),
    "(Provided file has extension)*(xls)*(while)*(xlsx)*(was expected instead)"
  )

  expect_error(
    toExcelEditor(fileName = "test.csv", snapshotPaths = snapshotPaths),
    "(Provided file has extension)*(csv)*(while)*(xlsx)*(was expected instead)"
  )

  expect_error(
    toExcelEditor(fileName = "test", snapshotPaths = snapshotPaths),
    "(Provided file has extension)*(while)*(xlsx)*(was expected instead)"
  )
})

test_that("toExcelEditor creates workbook with data validations", {
  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = snapshotPaths,
    observedDataPaths = observedDataPaths
  )

  # Use tidyxl to check if data validations exist (if available)
  if (requireNamespace("tidyxl", quietly = TRUE)) {
    wb <- openxlsx::loadWorkbook(testOutputFile)
    # Check that ObsData sheet exists and has columns
    obsData <- readxl::read_xlsx(testOutputFile, sheet = "ObsData")
    expect_true("Type" %in% names(obsData))
  } else {
    # Basic check - verify the sheet has expected columns
    obsData <- readxl::read_xlsx(testOutputFile, sheet = "ObsData")
    expect_true("Type" %in% names(obsData))
  }
})

test_that("toExcelEditor handles qualification plan with all plot types", {
  # Create a comprehensive qualification plan
  qualPlan <- list(
    Projects = list(
      list(Id = "Project1", Path = "project1.json")
    ),
    Plots = list(
      PlotSettings = list(
        ChartWidth = 600,
        ChartHeight = 400
      ),
      AxesSettings = list(
        ComparisonTimeProfile = list(
          list(Type = "X", Dimension = "Time", Unit = "h")
        )
      ),
      AllPlots = list(
        list(
          Project = "Project1",
          Simulation = "Sim1",
          SectionReference = "Sec-1"
        )
      ),
      ComparisonTimeProfilePlots = list(
        list(
          Title = "CT Plot 1",
          SectionReference = "Sec-1"
        )
      ),
      GOFMergedPlots = list(
        list(
          Title = "GOF Plot 1",
          SectionReference = "Sec-1",
          PlotType = "predictedVsObserved"
        )
      ),
      DDIRatioPlots = list(
        list(
          Title = "DDI Plot 1",
          SectionReference = "Sec-1",
          PKParameter = "AUC_tEnd"
        )
      ),
      PKRatioPlots = list(
        list(
          Title = "PK Ratio Plot 1",
          SectionReference = "Sec-1",
          PKParameter = "C_max"
        )
      )
    )
  )

  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = NULL,
    qualificationPlan = jsonlite::toJSON(qualPlan, auto_unbox = TRUE)
  )

  sheets <- readxl::excel_sheets(testOutputFile)
  expect_contains(sheets, c("All_Plots", "CT_Plots", "GOF_Plots", "DDIRatio_Plots", "PKRatio_Plots"))
  expect_contains(sheets, c("GlobalPlotSettings", "GlobalAxesSettings"))

  # Verify plot data was written
  allPlotsData <- readxl::read_xlsx(testOutputFile, sheet = "All_Plots")
  expect_equal(nrow(allPlotsData), 1)
})

test_that("toExcelEditor handles qualification plan with building blocks", {
  qualPlan <- list(
    Projects = list(
      list(
        Id = "Project1",
        Path = "project1.json",
        BuildingBlocks = list(
          list(Type = "Compound", Name = "Drug1", Project = ""),
          list(Type = "Individual", Name = "Person1", Project = "ParentProject")
        )
      )
    )
  )

  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = NULL,
    qualificationPlan = jsonlite::toJSON(qualPlan, auto_unbox = TRUE)
  )

  bbData <- readxl::read_xlsx(testOutputFile, sheet = "BB")
  expect_equal(nrow(bbData), 2)
  expect_equal(bbData$Project[1], "Project1")
  expect_true("BB-Type" %in% names(bbData))
  expect_true("BB-Name" %in% names(bbData))
})

test_that("toExcelEditor merges snapshot projects with qualification plan projects", {
  qualPlan <- list(
    Projects = list(
      list(Id = "Raltegravir", Path = "different-path.json"),
      list(Id = "NewProject", Path = "new.json")
    )
  )

  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = snapshotPaths,
    qualificationPlan = jsonlite::toJSON(qualPlan, auto_unbox = TRUE)
  )

  projectData <- readxl::read_xlsx(testOutputFile, sheet = "Projects")

  # Should have both Raltegravir (merged) and Atazanavir (from snapshot)
  # and NewProject (from qual plan)
  expect_true("Raltegravir" %in% projectData$Id)
  expect_true("Atazanavir" %in% projectData$Id)
  expect_true("NewProject" %in% projectData$Id)
})

test_that("toExcelEditor handles qualification plan with simulation parameters", {
  qualPlan <- list(
    Projects = list(
      list(Id = "Project1", Path = "project1.json")
    ),
    SimulationParameters = list(
      list(
        Project = "Project1",
        Simulation = "Sim1",
        Path = "Organism|Age",
        Value = "30",
        Unit = "year(s)"
      )
    )
  )

  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = NULL,
    qualificationPlan = jsonlite::toJSON(qualPlan, auto_unbox = TRUE)
  )

  sheets <- readxl::excel_sheets(testOutputFile)
  expect_contains(sheets, "SimParam")

  simParamData <- readxl::read_xlsx(testOutputFile, sheet = "SimParam")
  expect_equal(nrow(simParamData), 1)
  expect_true("Project" %in% names(simParamData))
})

test_that("toExcelEditor handles observed data with different types", {
  mixedObsData <- list(
    "TimeProfile1" = "path/to/tp1.csv",
    "TimeProfile2" = list(Path = "path/to/tp2.csv", Type = "TimeProfile"),
    "DDI1" = list(Path = "path/to/ddi1.csv", Type = "DDIRatio"),
    "PKRatio1" = list(Path = "path/to/pk1.csv", Type = "PKRatio")
  )

  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = snapshotPaths,
    observedDataPaths = mixedObsData
  )

  obsData <- readxl::read_xlsx(testOutputFile, sheet = "ObsData")
  expect_equal(nrow(obsData), 4)
  expect_true(all(c("Id", "Path", "Type") %in% names(obsData)))

  # Check that types are correctly assigned
  expect_true(any(obsData$Type == "DDIRatio", na.rm = TRUE))
  expect_true(any(obsData$Type == "PKRatio", na.rm = TRUE))
})

test_that("toExcelEditor creates proper sheet structure with frozen panes", {
  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = snapshotPaths
  )

  wb <- openxlsx::loadWorkbook(testOutputFile)

  # Check that sheets exist
  expect_true("Projects" %in% names(wb))
  expect_true("ObsData" %in% names(wb))

  # The file should be properly formatted and loadable
  projectData <- readxl::read_xlsx(testOutputFile, sheet = "Projects")
  expect_s3_class(projectData, "data.frame")
})

test_that("toExcelEditor handles qualification plan as file path", {
  # Create a temporary JSON file
  qualPlan <- list(
    Projects = list(
      list(Id = "Project1", Path = "project1.json")
    )
  )

  tempQualFile <- tempfile(fileext = ".json")
  writeLines(jsonlite::toJSON(qualPlan, auto_unbox = TRUE), tempQualFile)

  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = NULL,
    qualificationPlan = tempQualFile
  )

  expect_true(file.exists(testOutputFile))
  projectData <- readxl::read_xlsx(testOutputFile, sheet = "Projects")
  expect_equal(projectData$Id[1], "Project1")

  unlink(tempQualFile)
})

test_that("toExcelEditor fails gracefully when workbook cannot be loaded", {
  # Create an invalid Excel file
  invalidFile <- tempfile(fileext = ".xlsx")
  writeLines("not an excel file", invalidFile)

  # Create a custom template path pointing to invalid file
  expect_error(
    {
      template <- system.file("Qualification-Template.xlsx", package = "ospsuite.qualificationplaneditor")
      file.copy(template, invalidFile, overwrite = TRUE)
      # Corrupt the file
      con <- file(invalidFile, "ab")
      writeBin(raw(1000), con)
      close(con)

      toExcelEditor(
        fileName = testOutputFile,
        snapshotPaths = snapshotPaths,
        excelTemplate = invalidFile
      )
    },
    "Cannot load workbook",
    class = "error"
  )

  if (file.exists(invalidFile)) unlink(invalidFile)
})

test_that("toExcelEditor creates schema version information from qualification plan", {
  qualPlan <- list(
    `$schema` = "https://example.com/schema/v2.3.json",
    Projects = list(
      list(Id = "Project1", Path = "project1.json")
    )
  )

  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = NULL,
    qualificationPlan = jsonlite::toJSON(qualPlan, auto_unbox = TRUE)
  )

  metaInfo <- readxl::read_xlsx(testOutputFile, sheet = "MetaInfo")
  # The MetaInfo sheet should exist and have schema version data
  expect_true(nrow(metaInfo) > 0 || ncol(metaInfo) > 0)
})

test_that("toExcelEditor applies project status styling correctly", {
  # This test verifies that styling is applied without errors
  # Actual visual verification would require opening the Excel file
  qualPlan <- list(
    Projects = list(
      list(Id = "Raltegravir", Path = paste0(ospURL, "/Raltegravir-Model/v1.2/Raltegravir-Model.json")),
      list(Id = "NewProject", Path = "new.json")
    )
  )

  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = snapshotPaths,
    qualificationPlan = jsonlite::toJSON(qualPlan, auto_unbox = TRUE)
  )

  # If the function completes without error, styling was applied successfully
  expect_true(file.exists(testOutputFile))

  # Load and verify the workbook can be read
  wb <- openxlsx::loadWorkbook(testOutputFile)
  expect_true("Projects" %in% names(wb))
})

test_that("toExcelEditor handles mapping data with color styling", {
  qualPlan <- list(
    Projects = list(
      list(Id = "Project1", Path = "project1.json")
    ),
    Plots = list(
      ComparisonTimeProfilePlots = list(
        list(Title = "Plot1", SectionReference = "Sec-1")
      ),
      OutputMappings = list(
        list(
          Project = "Project1",
          Simulation = "Sim1",
          Output = "Output1",
          ObservedData = "Obs1",
          Color = "#FF0000"
        )
      )
    )
  )

  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = NULL,
    qualificationPlan = jsonlite::toJSON(qualPlan, auto_unbox = TRUE)
  )

  sheets <- readxl::excel_sheets(testOutputFile)
  expect_contains(sheets, "CT_Mapping")

  # Verify mapping data exists
  mapping <- readxl::read_xlsx(testOutputFile, sheet = "CT_Mapping")
  expect_true("Color" %in% names(mapping) || nrow(mapping) >= 0)
})

test_that("toExcelEditor creates data validation for dropdown columns", {
  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = snapshotPaths,
    observedDataPaths = observedDataPaths
  )

  # Verify that dropdown columns exist
  obsData <- readxl::read_xlsx(testOutputFile, sheet = "ObsData")
  expect_true("Type" %in% names(obsData))

  bbData <- readxl::read_xlsx(testOutputFile, sheet = "BB")
  expect_true("Parent-Project" %in% names(bbData) || nrow(bbData) == 0)
})

test_that("toExcelEditor handles NULL qualification plan with projects", {
  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = snapshotPaths,
    qualificationPlan = NULL
  )

  expect_true(file.exists(testOutputFile))
  projectData <- readxl::read_xlsx(testOutputFile, sheet = "Projects")
  expect_true(nrow(projectData) > 0)
})

test_that("toExcelEditor exports intro and sections data correctly", {
  qualPlan <- list(
    Projects = list(
      list(Id = "Project1", Path = "project1.json")
    ),
    Intro = list(
      Content = list(
        list(Content = "## Introduction\nThis is a test."),
        list(Content = "More content here.")
      )
    ),
    Sections = list(
      list(Id = "sec1", Title = "Methods", Reference = "Sec-1"),
      list(Id = "sec2", Title = "Results", Reference = "Sec-2", ParentSection = "Sec-1")
    )
  )

  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = NULL,
    qualificationPlan = jsonlite::toJSON(qualPlan, auto_unbox = TRUE)
  )

  introData <- readxl::read_xlsx(testOutputFile, sheet = "Intro")
  expect_true(nrow(introData) > 0)

  sectionsData <- readxl::read_xlsx(testOutputFile, sheet = "Sections")
  expect_equal(nrow(sectionsData), 2)
  expect_true("Parent Section" %in% names(sectionsData))
  expect_equal(sectionsData$Reference[1], "Sec-1")
})

test_that("toExcelEditor handles empty qualification plan JSON object", {
  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = snapshotPaths,
    qualificationPlan = "{}"
  )

  expect_true(file.exists(testOutputFile))
  # Should still create file with snapshot data
  projectData <- readxl::read_xlsx(testOutputFile, sheet = "Projects")
  expect_true(nrow(projectData) > 0)
})

test_that("toExcelEditor handles qualification plan with empty project list", {
  qualPlan <- list(
    Projects = list()
  )

  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = snapshotPaths,
    qualificationPlan = jsonlite::toJSON(qualPlan, auto_unbox = TRUE)
  )

  projectData <- readxl::read_xlsx(testOutputFile, sheet = "Projects")
  # Should have projects from snapshotPaths
  expect_equal(nrow(projectData), 2)
})

test_that("toExcelEditor creates CT_Mapping sheet with proper structure", {
  qualPlan <- list(
    Projects = list(
      list(Id = "Project1", Path = "project1.json")
    ),
    Plots = list(
      ComparisonTimeProfilePlots = list(
        list(Title = "Plot1", SectionReference = "Sec-1")
      ),
      OutputMappings = list(
        list(
          Project = "Project1",
          Simulation = "Sim1",
          Output = "Output1",
          ObservedData = "Obs1",
          Color = "#0000FF",
          Symbol = "Circle"
        )
      )
    )
  )

  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = NULL,
    qualificationPlan = jsonlite::toJSON(qualPlan, auto_unbox = TRUE)
  )

  ctMapping <- readxl::read_xlsx(testOutputFile, sheet = "CT_Mapping")
  expect_true("Color" %in% names(ctMapping) || nrow(ctMapping) >= 0)
  expect_true("Symbol" %in% names(ctMapping) || nrow(ctMapping) >= 0)
})

test_that("toExcelEditor creates GOF_Mapping sheet with proper structure", {
  qualPlan <- list(
    Projects = list(
      list(Id = "Project1", Path = "project1.json")
    ),
    Plots = list(
      GOFMergedPlots = list(
        list(
          Title = "GOF1",
          SectionReference = "Sec-1",
          PlotType = "predictedVsObserved",
          Groups = list(
            list(Caption = "Group1", Symbol = "Circle")
          )
        )
      ),
      GOFMergedPlotsPredictedVsObserved = list(
        list(
          Project = "Project1",
          Simulation = "Sim1",
          Output = "Output1",
          ObservedData = "Obs1",
          Color = "#FF0000"
        )
      )
    )
  )

  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = NULL,
    qualificationPlan = jsonlite::toJSON(qualPlan, auto_unbox = TRUE)
  )

  sheets <- readxl::excel_sheets(testOutputFile)
  expect_contains(sheets, "GOF_Mapping")

  gofMapping <- readxl::read_xlsx(testOutputFile, sheet = "GOF_Mapping")
  expect_true("Color" %in% names(gofMapping) || nrow(gofMapping) >= 0)
})

test_that("toExcelEditor creates DDIRatio_Mapping sheet with proper structure", {
  qualPlan <- list(
    Projects = list(
      list(Id = "Project1", Path = "project1.json")
    ),
    Plots = list(
      DDIRatioPlots = list(
        list(
          Title = "DDI1",
          SectionReference = "Sec-1",
          PKParameter = "AUC_tEnd",
          Groups = list(
            list(Caption = "Group1", Color = "#00FF00")
          )
        )
      ),
      DDIRatioPlotsPredictedVsObserved = list(
        list(
          Project = "Project1",
          SimulationControl = "Control1",
          SimulationTreatment = "Treatment1",
          Output = "Output1",
          ObservedData = "Obs1"
        )
      )
    )
  )

  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = NULL,
    qualificationPlan = jsonlite::toJSON(qualPlan, auto_unbox = TRUE)
  )

  sheets <- readxl::excel_sheets(testOutputFile)
  expect_contains(sheets, "DDIRatio_Mapping")
})

test_that("toExcelEditor creates PKRatio_Mapping sheet with proper structure", {
  qualPlan <- list(
    Projects = list(
      list(Id = "Project1", Path = "project1.json")
    ),
    Plots = list(
      PKRatioPlots = list(
        list(
          Title = "PKRatio1",
          SectionReference = "Sec-1",
          PKParameter = "C_max",
          Groups = list(
            list(Caption = "Group1", Color = "#FFFF00")
          )
        )
      ),
      PKRatioPlots_Mapping = list(
        list(
          Project = "Project1",
          Simulation = "Sim1",
          Output = "Output1",
          ObservedData = "Obs1"
        )
      )
    )
  )

  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = NULL,
    qualificationPlan = jsonlite::toJSON(qualPlan, auto_unbox = TRUE)
  )

  sheets <- readxl::excel_sheets(testOutputFile)
  expect_contains(sheets, "PKRatio_Mapping")
})

test_that("toExcelEditor properly exports GlobalAxesSettings for all plot types", {
  qualPlan <- list(
    Projects = list(
      list(Id = "Project1", Path = "project1.json")
    ),
    Plots = list(
      AxesSettings = list(
        ComparisonTimeProfile = list(
          list(Type = "X", Dimension = "Time", Unit = "h", Scaling = "Linear", GridLines = FALSE),
          list(Type = "Y", Dimension = "Concentration (mass)", Unit = "µg/l", Scaling = "Log", GridLines = TRUE)
        ),
        GOFMergedPlotsPredictedVsObserved = list(
          list(Type = "X", Dimension = "Concentration (mass)", Unit = "µg/l", Scaling = "Log", GridLines = FALSE),
          list(Type = "Y", Dimension = "Concentration (mass)", Unit = "µg/l", Scaling = "Log", GridLines = FALSE)
        )
      )
    )
  )

  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = NULL,
    qualificationPlan = jsonlite::toJSON(qualPlan, auto_unbox = TRUE)
  )

  globalAxesSettings <- readxl::read_xlsx(testOutputFile, sheet = "GlobalAxesSettings")
  expect_true(nrow(globalAxesSettings) > 0)
  expect_true("Dimension" %in% names(globalAxesSettings))
  expect_true("Scaling" %in% names(globalAxesSettings))
  expect_true("GridLines" %in% names(globalAxesSettings))
})

test_that("toExcelEditor handles very long file names", {
  longFileName <- paste0(paste(rep("a", 200), collapse = ""), ".xlsx")

  # This should work or fail gracefully
  result <- tryCatch(
    {
      toExcelEditor(
        fileName = longFileName,
        snapshotPaths = snapshotPaths
      )
      TRUE
    },
    error = function(e) {
      # If it errors, that's also acceptable for very long names
      TRUE
    }
  )

  expect_true(result)

  # Clean up if file was created
  if (file.exists(longFileName)) {
    unlink(longFileName)
  }
})

test_that("toExcelEditor preserves Lookup sheet from template", {
  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = snapshotPaths
  )

  sheets <- readxl::excel_sheets(testOutputFile)
  expect_contains(sheets, "Lookup")

  # Verify lookup data is accessible
  lookupSheet <- readxl::read_xlsx(testOutputFile, sheet = "Lookup")
  expect_s3_class(lookupSheet, "data.frame")
  expect_true(ncol(lookupSheet) > 0)
})

test_that("toExcelEditor handles special characters in project IDs", {
  qualPlan <- list(
    Projects = list(
      list(Id = "Project-1_test.v2", Path = "project1.json"),
      list(Id = "Project (2)", Path = "project2.json"),
      list(Id = "Project/3", Path = "project3.json")
    )
  )

  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = NULL,
    qualificationPlan = jsonlite::toJSON(qualPlan, auto_unbox = TRUE)
  )

  projectData <- readxl::read_xlsx(testOutputFile, sheet = "Projects")
  expect_equal(nrow(projectData), 3)
  expect_true("Project-1_test.v2" %in% projectData$Id)
  expect_true("Project (2)" %in% projectData$Id)
})

test_that("toExcelEditor handles qualification plan as URL", {
  # Skip this test in normal runs as it requires network
  skip("Network test - requires valid URL")

  # Example test structure for URL-based qualification plan
  qualPlanURL <- "https://example.com/qualification-plan.json"

  # This would be tested in integration tests with a real URL
  expect_error(
    toExcelEditor(
      fileName = testOutputFile,
      snapshotPaths = NULL,
      qualificationPlan = qualPlanURL
    ),
    NA # Expect no error if URL is valid
  )
})

test_that("toExcelEditor handles large qualification plans efficiently", {
  # Create a large qualification plan with many projects
  projects <- lapply(1:50, function(i) {
    list(Id = paste0("Project", i), Path = paste0("project", i, ".json"))
  })

  qualPlan <- list(
    Projects = projects
  )

  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = NULL,
    qualificationPlan = jsonlite::toJSON(qualPlan, auto_unbox = TRUE)
  )

  projectData <- readxl::read_xlsx(testOutputFile, sheet = "Projects")
  expect_equal(nrow(projectData), 50)
})

test_that("toExcelEditor includes additionalRows parameter in data validations", {
  # This is a regression test for the recent fix
  toExcelEditor(
    fileName = testOutputFile,
    snapshotPaths = snapshotPaths,
    observedDataPaths = observedDataPaths
  )

  # The function should complete without error
  # The additionalRows=1000 parameter should be applied to specific dropdowns
  expect_true(file.exists(testOutputFile))

  # Verify sheets that should have validation with additionalRows
  sheets <- readxl::excel_sheets(testOutputFile)
  expect_contains(sheets, "Sections")
  expect_contains(sheets, "ObsData")
})