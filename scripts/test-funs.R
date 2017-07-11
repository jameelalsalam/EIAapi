# test-funs.R

# API url for AEO17 category query: http://api.eia.gov/category/?api_key=YOUR_API_KEY_HERE&category_id=2227112

httr::modify_url("http://api.eia.gov/", path="category", query = )


catAEO17 <- getEIAcat(id=2227112) # right now yields an s3 object
catAEO17$content

subcats <- catAEO17$content$childcategories[[1]][["child_category_id"]][1:2] %>%
  map(., getEIAcat)

typeof(catAEO17$content)
typeof(subcats[[1]]$content)

cats <- bind_rows(catAEO17$content, map(subcats, "content"))

cats_unnest <- cats %>% unnest()

setdiff(cats_unnest$child_category_id, cats_unnest$category_id)

subcats_not_yet <- setdiff(cats_unnest$child_category_id, cats_unnest$category_id)

subcats_EIA <- map(subcats_not_yet, getEIAcat)
cats_EIA <- bind_rows(map(subcats_EIA, "content"))

cats2 <- bind_rows(cats, cats_EIA)
cats2u <- cats2 %>% unnest()

# set global env for testing getEIAcat:

id <- 2227112


cat_ids_of_interest <- c(
  2227289, #Energy-Related Carbon Dioxide Emissions by Sector and Source (million metric tons carbon dioxide, unless otherwise noted), United States - Ref case - AEO17
  2228110 # Energy-Related Carbon Dioxide Emissions by Sector and Source (million metric tons carbon dioxide, unless otherwise noted), United States - no CPP case - AEO17
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

