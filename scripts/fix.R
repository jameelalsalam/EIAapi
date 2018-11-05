# fix

map_chr(AEO17_cats$childseries, ~typeof(.$child_series_id))

childseries_new <- AEO17_cats$childseries %>%
  map(., ~dplyr::mutate(., child_series_id = as.character(child_series_id)))

AEO17_new <- AEO17_cats %>% {
  tibble(
    category_id = .$"category_id",
    category_name = .$"category_name",
    parent_category_id = .$"parent_category_id",
    childcategories = .$"childcategories",
    childseries = childseries_new,
    date = .$date
  )
}

AEO17_cats$childseries[[1]] %>%
  dplyr::mutate(child_series_id = as.character(child_series_id))

all.equal(AEO17_cats$childseries[400:500], AEO17_new$childseries[400:500])
AEO17_cats <- AEO17_new
