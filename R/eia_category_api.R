# EIA Category Query API Access
# This file contains components of the API call, a raw API call, various approaches for simplifying the return information, recursively calling the API, etc

#' @importFrom magrittr %>%
magrittr::`%>%`
# I think this means I won't have to importFrom each time to use it.


#' Get information on categories from the EIA API
#'
#' @param id string EIA category ID
#' @importFrom magrittr %>%
#' @export
getEIAcat <- function(id) {

  if (is.na(key)) {
    stop("Please set variable \"key\" in the global environment with your API key") }

  url <- .url_EIA_cat(id)

  resp <- httr::GET(url)

  #stop if server returned an error of some kind
  httr::stop_for_status(resp)

  content <- httr::content(resp, "text", encoding = "UTF-8")
  parsed <- jsonlite::fromJSON(content, simplifyVector = TRUE)

  #parse childcategories, create empty df if necessary
  if(length(parsed[["category"]][["childcategories"]]) > 1) {
    childcategories <- parsed[["category"]][["childcategories"]]
    names(childcategories) <- c("child_category_id", "child_category_name")
  } else {
    childcategories <- tibble::tibble(
      child_category_id = integer(),
      child_category_name = character()
    )
  }

  #parse childseries, create empty df if necessary
  if(length(parsed[["category"]][["childseries"]]) > 1) {
    childseries <- parsed[["category"]][["childseries"]]
    names(childseries) <- c("child_series_id", "child_series_name", "child_series_f", "child_series_units", "child_series_updated")
  } else {
    childseries <- tibble::tibble(
      child_series_id = character(),
      child_series_name = character(),
      child_series_f = character(),
      child_series_units = character(),
      child_series_updated = character()
    )
  }

  #pull out the category data we really want
  cat_df <- list(parsed) %>% {
    list(
      category_id = purrr::map_chr(., c("category", "category_id")),
      category_name = purrr::map_chr(., c("category", "name")),
      parent_category_id = purrr::map_chr(., c("category", "parent_category_id")),
      childcategories = childcategories,
      childseries = childseries,
      date = resp[["date"]]
    )
  }

  #pull out the response data that we want
  # resp_simple <- resp[c(1, 2, 3, 9, 10)]

  #return an S3 object
  # structure(
  #   list(
  #     content = cat_df,
  #     response = resp_simple
  #   ),
  #   class = "EIA_api"
  # )
  cat_df
}

.url_EIA_cat <- function(id, out="json") {
  url <- paste("http://api.eia.gov/category?api_key=", key, "&category_id=", id, sep="" )

  url
}

#' Get information on multiple EIA categories
#' @param ids a vector of category IDs. Will result in an API call for each.
#' @export
getEIAcats <- function(ids) {

  resps <- purrr::map(ids, getEIAcat)

  resps2 <- purrr::transpose(resps)
  resps3 <- purrr::simplify_all(resps2)
  resps4 <- tibble::as_tibble(resps3)
  resps5 <- dplyr::mutate(resps4, date = as.Date.POSIXct(date))

  resps5
}




#' Get EIA data series
#'
#' @param ID a vector of series IDs (up to 100)
#' @param key your API key as a string
#' @export
EIA_series_api <- function(ID, key) {

}

#' Update a directory of category API requests
#' Will check whether information is old or updated prior to sending a request

#' @param dir a dataframe which is a directory of category IDs to update
#' @export
update_cat_dir <- function(dir) {

}

#' Expand a directory of category API requests
#' Will check for flag to update

#' @param dir a dataframe which is a directory of category IDs to update
#' @export
update_series_dir <- function(dir) {

}
