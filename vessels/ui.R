
# packages ----------------------------------------------------------------

library(shiny)
library(leaflet)

shinyUI(fluidPage(
  

  titlePanel("Ships"),
  

  sidebarLayout(

# inputs ------------------------------------------------------------------
    sidebarPanel(
      dropdownUI(id = 'vessel_type', label = 'Vessel types', choices = vessel_types),
      dropdownUI(id = 'vessel_id', label = 'Vessel name', choices = vessel_names)
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
