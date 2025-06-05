
<!-- README.md is generated from README.Rmd. Please edit that file -->

# LightFitR

<!-- badges: start -->

<!-- badges: end -->

The goal of LightFitR is to allow scientists to program complex light
regimes with confidence.

## Installation

You can install the development version of LightFitR from
[GitHub](https://github.com/ginavong/LightFitR) with:

``` r
# install.packages("devtools")
devtools::install_github("ginavong/LightFitR")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(LightFitR)

# Prep variables
calib <- LightFitR::calibration
times <- LightFitR::time_vector
target_irradiance <- LightFitR::target_irradiance

# Run function
#makeRegime(times, target_irradiance, calib$led, calib$wavelength, calib$intensity, calib$irradiance)
```

# Devnotes

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this.

You can also embed plots, for example:

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.
