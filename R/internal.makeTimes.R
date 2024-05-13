#' Title
#'
#' @param timeVector_POSICxt Vector of schedule timepoints in POSICxt format
#'
#' @return
#' @export
#'
#' @examples
internal.makeTimes = function(timeVector_POSICxt){
  hours = sapply(timeVector_POSICxt, lubridate::hour)
  minutes = sapply(timeVector_POSICxt, lubridate::minute)
  seconds = sapply(timeVector_POSICxt, lubridate::second)


  timeVec = format(timeVector_POSICxt, '%H:%M:%S')
  timeMat = rbind(timeVec, hours, minutes, seconds) #Will this automatically numericise the times?
  return(timeMat)
}
