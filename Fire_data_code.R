#loading in data and ensuring date column is dates.
wl1_data <- read.csv("WL1_cleaned.csv")
wl1_data$Census_date <- as.Date(wl1_data$Census_date)

#getting number of plants in each transect for each year
year_transect_counts <- table(wl1_data$Census_date, wl1_data$Transect_plot)
