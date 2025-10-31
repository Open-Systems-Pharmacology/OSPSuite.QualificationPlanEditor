test_that("getProjectsFromList creates a data.frame with appropriate values", {
  snapshotPaths <- list(
    A = "path/to/A.json",
    B = "path/to/B.json"
  )
  expect_equal(
    getProjectsFromList(snapshotPaths),
    data.frame(
      Id = c("A", "B"),
      Path = c("path/to/A.json", "path/to/B.json"),
      row.names = NULL
    )
  )
})


test_that("getProjectsFromList can parse Ids from paths", {
  snapshotPaths <- c("path/to/A.json", "path/to/B.json")
  expect_equal(
    getProjectsFromList(snapshotPaths),
    data.frame(
      Id = c("A", "B"),
      Path = c("path/to/A.json", "path/to/B.json"),
      row.names = NULL
    )
  )
  snapshotPaths <- c("path/to/A-Model.json", "path/to/B.json")
  expect_equal(
    getProjectsFromList(snapshotPaths),
    data.frame(
      Id = c("A", "B"),
      Path = c("path/to/A-Model.json", "path/to/B.json"),
      row.names = NULL
    )
  )
})
