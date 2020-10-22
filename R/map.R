#' @title
#'USA Map Data.
#'
#'@description 
#'This dataset contains necessary data to draw geographical map of the US.
#'
#'@format
#'A dataframe with 15,537 rows and 10 variables:
#'- **long**: Longitude
#'- **lat**:  Latitude
#'- **group**: Grouping geographical data to states
#'- **order**: Index
#'- **region**: USA States
#'- **subregion**: NA
#'- **X**: The value of the x axis for a state's centroid
#'- **Y**:The value of the y axis for a state's centroid
#'- **geom**: Simple feature geometry list-column (sfc)
#'- **abb**: State abbreviation
#'
#'@references 
#'H. Wickham. ggplot2: Elegant Graphics for Data Analysis. Springer-Verlag New York, 2016.
#'
#'@docType data
#'
#'@name usa_map
#'
#'@usage usa_map
#'
#'@examples 
#'library(ggplot2)
#'data(usa_map)
#'
#'# Creating a map of the US
#'ggplot(usa_map, aes(x = long, y = lat, group = group)) +
#'geom_polygon(color = "light grey",
#'             size = 0.25) +
#'  geom_text(aes(X, Y, 
#'                label = abb), 
#'            size = 3,
#'            color = "white",
#'            family = "sans") +
#'  theme_void()+
#'  theme(legend.position = "none")
#'
"usa_map"