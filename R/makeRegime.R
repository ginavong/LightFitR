#' Create a regime (matrix) to program lights to achieve intended irradiances
#'
#' @description
#' This is a wrapper function that carries out multiple steps:
#'
#' 1. Calculate closest intensities
#'
#' 2. Predict the intensities to use to achieve the target irradiance (via a system of linear equations or non-negative least squares)
#'
#' 3. Tidy the intensities (rounding to integer, keep within the range of intensities that the lights can be set to)
#'
#' 4. Format the intensities and timestamps into a human-readable regime matrix
#'
#' @section NNLS vs SLE:
#'
#' NNLS and SLE largely predict the same intensities, except in outlier cases. The default is NNLS, but if your predicted intensities end up being very far off, try SLE.
#'
#'
#' @inheritParams internal.calibCombine
#' @inheritParams internal.makeTimes
#' @inheritParams internal.closestIntensities
#' @inheritParams nnls_intensities
#' @param method Use 'nnls' (non-negative least squares) or 'sle' (system of linear equations)
#'
#' @return Matrix with light regime needed to program the lights
#' @export
#'
#' @examples
#' # Prep variables
#' calib <- LightFitR::calibration
#' times <- LightFitR::time_vector
#' target_irradiance <- LightFitR::target_irradiance
#'
#' # Run function
#' makeRegime(times, target_irradiance, calib$led, calib$wavelength, calib$intensity, calib$irradiance)
#'
#'
makeRegime = function(timeVector_POSICx, irradiance_matrix, calibration_leds, calibration_wavelengths, calibration_intensities, calibration_irradiances, peaks=LightFitR::helio.dyna.leds$wavelength, method='nnls'){

  # Setup
  calibrationDf = internal.calibCombine(calibration_leds, calibration_wavelengths, calibration_intensities, calibration_irradiances)

  ## Checks

  internal.checkNAs(irradiance_matrix)
  LightFitR::helio.checkFormat(irradiance_matrix)
  helio.checkWhite(irradiance_matrix)

  LightFitR::checkRange(irradiance_matrix, calibrationDf$led, calibrationDf$wavelength, calibrationDf$intensity, calibrationDf$irradiance)

  # Times
  times = internal.makeTimes(timeVector_POSICx)

  # Calculate intensities
  closestIntensities = internal.closestIntensities(irradiance_matrix, calibrationDf, peaks=peaks)

  switch(method,

    'sle' = {intensities = LightFitR::sle_intensities(irradiance_matrix, closestIntensities, calibrationDf$led, calibrationDf$wavelength, calibrationDf$intensity, calibrationDf$irradiance, peaks=peaks)},

    'nnls' = {intensities = LightFitR::nnls_intensities(irradiance_matrix, closestIntensities, calibrationDf$led, calibrationDf$wavelength, calibrationDf$intensity, calibrationDf$irradiance, peaks=peaks)},

    stop("Input 'sle' or 'nnls' to method")
  )

  # Formatting

  ## Tidy up
  intensities = internal.tidyIntensities(intensities, calibration_intensities)

  # Make regime
  regime = as.matrix(rbind(times, intensities))
  rownames(regime) = c(rownames(times), LightFitR::helio.dyna.leds$name)
  colnames(regime) = colnames(times)

  return(regime)

}
