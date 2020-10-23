#' @title 
#' USA COVID-19 Explorer Launcher
#' 
#' @description 
#' To launch the USA COVID-19 Explorer Shiny app.
#' 
#' 
#' 
#' 
#' @export
launch_app <- function(){
  
  appDir <- system.file("app", "app.R", package = "covidexplorer")
  
  shiny::runApp(appDir)
}