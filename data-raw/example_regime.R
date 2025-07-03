## code to prepare `example_regime` dataset goes here

# Import data
timeVec = LightFitR::time_vector
target = LightFitR::target_irradiance
calib = LightFitR::calibration

# Put together into regime

example_regime = LightFitR::makeRegime(timeVec, target, calib$led, calib$wavelength, calib$intensity, calib$irradiance)

usethis::use_data(example_regime, overwrite = TRUE)
