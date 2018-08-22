
# packages ----------------------------------------------------------------

library(shiny)
library(leaflet)

shinyUI(fluidPage(
  

  titlePanel("Ships"),
  

  sidebarLayout(

# inputs ------------------------------------------------------------------
    sidebarPanel(
      dropdownUI(id = 'vessel_type'),
      dropdownUI(id = 'vessel_name')
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
