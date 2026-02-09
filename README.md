# st422-week4-yourname

This repository extends the client brief to the new data set. 
It is designed to run on either:
- Week 4 snapshot data (one row per customer), or
- Week 5 time-series data (multiple months), automatically.

## What this repo produces

A client-facing report that follows the required structure:

1. Introduction
2. Client brief
3. Data description
4. Baseline summary of data characteristics
5. Claim
6. Data and approach (plain language)
7. Evidence
   - Table 1 + interpretation
   - Visualisation 1 + interpretation
   - Visualisation 2 + interpretation
8. Uncertainty and limitations (1-3 items, each with impact)
9. Recommendation and next steps

Outputs are written to:
- outputs/tables/
- outputs/figures/
- rendered report in reports/

## Quick start

1. Open `st422-week4.Rproj`
2. Install packages (first time only):
   `install.packages(c("tidyverse","knitr","rmarkdown","scales"))`
3. Knit the report:
   - Open reports/CLIENT_REPORT.Rmd
   - Click Knit

## Dataset selection

The report will choose a dataset in this priority order:
1. `data/raw/week5_dataset.csv` (if present)
2. `data/raw/week4_dataset_updated.csv` (if present)
3. `data/raw/week4_dataset.csv`

You can override this in the YAML `params` at the top of 
`reports/CLIENT_REPORT.Rmd`.

## How the report adapts to Week 5 time-series data

The Week 4 activity is a snapshot (one record per customer). The Week 5 dataset
contains repeated monthly observations.

For Week 5 data, this repo constructs the Week 4-style snapshot by taking the
most recent month in the file and analysing that month as the baseline.
This keeps the Week 4 deliverable structure intact, while noting the limitation
and recommending a time-series follow-up in "Next steps".

## Included datasets

The following were copied into data/raw/ when this repo was generated:
- `week4_dataset.csv`, `week4_dataset_updated.csv`, `week5_dataset.csv`

If any are missing, add them into `data/raw/` with the exact names above.
