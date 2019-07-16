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
hcahps <- hcahps %>% 
  mutate(coords = get_coordinates(location)) %>% 
  select(hospital_name, location, coords)

hcahps %>% 
  separate(coords, c("lat", "long"), ",")

## Debug Once
debugonce(tidyr::separate)
hcahps %>% 
  separate(coords, c("lat", "long"), ",")

## Locating errors
f <- function(a) g(a)
g <- function(b) h(b)
h <- function(c) i(c)
i <- function(d) {
  if (!is.numeric(d)) {
    stop("`d` must be numeric", call. = FALSE)
  }
  d + 10
}

## Error Options
options(error = recover)
read.csv("data/nothing.csv")
options(error = NULL)

f("a")
