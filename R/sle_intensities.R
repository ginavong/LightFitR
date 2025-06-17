#' Use a system of linear equations to calculate intensities
#'
#' @inheritParams internal.calibCombine
#' @inheritParams internal.closestIntensities
#' @inheritParams nnls_intensities
#'
#' @importFrom graphics image
#'
#' @return Matrix of intensities to set the lights to, to achieve desired irradiances
#' @export
#'
#' @examples
#' #' # Prep variables
#' target_irradiance = LightFitR::target_irradiance
#' closest = LightFitR::example_closest
#' calib = LightFitR::calibration
#'
#' # Run the function
#' sle_intensities(target_irradiance, closest,  calib$led, calib$wavelength, calib$intensity, calib$irradiance)
#'
sle_intensities = function(irradiance_matrix, closest_intensities, calibration_leds, calibration_wavelengths, calibration_intensities, calibration_irradiances, peaks=LightFitR::helio.dyna.leds$wavelength){

  # Setup

  calib = internal.calibCombine(calibration_leds, calibration_wavelengths, calibration_intensities, calibration_irradiances)
  peakWavelengths = internal.closestWavelength(calib$wavelength, peaks)

  ## Checks
  LightFitR::helio.checkFormat(irradiance_matrix)
  helio.checkWhite(irradiance_matrix)
  internal.checkNAs(irradiance_matrix)
  LightFitR::helio.checkFormat(closest_intensities)
  helio.checkWhite(closest_intensities)
  internal.checkNAs(closest_intensities)
  LightFitR::checkRange(irradiance_matrix, calib$led, calib$wavelength, calib$intensity, calib$irradiance)

  ## Remove white LED
  irradMat = internal.rmWhite(irradiance_matrix)
  closestMat = internal.rmWhite(closest_intensities)

  # LM

  intensities_mat = sapply(1:ncol(closestMat), function(i){

    # Make a dataframe with only the info we need for this event
    tempDf = data.frame(led=LightFitR::helio.dyna.leds[-9, 'wavelength'], closest=closestMat[,i], intended=irradMat[,i])

    # Make a matrix of irradiances to input into nnls function
    mat = sapply(1:nrow(tempDf), function(j){
      criteria = (calib$led == tempDf[j, 'led']) & (calib$intensity == tempDf[j, 'closest']) & (calib$wavelength %in% peakWavelengths) # We want the irradiances (from calib data) of each LED at the intensity where it is closest to the intended irradiance
      calib[criteria, 'irradiance']
    })

    ## Solve linear equations
    coef = solve(mat, tempDf[,'intended'])

    ## Calculate intensities
    intensities = coef * tempDf[,'closest']

  })

  # Add white LED back
  intensities_mat = internal.addWhiteZero(intensities_mat)

  graphics::image(intensities_mat, main='predicted intensities')

  return(intensities_mat)
}
