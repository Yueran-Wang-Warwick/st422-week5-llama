# DATA_DICTIONARY

## Data definitions

The client has provided a set of definitions and coding of fields contained in
the dataset they have provided.

> Each record represents a single customer.
>
> Please note: the staff member who originally prepared the extract has now left
  the company and no handover notes were provided. Some definitions therefore
  reflect our best understanding and should be treated as provisional until you
  confirm them against the source systems and business rules.

### Record structure

- Unit of analysis: One record per customer.
- Grouping variable: Two groups are provided for comparison:
  - Control
  - Treatment

Interpretation note: the groups are intended to represent whether the customer
was included in a marketing intervention (Treatment) or not (Control).
Please confirm the intervention definition, dates, and eligibility rules.

### Field definitions

**group**
- Meaning: Group membership used for comparison.
- Type: Categorical
- Permitted values: "Control", "Treatment"
- Note: The individual who prepared the data had worked in the medical field and
  often used this terminology to differentiate between those with and without
  an intervention.

**customer_age**
- Meaning: Customer age at the time of the extract.
- Type: Integer
- Units: Years
- Expected range: 18 to 90

**customer_type**
- Meaning: Customer status based on prior relationship with the company.
- Type: Categorical
- Permitted values: "New", "Existing"
- Notes: Please confirm the rule used to classify "New" vs "Existing"
  (e.g., any prior purchase ever, or within a lookback window).

**avg_order_value_gbp**
- Meaning: Average order value for the customer over a stated historical window.
- Type: Numeric (currency)
- Units: GBP
- Expected range: Approximately 8 to 350 (in this file)
- Notes: Please confirm the window used (e.g., last 12 months) and whether
  refunds/cancellations are included.

**orders_last_90d**
- Meaning: Number of orders placed in the last 90 days prior to the extract date.
- Type: Integer (count)
- Units: Orders
- Expected range: 0 and above

**web_sessions_last_30d**
- Meaning: Number of website sessions in the last 30 days prior to the extract date.
- Type: Integer (count)
- Units: Sessions
- Expected range: 0 and above
- Notes: Please confirm session definition (e.g., analytics tool, timeout rules,
  bots filtered or not).

**discount_eligible**
- Meaning: Whether the customer is eligible for a discount under the
  intervention rules (as recorded in the dataset).
- Type: Categorical (binary)
- Permitted values: "No", "Yes"
- Notes: Please confirm whether this is eligibility or actual discount use.

**area_affluence_score**
- Meaning: Area-level affluence score associated with the customer's location
  (higher implies more affluent).
- Type: Integer (index)
- Units: Unitless
- Expected range: 1 to 60
- Notes: Please confirm the source and scale (e.g., internal segmentation score,
  external index) and whether higher always means more affluent.

**made_purchase_30d**
- Meaning: Whether the customer made at least one purchase in the 30 days after
  the intervention/extract reference point.
- Type: Categorical (binary)
- Permitted values: "No", "Yes"
- Notes: Please confirm the time window anchor date (intervention send date vs
  extract date), and whether purchases are defined by order placed vs fulfilled.

## Week 5 fields (time-series dataset only)

**month**
- Meaning: Month of observation (YYYY-MM). One record per customer per month.
- Type: Character / Date-like string

**tracking_version**
- Meaning: Tracking / recording definition version indicator.
- Type: Categorical
- Notes: Treat as a potential discontinuity marker.
