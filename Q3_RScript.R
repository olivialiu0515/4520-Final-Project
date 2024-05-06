#load necessary package
library(data.table)
library(dplyr)

# Set the root directory
root_directory <- "/Users/olivialiu/Desktop/4520-Final-Project/raw_data"

# List all CSV files within the root directory
files <- list.files(root_directory, pattern = "\\.txt$", full.names = TRUE, recursive = TRUE)

# use function to rbind all dataset into a dataset
all_data <- rbindlist(lapply(files, fread))

all_data <- all_data %>%
  select(1:11)

#rename columns 
all_data <- all_data %>%
  rename(WBANNO = V1) %>%
  rename(LST_DATE = V2) %>%
  rename(CRX_VN = V3 ) %>%
  rename(LONGITUDE = V4) %>%
  rename(LATITUDE = V5) %>%
  rename(T_DAILY_MAX = V6) %>%
  rename(T_DAILY_MIN = V7) %>%
  rename(T_DAILY_MEAN = V8) %>%
  rename(T_DAILY_AVG = V9) %>%
  rename(P_DAILY_CALC = V10) %>%
  rename(SOLARAD_DAILY = V11)

#load the csv file containing each station's summary information
summary <- read.csv("/Users/olivialiu/Desktop/4520-Final-Project/stations_info.csv")

#match two dataset based on the station identifier number
matched_indices <- match(all_data$WBANNO, summary$Identifier)

#create state variable & station_name variable and fill in information based on the matching
all_data$state <- summary$State[matched_indices]
all_data$station_name <- summary$StationName[matched_indices]

# alter the date format from integer to date
all_data$LST_DATE <- as.Date(as.character(all_data$LST_DATE), format = "%Y%m%d")

#change all missing values into NA (turn extreme values into NA)
all_data[all_data < -1000] <- NA

#rearrange the order of columns
all_data <- all_data %>%
  select(WBANNO, state, station_name,everything())

saveRDS(all_data, "/Users/olivialiu/Desktop/all_daily_data.RData")

