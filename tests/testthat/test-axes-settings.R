test_that("Default Global Axes Settings are exported as an appropriate data.frame", {
  for (plotName in ospsuite.qualificationplaneditor:::ALL_EXCEL_AXES) {
    excelAxesSetting <- ospsuite.qualificationplaneditor:::formatGlobalAxesSettings(
      axesSettings = NULL,
      plotName = plotName
    )
    expect_s3_class(excelAxesSetting, "data.frame")
    expect_equal(excelAxesSetting$Plot, rep(plotName, 2))
    expect_equal(excelAxesSetting$Type, c("X", "Y"))
    expect_true(all(excelAxesSetting$Dimension %in% ospsuite.qualificationplaneditor:::ALL_EXCEL_DIMENSIONS))
    expect_true(all(excelAxesSetting$Scaling %in% c("Linear", "Log")))
    expect_type(excelAxesSetting$GridLines, "logical")
  }
})

test_that("formatGlobalAxesSettings exported qualification data appropriately", {
  testAxesSettings <- list(
    list(Type = "X", Dimension = "Time", Unit = "h", GridLines = TRUE, Scaling = "Linear"),
    list(Type = "Y", Dimension = "Concentration (mass)", Unit = "ng/ml", GridLines = FALSE, Scaling = "Linear")
  )
  excelAxesSetting <- ospsuite.qualificationplaneditor:::formatGlobalAxesSettings(
    axesSettings = testAxesSettings,
    plotName = "ComparisonTimeProfile"
  )
  expect_equal(
    excelAxesSetting,
    data.frame(
      Plot = "ComparisonTimeProfile",
      Type = c("X", "Y"),
      Dimension = c("Time", "Concentration (mass)"),
      Unit = c("h", "ng/ml"),
      GridLines = c(TRUE, FALSE),
      Scaling = "Linear"
    )
  )
})
