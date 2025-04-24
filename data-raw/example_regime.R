## code to prepare `example_regime` dataset goes here

# Import data
timeVec = LightFitR::time_vector
intensities = LightFitR::example_intensities

# Put together into regime

timeMat = LightFitR::internal.makeTimes(timeVec)

example_regime = rbind(timeMat, intensities)

usethis::use_data(example_regime, overwrite = TRUE)
