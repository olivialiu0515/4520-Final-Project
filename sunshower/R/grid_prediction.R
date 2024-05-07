#' Make weather predictions on USA map grid points
#'
#' This function is used to make different weather predictions on USA map grid points of various resolutions;
#' the predictions made depend on the statistic the user is interested in
#'
#' @param usa_grid a list of grid points of USA map with a longitude column and a latitude column
#' @param data a cleaned data set with a LONGITUDE column and a LATITUDE column of stations used for prediction
#' @param prediction_value a list of statistic of stations that is used for the prediction of grid points
#'
#' @return A data frame or matrix containing the predicted values for each grid point
#'         in the `usa_grid`. Each row corresponds to a grid point.
#'
#' @examples
#' # estimate the temperature on March 1st, 2023 for USA map grid points with a given resolution
#' # create an example USA map grid points with resolution of 1
#' library(dplyr)
#‘ data("all_data")
#' usa_grid <- create_usa_grid(resolution = 2)
#' data2 <- all_data %>% filter(LST_DATE == "2023-03-01")
#' prediction_value <- data2$T_DAILY_MEAN
#' grid_pred <- grid_prediction(usa_grid, data2, prediction_value)
#' print(grid_pred)
#' @import GpGp
#' @export

grid_prediction <- function(usa_grid, data, prediction_value) {

  #creating locs by extracting longitude and latitude data
  locs1 <- cbind(data$LONGITUDE, data$LATITUDE)

  #fit the spatial model using fit_model function in GpGp package
  spatial_model <- fit_model(prediction_value,
                             locs = locs1,
                             covfun_name  = "matern_sphere",
                             silent = TRUE)

  locs_pred <- as.matrix(usa_grid)
  X_pred <- as.matrix(rep(1, nrow(usa_grid)))

  #make predictions based on the fitted spatial model
  grid_prediction <- predictions( fit = spatial_model,
                                  locs_pred = locs_pred,
                                  X_pred = X_pred
  )
  return(grid_prediction)
}
