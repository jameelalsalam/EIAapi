# trying more

sctrs <- c("ALL", "RES", "COM", "IND", "TRA", "OTH")
elec_cons <- glue::glue("ELEC.SALES.US-{sctrs}.A")

elec <- getEIAseries(elec_cons)

elec$sector <- sctrs

str(elec)

elec_df <- elec %>%
  select(series_id, name, sector, units, data) %>%
  unnest()

View(elec_df)
