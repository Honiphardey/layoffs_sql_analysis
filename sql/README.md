# SQL Queries

This folder contains all SQL queries used for cleaning and analyzing the layoffs dataset.

## Contents
- `layoffs_cleaning_eda.sql` – SQL queries for:
  - Data cleaning: removing duplicates, standardizing company/industry/country names, handling nulls, converting dates.
  - Exploratory Data Analysis (EDA): aggregations, trends, totals, top-N analysis.
  - Ranking queries using window functions (`ROW_NUMBER()`, `DENSE_RANK()`) to identify top companies, industries, countries, and funding stages by layoffs.

## Notes
- Queries were executed in MySQL.
- The outputs of these queries were exported for visualization in Excel and for generating the cleaned dataset CSV.
