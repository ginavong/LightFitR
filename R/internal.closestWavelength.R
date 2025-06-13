#' Internal function. Find the closest wavelengths to the stated peaks
#'
#' @param wavelength_vec Vector of wavelengths that we have spectrometry data for
#' @param peak_wavelengths Vector of stated LED peaks
#'
#' @returns Vector of wavelengths closest to the stated peaks
#'
#' @examples
#' calib_wavelengths = LightFitR::calibration$wavelength
#' peaks = LightFitR::helio.dyna.leds$wavelength
#'
#' internal.closestWavelength(calib_wavelengths, peaks)
#'
internal.closestWavelength = function(wavelength_vec, peak_wavelengths){

  if(all(peak_wavelengths %in% unique(wavelength_vec))){
    return(peak_wavelengths)
  } else{

    warning("We couldn't find exact matches with the peak wavelengths specified. Returning the closest wavelengths")

    wavelengths = unique(wavelength_vec)

    closestWavelengths = sapply(peak_wavelengths[-9], function(p){
      loc = which.min(abs(wavelengths - p))
      wavelengths[loc]
    })

    return(closestWavelengths)

  }
}
