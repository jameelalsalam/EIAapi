


#' Get information on categories from the EIA API
#'
#' @param category ID string
#' @param key your API key as a string
#' @export
EIA_cat_api <- function(cat, key = NA) {

  if(is.na(key)) {key <- EIA_key}
  url <- paste("http://api.eia.gov/category?api_key=", key, "&category_id=", cat, "&out=json", sep="" )
  url2 <-

  print(url, url2)
  # resp <- httr::GET(url)
  resp
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

#' @export
update_cat_dir <- function(dir) {

}

#' Expand a directory of category API requests
#' Will check for flag to update

#' @export
update_series_dir <- function(dir) {

}
