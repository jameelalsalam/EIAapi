# parsing series names

# Some examples:

#from accumulate_dirs:
childsrs <- AEO17_cats %>% unnest(childseries) %>%
  distinct(child_series_id, .keep_all = TRUE)

srs <- childsrs %>%
  select(starts_with("child_")) %>%

  separate(child_series_id,
           into = c("pub", "pub_year", "scenario", "variable", "freq_2"),
           sep="\\.",
           remove = FALSE) %>%

  separate(variable,
           into = c("topic", "v2", "sector", "v4",
                    "fuel", "fuel_sub?", "region", "units_2"))


srs %>% distinct(scenario)
srs %>% distinct(pub)
srs %>% distinct(pub_year)
srs %>% distinct(topic) %>% View()
srs %>% distinct(sector) %>% View()

srs %>%
  filter(topic == "EMI",
         units_2 == "MILLMTCO2EQ") %>%
  distinct(child_series_id, .keep_all = TRUE) %>%
  View()
