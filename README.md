
# covidexplorer
<!-- badges: start -->
<!-- badges: end -->

The goal of `covidexplorer` package is to provide users with insights of the spread of COVID-19 in the US through interactive plots and table. The package allows users to launch a Shiny app called USA COVID-19 Explorer. Through this app, users will be able to see the trend of COVID-19 infections across states in the US over time. In addition to selecting preferred stats in a specific date range, the app also allows users to choose daily or cumulative numbers of a number of variable of interests to be shown in the plots and table:

* Confirmed cases
* Deaths
* Test
* Recovered

## Installation

You can install the `covidexplorer` package with:

``` r
devtools::install_github("etc5523-2020/r-package-assessment-j-effendy")
```

## Example

This is how you can use the `covidexplorer` package to launch USA COVID-19 Explorer app:

``` r
library(covidexplorer)
# Launching the USA COVID-19 Explorer app
launch_app()
```

![USA COVID-19 Explorer app](man/figures/map.png)