#' Estimate temperature trends for a specific station
#'
#' This function models the temperature trend and seasonal variations at a specific weather station
#' using a Generalized Additive Model (GAM). The model includes a linear trend component for the
#' year and a smooth seasonal component for the day of the year.
#'
#' @param station_id The identifier for the weather station, which could be numeric or string.
#' @return A dataframe with columns for year, day_of_year, and predicted_temp. The predicted_temp
#'         column contains the estimated average daily temperatures for each day of the year across
#'         the specified range of years.
#' @examples
#' # Estimate temperature trends for station 53878
#‘ data("all_data")
#' trends <- estimate_temp_trend(53878)
#' print(trends)
#' @import dplyr
#' @import mgcv
#' @import lubridate
#' @export

estimate_temp_trend <- function(station_id) {
  data <- all_data %>%
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
