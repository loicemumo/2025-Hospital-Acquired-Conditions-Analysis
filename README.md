# 2025 Hospital-Acquired Conditions Analysis
**Fall and Trauma Rates Up to 16X Higher Than Other Measures**

## Overview:

This project analyzes the CMS Deficit Reduction Act Hospital-Acquired Conditions (HAC) dataset to determine which preventable conditions contribute most to patient safety variation across U.S. hospitals. Using MySQL for data cleaning and statistical analysis, and Excel for result visualization, the project translates raw provider-level rates into actionable priorities for healthcare leadership.

## Business Questions:
- What are the average HAC rates by measure in 2025?
- Which measures show the highest and lowest HAC rates nationally?
- Which measures contribute most to variation in patient safety outcomes?
- What condition areas should be prioritized to reduce hospital-acquired conditions and improve patient safety outcomes?

## Tools
- MySQL
- Microsoft Excel

## Data Overview:
- **Dataset:** [CMS Deficit Reduction Act Hospital-Acquired Conditions (HAC) Reduction Program](https://data.cms.gov/quality-of-care/deficit-reduction-act-hospital-acquired-condition-measures)
- **Scope:** National provider-level rates for four preventable conditions (2025)
    - Foreign Object Retained After Surgery
    - Blood Incompatibility
    - Air Embolism
    - Falls and Trauma
- **Unit:** Rate per 1,000 discharges

## Analytical Approach:
- **Data Ingestion & Staging:** Loaded raw CSV into MySQL; created staging table for iterative cleaning
- **Cleaning:** Standardized measure labels, removed redundant temporal columns, validated for duplicates
- **Statistical Analysis:**
    - Mean rates to establish baseline frequency
    - Min/max range to identify performance extremes
    - Coefficient of variation (CV) to assess relative dispersion while accounting for scale differences
- **Prioritization Framework:** Ranked conditions by combining prevalence, variability, and clinical severity
- **Visualization:** Exported query results to Excel to create static, publication-ready charts for reporting

## Key Insights
- Falls and Trauma represented the highest-impact opportunity for HAC reduction, averaging 0.33 cases per 1,000 discharges and reaching peaks of 16.0
- Foreign Object Retained After Surgery occurred at roughly 1.541 times per 1000 discharges, but warrants disciplined oversight due to its severe clinical and reputational consequences when it does occur
- Air Embolism and Blood Incompatibility remained statistically negligible in 2025, making them lower priorities for resource allocation
