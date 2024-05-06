# Test 1: Test the output
test_that("time series looks okay", {
  df <- all_data
  station_id <- 63829
  info <- timeser(df, station_id)
  expect_equal(
    names(info), 
    c("WBANNO", "state", "station_name", "LST_DATE", 
      "CRX_VN", "LONGITUDE", "LATITUDE", "T_DAILY_MAX", 
      "T_DAILY_MIN", "T_DAILY_MEAN", "T_DAILY_AVG", 
      "P_DAILY_CALC", "SOLARAD_DAILY"
)
  )
})

# Test 2: Test the output with dates
test_that("time series looks okay with specified date", {
  df <- all_data
  station_id <- 63829
  start_date <- "2008-01-01"
  end_date <- "2020-04-09"
  info <- timeser(df, station_id, start_date, end_date)
  expect_equal(
    names(info), 
    c("WBANNO", "state", "station_name", "LST_DATE", 
      "CRX_VN", "LONGITUDE", "LATITUDE", "T_DAILY_MAX", 
      "T_DAILY_MIN", "T_DAILY_MEAN", "T_DAILY_AVG", 
      "P_DAILY_CALC", "SOLARAD_DAILY"
    )
  )
})