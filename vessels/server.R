# packages ----------------------------------------------------------------

library(shiny)
library(leaflet)
library(dplyr)

shinyServer(function(input, output) {
   
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
