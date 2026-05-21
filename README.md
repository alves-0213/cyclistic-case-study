# Cyclistic Bike-Share: Converting Casual Riders
### Google Data Analytics Certificate — Capstone Project

**Gabriel Almeida Alves** | May 2026

📊 [View Interactive Dashboard on Tableau Public](https://public.tableau.com/app/profile/gabriel.almeida.alves/viz/Cyclistic_Case_Study_17793310347890/Story1)

---

## Business Question

> *How do annual members and casual riders use Cyclistic bikes differently — and how can those differences inform a campaign to convert casual riders into members?*

Cyclistic's finance team determined that annual members are significantly more profitable than casual riders. This analysis was commissioned to identify behavioral patterns that would enable targeted, data-driven conversion campaigns.

---

## Key Findings

| | Members | Casual Riders |
|---|---|---|
| **Total rides** | 3,658,607 | 2,032,986 |
| **Avg. trip duration** | 12 min | 19 min (+58%) |
| **Median trip duration** | 8.6 min | 11.3 min |
| **Peak days** | Mon–Fri | Sat–Sun |
| **Peak hours** | 8am & 5–6pm | 12pm–6pm |
| **Geographic pattern** | City-wide (residential + commercial) | Lakefront (tourist + recreational) |

**Four patterns emerged:**
1. **Members commute. Casual riders explore.** The activity heatmap shows members peaking at rush hours on weekdays; casual riders peak on weekend afternoons.
2. **Casual riders take longer, more expensive trips.** At 19 min average vs. 12 min for members, casual riders extract more time per ride — while paying per trip instead of a flat annual fee.
3. **Casual demand collapses in winter.** Casual rides drop to ~25K in January vs. ~330K in August. This creates a clear conversion window in spring (April–June), before summer habits set in.
4. **Casual riders cluster at leisure stations.** The top casual stations are concentrated near Millennium Park, Navy Pier, and Grant Park — Chicago's primary tourist corridors.

---

## Recommendations

1. **Launch a spring conversion campaign (April–June)** — catch casual riders before they lock into a summer of pay-per-trip habits.
2. **Deploy in-app messaging on weekend afternoons** — personalized to each rider's actual usage history.
3. **Concentrate physical touchpoints at lakefront stations** — QR codes, signage, and seasonal activations where casual riders already ride.

---

## Tools & Methodology

- **R** (tidyverse, lubridate) — data cleaning, feature engineering, CSV exports
- **Tableau Public 2026.1.1** — visualization and interactive dashboard
- **Analytical framework:** Google Data Analytics Certificate (Ask → Prepare → Process → Analyze → Share → Act)

---

## Repository Structure

```
├── cyclistic_analysis.R          # Full R script: cleaning, processing, 12 CSV exports
├── Cyclistic_Case_Study_Gabriel_Alves.docx   # Complete written case study
└── README.md
```

**Note:** The processed CSV files are not included in this repository due to size. Running `cyclistic_analysis.R` against the source data will regenerate all 12 export files.

---

## How to Run the Analysis

### Prerequisites
```r
install.packages(c("tidyverse", "lubridate"))
```

### Data Source
Download the 12 monthly CSV files (May 2025 – April 2026) from [Divvy Trip Data](https://divvy-tripdata.s3.amazonaws.com/index.html), provided by Motivate International Inc. under the [Divvy Data License Agreement](https://divvybikes.com/data-license-agreement).

### Steps
1. Clone this repository
2. Download the source CSV files and place them in the path defined in `cyclistic_analysis.R`
3. Run the script — it will clean the data, perform analysis, and export 12 CSV files to `/exports/`
4. Open Tableau and connect to the exported CSVs to reproduce the dashboard

---

## Data Limitations

- **No pricing data:** Cyclistic did not include fare information in the dataset. Financial break-even calculations are therefore structural (not exact).
- **No demographic data:** Rider identity information was removed to protect privacy.
- **Station gaps:** Some rides had missing station names or coordinates and were excluded from geographic visualizations.

---

## Data Source & License

Motivate International Inc. (2026). *Divvy trip data* [Dataset]. Available at https://divvy-tripdata.s3.amazonaws.com/index.html under the [Divvy Data License Agreement](https://divvybikes.com/data-license-agreement).

*"Cyclistic" is a fictional company name used in the Google Data Analytics Certificate capstone project. The underlying data reflects real Divvy Bikes trip records from Chicago.*

---

*This project is part of the [Google Data Analytics Professional Certificate](https://www.coursera.org/professional-certificates/google-data-analytics) on Coursera.*
