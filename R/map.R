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
#'- **X**: The value of the x coordinate for a state's centroid
#'- **Y**:The value of the y coordinate for a state's centroid
#'- **geom**: Simple feature geometry list-column (sfc)
#'- **abb**: State abbreviation
#'
#'
#'@docType data
#'
#'@name usa_map
#'
#'@usage usa_map
#'
#'@references 
#'H. Wickham. ggplot2: Elegant Graphics for Data Analysis. Springer-Verlag New York, 2016.
#'Pebesma, E., 2018. Simple Features for R: Standardized Support for Spatial Vector Data. The R Journal 10 (1), 439-446, 
#'https://doi.org/10.32614/RJ-2018-009
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

#' @title
#'USA State List.
#'
#'@description 
#'This dataset contains a list of the centroids coordinates of each states in the US.
#'
#'@format
#'A dataframe with 49 rows and 3 variables:
#'- **X**: The value of the x axis for a state's centroid
#'- **Y**:The value of the y axis for a state's centroid
#'- **abb**: State abbreviation
#'
#'
#'@docType data
#'
#'@name state_list
#'
#'@usage state_list
#'
#'#'@references 
#'Pebesma, E., 2018. Simple Features for R: Standardized Support for Spatial Vector Data. The R Journal 10 (1), 439-446,
#'https://doi.org/10.32614/RJ-2018-009
#'
"state_list"