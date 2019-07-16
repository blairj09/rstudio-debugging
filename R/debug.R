# Setup ----
library(tidyverse)

get_coordinates <- function(address) {
  # Split on new line
  split_address <- strsplit(address, "\\n")
  
  # Pull last entry
  coordinates <- purrr::map_chr(split_address, dplyr::last)
  
  # Get rid of parentheses
  substr(coordinates, 2, nchar(coordinates) - 1)
}

# Data ----
# 45 hospitals, 32 observations for each hospital
hcahps <- read.csv(here::here("data", "hcahps.csv")) %>% 
  janitor::clean_names(case = "snake")

# Extract coordinates
hcahps %>% 
  mutate(coords = get_coordinates(location)) %>% 
  select(hospital_name, location, coords)

## Debug Once
debugonce(here::here)
here::here("R", "utils.R")
