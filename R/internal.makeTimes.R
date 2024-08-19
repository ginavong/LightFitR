#' Internal function. Takes vector of timepoints (POSICxt format) and converts into format readable by heliospectra.
#'
#' @param timeVector_POSICxt Vector of schedule timepoints in POSICxt format
#'
#' @return Matrix of times. Each row corresponds to hours, minutes, seconds
#' @export
#'
#' @examples
internal.makeTimes = function(timeVector_POSICxt){
  hours = sapply(timeVector_POSICxt, lubridate::hour)
  minutes = sapply(timeVector_POSICxt, lubridate::minute)
  seconds = sapply(timeVector_POSICxt, lubridate::second)


  timeVec = as.character(format(timeVector_POSICxt, '%H:%M:%S'))
  timeMat = rbind(timeVec, hours, minutes, seconds)
  rownames(timeMat) = c('time', 'hour', 'minute', 'second')
  colnames(timeMat) = timeVec

  return(timeMat)
}
