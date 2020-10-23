## code to prepare `covid` dataset goes here

library(COVID19)
library(dplyr)
library(lubridate)

covid <- covid19(country = "US",
                 level = 2,
                 raw = FALSE,
                 verbose = FALSE) %>%
  mutate(daily_confirmed = confirmed - lag(confirmed),
         daily_deaths = deaths - lag(deaths),
         daily_tests = tests - lag(tests),
         daily_recovered = recovered - lag(recovered),
         month = month(date, label = TRUE, abbr = TRUE)) %>% 
  select(date:deaths, daily_confirmed:month,key_alpha_2, administrative_area_level_2) %>% 
  pivot_longer(tests:daily_recovered, names_to = "variable")


usethis::use_data(covid, overwrite = TRUE)
