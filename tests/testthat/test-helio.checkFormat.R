# Setup

mat = matrix(data=sample(0:1000, size=9*160, replace=TRUE), nrow=9)

# Tests

test_that("Formatting passes", {
  check = LightFitR::helio.checkFormat(mat[, 1:120])
  expect_equal(check, c(TRUE, TRUE))
})

test_that("Warning with too many events", {

  expect_warning(LightFitR::helio.checkFormat(mat), paste('Please check matrix formatting. ncol of matrix cannot exceed', LightFitR::helio.eventLimit, ', as the heliospectra cannot handle more. \n', sep=' '))

  expect_equal(LightFitR::helio.checkFormat(mat), c(FALSE, TRUE))

})

test_that("Warning with not enough channels", {

  mat2 = mat[1:8, 1:150]

  expect_warning(LightFitR::helio.checkFormat(mat2), paste('Please check that your rows correspond with all ', nrow(LightFitR::helio.dyna.leds), ' LEDs in the heliospectra DYNA: ', paste(LightFitR::helio.dyna.leds$name, collapse=', '), sep=''))

  expect_equal(LightFitR::helio.checkFormat(mat2), c(TRUE, FALSE))
})

test_that("Warning with too many events and not enough channels", {

  mat2 = mat[1:8,]

  expect_warning(LightFitR::helio.checkFormat(mat2), paste('Please check that your rows correspond with all ', nrow(LightFitR::helio.dyna.leds), ' LEDs in the heliospectra DYNA: ', paste(LightFitR::helio.dyna.leds$name, collapse=', '), sep=''))

  expect_warning(LightFitR::helio.checkFormat(mat2), paste('Please check matrix formatting. ncol of matrix cannot exceed', LightFitR::helio.eventLimit, ', as the heliospectra cannot handle more. \n', sep=' '))

  expect_equal(LightFitR::helio.checkFormat(mat2), c(FALSE, FALSE))
})

test_that("Warning with too many channels", {
  mat2 = rbind(mat, mat)
  mat2 = mat2[, 1:120]

  expect_warning(LightFitR::helio.checkFormat(mat2), paste('Please check that your rows correspond with all ', nrow(LightFitR::helio.dyna.leds), ' LEDs in the heliospectra DYNA: ', paste(LightFitR::helio.dyna.leds$name, collapse=', '), sep=''))

  expect_equal(LightFitR::helio.checkFormat(mat2), c(TRUE, FALSE))
})
