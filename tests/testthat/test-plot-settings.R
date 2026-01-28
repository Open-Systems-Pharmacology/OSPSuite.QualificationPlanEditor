test_that("Default Global Plot Settings are exported as an appropriate data.frame", {
  excelPlotSetting <- ospsuite.qualificationplaneditor:::formatPlotSettings(
    plotSettings = NULL,
    fillEmpty = FALSE
  )
  expect_equal(
    excelPlotSetting,
    data.frame(ChartWidth = NA, ChartHeight = NA, AxisSize = NA, LegendSize = NA, OriginSize = NA, FontFamilyName = NA, WatermarkSize = NA)
  )

  excelPlotSetting <- ospsuite.qualificationplaneditor:::formatPlotSettings(
    plotSettings = NULL,
    fillEmpty = TRUE
  )
  expect_equal(
    excelPlotSetting,
    data.frame(ChartWidth = 500, ChartHeight = 400, AxisSize = 11, LegendSize = 9, OriginSize = 11, FontFamilyName = "Arial", WatermarkSize = 40)
  )
})

test_that("formatPlotSettings exports qualification data appropriately", {
  testPlotSettings <- list(ChartWidth = 600, ChartHeight = 500, WatermarkSize = 28)
  excelPlotSetting <- ospsuite.qualificationplaneditor:::formatPlotSettings(plotSettings = testPlotSettings)
  expect_equal(
    excelPlotSetting,
    data.frame(ChartWidth = 600, ChartHeight = 500, AxisSize = NA, LegendSize = NA, OriginSize = NA, FontFamilyName = NA, WatermarkSize = 28)
  )
  
  excelPlotSetting <- ospsuite.qualificationplaneditor:::formatPlotSettings(plotSettings = testPlotSettings, fillEmpty = TRUE)
  expect_equal(
    excelPlotSetting,
    data.frame(ChartWidth = 600, ChartHeight = 500, AxisSize = 11, LegendSize = 9, OriginSize = 11, FontFamilyName = "Arial", WatermarkSize = 28)
  )
})
