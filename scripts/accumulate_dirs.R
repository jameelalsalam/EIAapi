# accumulate_dirs.R

EIA_cats <- EIA_cats %>%
  distinct(category_id, .keep_all = TRUE)

########## from here:

cats_asked        <- c(EIA_cats$category_id)
cats_in_dir       <- unique(unnest(EIA_cats, childcategories)$child_category_id)
cats_not_asked    <- setdiff(cats_in_dir, cats_asked)

next_chunk  <- sample(cats_not_asked, size = 400)
chunk_calls <- getEIAcats(next_chunk)

EIA_cats <- bind_rows(EIA_cats, chunk_calls)
devtools::use_data(EIA_cats, overwrite = TRUE)

