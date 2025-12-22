# Cleaned Data

This folder contains the cleaned and processed dataset used for analysis and visualization.

## Contents
- `layoffs_cleaned.csv` – Final cleaned layoffs data.
  
### Columns included:
- `company` – Company name (trimmed and standardized)
- `location` – City or region of the company
- `industry` – Standardized industry
- `total_laid_off` – Number of employees laid off
- `percentage_laid_off` – % of workforce laid off
- `date` – Date of the layoff (YYYY-MM-DD)
- `stage` – Funding stage (Post-IPO, Series D, etc.)
- `country` – Country name
- `funds_raised_millions` – Funding raised in millions USD

### Notes
- Duplicates and rows with missing critical values were removed.
- Data was aggregated and cleaned using SQL before export.
- This dataset is ready for visualization and analysis.
