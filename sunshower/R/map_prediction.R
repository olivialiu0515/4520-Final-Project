#' Create a heat map for gridded weather predictions
#' 
#' This function utilizes predictions generated for USA maps grid points to make a heat map on the USA map contour.
#' Note that the length of predictions should match the grid points.
#' 
#' @param grid_prediction weather predictions made for USA map grids.
#' @param usa_grid a list of grid points of USA map with a longitude column and a latitude column. 
#'        This should be identical with the one used to make predictions.
#' @examples 
#' # create a heatmap for the estamted temperature on March 1st, 2023 for USA map grid points with a given resolution
#' #create an example USA map grid points with resolution of 1
#' usa_grid <- create_usa_grid(resolution = 1)
#' #create an example station data with LONGITUDE and LATITUDE information used for prediction
#' data <- data.frame(LONGITUDE = c(-158.61, -164.08, -145.35, -148.46, -150.87,-147.51), 
#'                     LATITUDE = c(59.28, 61.35, 60.47, 70.16, 63.45,64.97))
#' # create an example list of statistic of the stations used to predict 
#' prediction_value <- c( -6.9 -13.4  -1.3 -28.4 -10.0 -11.7)
#' grid_prediction <- grid_prediction(usa_grid, data, prediction_value)
#' map_predictions(predictions, usa_grid)
#' 
#' @export
map_predictions <- function(grid_prediction, usa_grid) {
  map_usa <- map_data("usa")
  usa_grid <- as.data.frame(usa_grid) 
  
  # Define the color palette
  colors <- rev(brewer.pal(6, "RdYlBu"))
  
  # Plot the map with grid points and predicted temperature using a different color gradient
  ggplot() +
    geom_polygon(data = map_usa, aes(x = long, y = lat, group = group), fill = "white", color = "grey") +
    geom_point(data = usa_grid, aes(x = lon, y = lat, color = predictions), size = 2) +
    scale_color_gradientn(colors = colors, name = "Temperature") +  # Color gradient
    labs(title = "Predicted Temperature for USA Grid Points",
         x = "Longitude", y = "Latitude") +  # Set x and y axis labels
    theme_minimal() +
    theme(plot.title = element_text(hjust = 0.5))  # Center the plot title
}

