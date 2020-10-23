filter_input <- function(data){
  data %>%
    dplyr::filter(key_alpha_2 == input$state,
                  date >= input$date[1] & date <= input$date[2])
}

covid_filter <- function(data, stats){
  if(stats == "cumulative"){
    dplyr::filter_input(data) %>% 
      dplyr::filter(variable == input$variable)
  } else if (stats == "daily"){
    filter_input(data) %>% 
      dplyr::filter(variable == str_c("daily_", input$variable))
  } else {
    print("Invalid value passed to stats argument. Please enter 'cumulative' or 'daily'.")
  }
}