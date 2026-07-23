library("dplyr")
#loading in data and filtering for phenology values of not "NA"
wl1_data <- read.csv("WL1_cleaned.csv")
plants_measured <- wl1_data %>% filter(Phenology != "NA")


#getting number of plants censused for each year
plants_measured %>% count(Census_year)

#filter for reproductive F and P and count total
FP_reproductive <- plants_measured %>% filter(Phenology %in% c("F","P"))

#count of F and P plants each year
FP_reproductive %>% count(Census_year)

avg_flower <- FP_reproductive %>% group_by(Census_year) %>% 
              summarise(mean_num_flwr = mean(Num_flowers))

avg_fruit <- FP_reproductive %>% group_by(Census_year) %>%
              summarise(mean_num_fruit = mean(Num_fruits))
