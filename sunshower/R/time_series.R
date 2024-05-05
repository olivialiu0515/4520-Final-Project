# Define the function to extract time series data for a specific station
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
