nnls_intensities = function(closest_intensities, calibration_leds, calibration_wavelengths, calibration_intensities, calibration_irradiances, peaks=helio.dyna.leds$wavelength){

  # Setup

  calib = internal.calibCombine(calibration_leds, calibration_wavelengths, calibration_intensities, calibration_irradiances)

  # NNLS

}
