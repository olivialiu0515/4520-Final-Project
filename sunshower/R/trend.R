estimate_temp_trend3 <- function(station_id) {
  data <- df %>%
    filter(WBANNO == station_id) %>%
    mutate(date = as.Date(LST_DATE), year = year(date), day_of_year = yday(date)) %>%
    group_by(year, day_of_year) %>%
    summarise(
      average_temp = mean(T_DAILY_MEAN, na.rm = TRUE),
      .groups = 'drop'
    )
  
  # Fit a GAM model with a linear trend for 'year' and a seasonal component for 'day_of_year'
  model <- gam(average_temp ~ s(day_of_year, bs = "cs") + year, 
               data = data)
  
  # Create a data frame for predictions covering all days of each year from 2000 to 2024
  prediction_years <- expand.grid(
    year = 2000:2024,
    day_of_year = 1:365  # Ensures covering all days of the year
  )
  
  # Generate predictions for each day of each year
  prediction_years$predicted_temp <- predict(model, newdata = prediction_years)
  
  return(prediction_years)
}