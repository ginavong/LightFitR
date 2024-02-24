#' Internal function. Find the intensities corresponding to the closest irradiance match between intended and calibration.
#'
#' @param irradiance_matrix Matrix of intended irradiances. rows = leds and columns = events
#' @param nEvents Number of events in schedule.
#' @inheritParams internal.calibCombine
#' @param peaks Vector of length 8 or 9. Containing wavelengths at which each LED peaks.
#'
#' @return Matrix of closest intensities, in the same format as `irradiance_matrix`
#' @export
#'
#' @examples
internal.closestIntensities = function(irradiance_matrix, calibration_leds, calibration_wavelengths, calibration_intensities, calibration_irradiances, peaks=helio.dyna.leds$wavelength){

  # Setup
  calib = LightFitR::internal.calibCombine(calibration_leds, calibration_wavelengths, calibration_intensities, calibration_irradiances)

  ## Checks
  LightFitR::helio.checkFormat(irradiance_matrix)
  LightFitR::helio.checkWhite(irradiance_matrix)
  LightFitR::checkRange(irradiance_matrix, calib$led, calib$wavelength, calib$intensity, calib$irradiance)

  # Calculate closest
  closestIntensityMatrix = sapply(1:(nrow(helio.dyna.leds)-1), function(a){ # Go through each LED and calculate the closest we can get with calibration data
    intendedSubset = c(as.numeric(irradiance_matrix[a,]))

    criteria = (calib$led == LightFitR::helio.dyna.leds[a, 'wavelength']) & (round(calib$wavelength) == round(peaks[a]))
    calibSubset = calib[criteria,] #subset calib data based on the led in question, and teh wavelength at the peak

    # Closest intensity for each timepoint
    closestIntensity = sapply(intendedSubset, function(i){

      if(i==0){closest=0}
      else{
        closestIrradiance = which.min(abs(calibSubset$irradiance - i))[1] #Which is the 1st closest to intended irradiance?
        closest = calibSubset[closest, 'intensity'] #Get the corresponding intensity
      }

      closest
    })

    closestIntensity
  })

  closestIntensityMatrix = t(closestIntensityMatrix)
  return(closestIntensityMatrix)
}
