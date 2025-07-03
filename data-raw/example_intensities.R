## code to prepare `example_intensities` dataset goes here

# Setup
target = LightFitR::target_irradiance
calib = LightFitR::calibration[, c(3,5,4,6)]

closest = LightFitR:::internal.closestIntensities(target, calib)

example_intensities = LightFitR::nnls_intensities(target, closest, calib$led, calib$wavelength, calib$intensity, calib$irradiance, peaks=LightFitR::helio.dyna.leds$wavelength)

# Export

usethis::use_data(example_intensities, overwrite = TRUE)
