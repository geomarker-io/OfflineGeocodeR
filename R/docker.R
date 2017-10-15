#' find the docker executable
#'
#' @export
find_docker_cmd <- function() {
  docker_cmd <- Sys.which('docker')
  if (length(docker_cmd) == 0) stop(paste('\n','Docker command not found. ','\n',
                                          'Please install docker: ','\n',
                                          'https://www.docker.com/products/overview#/install_the_platform'))
  docker_check <- suppressWarnings(system2(docker_cmd,'ps',stderr=TRUE,stdout=TRUE))
  if(!is.null(attr(docker_check,'status'))) stop(paste0('Cannot connect to the Docker daemon. ',
                                                        'Is the docker daemon running on this host?'))
  return(docker_cmd)
}

#' start geocoding container
#'
#' @param image_name name of geocoding image; can be used to specify the version
#'   i.e. \code{degauss/geocoder_slim:2.4}; defaults to
#'   \code{degauss/geocoder_slim:latest}
#'
#' @export
start_geocoder_container <- function(image_name = 'degauss/geocoder_slim') {
  message('starting geocoding container...')
  docker_cmd <- find_docker_cmd()
  system2(docker_cmd,
          args = c('run','-it','-d','--name gs',
                   '--entrypoint /bin/bash',
                   image_name))
  message('loading address range database...')
  invisible(gc_call('3333 Burnet Ave Cincinnati OH 45229'))
}

#' stop geocoding container
#'
#' @export
stop_geocoder_container <- function() {
  docker_cmd <- find_docker_cmd()
  message('stopping geocoding container...')
  system2(docker_cmd,
          args = c('stop','gs'))
  system2(docker_cmd,
          args = c('rm','gs'))
}

#' call a running geocoding container to geocode an address
#'
#' This is used internally by \code{geocode()} and normally should not be called directly.
#'
#' @param address a string; see vignette for best practices and examples
#'
#' @export
#' @importFrom jsonlite fromJSON
gc_call <- function(address) {
  docker_cmd <- find_docker_cmd()
  docker_out <- system2(docker_cmd,
                        args = c('exec','gs',
                                 'ruby','/root/geocoder/geocode.rb',
                                 shQuote(address)),
                        stderr=TRUE,stdout=TRUE)
  jsonlite::fromJSON(docker_out)
}
