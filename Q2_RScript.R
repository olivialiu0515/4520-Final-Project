library(data.table) 

# Function to extract information from a single file
process_file <- function(file_path) {
  # Extracting parts of the file name, usuing different collapse
  parts <- unlist(strsplit(basename(file_path), split = "[_.]"))
  state <- substr(basename(file_path), 15, 16)
  station_name <- paste(parts[3:length(parts) - 1], collapse = "_") 
  
  # Read the file content
  data <- fread(file_path, header = FALSE)
  
  if (nrow(data) > 0) {
    first_row <- data[1, ]
    identifier <- first_row$V1
    longitude <- first_row$V4
    latitude <- first_row$V5
    
    # Create a data frame with the extracted info
    return(data.frame(
      Identifier = identifier,
      State = state,
      StationName = station_name,
      Longitude = longitude,
      Latitude = latitude
    ))
  } else {
    return(NULL) 
  }
}

# Directory containing all the data folders
data_dir <- "/Users/gengxingshuo/Desktop/4520-Final-Project/raw_data"

# List all files recursively
file_list <- list.files(data_dir, pattern = "\\.txt$", full.names = TRUE, recursive = TRUE)

# Process and iterate through all files
stations_info <- lapply(file_list, process_file)

# Combine all data frames into one
stations_info <- Filter(Negate(is.null), stations_info) 
combined_data <- do.call(rbind, stations_info)

# Remove duplicate rows based on station identifier
unique_stations <- unique(combined_data)

# Save the final dataset into a new dataset
write.csv(unique_stations, "stations_summary4.csv", row.names = FALSE, quote = FALSE)


