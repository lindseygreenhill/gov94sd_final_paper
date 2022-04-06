library(data.table)
library(janitor)
library(lubridate)
library(tidyverse)


# test

f <- read_tsv("gov94sd_final_project_data/news_chyrons/8_16-8_22.tsv")  %>%
  clean_names() 


# Collect the file names for news chyrons
file_list <- list.files("gov94sd_final_project_data/news_chyrons")

# creating a data frame of all of the chyrons. The data I used is from August
# 2021 to end of March 2022. I deleted BBC because it is not as relavent to
# America

dataset <- data.frame()

for(i in 1:length(file_list)){
  
  temp_data <- read_tsv(str_c("gov94sd_final_project_data/news_chyrons/", file_list[i])) %>%
    clean_names() %>%
    filter(channel != "BBCNEWS") %>%
    mutate(date_sub = substr(date_time_utc, 1, 10),
           date = ymd(date_sub)) %>%
    select(-date_sub, - date_time_utc, -https_archive_org_details)
  
   dataset <- rbind(dataset, temp_data)
  
}

# saving as R data

save(dataset, file = "gov94sd_final_project_data/news_chyrons_combined.RData")

