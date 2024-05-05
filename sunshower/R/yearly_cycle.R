#' Estimate the yearly temperature cycle for a specific station and year
#'
#' This function estimates the annual cycle of daily mean temperatures for a specified weather
#' station and year using a non-linear least squares (nls) model. It fits a cosine and sine
#' function to the day of the year to capture seasonal temperature variations.
#'
#' @param station_id A numeric or string identifier for the weather station.
#' @param year The year for which the temperature cycle is to be estimated.
#' @return A dataframe with two columns: day_of_year and expected_temp, where
#'         day_of_year ranges from 1 to the number of days in the provided year, and
#'         expected_temp contains the predicted temperatures for these days.
#' @examples
#' # Estimate the temperature cycle for station 12345 in the year 2023
#' yearly_cycle <- estimate_yearly_cycle(12345, "2023")
#' plot(yearly_cycle$day_of_year, yearly_cycle$expected_temp, type = "l",
#'      main = "Estimated Yearly Temperature Cycle",
#'      xlab = "Day of the Year", ylab = "Temperature (°C)")
#' @export

estimate_yearly_cycle <- function(station_id, year) {
  data <- df %>% filter(WBANNO == station_id) %>% filter(format(LST_DATE, "%Y") == year)
  data$day_of_year <- yday(data[["LST_DATE"]])
  days <- max(data$day_of_year)
  formula_str <- T_DAILY_MEAN ~ a + b * cos(2 * pi * day_of_year / days) + c * sin(2 * pi * day_of_year / days)
  control_settings <- nls.control(maxiter = 200, tol = 1e-5, minFactor = 1/1024)
  
  # Fit model using nls
  fit <- nls(
    formula = formula_str,
    data = data,
    start = list(a = mean(data$T_DAILY_MEAN, na.rm = TRUE), b = 0, c = 0),
    control = control_settings,
    na.action = na.exclude
  )
  
  newdata <- data.frame(day_of_year = 1:days)
  expected_temp <- predict(fit, newdata = newdata)
  
  result <- data.frame(day_of_year = 1:days, expected_temp = expected_temp)
  
  return(result)
}