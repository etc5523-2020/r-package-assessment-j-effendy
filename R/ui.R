#'@import shiny
daterange <- function(id, label = "Select date range") {
  ns <- shiny::NS(id)
  shiny::dateRangeInput(id, 
                 label,
                 start = "2020-03-01",
                 end = "2020-04-30",
                 min = "2020-03-01",
                 max = "2020-10-07")
}