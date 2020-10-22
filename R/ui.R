#'@import shiny
daterange <- function(id, label = "Select date range",
                      start = "2020-03-01", end = "2020-04-30", 
                      min = "2020-03-01", max = "2020-10-07") {
  ns <- shiny::NS(id)
  
  stopifnot(
    start <= end,
    start >= min,
    end <= max,
    nchar(id) > 0,
    length(id) > 0
  )
  
  shiny::dateRangeInput(id, 
                 label,
                 start = start,
                 end = end,
                 min = min,
                 max = max)
}