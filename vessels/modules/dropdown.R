dropdownUI <- function(id, label, choices) {
  selectInput(inputId = 'dropdown', label = label, choices = choices)
}