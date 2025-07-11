% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/internal.rmWhite.R
\name{internal.rmWhite}
\alias{internal.rmWhite}
\title{Remove empty white (5700k) LED from calculations}
\usage{
internal.rmWhite(irradiance_matrix)
}
\arguments{
\item{irradiance_matrix}{Matrix of intended irradiances. rows = leds and columns = events}
}
\value{
Matrix of irradiances, with 9th row removed as we currently don't support 5700k LED channel
}
\description{
Remove empty white (5700k) LED from calculations
}
\keyword{internal}
