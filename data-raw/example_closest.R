## code to prepare `example_closest` dataset goes here

# Import data
target_irradiance = LightFitR::target_irradiance
calib = LightFitR::calibration
calib = LightFitR::internal.calibCombine(calib$led, calib$wavelength, calib$intensity, calib$irradiance)

# Make closest intensities
example_closest = internal.closestIntensities(target_irradiance, calib)

# Format
rownames(example_closest) = LightFitR::helio.dyna.leds$name

# Export

usethis::use_data(example_closest, overwrite = TRUE)
