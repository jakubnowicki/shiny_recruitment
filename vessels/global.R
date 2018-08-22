library(readr)


# data -------------------------------------------------------------

ships <- read_csv("data/ships.csv")

# additional objects ------------------------------------------------------

# ship types for selectInput
vessel_types <- unique(ships$ship_type)

# ship names (all)
vessel_names <- unique(ships$SHIPNAME)


# modules -----------------------------------------------------------------

source('modules/dropdown.R')
