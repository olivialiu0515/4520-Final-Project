#' Extract time series data for a specific weather station
#'
#' This function filters a given dataset to retrieve data from a specific weather
#' station within an optional specified date range.
#'
#' @param df A dataframe containing weather data.
#' @param station_id A string or numeric value representing the station ID.
#' @param start_date Optional start date for filtering data. Default is NULL. If provided,
#'        the function filters data recorded on or after this date.
#' @param end_date Optional end date for filtering data. Default is NULL. If provided,
#'        the function filters data recorded on or before this date.
#' @return A filtered dataframe containing data from the specified station between the
#'        optional start and end dates.
#' @examples
#' # Example dataset with columns WBANNO and LST_DATE
#' data <- data.frame(WBANNO = c(1, 1, 2, 2), LST_DATE = as.Date(c("2023-01-01", "2023-01-02", "2023-01-01", "2023-01-02")),
#'                    Temp = c(20, 21, 19, 18))
#' # Extract data for station 1
#' station1_data <- timeser(data, 1)
#' print(station1_data)
#' # Extract data for station 1 from 2023-01-02
#' station1_data_jan2 <- timeser(data, 1, as.Date("2023-01-02"))
#' print(station1_data_jan2)
#' @import dplyr
#' @export

timeser <- function(df, station_id, start_date = NULL, end_date = NULL) {
  # Filter the dataset by the station ID
  station_data <- df |> filter(WBANNO == station_id)
  
  # If start date is provided, filter data after the start date
  if (!is.null(start_date)) {
    station_data <- station_data |> filter(LST_DATE >= start_date)
  }
  
  # If end date is provided, filter data before the end date
  if (!is.null(end_date)) {
    station_data <- station_data |> filter(LST_DATE <= end_date)
  }
  
  return(station_data)
}