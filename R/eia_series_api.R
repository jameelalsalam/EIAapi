#EIA series API

#' Get an data series(es) from the API. Up to 100 can be retrieved at a time.
#'
#' @param id vector of character strings with EIA series IDs
#' @param return flag for type of return object: simple, content, raw, or full.
#' @importFrom magrittr %>%
#' @import dplyr
#' @import purrr
#' @export
getEIAseries <- function(ids, return = "simple") {

  if (length(ids) < 0) {
    stop("No ID values supplied")
  } else if (length(ids) > 100) {
    stop("Maximum of 100 series IDs can be retrieved")
  } else if(!is.character(ids)) {
    stop("IDS must be supplied as a character vector")
  }

  stopifnot(length(ids) > 0)
  stopifnot(length(ids) < 101)

 if (is.na(Sys.getenv("EIA_API_KEY"))) {
    stop("Please set environment variable \"EIA_API_KEY\" to use this function") }

  url <- .url_EIA_series(ids)

  if(length(ids)<10) {
    resp <- httr::GET(url)
  } else {
    resp <- httr::POST(url)
  }

  #stop if server returned an error of some kind
  httr::stop_for_status(resp)

  content <- httr::content(resp, "text", encoding = "UTF-8")
  parsed <- jsonlite::fromJSON(content, simplifyVector = TRUE)

  series <- parsed$series %>%
    mutate(data = map(data, .f = ~tibble(year = as.numeric(.[,1]), value = as.numeric(.[,2]) )))

  series
}


.url_EIA_series <- function(ids, out="json") {
  ids <- paste(ids, collapse = ";")
  url <- paste("http://api.eia.gov/series?api_key=", Sys.getenv("EIA_API_KEY"), "&series_id=", ids, sep="" )

  url
}

