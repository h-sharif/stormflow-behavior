# Reproducible Code for "A Global Classification of Hydrologic Functional Diversity in Gauged and Ungauged Catchments"

<!-- START_BADGES -->
[![CI Status](https://github.com/h-sharif/stormflow-behavior/actions/workflows/run-tests.yaml/badge.svg)](https://github.com/h-sharif/stormflow-behavior/actions) [![Test Pass Rate](https://img.shields.io/badge/pass%20rate-100.00%25-brightgreen)](https://github.com/h-sharif/stormflow-behavior/actions)
<!-- END_BADGES -->

Paper: https://doi.org/10.1038/s44221-026-00699-6

Versions
- Version 2 (October 2026): newly trained XGBoost models, evaluated with three statistical metrics. Predicted classes for ungauged catchments differ in a very small subset of catchments compared to version 1; see the summary table at the top of the version 2 report.
- Version 1 (July 2026): previous version of the models, available under release v1.0.

This Repository contains the following items:

- Training IDs and gauged catchments metadata as well as attributes are located in data subdirectory.
- `code/models/dormant_model` and `code/models/growing_model` are the trained XGBoost models for dormant and growing seasons.
- `code/Reproducing_XGBoost_Models_Results.html` is the rendered results of the reproducible notebook, `code/Reproducing_XGBoost_Models_Results.Rmd`, which generates regional as well as training/testing set performances for growing and dormant seasons.
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
* httr 1.4.8
* jsonlite 2.0.0

This repository can be cloned and executed with a local installation of R and the required packages noted above.