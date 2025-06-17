#' Turn Heliospectra into disco lights
#'
#' Congratulations! You've found the easter egg function!
#'
#' This writes a schedule for Heliospectra DYNA lights which randomly changes colour every second for a fun disco effect. The disco will last until the Heliospectra runs out of memory (150 events), so you can get 2 min 30s of disco out of your expensive lights...
#' Enjoy!
#'
#' @inheritParams write.helioSchedule
#'
#' @import lubridate
#'
#' @export Heliospectra file with random disco
#'
#' @examples
#' tempfile_name = tempfile(fileext='.txt')
#' helio.disco(tempfile_name, format='json')
#'
helio.disco = function(filename, format=c('csv', 'json')){
  nEvents = LightFitR::helio.eventLimit

  #make random matrix of light intensities as regime
  random = sapply(1:nEvents, function(i){
    sample(0:1000, size=8, replace=T)
  })
  refinedRandom = sapply(1:nEvents, function(i){ #need some LED channels off in each event otherwise it's too
    pos = sample(c(1:8), size=4)
    random[pos,i] = c(rep(0, 4))
    random[,i]
  })

  # Get times
  time_vec = seq(from=lubridate::hms('00:00:00'), by=lubridate::seconds(1), length.out=nEvents)
  time_vec = as.POSIXct(time_vec, origin=lubridate::origin, tz='GMT')
  time_mat = LightFitR::internal.makeTimes(time_vec)

  # Make regime
  regime = as.matrix(rbind(time_mat, refinedRandom, c(rep(0, nEvents)))) #make white light = 0 the whole time
  rownames(regime) = c('time', 'hours', 'minutes', 'seconds', LightFitR::helio.dyna.leds[,'name'])
  #image(regime) #sanity check that things are random

  rm(random, refinedRandom, time_vec)

  LightFitR::write.helioSchedule(regime, filename, format=format)
}
