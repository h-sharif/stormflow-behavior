# Reproducible Code for "The Functional Diversity of Ungauged Basins: A global Hydrological Synthesis"

<!-- START_BADGES -->
[![CI Status](https://github.com/h-sharif/stormflow-behavior/actions/workflows/run-tests.yaml/badge.svg)](https://github.com/h-sharif/stormflow-behavior/actions) [![Test Pass Rate](https://img.shields.io/badge/pass%20rate-100.00%25-brightgreen)](https://github.com/h-sharif/stormflow-behavior/actions)
<!-- END_BADGES -->

This research article is currently submitted to a scientific journal and is under review.

This Repo contains the following items:

- Training IDs and gauged catchments metadata as well as attributes are located in data subdirectory.
- `code/models/dormant_model` and `code/models/growing_model` are the trained XGBoost models for dormant and growing seasons.
- `Reproducing_XGBoost_Models_Results.html` is the rendered results of the reproducible notebook, `code/Reproducing_XGBoost_Models_Results.Rmd`, generating regional as well as training/testing set performances for growing and dormant seasons.
- `code/run.R` script also runs the Rmarkdown notebook and regenerates `Reproducing_XGBoost_Models_Results.html` report.

Using R version 4.4.2 on an Apple M3 with 8 GB memory and Sonoma 14.6.1 macOS, it took less than a minute to run the `code/run.R` with following package versions:

* rmarkdown 2.29
* data.table 1.17.2
* here 1.0.2
* tidyverse 2.0.0
* xgboost 1.7.9.1
* caret 7.0-1
* knitr 1.50
* countrycode 1.6.1
* maptiles 0.11.0
* tidyterra 0.6.1
* sf 1.0.19
* scales 1.3.0
* ggthemes 5.1.0
* rnaturalearth 1.0.1
* rnaturalearthhires 1.0.0.9000

This repository can be cloned and executed with a local installation of R and the required packages noted above.