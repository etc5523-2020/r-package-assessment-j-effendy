library(shiny)
library(shinythemes)
library(dplyr)
library(tidyr)
library(stringr)
library(ggplot2)
library(plotly)
library(viridis)
library(DT)
library(here)
theme_set(theme_minimal())

# covid data --------------------------------------------------------------

load(file = here::here("data/covid.rda"))


# map data --------------------------------------------------------------

load(file = here::here("data/usa_map.rda"))
load(file = here::here("data/state_list.rda"))

# ui --------------------------------------------------------------

ui <- navbarPage("USA COVID-19 Explorer", theme = shinytheme("flatly"), collapsible = TRUE,
                 tabPanel("Plot",
                          div(plotlyOutput("map", height = "700px", width = "1300px"), align = "center"),
                          fluidRow(column(4,
                                          wellPanel(
                                              h4("User Control"),
                                              daterange("date"),
                                              selectInput("state", 
                                                          "Select a state",
                                                          choices = state_list$abb,
                                                          selected = "CA"),
                                              selectInput("variable", 
                                                          "Select variable of interest", 
                                                          choices = c("Confirmed Cases" = "confirmed", 
                                                                      "Deaths" = "deaths",
                                                                      "Tests" = "tests",
                                                                      "Recovered" = "recovered"),
                                                          selected = "Confirmed Cases"),
                                              tags$i("Note: you can also click at the abbreviations of the states on the map above to select your preferred state.")
                                              ),
                                          ),
                                   column(4,plotlyOutput("cumulative")
                                          ),
                                   column(4,plotlyOutput("daily")
                                          ),
                          )),
                 tabPanel("Table",
                          fluidRow(
                              column(4,
                                     daterange("date.t")),
                                     # dateRangeInput("date.t", 
                                     #                "Select date range",
                                     #                start = "2020-03-01",
                                     #                end = "2020-04-30",
                                     #                min = "2020-03-01",
                                     #                max = "2020-10-07")),
                              column(4,
                                     selectInput("stats", 
                                                 "Select statistics", 
                                                 choices = c("Daily" = "daily_",
                                                             "Cumulative" = "cumulative"),
                                                 selected = "Daily")),
                              column(4,
                                     selectInput("variable.t", 
                                                 "Select variable of interest", 
                                                 choices = c("Confirmed Cases" = "confirmed", 
                                                             "Deaths" = "deaths",
                                                             "Tests" = "tests",
                                                             "Recovered" = "recovered"),
                                                 selected = "Confirmed Cases"))
                          ),
                          hr(),
                          DTOutput("table")),
                 tabPanel("About",
                          tags$div(
                              tags$h4("Background"),
                              "According to ", 
                              tags$a(href="https://www.aapmr.org/news-publications/covid-19/covid-19-background-information", "American Academy of Physical Medicine and Rehabilitation"),
                              ", since the COVID-19 outbreak was first reported in China back in late 2019, it has spread to more than 70 countries globally, including the US.
                              The ",
                              tags$a(href = "https://www.cdc.gov/mmwr/volumes/69/wr/mm6922e1.htm", "Centers for Disease Control and Prevention"),
                              " reported that the virus reached the U.S. on Feburary 26th for the very first time. As of 8th of October, 2020, the total cases in the U.S. is 7,528,313.",
                              tags$h4("This App"),
                              "This Shiny app is developed by Jimmy Effendy, a post-graduate student from Monash University
                              as a part of Master of Business Analytics.",
                              tags$br(), tags$br(),
                              "The app aims to provide users with insights of the development of COVID-19 spread in the US.
                              The numbers of both cumulative and daily cases of a chosen parameter are provided in graphs and table.
                              A level of interactivity provided in the app allows users to see the table and graph based on desired parameters.",
                              tags$br(), tags$br(),
                              tags$h4("Data and Codes"),
                              "The data used in this app is obtained by utilizing COVID-19 R package developed by ",
                              tags$a(href="https://covid19datahub.io/", "Emanuele Guidotti. "), 
                              "This codes used to generate this app can be found on ",
                              tags$a(href="https://github.com/etc5523-2020/shiny-assessment-j-effendy", "Github."),
                              tags$br(), tags$br(),
                              tags$h4("Author"),
                              "Jimmy Effendy (jeff0001@student.monash.edu.au)"
                          ))
                 )


# server ------------------------------------------------------------------

server <- function(input, output, session) {
    
     observeEvent(event_data("plotly_click"), {
         click_df <- event_data("plotly_click")
         chosen_state <- dplyr::filter(state_list, X == round(click_df$x,0), Y == round(click_df$y,0)) %>%
             pull(abb)
         updateSelectInput(session, "state", selected = chosen_state)
     })
    
    output$map <- renderPlotly({
        
        #join filtered covid dataset to the usa map dataset
        usa_map <- usa_map %>% left_join(dplyr::filter(covid, 
                                                date == input$date[2],
                                                variable == str_c("daily_", input$variable)), 
                                         by = c("abb" = "key_alpha_2"))
        
        #plotting a covid map in USA
         p <- ggplot(usa_map, 
                     aes(long, 
                         lat,
                         group = group,
                         fill = value)) +
             scale_fill_viridis(alpha = 0.7,
                                option = "A") +
             geom_polygon(color = "light grey",
                          size = 0.25) +
             geom_polygon(color = "black",
                          size = 0.6,
                          data = filter(usa_map, abb == input$state)) +
             geom_text(aes(X, Y, 
                           label = abb), 
                       size = 3,
                       color = "black",
                       family = "sans") +
             theme(panel.grid = element_blank(),
                   axis.title = element_blank(),
                   axis.text = element_blank(),
                   axis.ticks = element_blank(),
                   aspect.ratio=1.62/3)
        
         ggplotly(p) %>% 
             config(displayModeBar = F)
    })
    
    #Plotting covid daily cases
    output$daily <- renderPlotly({
        daily_cases <- covid %>%
            dplyr::filter(key_alpha_2 == input$state,
                   date >= input$date[1] & date <= input$date[2],
                   variable == str_c("daily_", input$variable)) %>% 
            ggplot(aes(x = date,
                       y = value)) +
            geom_col(fill = "darkcyan",
                     alpha = 0.5) +
            xlab(str_to_title(str_c("daily ", input$variable))) +
            theme(panel.grid = element_blank(),
                  axis.title.y = element_blank(),
                  axis.ticks = element_blank())
        
        ggplotly(daily_cases, source = "B") %>% 
             config(displayModeBar = F)
    })
    
    #plotting cumulative covid cases
    output$cumulative <- renderPlotly({
        cumulative_cases <- covid %>%
            dplyr::filter(key_alpha_2 == input$state,
                   date >= input$date[1] & date <= input$date[2],
                   variable == input$variable) %>% 
            ggplot(aes(x = date,
                       y = value)) +
            geom_line(size = 1.5,
                      color = "darkcyan",
                      alpha = 0.5) +
            xlab(str_to_title(str_c("cumulative ", input$variable))) +
            theme(panel.grid = element_blank(),
                  axis.title.y = element_blank(),
                  axis.ticks = element_blank())
        
        ggplotly(cumulative_cases, source = "B") %>%
            config(displayModeBar = F)
    })
    
    output$table = renderDataTable(
        covid %>% dplyr::filter(date == input$date.t[2],
                         variable == str_c(str_replace(input$stats, "cumulative", ""), 
                                           input$variable.t)) %>%
        ungroup() %>% 
        select(administrative_area_level_2, value),
               option = list(pageLength = 15),
               colnames = c("State", "Number of Cases")
    )
}

# Run the application 
shinyApp(ui = ui, server = server)
