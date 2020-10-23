filter_input <- function(data, input){
  data %>%
    dplyr::filter(key_alpha_2 == input$state,
                  date >= input$date[1] & date <= input$date[2])
}

#' Filtering the `covid` data frame based on user input.
#'
#' @param data `covid` data frame.
#'
#' @param stats Preferred statistics to calculate the variable of interest in the COVID-19 data frame.
#' Use 'cumulative' to return cumulative COVID-19 stats, and 'daily'to return daily COVID-19 stats.
#'
#' @return `covid_filter` reruns the same type of the input, i.e. a data frame.
#'
#' @examples
#' # This will return filtered cumulative stats from covid data frame based on users' input
#' covid_filter(covid, stats = 'cumulative')
#' 
#' @export
#' @name covid_filter

covid_filter <- function(data, stats, input){
  if(stats == "cumulative"){
    filter_input(data, input) %>% 
      dplyr::filter(variable == input$variable)
  } else if (stats == "daily"){
    filter_input(data, input) %>% 
      dplyr::filter(variable == str_c("daily_", input$variable))
  } else {
    print("Invalid value passed to stats argument. Please enter 'cumulative' or 'daily'.")
  }
}