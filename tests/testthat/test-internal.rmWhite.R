# Setup

mat = matrix(data=sample(0:1000, replace=TRUE, size=9*10), nrow=9)
expected = mat[1:8,]

# Test

test_that("It works", {
  expect_equal(LightFitR:::internal.rmWhite(mat), expected)
})
