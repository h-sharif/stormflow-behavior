library(data.table)
library(dplyr)
library(tidyr)
library(xgboost)
library(caret)
library(testthat)
library(here)

df_atts_gauged   <- fread("../../data/Gauged_Catchments_Metadata_and_Attributes.csv")
df_atts_ungauged <- fread("../../data/Ungauged_Catchments_Metadata_and_Attributes.csv")
dormant_model <- xgb.load("../../code/models/dormant_model.json")
growing_model <- xgb.load("../../code/models/growing_model.json")

test_that("Model simulations are structurally valid across all 4 spatial/temporal strata", {

  # Define the execution configurations for your 4 testing environments
  scenarios <- list(
    list(name = "dormant_gauged",   df = df_atts_gauged,   period = "dormant", id = "GCIN", class = "dormant_predicted_class",  model = dormant_model),
    list(name = "growing_gauged",   df = df_atts_gauged,   period = "growing", id = "GCIN", class = "growing_predicted_class",  model = growing_model),
    list(name = "dormant_ungauged", df = df_atts_ungauged, period = "dormant", id = "UCIN", class = "dormant_predicted_class", model = dormant_model),
    list(name = "growing_ungauged", df = df_atts_ungauged, period = "growing", id = "UCIN", class = "growing_predicted_class", model = growing_model)
  )

  metrics_summary <- data.frame()

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
    predicted_matrix <- matrix(raw_preds, ncol = 3, byrow = TRUE)

    # 3. Convert multi-class probability vectors into discrete 0, 1, 2 labels
    predicted_labels <- max.col(predicted_matrix, ties.method = "first") - 1

    # 4. Calculate exact performance metrics
    mismatch_count <- sum(predicted_labels != test_env$labels)
    total_count    <- length(test_env$labels)
    mismatch_rate  <- mismatch_count / total_count
    accuracy_rate  <- 1 - mismatch_rate

    # 5. Collect data for the README table
    metrics_summary <- rbind(metrics_summary, data.frame(
      Stratum = scen$name,
      Total = total_count,
      Mismatches = mismatch_count,
      `Mismatch Rate` = sprintf("%.4f%%", mismatch_rate * 100),
      Accuracy = sprintf("%.2f%%", accuracy_rate * 100),
      check.names = FALSE
    ))

    # 6. GitHub Actions Cross-Platform Tolerance Check
    # OS differences (Windows vs. Linux CI runner) and CPU instruction sets
    # (AVX vs. SSE) alter machine-precision probabilities at the 15th decimal
    # place. A 5% mismatch tolerance prevents false test failures on GitHub
    # Actions caused by hardware-level floating-point variations.
    report_msg <- sprintf(
      "Stratum: %-18s | Total: %6d | Mismatches: %4d | Mismatch Rate: %6.4f%% | Accuracy: %6.2f%%",
      scen$name, total_count, mismatch_count, mismatch_rate * 100, accuracy_rate * 100
    )
    context_msg <- paste("Failed stratum assertion:", scen$name, "| Details:", report_msg)

    # Strict assertion for gauged catchments
    if (strsplit(scen$name, split = "_")[[1]][2] == "gauged") {
      expect_true(mismatch_count == 0, info = context_msg)
    } else {
    # Allow 1 discrepancy out of 77k ungauged catchments
      expect_true(mismatch_count <= 1, info = context_msg)
    }
  }

  # Build a Markdown table text block
  md_table <- paste0(
    "### 📊 Model Validation Metrics (Live CI)\n\n",
    "| Stratum | Total Rows | Mismatches | Mismatch Rate | Accuracy |\n",
    "| :--- | :---: | :---: | :---: | :---: |\n"
  )

  for(i in 1:nrow(metrics_summary)) {
    md_table <- paste0(md_table, sprintf(
      "| **%s** | %d | %d | %s | %s |\n",
      metrics_summary$Stratum[i], metrics_summary$Total[i],
      metrics_summary$Mismatches[i], metrics_summary$`Mismatch Rate`[i], metrics_summary$Accuracy[i]
    ))
  }
  md_table <- paste0(md_table, "\n*Last updated: ", Sys.time(), " UTC*")

  # Write out the file for GitHub Actions to read
  writeLines(md_table, here::here("tests/metrics.md"))
  succeed()

})
