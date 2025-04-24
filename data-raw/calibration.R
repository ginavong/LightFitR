## code to prepare `calibration` dataset goes here

# Download data and load from https://github.com/ginavong/2024_LightFitR_MethodsPaper/blob/master/data/heliospectra_measurements/calibration/Apollo_Calib_20240827/Apollo_calibration_annotated_20240827.Rda

# Format df

calibration = df

## Filter for middle time

calibration = calibration[calibration$middle_time==TRUE,]

## Remove 5700k (white) LED
calibration = calibration[calibration$LED!=5700,]

## Remove unnecessary columns
keepCols = c(1, 4, 7:9, 11)
calibration = calibration[, keepCols]

## Colnames
colnames(calibration)[3] = 'led'


# Export

usethis::use_data(calibration, overwrite = TRUE)
