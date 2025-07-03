# Setup
rm(list=ls())

# Tests
test_that("It works", {

  example_file <- system.file("extdata", "example_json_schedule.txt", package = "LightFitR", mustWork = TRUE)

  expect_no_error(LightFitR::read.helio_json(example_file))
})
