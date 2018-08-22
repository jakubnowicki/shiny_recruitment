# packages ----------------------------------------------------------------

library(shiny)
library(leaflet)
library(dplyr)

shinyServer(function(input, output, session) {
  

observe({
  callModule(dropdownRender, 'vessel_type', label = 'Vessel types', choices = vessel_types)
  callModule(dropdownRender, 'vessel_name', label = 'Vessel names', choices = vessel_names)
})
  
# map ---------------------------------------------------------------------

  output$map <- renderLeaflet(
      leaflet() %>%
        addTiles()
      )

# comment -----------------------------------------------------------------
  output$comment <- renderText(
    callModule(dropdownValue, id = 'vessel_type')
  )
    
})
