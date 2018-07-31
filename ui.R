####libraries used
library(haven)
library(Hmisc)
library(ggplot2)
library(gridExtra)
library(grid)
library(data.table)
library(shiny)
library(rsconnect)
library(shinythemes)
library(RColorBrewer)
library(ggpubr)
library(png)
library(shinydashboard)
library(leaflet)
library(scales)
library(lattice)
library(dplyr)
library(magrittr)
library(rgdal)


####Datasets
#the CSV with the SIMD data
data <-read.csv("data(simd).csv")

data2<-data[complete.cases(data),]

ColAttr <- function(x, attrC, ifIsNull) {
  # Returns column attribute named in attrC, if present, else isNullC.
  atr <- attr(x, attrC, exact = TRUE)
  atr <- if (is.null(atr)) {ifIsNull} else {atr}
  atr
}
AtribLst <- function(df, attrC, isNullC){
  # Returns list of values of the col attribute attrC, if present, else isNullC
  lapply(df, ColAttr, attrC=attrC, ifIsNull=isNullC)
}
variables <- AtribLst(data, attrC="labels", isNullC=NA)

#for the map
mapDat<-readOGR("~/R Shiny Apps","SG_SIMD_2016X1") 
class(mapDat)
names(mapDat)


###UI code
ui <-fluidPage(
  tags$head(
    tags$style(HTML("
                    @import url('https://fonts.googleapis.com/css?family=Neucha|Cabin+Sketch');
                    
                    h1 {
                    font-family: 'Neucha', cursive;
                    font-weight: 500;
                    line-height: 1.1;
                    color: #212529;
                    }
                    
                    "))
    ),
#the above code makes the fond change!!
  
  headerPanel("Scottish Index of Multiple Depravation"),
  
  sidebarPanel(
    # Map with choices of council areas, variables, and colors to change in the interactive map.
              
           fluidRow( width = 7,
            
                  tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
                               
                      
                          sidebarPanel(
                                    selectInput("council", "Choose Council Area",
                                                choices = c("Aberdeen City","Aberdeenshire", "Angus", "Argyll and Bute", "City of Edinburgh",
                                                            "Clackmannanshire", "Dumfries and Galloway", "Dundee City", "East Aryshire",
                                                            "East Dumbartonshire", "East Lothian", "East Renfrewshire", "Falkirk", "Fife",
                                                            "Glasgow City", "Highland", "Inverclyde", "Midlothian", "Moray", "Na h-Eileanan an Iar",
                                                            "North Ayrshire", "North Lanarkshire", "Orkney Islands", "Perth and Kinross", 
                                                            "Renfrewshire", "Scottish Borders", "Shetland Islands", "South Aryshire", "South Lanarkshire",
                                                            "Stirling", "Wesr Dumbartonshire", "West Lothian")),
                                    
                                    selectInput("cov4", "Variables:", choices = names(data2)),
                                    
                                    selectInput(inputId = "bincolor1",
                                                label = "Color Palette of the Legend",
                                                choices = colors(),
                                          selected = "grey")),
            
          checkboxInput("legend", "Show legend", TRUE),
          
          
          leafletOutput("my_map")# width = 850 , height = 700),
            
                  )
                
              )
                

          )
