library(readr)


# data -------------------------------------------------------------

ships <- read_csv("data/ships.csv")

# additional objects ------------------------------------------------------

# ship types for selectInput
vessel_types <- unique(ships$ship_type)


# modules -----------------------------------------------------------------

source('modules/dropdown.R')
