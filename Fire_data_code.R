library("dplyr")
#loading in data and filtering for phenology values of not "NA"
wl1_data <- read.csv("WL1_cleaned.csv")
plants_measured <- wl1_data %>% filter(Phenology != "NA") %>% select (
    -c(X, Site, Xcoord, Ycoord, Stem_diam_mm, Height_cm, Num_total_branches, Longest_leaf_cm,
       Year_marked, Entered_by, Date_entered, Collected_by, Tag, X2018tag, X2019tag,
       Pick_color, Sword_color, Canopy_width_cm, Leaf_thickness_mm, Herbivory, Num_leaves, Buds,
       Category_herbivory, Stem_diam_mm_UFA)
)


#getting number of plants censused for each year
plants_measured %>% count(Census_year)

#filter for reproductive F and P and count total
FP_reproductive <- plants_measured %>% filter(Phenology %in% c("F","P")) %>%
                    mutate(sum_flwr_fruit = Num_flowers + Num_fruits)

#count of F and P plants each year
total_reproductive <- FP_reproductive %>% count(Census_year)

avg_flower <- FP_reproductive %>% group_by(Census_year) %>% 
              summarise(mean_num_flwr = mean(Num_flowers))

avg_fruit <- FP_reproductive %>% group_by(Census_year) %>%
              summarise(mean_num_fruit = mean(Num_fruits))

avg_flwr_fruit <- FP_reproductive %>% group_by(Census_year) %>%
              summarise(mean_sum_flwr_fruit = mean(sum_flwr_fruit, na.rm = T))

avg_reproduction <- avg_fruit %>% left_join(avg_flower, by = "Census_year") %>%
                    left_join(avg_flwr_fruit, by = "Census_year") %>%
                    left_join(total_reproductive, by = "Census_year") %>% 
                    rename(total_plants = n)
