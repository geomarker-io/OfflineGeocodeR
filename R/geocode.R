#' geocode
#'
#' To prevent errors and optimize accuracy, please remove non alphanumeric
#' characters from address strings prior to geocoding. In general, address
#' cleaning is outside the scope of this package and should be completed prior
#' to geocoding.
#'
#' By default, geocoding results will be cached in a local folder named
#' \code{geocoding_cache}.  See help for \code{CB::mappp} to change these
#' defaults.
#'
#' @param addresses a list or vector addresses
#' @param ... additional arguments passed to \code{CB::mappp}; set options for
#'   cache here
#'
#' @return list of geocoding results with one address per element; some
#'   addresses may return more than one geocoding result if there is a tie among
#'   the best matches
#' @export
geocode <- function(addresses, ...){
  start_geocoder_container()
  on.exit(stop_geocoder_container())
  message('now geocoding...')
  CB::mappp(addresses, gc_call, parallel=FALSE, cache=TRUE, cache.name='geocoding_cache', ...)
}
