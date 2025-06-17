# Setup

peaks = LightFitR::helio.dyna.leds$wavelength

wavelengths = LightFitR::calibration$wavelength

closest = LightFitR::internal.closestWavelength(wavelengths, peaks)

# Tests

test_that("It works when wavelengths==peaks", {
  expect_equal(LightFitR::internal.closestWavelength(peaks, peaks), peaks)
})

test_that("It warns when wavelengths != peaks", {

  expect_warning(output <- LightFitR::internal.closestWavelength(wavelengths, peaks),
                 "We couldn't find exact matches with the peak wavelengths specified. Returning the closest wavelengths")

  expect_equal(output, closest)
})
