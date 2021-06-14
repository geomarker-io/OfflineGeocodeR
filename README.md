# OfflineGeocodeR

`OfflineGeocodeR` is an experimental R package that provides a wrapper around calling the Docker container
[`degauss/geocoder:3.0`](https://github.com/degauss-org/geocoder) in order to geocode addresses from R without using
the internet. 

## Installing

Install with:

``` r
remotes::install_github('cole-brokamp/OfflineGeocodeR')
```

You must also have Docker installed and available on your system. The first time `geocode()` is called, it will download the container from [DockerHub](https://hub.docker.com/repository/docker/degauss/geocoder).
