# Setup

rm(list=ls())

timevec = LightFitR::time_vector
calib = LightFitR::calibration
target = LightFitR::target_irradiance

peaks = LightFitR:::internal.closestWavelength(calib$wavelength, LightFitR::helio.dyna.leds$wavelength)

expected = LightFitR::example_regime

# Tests

test_that("It works", {
  output = LightFitR::makeRegime(timevec, target, calib$led, calib$wavelength, calib$intensity, calib$irradiance, peaks=peaks)

  expect_equal(output, expected)
})

test_that("Errors when wrong method is provided", {
  expect_error(LightFitR::makeRegime(timevec, target,
                                     calib$led, calib$wavelength, calib$intensity, calib$irradiance,
                                     peaks=peaks, method='fake'))
})

