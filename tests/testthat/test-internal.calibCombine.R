# Setup

calib = LightFitR::calibration
expected = calib[, c(3, 5, 4, 6)]
rownames(expected) = 1:nrow(expected)


# Tests

test_that("It works", {
  output = LightFitR:::internal.calibCombine(calib$led, calib$wavelength, calib$intensity, calib$irradiance)
  expect_equal(output, expected)
})

test_that("Warning when uneven vectors", {

  warnings = capture_warnings(LightFitR:::internal.calibCombine(calib$led, calib$wavelength, calib$intensity, calib$irradiance[1:50]))

  expect_equal(warnings,
                 c('Please check your calibration data is formatted correctly: it should be in longform and you should input the relevant columns as vectors.', "number of rows of result is not a multiple of vector length (arg 4)"))

})

test_that("Removes 'nm' and converts to integers", {
  strings = stringr::str_c(calib$wavelength, 'nm')

  expect_warning(output <- LightFitR:::internal.calibCombine(calib$led, strings, calib$intensity, calib$irradiance),
                 'Some of the values are non-numeric. They have been coerced to numeric by removing letters. Please check your calibration data as NAs may have been introduced. \n')

  expect_equal(output, expected)

})

test_that("Warning when there is NA", {
  na_vec = calib$irradiance
  na_vec[3] = NA

  expect_warning(LightFitR:::internal.calibCombine(calib$led, calib$wavelength, calib$intensity, na_vec), 'NAs introduced by coercion')
})

