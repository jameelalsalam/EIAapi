# test-funs.R

#TODO
# - Modify getEIAcat to use httr::modify_url instead of paste
# httr::modify_url("http://api.eia.gov/", path="category", query = )

# figure out how to parse the series ID names into metadata
# improve NA parsing
# improve the key handling as recommended by httr vignette
# implement getEIAseries -> series query
# implement getEIAupdate -> updates query
# implement tests
# do I still want the update and results caching features?
# do I want a version of the functions that returns a bigger object?

#


# set global env for testing getEIAcat:

id <- 2227112


cat_ids_of_interest <- c(
  2227289, #Energy-Related Carbon Dioxide Emissions by Sector and Source (million metric tons carbon dioxide, unless otherwise noted), United States - Ref case - AEO17
  2228110, # Energy-Related Carbon Dioxide Emissions by Sector and Source (million metric tons carbon dioxide, unless otherwise noted), United States - no CPP case - AEO17
  2227324, #Reference, macro
  2227430, #Reference, coal production by region and type

)

##########

#id <- 2228110 # a leaf node, with childseries
leaf <- getEIAcat(2228110)
leaf$childcategories
leaf$childseries
names(leaf$childcategories)
names(leaf$childseries)
str(leaf$childcategories)
str(leaf$childseries)

#id <- 2227112 # not a leaf node, with child categories
branch <- getEIAcat(2227112)
branch$childcategories
branch$childseries
names(branch$childcategories)
names(branch$childseries)
str(branch$childcategories)
str(branch$childseries)

resps <- map(c(2228110, 2227112), getEIAcat)
resps2 <- transpose(resps) %>%
  simplify_all() %>%
  as_tibble() %>%
  mutate(date = as.Date.POSIXct(date))

childcats <- resps2 %>%
  unnest(childcategories)

childsrs <- resps2 %>%
  unnest(childseries)

cats2 <- getEIAcats(ids = c(2227289, 2228110))
childsrs <- cats2 %>% unnest(childseries)

