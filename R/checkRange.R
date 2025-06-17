#' Check that the intended irradiances are acheivable by the lights
#'
#' @param intended_irradiance Matrix of intended irradiances to be checked. Each row corresponds to an LED channel.
#' @inheritParams internal.calibCombine
#'
#' @return Boolean: TRUE = pass, FALSE = fail
#' @export
#'
#' @examples
#' calib <- LightFitR::calibration
#' irradiances <- LightFitR::target_irradiance
#' checkRange(irradiances, calib$led, calib$wavelength, calib$intensity, calib$irradiance)
#'
checkRange = function(intended_irradiance, calibration_leds, calibration_wavelengths, calibration_intensities, calibration_irradiances){

  # Make calibration dataframe
  calib = LightFitR::internal.calibCombine(calibration_leds, calibration_wavelengths, calibration_intensities, calibration_irradiances)

  # Go through each LED and check the ranges line up. Outputs vector of booleans
  rangeCheck = sapply(1:nrow(LightFitR::helio.dyna.leds), function(i){

    # Get parameters
    led = LightFitR::helio.dyna.leds[i, 'wavelength']
    channel = LightFitR::helio.dyna.leds[i, 'name']
    calibRange = range(calib[calib$led==led, 'irradiance'])
    matrixRange = range(intended_irradiance[i,])

    # Check the range fits
    ledRangeCheck = (calibRange[1] <= matrixRange[1]) & (calibRange[2] > matrixRange[2])

    if(ledRangeCheck == FALSE){
      warn = 'Please check that your intended irradiances are achievable by the heliospectra.'
      warning(paste(warn, 'Your intended range for', channel, 'channel seems to be outside the achievable range. \n', sep=' '))
    }

    ledRangeCheck
  })

  # Do all of the ranges fit?
  if(all(rangeCheck)){
    message(paste('Ranges fall within irradiances acheivable by heliospectra:', all(rangeCheck), sep=' '))
    # if they are a mix of Ts and Fs, that will have been handled bY earlier warning ^
    return(TRUE)
  } else{return(FALSE)}
}
