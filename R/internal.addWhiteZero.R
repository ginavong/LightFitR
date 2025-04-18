#' Add white (5700k) LED to intensities matricies after calculations
#'
#' @param intensities_matrix Matrix of intensities with 8 rows
#'
#' @returns Matrix of intensities with 9 rows
#' @export
#'
#' @examples
internal.addWhiteZero = function(intensities_matrix){
  mat = as.matrix(rbind(intensities_matrix, rep(0, ncol(intensities_matrix))))
  return(mat)
}
