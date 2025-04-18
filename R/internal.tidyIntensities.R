#' Title
#'
#' @param intensities_matrix Matrix of predicted intensities
#' @inheritparam internal.calibCombine
#'
#' @return Maxtrix of intensities which are integers and capped at the maximum possible intensity
#' @export
#'
#' @examples
internal.tidyIntensities = function(intensities_matrix, calibration_intensities){

  # Round, since the lights only accept integers
  internalMat = round(intensities_matrix)

  # Cap the intensities at maximum intensity of calibration
  maxAllowable = max(calibration_intensities)

  overAllowable = which(internalMat > maxAllowable)
  internalMat[overAllowable] = maxAllowable

  # Set negatives to 0
  under0 = which(internalMat < 0)
  internalMat[under0] = 0

  # Return
  return(internalMat)
}
