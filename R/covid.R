#' @title
#'USA COVID-19 Data.
#'
#'@description 
#'This dataset contains USA COVID-19 data at State level from 2020-01-12 to 2020-10-21.
#'
#'@format
#'A tibble with 127,232 rows and 7 variables:
#'- **id**: Index ID
#'- **date**:  Date when the cases are recorded
#'- **month**: Month when the cases are recorded
#'- **key_alpha_2**: State abbreviation
#'- **administrative_area_level_2**: USA States
#'- **variables**: Variable of interests (number of tests, confirmed cases, deaths, and recovered)
#'- **value**: The counts of the variable of interests.
#'
#'@references 
#'Guidotti, E., Ardia, D., (2020), "COVID-19 Data Hub", Journal of Open Source Software 5(51):2376, doi: 10.21105/joss.02376.
#'
#'@docType data
#'
#'@name covid
#'
#'@usage covid
#'
#'@examples 
#'library(dplyr)
#'library(ggplot2)
#'data(covid)
#'
#'# Creating a plot of cumulative number of COVID-19 cases in California overtime
#'covid %>% filter(variable == "confirmed", key_alpha_2 == "CA") %>% 
#'   ggplot(aes(x = date, y = value)) + 
#'   geom_line()
#'
"covid"