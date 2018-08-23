# read and limit data

ships_light <- read_csv("vessels/data/ships.csv",guess_max = 3000000) %>% select(LON, LAT,DATETIME, SHIPNAME, ship_type)

# write lighter file

write_csv(ships_light, path = 'vessels/data/ships_light.csv')
