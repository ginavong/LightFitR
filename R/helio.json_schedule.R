#' Format regime_matrix for json output that Heliospectra lights can parse
#'
#' @inheritParams write.helioSchedule
#'
#' @return Character in json format that Heliospectra can parse
#'
#' @examples
#' tempfile_name = tempfile(fileext='.txt')
#' helio.csv_schedule(LightFitR::example_regime, tempfile_name)
#'
helio.json_schedule = function(regime_matrix, filename){
  LightFitR::helio.checkFormat(regime_matrix[-c(1:4),])

  # Define subfunctions
  timeRecipe = function(event_vector){ #Makes the timing part of the string when given input vector
    paste('{\"hour\" : ', event_vector[2], ', \"minute\" : ', event_vector[3], ', \"second\" : ', event_vector[4], sep='')
  }
  lightRecipe = function(event_vector){ #Input: light intensity vector without time consideration - not sure if good idea - think light will sort that as long as rownames are sensible
    paste(sapply(1:nrow(LightFitR::helio.dyna.leds), function(i){
      paste('{\"wl\":', LightFitR::helio.dyna.leds[i, 'wavelength'], ',\"i\":', event_vector[4+i], "}", sep="")
    }), sep="", collapse = ",")
  }

  # Define variables
  nEvents = ncol(regime_matrix)

  wlVec=paste(sapply(helio.dyna.leds[,'wavelength'], function(light){
    paste("{\"wl\" : ", light, ",\"pwr\": 94 }", sep="")
  }), collapse = ",\n")

  # Header of json file
  header = c("{",
             paste('\"text\": \"', filename, '\",', sep=''),
             "\"type\" : 0,",
             "\"no_of_wave_lengths\" : 9,",
             paste("\"no_of_events\": ", nEvents, ",", sep=""),
             "\"wavelengths\" : [",
             wlVec,
             "],",
             "\"events\":[")

  # Make schedule part of input file
  schedule = sapply(1:nEvents, function(event){

    eventVec = regime_matrix[,event]

    if(event < nEvents){
      text=paste(timeRecipe(eventVec), ', \"intensities\" : [', lightRecipe(eventVec), ']},', sep="")
    }
    else { #last time point has different formatting (can't have a comma at the end of the string)
      text=paste(timeRecipe(eventVec), ', \"intensities\" : [', lightRecipe(eventVec), ']}', sep="")
    }

    text
  })

  # Footer
  footer = ']}'

  return(c(header, schedule, footer))
}
