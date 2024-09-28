#' Format regime_matrix for csv output that Heliospectra lights can parse
#'
#' @inheritParams write.helioSchedule
#'
#' @return Matrix formatted for Heliospectra lights csv
#' @export
#'
#' @examples

helio.csv_schedule = function(regime_matrix, filename){
  LightFitR::helio.checkFormat(regime_matrix[-c(1:4),])

  # Header
  header = matrix(nrow=3, ncol=10)
  header[1,] = c('Schedule.exported.from', filename, rep('', 8))
  header[2,] = c('Lamp timestamp', format(Sys.time(), "%Y-%m-%d %H:%M:%S"), rep('', 8))
  header[3,] = c('', helio.dyna.leds$name)

  # Schedule
  schedule = t(regime_matrix[-c(2:4),])

  return(rbind(header, schedule))
}
