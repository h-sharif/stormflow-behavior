# Reproducible Code for "A Global Classification of Hydrologic Functional Diversity in Gauged and Ungauged Catchments"

<!-- START_BADGES -->
[![CI Status](https://github.com/h-sharif/stormflow-behavior/actions/workflows/run-tests.yaml/badge.svg)](https://github.com/h-sharif/stormflow-behavior/actions) [![Test Pass Rate](https://img.shields.io/badge/pass%20rate-100.00%25-brightgreen)](https://github.com/h-sharif/stormflow-behavior/actions)
<!-- END_BADGES -->

Paper: https://doi.org/10.1038/s44221-026-00699-6

## ⚠️ Note on Code Correction & Metrics Adjustment (October 2026)

A correction has been applied to address an orientation issue in the evaluation code's confusion matrix.

### 🔍 Issue Summary
In the function `calculate_class_metrics`, the confusion matrix was read in a transposed orientation because software packages differ in whether rows represent true or predicted classes. This transposition interchanged **False Positives (FP)** and **False Negatives (FN)**, leading to mismatched metric labels:
* **Recall** was computed and reported under the heading **Precision**.
* **Negative Predictive Value (NPV)** was computed and reported under the heading **Specificity**.

### 🛠️ Code Resolution & Archiving
* **Current Main Branch:** This issue is now fully resolved. The confusion matrix orientation and all class metrics are correctly calculated in the latest codebase.
* **Published Article Version:** The original code version used to generate the values in the published article is preserved as [**Release v1.0.0 - Version 1 (July 2026)**](https://github.com/h-sharif/stormflow-behavior/releases) on the Releases page.

### 📊 Metric & Findings Impact
The central findings of the article, figures, maps, and the spatial/seasonal distributions of functional classes are entirely unaffected. 
* **Complex Class:** Correctly computed precision remains high (0.84 dormant, 0.89 growing) and is equal to or higher than the values previously reported under that heading.
* **Simple Class:** Correctly computed precision is lower than previously reported due to low class prevalence (0.042 dormant, 0.015 growing). However, it remains more than ten times higher than a no-skill baseline, confirming the model identifies simple catchments with skill. Recall (0.67 dormant, 0.62 growing) and specificity (0.97 both seasons) confirm this performance.

## 📦 This Repository Contains the Following Items:

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

This repository can be cloned and executed with a local installation of R and the required packages noted above.