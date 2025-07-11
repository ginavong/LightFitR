#' Write the schedule to file that Heliospectra can parse
#'
#' Writes to json or csv format
#'
#' @param regime_matrix Matrix containing light regime, as generated by makeRegime
#' @param filename Character. Filename to export to
#' @param format Character. Which format to export to? csv or json. Use extensions '.csv' or '.txt'
#'
#' @importFrom utils write.table
#'
#' @export
#'
#' @examples
#' tempcsv_name = tempfile(fileext='.csv')
#' write.helioSchedule(LightFitR::example_regime, tempcsv_name, format='csv')
#'
#' temptxt_name = tempfile(fileext='.txt')
#' write.helioSchedule(LightFitR::example_regime, temptxt_name, format='json')
#'
write.helioSchedule = function(regime_matrix, filename, format=c('csv', 'json')){
  if(format=='csv'){
    csv = LightFitR::helio.csv_schedule(regime_matrix, filename)
    utils::write.table(csv, file=filename, row.names=F, col.names=F, sep=';', quote=F)
  }

  if(format=='json'){
    json = LightFitR::helio.json_schedule(regime_matrix, filename)
    utils::write.table(json, file=filename, row.names = F, col.names = F, quote = F)
  }
}
