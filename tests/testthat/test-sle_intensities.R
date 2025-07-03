# Setup
rm(list=ls())

target = LightFitR::target_irradiance
closest = LightFitR::example_closest
calib = LightFitR::calibration
peaks = LightFitR:::internal.closestWavelength(calib$wavelength, LightFitR::helio.dyna.leds$wavelength)

# Tests

test_that("it works", {
  output = LightFitR::sle_intensities(target, closest, calib$led, calib$wavelength, calib$intensity, calib$irradiance,
                                       peaks=peaks)

  expect_equal(dim(output), dim(target))
})
