# Test 1
test_that("map_prediction runs without errors", {
    usa_grid <- create_usa_grid(resolution = 1)
    data5 <- df %>% filter(LST_DATE == "2023-03-01")
    prediction_value <- data5$T_DAILY_MEAN
    grid_pred <- grid_prediction(usa_grid, data5, prediction_value)
    expect_no_error(map_predictions(grid_pred, usa_grid))
  })