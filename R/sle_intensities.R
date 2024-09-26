#' Use a system of linear equations to calculate intensities
#'
#' @inheritParams internal.calibCombine
#' @inheritParams internal.closestIntensities
#' @inheritParams nnls_intensities
#'
#' @return
#' @export
#'
#' @examples
sle_intensities = function(irradiance_matrix, closest_intensities, calibration_leds, calibration_wavelengths, calibration_intensities, calibration_irradiances, peaks=helio.dyna.leds$wavelength){

  # Setup

  calib = LightFitR::internal.calibCombine(calibration_leds, calibration_wavelengths, calibration_intensities, calibration_irradiances)

  ## Checks
  LightFitR::helio.checkFormat(irradiance_matrix)
  LightFitR::helio.checkWhite(irradiance_matrix)
  LightFitR::internal.checkNAs(irradiance_matrix)
  #LightFitR::helio.checkFormat(closest_intensities)
  #LightFitR::helio.checkWhite(closest_intensities)
  LightFitR::internal.checkNAs(closest_intensities)
  LightFitR::checkRange(irradiance_matrix, calib$led, calib$wavelength, calib$intensity, calib$irradiance)

  # LM

  intensities_mat = sapply(1:ncol(closest_intensities), function(i){

    # Make a dataframe with only the info we need for this event
    tempDf = data.frame(led=LightFitR::helio.dyna.leds[-9, 'wavelength'], closest=closest_intensities[,i], intended=irradiance_matrix[-9,i])

    # Make a matrix of irradiances to input into nnls function
    mat = sapply(1:nrow(tempDf), function(j){
      criteria = (calib$led == tempDf[j, 'led']) & (calib$intensity == tempDf[j, 'closest']) & (calib$wavelength %in% peaks) # We want the irradiances (from calib data) of each LED at the intensity where it is closest to the intended irradiance
      calib[criteria, 'irradiance']
    })

    ## Solve linear equations
    coef = solve(mat, tempDf[,'intended'])

    ## Calculate intensities
    intensities = coef * tempDf[,'closest']

  })

  image(intensities_mat, main='predicted intensities')

  return(intensities_mat)
}
