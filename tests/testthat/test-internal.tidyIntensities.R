# Setup
rm(list=ls())

sample_space = seq(from=0, to=1050, by=0.5)
mat = matrix(sample(sample_space, size=9*10, replace=TRUE), nrow=9)

calib = LightFitR::calibration

output = LightFitR:::internal.tidyIntensities(mat, calib$intensity)

# Tests

test_that("It does not contain decimals", {
  char = as.character(output)
  dec = any(stringr::str_detect(char, '\\.'))
  expect_false(dec)
})

test_that("It caps things", {
  expect_gte(min(output), 0)
  expect_lte(max(output), 1000)
})
