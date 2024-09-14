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

  # Cap the intensities at 1000
  maxAllowable = max(calibration_intensities)

  if(max(internalMat)> maxAllowable){
    overAllowable = which(internalMat > maxAllowable)
    internalMat[overAllowable] = maxAllowable
  }

  return(internalMat)
}
