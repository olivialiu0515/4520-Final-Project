# Function to create a grid of points within the contiguous USA
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
