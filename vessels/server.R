# packages ----------------------------------------------------------------

library(shiny)
library(leaflet)
library(dplyr)

shinyServer(function(input, output, session) {
  

# render vessel types input -----------------------------------------------

  observe({
    callModule(dropdownRender, 'vessel_type', label = 'Vessel types', choices = vessel_types)
  })
  

# render and update vessel name input ------------------------------------------------

  observe({
    type <- callModule(dropdownValue, id = 'vessel_type')
    if (!is.null(type)) {
      print(type)
      names <- ships %>% filter(ship_type == type) %>%
        pull(SHIPNAME) %>% unique()
      print(names)
      callModule(dropdownRender, 'vessel_name', label = 'Vessel names', choices = names)
    }
  })


# ship data filter --------------------------------------------------------

selected_vessel <- reactive({
  tmp <- ships %>% filter(SHIPNAME == callModule(dropdownValue, id = 'vessel_name')) %>% 
    select(LON, LAT)
  
  tmp[1:2,]
})  
  
  
# map ---------------------------------------------------------------------

  output$map <- renderLeaflet(
      leaflet(data = selected_vessel()) %>%
        addTiles() %>% 
        addMarkers()
      )

# comment -----------------------------------------------------------------
  output$comment <- renderText(
    callModule(dropdownValue, id = 'vessel_name')
  )
    
})
