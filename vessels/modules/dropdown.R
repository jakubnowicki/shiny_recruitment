
# dropdown UI -------------------------------------------------------------

dropdownUI <- function(id, label, choices) {
  
  ns <- NS(id)
  uiOutput(ns('dropdown'))
}


# dropdown render UI ------------------------------------------------------

dropdownRender <- function(input, output, session, label, choices) {
  ns <- session$ns
  output$dropdown <- renderUI({
    selectInput(inputId = ns('drop'), label = label, choices = choices)
  })
}

# dropdown - value extraction ---------------------------------------------

dropdownValue <- function(input, output, session) {
  dropdown_val <- reactive({
    input$drop
  })
  
  return(dropdown_val())
}


