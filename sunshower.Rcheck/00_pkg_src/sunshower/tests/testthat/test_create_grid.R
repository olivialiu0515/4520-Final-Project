# Test 1
test_that("create_usa_grid runs without errors and returns valid output", {
  expect_silent({
    grid_default <- create_usa_grid()
  })
})

# Test 2
test_that("create_usa_grid runs without errors using specified resolutions", {
  expect_silent({
    grid_default <- create_usa_grid(resolution = 2)
  })
})