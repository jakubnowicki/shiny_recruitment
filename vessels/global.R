library(readr)


# data -------------------------------------------------------------

ships <- read_csv("data/ships.csv") %>% rename_all(tolower)

# additional objects ------------------------------------------------------

# ship types for selectInput
vessel_types <- unique(ships$ship_type)

# ship names (all)
vessel_names <- unique(ships$shipname)


# modules -----------------------------------------------------------------

source('modules/dropdown.R')
