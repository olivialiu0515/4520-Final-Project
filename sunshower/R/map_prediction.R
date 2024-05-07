#' Create a heat map for gridded weather predictions
#'
#' This function utilizes predictions generated for USA maps grid points to make a heat map on the USA map contour.
#' Note that the length of predictions should match the grid points.
#'
#' @param grid_prediction weather predictions made for USA map grids.
#' @param usa_grid a list of grid points of USA map with a longitude column and a latitude column.
#'        This should be identical with the one used to make predictions.
#'
#' @return A ggplot object representing a heat map of the weather predictions across the USA map grid points.
#'         The heat map displays the geographic distribution of predicted temperatures on the USA map contour.
#'
#' @examples
#' # create a heatmap for the estimated temperature on March 1st, 2023 for USA map
#' # grid points with a given resolution
#' # create an example USA map grid points with resolution of 1
#' library(dplyr)
#' data("all_data")
#' usa_grid <- create_usa_grid(resolution = 2)
#' data2 <- all_data %>% filter(LST_DATE == "2023-03-01")
#' prediction_value <- data2$T_DAILY_MEAN
#' grid_pred <- grid_prediction(usa_grid, data2, prediction_value)
#' map_predictions(grid_pred, usa_grid)
#' @import ggplot2
#' @import RColorBrewer
#' @export
map_predictions <- function(grid_prediction, usa_grid) {
  map_usa <- map_data("usa")
  usa_grid <- as.data.frame(usa_grid)

  # Define the color palette
  colors <- rev(brewer.pal(6, "RdYlBu"))

  # Plot the map with grid points and predicted temperature using a different color gradient
  ggplot() +
    geom_polygon(data = map_usa, aes(x = long, y = lat, group = group), fill = "white", color = "grey") +
    geom_point(data = usa_grid, aes(x = lon, y = lat, color = grid_prediction), size = 2) +
    scale_color_gradientn(colors = colors, name = "Temperature") +  # Color gradient
    labs(title = "Predicted Temperature for USA Grid Points",
         x = "Longitude", y = "Latitude") +  # Set x and y axis labels
    theme_minimal() +
    theme(plot.title = element_text(hjust = 0.5))  # Center the plot title
}

