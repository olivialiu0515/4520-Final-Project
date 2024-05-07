# Test 1
test_that("grid_prediction runs without errors and returns valid output", {
    data("all_data")
    usa_grid <- create_usa_grid(resolution = 2)
    data5 <- all_data %>% filter(LST_DATE == "2023-03-01")
    prediction_value <- data5$T_DAILY_MEAN
    grid_pred <- grid_prediction(usa_grid, data5, prediction_value)
    expect_equal((length(grid_pred)), 194)
})
