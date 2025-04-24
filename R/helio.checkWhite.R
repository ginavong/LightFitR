#' Check that the 9th white channel is set to 0
#'
#' We currently cannot support programming the white (5700k) LED channel.
#'
#' @param irradiance_matrix Matrix of intended irradiances. rows = leds and columns = events
#'
#' @return Boolean: TRUE = pass, FALSE = fail
#' @export
#'
#' @examples
#' helio.checkWhite(LightFitR::target_irradiance)
#'
helio.checkWhite = function(irradiance_matrix){
  if(unique(irradiance_matrix[9,]) ==0){
    return(TRUE)
  }
  else{
    warning('Please ensure that the 9th white channel is set to 0 irradiance, as we currently cannot program it \n')
    return(FALSE)
  }
}
