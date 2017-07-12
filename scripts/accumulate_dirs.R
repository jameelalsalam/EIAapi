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
#sixth time:  951 asked, 7100 not asked

next_chunk  <- sample(child_cats_not_asked, size = 100)
chunk_calls <- getEIAcats(next_chunk)

AEO17_cats <- bind_rows(AEO17_cats, chunk_calls)
devtools::use_data(AEO17_cats, overwrite = TRUE)

##########################

# STEO_start <- c(829714, 829718, 1039914, 1039986, 1039987, 829791, 1039917, 1039918, 829724, 1039995, 714755)
# STEO_chunk_start <- getEIAcats(STEO_start)
# STEO_cats <- STEO_chunk_start

##########

STEO_we_asked             <- c(STEO_cats$category_id) %>% unique(.)
STEO_child_cats_in_dir    <- unnest(STEO_cats, childcategories)$child_category_id %>% unique(.)
STEO_child_cats_not_asked <- setdiff(STEO_child_cats_in_dir, STEO_we_asked)

STEO_next_chunk <- STEO_child_cats_not_asked[1:50]
STEO_chunk_calls <- getEIAcats(STEO_next_chunk)

STEO_cats <- bind_rows(STEO_cats, STEO_chunk_calls)
devtools::use_data(STEO_cats, overwrite = TRUE)

################

# MER_start <- c(714756, 714805, 717234, 711224)
# MER_chunk_start <- getEIAcats(MER_start)
# MER_cats <- MER_chunk_start

###########

MER_we_asked             <- c(MER_cats$category_id) %>% unique(.)
MER_child_cats_in_dir    <- unnest(MER_cats, childcategories)$child_category_id %>% unique(.)
MER_child_cats_not_asked <- setdiff(MER_child_cats_in_dir, MER_we_asked)

MER_next_chunk <- MER_child_cats_not_asked[1:50]
MER_chunk_calls <- getEIAcats(MER_next_chunk)

MER_cats <- bind_rows(MER_cats, MER_chunk_calls)
devtools::use_data(MER_cats, overwrite = TRUE)

#################

# Intl_start <- c(2134384)
# Intl_chunk_start <- getEIAcats(Intl_start)
# Intl_cats <- Intl_chunk_start
#
# ###########
#
# Intl_we_asked             <- c(Intl_cats$category_id) %>% unique(.)
# Intl_child_cats_in_dir    <- unnest(Intl_cats, childcategories)$child_category_id %>% unique(.)
# Intl_child_cats_not_asked <- setdiff(Intl_child_cats_in_dir, Intl_we_asked)
#
# Intl_next_chunk <- Intl_child_cats_not_asked[1:40]
# Intl_chunk_calls <- getEIAcats(Intl_next_chunk)
#
# Intl_cats <- bind_rows(Intl_cats, Intl_chunk_calls)
# devtools::use_data(Intl_cats, overwrite = TRUE)

#################
