# accumulate_dirs.R


#############
# No need to re-run above, but can re-run below
#############

cats_we_asked        <- c(AEO17_cats$category_id)
child_cats_in_dir    <- unnest(AEO17_cats, childcategories)$child_category_id
child_cats_not_asked <- setdiff(child_cats_in_dir, cats_we_asked)

# 8200 categories in the directory. But we are gradually querying the series

#first time:  191 asked, 7860 not asked
#second time: 451 asked, 7600 not asked
#third time:  551 asked, 7500 not asked
#fourth time: 751 asked, 7300 not asked
#fifth time:  851 asked, 7200 not asked

next_chunk  <- child_cats_not_asked[1:100]
chunk_calls <- getEIAcats(next_chunk)

AEO17_cats <- bind_rows(AEO17_cats, chunk_calls)
devtools::use_data(AEO17_cats, overwrite = TRUE)
