# Reproducible Code for "The Functional Diversity of Ungauged Basins: A global Hydrological Synthesis"

This research article is currently submitted to a scientific journal and is under review.

This Repo contains the following items:

- Training IDs and gauged catchments metadata as well as attributes are located in data subdirectory.
- `code/dormant_model` and `code/growing_model` are the trained XGBoost models for dormant and growing seasons.
- `XGBoost_Models_Results.html` is the rendered results of the reproducible notebook, `code/XGBoost_Models_Results.Rmd`, generating regional as well as training/testing set performances for growing and dormant seasons.
- `code/run.R` script also runs the Rmarkdown notebook and regenerates `XGBoost_Models_Results.html` report.

Using R version 4.4.1 on an Apple M3 with 8 GB memory and Sonoma 14.6.1 macOS, it took 3.356 seconds to run thr `code/run.R` with following package versions:

* rmarkdown 2.29
* data.table 1.17.2
* here 1.0.2
* tidyverse 2.0.0
* xgboost 1.7.11.1
* caret 7.0-1
* knitr 1.50
* countrycode 1.6.1