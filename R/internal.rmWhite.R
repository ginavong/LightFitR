#' Remove empty white (5700k) LED from calculations
#'
#' @inheritParams internal.closestIntensities
#'
#' @returns Matrix of irradiances, with 9th row removed as we currently don't support 5700k LED channel
#' @export
#'
#' @examples
#'
#'
internal.rmWhite = function(irradiance_matrix){
  return(irradiance_matrix[-9,])
}
