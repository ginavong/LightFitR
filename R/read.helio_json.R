#' Read a heliospectra script (json format) into a matrix.
#'
#' @param helio_script File (.txt or .json) containing heliospectra regime script
#'
#' @importFrom utils read.delim
#'
#' @return Matrix containing the regime encoded by the Heliospectra script
#' @export
#'
#' @examples
#' example_file <- system.file("extdata", "example_json_schedule.txt", package = "LightFitR", mustWork = TRUE)
#' read.helio_json(example_file)
#'
read.helio_json = function(helio_script){

  # Read in & initial formatting
  regime = utils::read.delim(helio_script, skip = 17) #Skip first 17 lines, which is metadata
  regime = regime[-nrow(regime),] # Remove closing brackets, coerce into vector of chars

  # Format regime into matrix
  mat = sapply(regime, function(i){ #go through each line
    tempVec = as.numeric(unlist(regmatches(i, gregexpr('\\(?[0-9.]+', i)))) # extract numbers
    tempVec[-seq(4, 20, by=2)] #remove led names
  })

  # Format time
  timeMat = mat[1:3,]
  timeVec = c(apply(timeMat, 2, function(t){ #For each column (i.e. timepoint)
    timeString = paste(c(sprintf("%02d", t)), collapse=':') #Format string like HH:MM:SS by adding leading 0 where necessary (the sprintf bit)
    timeString
  }))

  # Combine
  mat = rbind(timeVec, mat)

  # Tidying
  colnames(mat) = timeVec
  rownames(mat) = c('time', 'hour', 'minute', 'second', LightFitR::helio.dyna.leds[,'name'])
  LightFitR::helio.checkFormat(mat[-c(1:4),])

  return(mat)
}
