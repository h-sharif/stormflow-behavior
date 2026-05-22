library(data.table)
library(here)
library(tidyverse)
library(xgboost)
library(caret)
library(testthat)

df_atts_gauged   <- fread("../../data/Gauged_Catchments_Metadata_and_Attributes.csv")
df_atts_ungauged <- fread("../../data/Ungauged_Catchments_Metadata_and_Attributes.csv")
dormant_model <- xgb.load("../../code/models/dormant_model")
growing_model <- xgb.load("../../code/models/growing_model")

test_that("Model simulations are structurally valid across all 4 spatial/temporal strata", {

  # Define the execution configurations for your 4 testing environments
  scenarios <- list(
    list(name = "dormant_gauged",   df = df_atts_gauged,   period = "dormant", id = "GCIN", class = "dormant_predicted_class",  model = dormant_model),
    list(name = "growing_gauged",   df = df_atts_gauged,   period = "growing", id = "GCIN", class = "growing_predicted_class",  model = growing_model),
    list(name = "dormant_ungauged", df = df_atts_ungauged, period = "dormant", id = "UCIN", class = "dormant_predicted_class", model = dormant_model),
    list(name = "growing_ungauged", df = df_atts_ungauged, period = "growing", id = "UCIN", class = "growing_predicted_class", model = growing_model)
  )

  for (scen in scenarios) {
    context_msg <- paste("Failed stratum:", scen$name)

    # 1. Process dataset using the helper function
    test_env <- prepare_test_matrix(
      set = strsplit(scen$name, split = "_")[[1]][2],
      atts_df = scen$df,
      selected_period = scen$period,
      id_col = scen$id,
      class_col = scen$class
    )

    # 2. Generate raw model predictions
    raw_preds <- predict(scen$model, newdata = test_env$dmatrix)

    # 3. Convert multi-class probability vectors into discrete 0, 1, 2 labels
    # matching simple, intermediate, and complex
    predicted_labels <- max.col(matrix(raw_preds, ncol = 3, byrow = TRUE)) - 1

    # 4. Strict Vector Assertion
    # This will fail the test if even one single prediction differs from the ground truth
    expect_equal(predicted_labels, test_env$labels, info = context_msg)
  }
})
