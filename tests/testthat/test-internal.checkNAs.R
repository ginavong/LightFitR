# Setup

mat = matrix(data=sample(0:1000, size=8*120, replace=TRUE), nrow=8)
mat = rbind(mat, rep(0, 120))

mat_nas = mat
mat_nas[7,19] = NA

# Tests

test_that("It passes", {
  expect_true(LightFitR::internal.checkNAs(mat))
})

test_that("It warns",{
  expect_warning(output <- LightFitR::internal.checkNAs(mat_nas), 'Your matrix contains NAs. The heliospectra cannot accept NAs as input \n')

  expect_false(output)
})
