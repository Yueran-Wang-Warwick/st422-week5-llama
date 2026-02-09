# src/02_table1.R
# Produces a simple "Table 1" baseline summary by group.

source("src/00_setup.R")

make_table1 <- function(df) {
  num_vars <- c("customer_age","avg_order_value_gbp","orders_last_90d","web_sessions_last_30d","area_affluence_score")
  cat_vars <- c("customer_type","discount_eligible","made_purchase_30d")

  out <- list()

  for (v in num_vars) {
    if (v %in% names(df)) {
      tmp <- df %>%
        group_by(group) %>%
        summarise(
          n = sum(!is.na(.data[[v]])),
          median = median(.data[[v]], na.rm = TRUE),
          iqr = IQR(.data[[v]], na.rm = TRUE),
          .groups = "drop"
        ) %>%
        mutate(variable = v,
               summary = sprintf("Median %.1f (IQR %.1f), n=%d", median, iqr, n)) %>%
        select(variable, group, summary)
      out[[v]] <- tmp
    }
  }

  for (v in cat_vars) {
    if (v %in% names(df)) {
      tmp <- df %>%
        filter(!is.na(.data[[v]])) %>%
        count(group, .data[[v]]) %>%
        group_by(group) %>%
        mutate(pct = n / sum(n)) %>%
        ungroup() %>%
        mutate(variable = v,
               level = as.character(.data[[v]]),
               summary = sprintf("%d (%.1f%%)", n, 100*pct)) %>%
        select(variable, level, group, summary)
      out[[v]] <- tmp
    }
  }

  bind_rows(out)
}

write_table1 <- function(tab, out_path = "outputs/tables/table1.csv") {
  dir.create(dirname(out_path), recursive = TRUE, showWarnings = FALSE)
  readr::write_csv(tab, out_path)
  invisible(out_path)
}
