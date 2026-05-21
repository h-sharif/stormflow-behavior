library(rmarkdown)
library(here)

# Render Rmd and save HTML in the project root
render(
  input = here("code", "Reproducing_XGBoost_Models_Results.Rmd"),
  output_format = "html_document",
  output_file = here("Reproducing_XGBoost_Models_Results.html")
)
