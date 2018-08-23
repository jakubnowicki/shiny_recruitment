
# packages ----------------------------------------------------------------

library(shiny)
library(leaflet)

shinyUI(fluidPage(
  

  titlePanel("Ships"),
  

  sidebarLayout(

# inputs ------------------------------------------------------------------
sidebarPanel(
  dropdownUI(id = 'vessel_type'),
  dropdownUI(id = 'vessel_name'),
  # time between observations
  fluidRow(
    column(
      width = 6,
      checkboxInput(inputId = 'time_limit', label = 'Limit time between observations?')
    ),
    column(
      width = 6,
      numericInput(
        inputId = 'limit_seconds',
        label = 'Value (seconds)',
        min = 0,
        step = 1,
        value = 240
      )
    )
  )
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
