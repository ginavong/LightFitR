# Setup

timevec = LightFitR::time_vector
timeMat = LightFitR::internal.makeTimes(timevec)

# Tests

test_that("It works", {
  expect_equal(LightFitR::internal.makeTimes(timevec), timeMat)
})
