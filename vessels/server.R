# packages ----------------------------------------------------------------

library(shiny)
library(leaflet)
library(dplyr)
library(geosphere)

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
  # select ship
  ship <- ships %>% filter(SHIPNAME == callModule(dropdownValue, id = 'vessel_name')) %>% 
    select(LON, LAT,DATETIME)
  
  max_dist <- 0
  coordinates <- NULL
  
  # get max distance
  for (i in 1:(nrow(ship) - 1)) {
    tmp <- distm(ship[i,1:2], ship[i+1,1:2])
    if (tmp > max_dist) {
      max_dist <- tmp
      coordinates <- ship[i:(i+1),1:2]
      time <- ship[i+1,'DATETIME'] - ship[i,'DATETIME']
    }
  }
  
  list(distance = max_dist, coordinates = coordinates, time = time)
})  
  
  
# map ---------------------------------------------------------------------

  output$map <- renderLeaflet(
      leaflet(data = selected_vessel()$coordinates) %>%
        addTiles() %>% 
        addMarkers()
      )

# comment -----------------------------------------------------------------
  output$comment <- renderText(
    paste0(callModule(dropdownValue, id = 'vessel_name'),': ',
           round(selected_vessel()$distance,0), ' meters')
  )
    
})
