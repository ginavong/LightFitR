#' Check formatting of the heliospectra matrices
#'
#' Heliospectra DYNA matrices should have 9 rows (1 for each LED channel) and up to 150 columns (max number of events that Heliospectra DYNA can store)
#'
#' @param check_matrix Matrix to be checked. Rows correspond to LEDs and columns are events / timepoints.
#'
#' @return Vector of booleans: TRUE = pass, FALSE = fail
#' @export
#'
#' @examples
#' matrix_to_check <- LightFitR::target_irradiance
#' helio.checkFormat(target_irradiance)
#'
helio.checkFormat = function(check_matrix){ # Check that the regime matrix is formatted correctly

  # Check nEvents
  nEventsMessage = paste('Please check matrix formatting. ncol of matrix cannot exceed', LightFitR::helio.eventLimit, ', as the heliospectra cannot handle more. \n', sep=' ')
  if(LightFitR::helio.eventLimit < ncol(check_matrix)){
    warning(nEventsMessage)
    nEvents = FALSE}
  else{nEvents = TRUE}

  # Check number of LEDs
  ledMessage = paste('Please check that your rows correspond with all ', nrow(LightFitR::helio.dyna.leds), ' LEDs in the heliospectra DYNA: ', paste(LightFitR::helio.dyna.leds$name, collapse=', '), sep='')
  if(nrow(check_matrix) != nrow(LightFitR::helio.dyna.leds)){
    warning(ledMessage)
    leds = FALSE}
  else{leds = TRUE}

  return(c(nEvents, leds))
}
