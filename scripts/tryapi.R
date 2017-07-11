

library("EIAdata")
library("tidyverse")

tlcats  <- getCatEIA(key=key)
tlcats[["Sub_Categories"]]

aeocats <- getCatEIA(key=key, cat = 964164)
aeocats[["Sub_Categories"]]

aeo17cats <- getCatEIA(key=key, cat = 2227112)
aeo17cats[["Sub_Categories"]]

aeo17nocpp <- getCatEIA(key=key, cat = 2227114)
aeo17nocpp[["Sub_Categories"]]

crosscats <- getCatEIA(key=key, cat = 2227943)
crosscats[["Sub_Categories"]] %>% View()

energycons_sector_and_source <- getCatEIA(key=key, cat = 2227961)
energycons_sector_and_source[["Series_IDs"]] %>% View()

emissions <- getCatEIA(key=key, cat = 2227981)
emissions[["Series_IDs"]] %>% View()
