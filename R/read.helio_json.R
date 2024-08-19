#' Read a heliospectra script (json format) into a matrix.
#'
#' @param helio_script File (.txt or .json) containing heliospectra regime script
#'
#' @return Matrix containing the regime encoded by the Heliospectra script
#' @export
#'
#' @examples
read.helio_json = function(helio_script){

  # Read in & initial formatting
  regime = read.delim(helio_script, skip = 17) #Skip first 17 lines, which is metadata
  regime = regime[-nrow(regime),] # Remove closing brackets, coerce into vector of chars

  # Format regime into matrix
  mat = sapply(regime, function(i){ #go through each line
    tempVec = as.numeric(unlist(regmatches(i, gregexpr('\\(?[0-9.]+', i)))) # extract numbers
    tempVec[-seq(4, 20, by=2)] #remove led names
  })

  # Tidying
  colnames(mat) = c(1:ncol(mat))
  rownames(mat) = c('hour', 'minute', 'seconds', LightFitR::helio.dyna.leds[,'name'])
  LightFitR::helio.checkFormat(mat[-c(1:3),], ncol(mat))

  return(mat)
}
