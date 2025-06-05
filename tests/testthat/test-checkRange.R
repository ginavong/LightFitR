# Universal variables
calib = LightFitR::calibration
target = LightFitR::target_irradiance

# Tests

test_that("ranges pass check", {

  intended1 = target

  check = LightFitR::checkRange(intended1, calib$led, calib$wavelength, calib$intensity, calib$irradiance)

  expect_true(check)
})

test_that("Check fails when target irradiance is too high", {

  # Generated intended irradiance
  max_620 = max(calib[calib$led=='620', 'irradiance'])
  intended2 = target
  intended2[6, 8] = max_620 * 2 # Set 1 event over the limit for 620nm channel

  # Run test
  expect_warning(LightFitR::checkRange(intended2, calib$led, calib$wavelength, calib$intensity, calib$irradiance), "Please check that your intended irradiances are achievable by the heliospectra. Your intended range for 620nm channel seems to be outside the achievable range.")
  expect_false(LightFitR::checkRange(intended2, calib$led, calib$wavelength, calib$intensity, calib$irradiance))
})

test_that("Check fails when multiple channels are too out of range", {

  # Generate intended irradiance
  max_620 = max(calib[calib$led=='620', 'irradiance'])
  max_400 = max(calib[calib$led=='400', 'irradiance'])
  min_450 = min(calib[calib$led=='450', 'irradiance'])
  intended3 = target
  intended3[6,8] = max_620 * 2
  intended3[2,2] = max_400*2
  intended3[4,4] = min_450 *2

  # Run test

  expect_false(LightFitR::checkRange(intended3, calib$led, calib$wavelength, calib$intensity, calib$irradiance))

  expect_warning(LightFitR::checkRange(intended3, calib$led, calib$wavelength, calib$intensity, calib$irradiance),
                 "Please check that your intended irradiances are achievable by the heliospectra. Your intended range for 620nm channel seems to be outside the achievable range.")
  expect_warning(LightFitR::checkRange(intended3, calib$led, calib$wavelength, calib$intensity, calib$irradiance),
                 "Please check that your intended irradiances are achievable by the heliospectra. Your intended range for 400nm channel seems to be outside the achievable range.")
  expect_warning(LightFitR::checkRange(intended3, calib$led, calib$wavelength, calib$intensity, calib$irradiance),
                 "Please check that your intended irradiances are achievable by the heliospectra. Your intended range for 450nm channel seems to be outside the achievable range.")
# })
