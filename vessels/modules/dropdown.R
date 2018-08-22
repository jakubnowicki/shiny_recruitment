
# dropdown UI -------------------------------------------------------------

dropdownUI <- function(id, label, choices) {
  
  ns <- NS(id)
  
  selectInput(inputId = ns('dropdown'), label = label, choices = choices)
}


# dropdown - value extraction ---------------------------------------------

dropdownValue <- function(input, output, session) {
  dropdown_val <- reactive({
    input$dropdown
  })
  
  return(dropdown_val())
}