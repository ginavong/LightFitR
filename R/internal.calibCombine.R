#' Internal function to make a calibration dataframe from user-supplied vectors of calibration data
#'
#' @param calibration_leds A numeric vector of LED values from calibration, mapping to intensities and irradiances (i.e. the same length)
#' @param calibration_wavelengths A numeric vector of wavelengths from calibration, corresponding to intensities and irradiances
#' @param calibration_intensities A numeric vector of intensities (heliospectra units) from calibration
#' @param calibration_irradiances A numeric vector of measured irradiances (any units, as long as it is consistently used) from calibration
#'
#' @import stringr
#'
#' @return Correctly formatted dataframe of calibration data, for use in other functions
#'
#' @examples
#' calib <- LightFitR::calibration
#' internal.calibCombine(calib$LED, calib$wavelength, calib$intensity, calib$irradiance)
#'
internal.calibCombine = function(calibration_leds, calibration_wavelengths, calibration_intensities, calibration_irradiances){

  calibList = list(calibration_leds, calibration_wavelengths, calibration_intensities, calibration_irradiances)

  # Check data
  lengths = sapply(calibList, length) #All vectors should be the same length
  if(length(unique(lengths)) != 1){
    warning('Please check your calibration data is formatted correctly: it should be in longform and you should input the relevant columns as vectors.')
  }

  # Remove any letters (e.g. 'nm') from leds, ensuring they are numeric for next steps
  calibListNumeric = lapply(calibList, function(l){
    if(class(l) == 'numeric' | class(l) == 'integer'){
      l
    }
    else{
      warning('Some of the values are non-numeric. They have been coerced to numeric by removing letters. Please check your calibration data as NAs may have been introduced. \n')
      l = as.numeric(stringr::str_remove_all(l, '[:alpha:]'))
      l
    }
  })

  # Make the dataframe
  calibData = as.data.frame(do.call(cbind, calibListNumeric))
  colnames(calibData) = c('led', 'wavelength', 'intensity', 'irradiance')

  if(sum(is.na(calibData)) != 0){warning('NAs introduced by coercion')}

  return(calibData)
}
