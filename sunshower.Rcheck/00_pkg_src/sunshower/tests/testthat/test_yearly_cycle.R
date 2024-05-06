# Test 1
test_that("yearly cycle looks okay", {
  station_id <- 53878
  year <- 2008
  cycle1 <- estimate_yearly_cycle(station_id, year)
  expect_equal(
    names(cycle1), 
    c("day_of_year", "expected_temp")
  )
})

# Test 2
test_that("yearly cycle for non-leap year has 365 rows", {
  station_id <- 53878
  year <- 2007
  cycle2 <- estimate_yearly_cycle(station_id, year)
  
  # Check if there are exactly 365 rows
  expect_equal(nrow(cycle2), 365)
})