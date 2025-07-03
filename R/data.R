#' Maximum number of events
#'
#' Maximum number of events programmable onto heliospectra
#'
#' @format Integer representing maximum allowable events
#'
#'
"helio.eventLimit"

#' heliospectra DYNA LEDs
#'
#' Data about the heliospectra DYNA LED channels
#'
#' @format A data frame with 9 rows and 3 columns:
#' \describe{
#'  \item{name}{Name of the LED channel}
#'  \item{wavelength}{Wavelength of the LED channel}
#'  \item{colour}{Colour of the LED channel}
#'}
#'
#'@source <https://heliospectra.com/led-grow-lights/dyna/>
#'
#'
"helio.dyna.leds"

#' calibration data
#'
#' Example calibration data
#'
#' @format A data frame with 12 columns:
#' \describe{
#'  \item{filename}{File that the raw data came from}
#'  \item{time}{The time when a given measurement was taken}
#'  \item{led}{LED channel being calibrated at that timepoint}
#'  \item{intensity}{Intensity the light is set to}
#'  \item{wavelength}{The wavelength this row describes}
#'  \item{irradiance}{The irradiance measured at that wavelength by the spectrometer}
#'}
#'
#'@source <https://github.com/ginavong/2024_LightFitR_MethodsPaper/blob/master/data/heliospectra_measurements/calibration/Apollo_Calib_20240827/Apollo_calibration_annotated_20240827.Rda>
#'
#'
#'
"calibration"

#' target irradiances
#'
#' Matrix of random target irradiances for example purposes
#'
#' @format A matrix with 9 rows and 10 columns: each row represents an LED channel and each column represents an event
#'
#'
#'
"target_irradiance"

#' closest intensities
#'
#' Matrix of closest intensities for example purposes. Generated from `target_irradiance`
#'
#' @format A matrix with 9 rows and 10 columns: each row represents an LED channel and each column represents an event
#'
#'
"example_closest"

#' example intensities
#'
#' Matrix of random intensities for example purposes
#'
#' @format A matrix with 9 rows and 10 columns: each row represents an LED channel and each column represents an event
#'
#'
#'
'example_intensities'

#' time vector
#'
#' Example timepoints for events
#'
#' @format A vector of length 10 with timepoints in POSIXct format
#'
#'
#'
"time_vector"

#' regime matrix
#'
#' Example regime matrix
#'
#' @format A matrix with 13 rows and 10 columns:
#' \describe{
#'  \item{time}{time in HH:MM:SS format}
#'  \item{hour}{The hour of the event}
#'  \item{minute}{The minute of the event}
#'  \item{second}{The second of the event}
#'  \item{380nm}{Intensity at 380nm LED channel}
#'  \item{400nm}{Intensity at 400nm LED channel}
#'  \item{etc.}{}
#' }
#'
"example_regime"
