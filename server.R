server <- function(input, output, session) {
   output$my_map <- renderLeaflet({
    
    if(input$cov4=="Population"){
    
     pal <- colorFactor(
      palette = "Reds",
      domain = shape1$Population)
    
  
    #legend.title <- paste(paste0(input$cov4, " ("), round(min(x, na.rm=T), 2), " - ", round(max(x, na.rm=T), 2), ")", sep="")
    
    leaflet(shape1) %>%
      addTiles(group = "OSM (default)") %>%
      addProviderTiles("Stamen.Toner", group = "Toner") %>%
      addProviderTiles("Stamen.TonerLite", group = "Toner Lite") %>%
      addProviderTiles("CartoDB.Positron", group = "CartoDB") %>%
     
      addPolygons(stroke = FALSE, smoothFactor = 0.2, fillOpacity = 0.8, color = ~pal(x)) %>%
      
      addLegend("bottomright", pal = pal, values = ~Population,  labFormat = labelFormat(suffix = ""), opacity = 0.3) %>%
     
      addLayersControl(baseGroups = c("OSM (default)", "Toner", "Toner Lite", "CartoDB"),options = layersControlOptions(collapsed = FALSE))
    
    }
  
    })
    
 
}
shinyApp(ui = ui, server = server)
