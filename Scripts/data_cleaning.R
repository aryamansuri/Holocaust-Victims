#### Preamble ####
# Purpose: Downloads the data
# Author: Aryaman Suri
# Date: 26/03/24
# Contact: aryaman.suri@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

#### Workspace setup ####
library(tidyverse)
library(dplyr)


#### Download data ####
holocaust_survivors_data <- read_csv("Data/raw_data/raw_data.csv")

#### Clean data ####
cleaned_holocaust_data <- holocaust_survivors_data |> count(Religion, sort = TRUE)

#### Save data ####
write_csv(cleaned_holocaust_data, "Data/analysis_data/cleaned_data.csv")