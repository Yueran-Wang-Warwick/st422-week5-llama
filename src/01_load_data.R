# src/01_load_data.R
# Loads either Week 4 snapshot data or Week 5 time-series data automatically.
# For Week 5, constructs a Week 4-style snapshot using the most recent month.

source("src/00_setup.R")

pick_dataset_path <- function(dataset = "auto") {
  candidates <- c(
    "data/raw/week5_dataset.csv",
    "data/raw/week4_dataset_updated.csv",
    "data/raw/week4_dataset.csv"
  )

  if (dataset != "auto") {
    if (!file.exists(dataset)) stop("Dataset not found: ", dataset)
    return(dataset)
  }

  for (p in candidates) {
    if (file.exists(p)) return(p)
  }
  stop("No dataset found in data/raw/. Expected one of: ", paste(candidates, collapse = ", "))
}

load_client_data <- function(dataset = "auto") {
  path <- pick_dataset_path(dataset)
  df <- readr::read_csv(path, show_col_types = FALSE)

  if (!("group" %in% names(df))) stop("Missing required column: group")
  if (!("made_purchase_30d" %in% names(df))) stop("Missing required column: made_purchase_30d")

  df <- df %>%
    mutate(
      group = as_group(group),
      made_purchase_30d = as_yes_no(made_purchase_30d),
      customer_type = if ("customer_type" %in% names(df)) factor(customer_type, levels = c("New","Existing")) else NA,
      discount_eligible = if ("discount_eligible" %in% names(df)) factor(discount_eligible, levels = c("No","Yes")) else NA
    )

  meta <- list(
    source_path = path,
    is_time_series = "month" %in% names(df),
    snapshot_month = NA_character_
  )

  if ("month" %in% names(df)) {
    df$month <- as.character(df$month)
    latest_month <- max(df$month, na.rm = TRUE)
    meta$snapshot_month <- latest_month
    df <- df %>% filter(month == latest_month)
  }

  list(df = df, meta = meta)
}
