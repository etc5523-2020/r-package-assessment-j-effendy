#' Function to create date range input for Shiny UI with specified parameters 
#' 
#' @param id Input ID that will be used to access the value chosen by users.
#' @param label The label for the date range input control.
#' @param start The initial start date. Either a Date object, or a string in yyyy-mm-dd format.
#' @param end The initial end date. Either a Date object, or a string in yyyy-mm-dd format.
#' @param min The minimum allowed date. Either a Date object, or a string in yyyy-mm-dd format.
#' @param max The maximum allowed date. Either a Date object, or a string in yyyy-mm-dd format.
#' @return `daterange` returns A Date vector of length 2.
#' @export
#' @name daterange
#' @references Winston Chang, Joe Cheng, JJ Allaire, Yihui Xie and Jonathan McPherson (2020). shiny: Web Application Framework for R. R
#' package version 1.5.0. https://CRAN.R-project.org/package=shiny

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