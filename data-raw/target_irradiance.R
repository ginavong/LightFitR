## code to prepare `target_irradiance` dataset goes here

# Setup

library(dplyr)
library(tidyr)

set.seed(123)

# Create matrix

## Load calib data
calib = LightFitR::calibration

## Get ranges

rangeLED = calib |> group_by(LED) |> summarise(max(irradiance))
colnames(rangeLED) = c('LED', 'max')
rangeLED = as.data.frame(rangeLED)

## Generate targets

targets = t(sapply(1:8, function(i){
  sampleIntensities = seq(from=0, to=floor(rangeLED[i, 2]), by=0.2)

  sample(sampleIntensities, size=10, replace=TRUE)
}))

# Format

## Add white LED
target_irradiance = rbind(targets, rep(0, ncol(targets)))

## Rownames

rownames(target_irradiance) = LightFitR::helio.dyna.leds$name

# Tidy
rm(calib, rangeLED, targets)

# Export

usethis::use_data(target_irradiance, overwrite = TRUE)
