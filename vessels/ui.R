
# packages ----------------------------------------------------------------

library(shiny)
library(leaflet)

shinyUI(fluidPage(
  

  titlePanel("Ships"),
  

  sidebarLayout(

# inputs ------------------------------------------------------------------
    sidebarPanel(
      selectInput(inputId = 'vessel_type', label = 'Vessel types', choices = vessel_types),
      selectInput(inputId = 'vessel_id', label = 'Vessel Id', choices = vessel_names)
    ),
# main panel --------------------------------------------------------------
    mainPanel(

# map ---------------------------------------------------------------------
      leafletOutput('map'),
      br(),

# comment -----------------------------------------------------------------
      htmlOutput('comment')

    )
  )
))
