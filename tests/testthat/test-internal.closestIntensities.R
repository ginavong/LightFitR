# Setup

target = LightFitR::target_irradiance
calib = LightFitR::calibration[, c(3,5,4,6)]

expected = LightFitR::example_closest
dimnames(expected) = NULL

# Tests

test_that("It works", {

  expect_warning(output <- LightFitR::internal.closestIntensities(target, calib),
  "We couldn't find exact matches with the peak wavelengths specified. Returning the closest wavelengths")

  expect_equal(output, expected)

})
