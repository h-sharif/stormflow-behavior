# Reproducible Code for "The Functional Diversity of Ungauged Basins: A global Hydrological Synthesis"

This research article is currently submitted to a scientific journal and is under review.

This Repo contains the following items:

- Training IDs and gauged catchments metadata as well as attributes are located in data subdirectory.
- `code/dormant_model` and `code/growing_model` are the trained XGBoost models for dormant and growing seasons.
- `XGBoost_Models_Results.html` is the rendered results of the reproducible notebook, `code/XGBoost_Models_Results.Rmd`, generating regional as well as training/testing set performances for growing and dormant seasons.
- `code/run.R` script also runs the Rmarkdown notebook and regenerates `XGBoost_Models_Results.html` report.
