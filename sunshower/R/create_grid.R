#' Create a grid of points within the contiguous USA
#'
#' This function generates a grid of longitude and latitude points within the geographic
#' boundaries of the contiguous United States. The resolution of the grid, which determines
#' the spacing between grid points, can be specified. Points are filtered to ensure they
#' fall within the actual boundaries of the USA as defined by the 'maps' package.
#'
#' @param resolution The resolution in degrees between points in the grid.
#'                   Default is 1 degree.
#' @return A dataframe containing two columns, lon and lat, which represent the longitude
#'         and latitude of each point within the contiguous USA.
#' @examples
#' # Create a grid with a resolution of 1 degree
#' usa_grid <- create_usa_grid()
#' # Create a higher resolution grid of 0.5 degrees
#' finer_usa_grid <- create_usa_grid(0.5)
#' @import maps
#' @export

create_usa_grid <- function(resolution = 1) {
  # Get USA map data
  usa_map <- maps::map("usa", plot = FALSE)
  
  # Find the range of the contiguous USA
  lon_range <- range(usa_map$x, na.rm = TRUE)
  lat_range <- range(usa_map$y, na.rm = TRUE)
  
  # Create a grid of points within this range
  lons <- seq(from = lon_range[1], to = lon_range[2], by = resolution)
  lats <- seq(from = lat_range[1], to = lat_range[2], by = resolution)
  
  # Create all combinations of latitudes and longitudes
  grid <- expand.grid(lon = lons, lat = lats)
  
  # Filter points that are inside the USA polygon
  inside <- with(usa_map, {
    inside <- map.where("usa", grid$lon, grid$lat)
    !is.na(inside)
  })
  grid <- grid[inside, ]
  
  # Return the filtered grid
  return(grid)
}