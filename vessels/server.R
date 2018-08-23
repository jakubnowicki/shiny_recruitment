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
      names <- ships %>% filter(ship_type == type) %>%
        pull(SHIPNAME) %>% unique()
      callModule(dropdownRender, 'vessel_name', label = 'Vessel names', choices = names)
    }
  })


# ship data filter --------------------------------------------------------
  # get name of the selected vessel
  name <- reactiveVal(NULL)
  
  observe({
    name(callModule(dropdownValue, id = 'vessel_name'))
  })
  
  selected_vessel <- reactive({
    req(!is.null(name()))
  
    # select ship
    ship <- ships %>% filter(SHIPNAME == name()) %>% 
      select(LON, LAT,DATETIME)
    
    max_dist <- 0
    coordinates <- NULL
  
    # get max distance
    
    ## time between observations limited
    if (input$time_limit == TRUE) {
      limit <- as.difftime(input$limit_seconds, units = 'secs')
      for (i in 1:(nrow(ship) - 1)) {
        tmp_dist <- geosphere::distm(ship[i,1:2], ship[i+1,1:2])
        tmp_time <- ship[i+1,'DATETIME'] - ship[i,'DATETIME']
        if (tmp_dist >= max_dist && (abs(tmp_time$DATETIME) < limit)) {
          max_dist <- tmp_dist
          coordinates <- ship[i:(i+1),1:2]
        }
      }
    } else {
    ## or not
      for (i in 1:(nrow(ship) - 1)) {
        tmp_dist <- geosphere::distm(ship[i,1:2], ship[i+1,1:2])
        if (tmp_dist >= max_dist) {
          max_dist <- tmp_dist
          coordinates <- ship[i:(i+1),1:2]
        }
      }
    }
    
    list(distance = max_dist, coordinates = coordinates, time = time)
})    
    
  
# map ---------------------------------------------------------------------

  output$map <- renderLeaflet({
    
    validate(need(selected_vessel()$coordinates, 'No observations'))
    
      leaflet(data = selected_vessel()$coordinates) %>%
        addTiles() %>% 
        addMarkers()
      })

# comment -----------------------------------------------------------------
  output$comment <- renderText({
    paste0('Sailed distance: ',
           round(selected_vessel()$distance,0), ' meters')
  })
    
})
