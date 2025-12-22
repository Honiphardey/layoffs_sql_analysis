# layoffs_sql_analysis
Data cleaning, EDA, and visualization of global layoffs between 2020 to 2023 using SQL and Excel

## Project Overview
This project analyzes a layoffs dataset using **SQL**, covering the full workflow from **data cleaning** to **exploratory data analysis (EDA)**.

The objective was to identify:
- Layoff trends over time  
- Industries, companies, and regions most affected  
- Patterns across funding stages  

All analysis was performed using SQL queries, including aggregations, ranking, and window functions.

---

## Dataset
The dataset contains company-level layoff information, including:
- Company name  
- Industry  
- Country and location  
- Funding stage  
- Funds raised  
- Number of employees laid off  
- Date of layoff  

A cleaned version of the dataset is included in this repository.

---

## Tools Used
- **SQL** – data cleaning, aggregation, ranking, and trend analysis  
- **Excel** – storing cleaned data and extracted query results  

---

## Key Insights

1. **Layoffs peaked sharply in 2022**  
   2022 recorded the highest total layoffs, significantly exceeding previous years. This suggests a major post-pandemic correction driven by overhiring, rising interest rates, and cost-cutting across tech companies.

2. **The United States accounts for the majority of global layoffs**  
   The U.S. dominates total layoffs, reflecting its heavy concentration of technology firms and venture-backed companies that scaled rapidly before the downturn.

3. **Technology and tech-adjacent industries were the most affected**  
   Technology, consumer tech, and crypto-related industries consistently ranked highest in layoff totals, indicating structural vulnerability during market contractions.

4. **Late-stage and post-IPO companies laid off more employees than early-stage startups**  
   Companies at later funding stages accounted for larger absolute layoff numbers, largely due to bigger workforce sizes and aggressive expansion strategies.

5. **Layoffs are highly concentrated among a small number of companies**  
   A few large firms were responsible for a disproportionate share of total layoffs, while most companies recorded relatively smaller cuts, creating a long-tail distribution.

---

## Analytical Approach
- Data cleaning using filtering, standardization, and removal of invalid records  
- Aggregations using `GROUP BY` across time, industry, country, and company  
- Rankings using window functions such as `DENSE_RANK()` with `PARTITION BY year`  
- Trend analysis using date-based grouping  

---

## Repository Structure

sql/
  layoffs_analysis.sql

data/
  layoffs_cleaned.csv

visuals/
  (visualizations to be added)

- **sql/**: Contains all SQL queries used for data cleaning, transformation, and exploratory data analysis (EDA).
- **data/**: Contains the cleaned dataset used for analysis.
- **visuals/**: Reserved for charts and dashboards derived from the analysis.


---

## Next Steps

- Create visualizations to highlight yearly layoff trends and top contributing entities.
- Build an interactive dashboard to explore layoffs by company, industry, country, and funding stage.
- Extend analysis to compare funding levels against layoff severity.
- Perform deeper time-series analysis on rolling layoffs across months and years.

---

## References & Tools

- Project inspired by Alex the analyst.
- SQL used for data cleaning and analysis (window functions, aggregations, ranking).
- AI tools were used to assist with query validation, documentation clarity, and insight refinement.
