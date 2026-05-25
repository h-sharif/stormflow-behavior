# Prepare inputs for XGBoost
prepare_test_matrix <- function(set, atts_df, selected_period, id_col, class_col) {
  if (set == "gauged") {
    processed <- atts_df %>%
      filter(!Catchment_Boundary_Flagged) %>%
      rename(CTI = `Async Index x Slope/AI`,
             `CTIW-dormant` = `RW1 x Async Index x Slope/AI-dormant`,
             `CTIW-growing` = `RW1 x Async Index x Slope/AI-growing`) %>%
      pivot_longer(cols = c(`RW1-dormant`:`RW5-growing`, `CTIW-dormant`, `CTIW-growing`),
                   names_to = c("var", "period"), values_to = "val",
                   names_sep = "-") %>%
      dplyr::filter(period == selected_period) %>%
      pivot_wider(names_from = var, values_from = val) %>%
      dplyr::select(
        all_of(
          c("period", id_col, "AI", "RW1", "RW2.5", "RW5", "Area", "Async Index",
            "Slope/AI", "CTI", "CTIW", "(P-AET) x Slope",
            "Median DepthToBedrock", "Median TWI",
            "First Geo Dominant Class", "Second Geo Dominant Class",
            "Frequency Not Level", "G Shape Elevation",
            "G Shape Slope", "G Shape TWI", "G Shape TRI",
            "G Scale Elevation", "G Scale Slope", "G Scale TWI",
            "G Scale TRI", "Urban", "Forest", "Cropland", "Bare", class_col)
        )
      )
  } else {
    processed <- atts_df %>%
      rename(CTI = `Async Index x Slope/AI`,
             `CTIW-dormant` = `RW1 x Async Index x Slope/AI-dormant`,
             `CTIW-growing` = `RW1 x Async Index x Slope/AI-growing`) %>%
      pivot_longer(cols = c(`RW1-dormant`:`RW5-growing`, `CTIW-dormant`, `CTIW-growing`),
                   names_to = c("var", "period"), values_to = "val",
                   names_sep = "-") %>%
      dplyr::filter(period == selected_period) %>%
      pivot_wider(names_from = var, values_from = val) %>%
      drop_na(RW1) %>% # wetness ratios in growing seasons are not available for two catchments in Australia
      # This is because no dominantly growing month existed for them.
      dplyr::select(
        all_of(
          c("period", id_col, "AI", "RW1", "RW2.5", "RW5", "Area", "Async Index",
            "Slope/AI", "CTI", "CTIW", "(P-AET) x Slope",
            "Median DepthToBedrock", "Median TWI",
            "First Geo Dominant Class", "Second Geo Dominant Class",
            "Frequency Not Level", "G Shape Elevation",
            "G Shape Slope", "G Shape TWI", "G Shape TRI",
            "G Scale Elevation", "G Scale Slope", "G Scale TWI",
            "G Scale TRI", "Urban", "Forest", "Cropland", "Bare", class_col)
        )
      )
  }

  features <- processed %>%
    dplyr::select(-all_of(c(id_col, "period", class_col)))

  raw_strings <- as.character(processed[[class_col]])
  labels <- ordered(raw_strings, levels = c("simple", "intermediate", "complex"))
  numeric_labels <- as.numeric(labels) - 1

  dmatrix <- xgb.DMatrix(data = as.matrix(features),
                         label = as.numeric(labels) - 1)

  return(list(dmatrix = dmatrix, labels = numeric_labels, features = features))
}

# evaluation
# prepare_test_matrix(set = "ungauged",
#                     atts_df = fread("data/Ungauged_Catchments_Metadata_and_Attributes.csv"),
#                     selected_period = "dormant",
#                     id_col = "UCIN",
#                     class_col = "dormant_predicted_class")
