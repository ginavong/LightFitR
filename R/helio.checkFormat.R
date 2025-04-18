#' Check formatting of the heliospectra matrices
#'
#' @param check_matrix Matrix to be checked. Rows correspond to LEDs and columns are events / timepoints.
#'
#' @return Vector of booleans: TRUE = pass, FALSE = fail
#' @export
#'
#' @examples
#'
helio.checkFormat = function(check_matrix){ # Check that the regime matrix is formatted correctly

  # Check nEvents
  nEventsMessage = paste('Please check matrix formatting. ncol of matrix cannot exceed', helio.eventLimit, ', as the heliospectra cannot handle more. \n', sep=' ')
  if(helio.eventLimit < ncol(check_matrix)){
    warning(nEventsMessage)
    nEvents = FALSE}
  else{nEvents = TRUE}

  # Check number of LEDs
  ledMessage = paste('Please check that your rows correspond with all ', nrow(helio.dyna.leds), ' LEDs in the heliospectra DYNA: ', paste(helio.dyna.leds$name, collapse=', '), sep='')
  if(nrow(check_matrix) != nrow(helio.dyna.leds)){
    warning(ledMessage)
    leds = FALSE}
  else{leds = TRUE}

  return(c(nEvents, leds))
}
