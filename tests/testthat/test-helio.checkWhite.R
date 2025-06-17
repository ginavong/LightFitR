# Setup

mat = matrix(data=sample(0:1000, size=8*120, replace=TRUE), nrow=8)
mat = rbind(mat, rep(0, 120))

# Tests
test_that("Pass when white off", {
  expect_true(LightFitR::helio.checkWhite(mat))
})

test_that("Warning when white is on", {
  mat2 = mat
  mat2[9, 20] = 50

  expect_warning(LightFitR::helio.checkWhite(mat2), 'Please ensure that the 9th white channel is set to 0 irradiance, as we currently cannot program it \n')

  expect_false(LightFitR::helio.checkWhite(mat2))
})
