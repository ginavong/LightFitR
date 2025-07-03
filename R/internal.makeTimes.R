#' Internal function. Takes vector of timepoints (POSICxt format) and converts into format readable by heliospectra.
#'
#' @param timeVector_POSIXct Vector of schedule timepoints in POSICxt format
#'
#' @import lubridate
#'
#' @return Matrix of times. Each row corresponds to hours, minutes, seconds
#' @keywords internal
#'
internal.makeTimes = function(timeVector_POSIXct){
  hours = sapply(timeVector_POSIXct, lubridate::hour)
  minutes = sapply(timeVector_POSIXct, lubridate::minute)
  seconds = sapply(timeVector_POSIXct, lubridate::second)


  timeVec = as.character(format(timeVector_POSIXct, '%H:%M:%S'))
  timeMat = rbind(timeVec, hours, minutes, seconds)
  rownames(timeMat) = c('time', 'hour', 'minute', 'second')
  colnames(timeMat) = timeVec

  return(timeMat)
}
