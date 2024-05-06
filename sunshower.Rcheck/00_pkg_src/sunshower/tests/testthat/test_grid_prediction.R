# Test 1
test_that("grid_prediction runs without errors and returns valid output", {
    usa_grid <- create_usa_grid(resolution = 1)
    data5 <- df %>% filter(LST_DATE == "2023-03-01")
    prediction_value <- data5$T_DAILY_MEAN
    grid_pred <- grid_prediction(usa_grid, data5, prediction_value)
    expect_equal((length(grid_pred)), 804)
})
