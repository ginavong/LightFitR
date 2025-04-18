#' Create a regime (matrix) to program lights to achieve intended irradiances
#'
#' @inheritParams internal.calibCombine
#' @inheritParams internal.makeTimes
#' @inheritParams internal.closestIntensities
#' @interitParams nnls_intensities
#' @param method Use 'nnls' (non-negative least squares) or 'sle' (system of linear equations)
#'
#' @return Matrix with light regime needed to program the lights
#' @export
#'
#' @examples
makeRegime = function(timeVector_POSICx, irradiance_matrix, calibration_leds, calibration_wavelengths, calibration_intensities, calibration_irradiances, peaks=LightFitR::helio.dyna.leds$wavelength, method='nnls'){

  # Setup
  calibrationDf = LightFitR::internal.calibCombine(calibration_leds, calibration_wavelengths, calibration_intensities, calibration_irradiances)

  ## Checks

  LightFitR::internal.checkNAs(irradiance_matrix)
  LightFitR::helio.checkFormat(irradiance_matrix)
  LightFitR::helio.checkWhite(irradiance_matrix)

  LightFitR::checkRange(irradiance_matrix, calibrationDf$led, calibrationDf$wavelength, calibrationDf$intensity, calibrationDf$irradiance)

  # Times
  times = LightFitR::internal.makeTimes(timeVector_POSICx)

  # Calculate intensities
  closestIntensities = LightFitR::internal.closestIntensities(irradiance_matrix, calibrationDf, peaks=peaks)

  switch(method,

    'sle' = {intensities = LightFitR::sle_intensities(irradiance_matrix, closestIntensities, calibrationDf$led, calibrationDf$wavelength, calibrationDf$intensity, calibrationDf$irradiance, peaks=peaks)},

    'nnls' = {intensities = LightFitR::nnls_intensities(irradiance_matrix, closestIntensities, calibrationDf$led, calibrationDf$wavelength, calibrationDf$intensity, calibrationDf$irradiance, peaks=peaks)},

    stop("Input 'sle' or 'nnls' to method")
  )

  # Formatting

  ## Tidy up
  intensities = LightFitR::internal.tidyIntensities(intensities, calibration_intensities)

  # Make regime
  regime = as.matrix(rbind(times, intensities))
  rownames(regime) = c(rownames(times), LightFitR::helio.dyna.leds$name)
  colnames(regime) = colnames(times)

  return(regime)

}
