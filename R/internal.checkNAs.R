#' Internal function to check matrix for NAs
#'
#' @inheritParams helio.checkFormat
#'
#' @return Boolean: TRUE = pass, FALSE = fail
#' @export
#'
#' @examples
#' internal.checkNAs(LightFitR::example_intensities)
#'
internal.checkNAs = function(check_matrix){

  naMessage = 'Your matrix contains NAs. The heliospectra cannot accept NAs as input \n' #May need to reword

  if(sum(is.na(check_matrix)) > 0){
    warning(naMessage) # IDK if error would be too strong here?
    return(FALSE)}

  else{return(TRUE)}

}
