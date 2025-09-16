library(rmarkdown)
library(here)

# Render Rmd and save HTML in the project root
render(
  input = here("code", "XGBoost_Models_Results.Rmd"),
  output_format = "html_document",
  output_file = here("XGBoost_Models_Results.html")
)