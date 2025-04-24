## code to prepare `time_vector` dataset goes here

# Setup
library(lubridate)

# Create time vector

time_vec = seq(from=lubridate::hm('00:00'), by=lubridate::minutes(5), length.out=10)
time_vector = as.POSIXct(time_vec, origin=lubridate::origin, tz='GMT')

usethis::use_data(time_vector, overwrite = TRUE)
