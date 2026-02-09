# src/00_setup.R
# Shared setup: packages, helpers, and consistent factor coding.

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(ggplot2)
  library(scales)
})

as_yes_no <- function(x) {
  x <- as.character(x)
  x <- trimws(x)
  x <- ifelse(tolower(x) %in% c("1","yes","y","true","t"), "Yes",
       ifelse(tolower(x) %in% c("0","no","n","false","f"), "No", x))
  factor(x, levels = c("No","Yes"))
}

as_group <- function(x) {
  x <- as.character(x)
  x <- trimws(x)
  factor(x, levels = c("Control","Treatment"))
}
