# Test 1
test_that("yearly trend looks okay", {
  station_id <- 53878
  trend1 <- estimate_temp_trend(station_id)
  expect_equal(
    names(trend1), 
    c("year", "day_of_year", "predicted_temp")
  )
})

# Test 2
test_that("predictions cover the full specified year range", {
  station_id <- 53878
  trend1 <- estimate_temp_trend(station_id)
  expect_equal(min(trend1$year), 2000)
  expect_equal(max(trend1$year), 2024)
  expect_equal(nrow(trend1[trend1$year == 2009,]), 365) 
})
