test_that("geocode", {
  expect_equal(
    geocode(c('3333 Burnet Ave Cincinnati OH 45229',
              '222 East Central Parkway Cincinnati OH 45202')),
    list(structure(list(street = "Burnet Ave", zip = "45229", city = "Cincinnati",
                        state = "OH", lat = 39.141224, lon = -84.500448,
                        score = 0.949, prenum = "", number = "3333", precision = "range"), class = "data.frame", row.names = 1L),
         structure(list(street = "E Central Pkwy", zip = "45202",
                        city = "Cincinnati", state = "OH", lat = 39.107766, lon = -84.511008,
                        score = 0.934, prenum = "", number = "222",
                        precision = "range"), class = "data.frame", row.names = 1L))
  )
})
