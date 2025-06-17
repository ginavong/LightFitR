# Setup

test_mat = matrix(data=sample(0:1000, size=8*120, replace=TRUE), nrow=8)

finished_mat = rbind(test_mat, rep(0, nrow(test_mat)))

# Test
test_that("It makes the desired matrix", {
  expect_equal(LightFitR::internal.addWhiteZero(test_mat), finished_mat)
})
