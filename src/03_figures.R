# src/03_figures.R
# Visualisation 1: purchase rate by group (with 95% CI)
# Visualisation 2: average order value distribution by group (boxplot)

source("src/00_setup.R")

make_purchase_rate_plot <- function(df) {
  rates <- df %>%
    filter(!is.na(made_purchase_30d)) %>%
    group_by(group) %>%
    summarise(
      n = n(),
      p = mean(made_purchase_30d == "Yes"),
      se = sqrt(p*(1-p)/n),
      lo = p - 1.96*se,
      hi = p + 1.96*se,
      .groups = "drop"
    ) %>%
    mutate(
      lo = pmax(0, lo),
      hi = pmin(1, hi)
    )

  ggplot(rates, aes(x = group, y = p)) +
    geom_col() +
    geom_errorbar(aes(ymin = lo, ymax = hi), width = 0.15) +
    scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
    labs(
      title = "30-day purchase rate by group",
      x = NULL,
      y = "Purchase rate (with 95% CI)"
    )
}

make_aov_plot <- function(df) {
  if (!("avg_order_value_gbp" %in% names(df))) return(NULL)
  ggplot(df, aes(x = group, y = avg_order_value_gbp)) +
    geom_boxplot(outlier.alpha = 0.35) +
    labs(
      title = "Average order value (GBP) by group",
      x = NULL,
      y = "Average order value (GBP)"
    )
}

save_plot <- function(p, path, width = 7, height = 4.5) {
  dir.create(dirname(path), recursive = TRUE, showWarnings = FALSE)
  ggplot2::ggsave(filename = path, plot = p, width = width, height = height, units = "in")
  invisible(path)
}
