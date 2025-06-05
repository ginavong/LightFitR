## code to prepare `example_intensities` dataset goes here

# Setup
set.seed(123)

# Generate matrix
intensities = matrix(round(runif(n=10*8, min=0, max=1000)), nrow=8)

## Add 0 row for white 5700k LED
example_intensities = rbind(intensities, rep(0, ncol(intensities)))

# Format
rownames(example_intensities) = LightFitR::helio.dyna.leds$name

# Tidy
rm(intensities)

# Export

usethis::use_data(example_intensities, overwrite = TRUE)
