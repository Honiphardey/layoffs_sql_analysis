-- Data cleaning

-- FIRST OVERVIEW DATA
SELECT *
FROM layoffs ;

-- DATA CLEANING STEPS
-- REMOVE DUPLICATES
-- STANDARDIZE THE DATA
-- NULL VALUE OR BLANK VALUES
-- REMOVE ANY COLUMNS NOT NEEDED

-- MAKE A STAGING INORDER NOT TO TAMPER WITH OUR MAIN DATA
CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT *
FROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoffs;

-- REMOVING DUPLICATES
SELECT *,
row_number() OVER(
PARTITION BY company,location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

WITH duplicates_cte AS
(
SELECT *,
row_number() OVER(
PARTITION BY `date`, company, location, industry, total_laid_off, percentage_laid_off, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicates_cte
WHERE row_num > 1;

-- CROSS CHECKING
SELECT *
FROM layoffs_staging
WHERE company = 'Tiktok';

-- CREATE ANOTHER STAGING TABLE 
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * 
FROM layoffs_staging2
WHERE row_num > 1;

INSERT INTO layoffs_staging2
SELECT *,
row_number() OVER(
PARTITION BY `date`, company, location, industry, total_laid_off, percentage_laid_off, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

DELETE  
FROM layoffs_staging2
WHERE row_num > 1;

SELECT * 
FROM layoffs_staging2;


-- STANDARDIZING DATA

SELECT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT * 
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2
SET country = 'United States'
WHERE country LIKE 'United States%';

SELECT `date`
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = str_to_date(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

SELECT *
FROM layoffs_staging2;


-- NULL VALUE OR BLANK VALUES
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';

UPDATE layoffs_staging2
SET industry = 'Travel'
WHERE company = 'Airbnb';

UPDATE layoffs_staging2
SET industry = 'Transportation'
WHERE company = 'Carvana';

UPDATE layoffs_staging2
SET industry = 'Consumer'
WHERE company = 'Juul';

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoffs_staging2;


-- REMOVING UNNECESSARY ROWS
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;



-- EXPLORATORY DATA ANALYSIS

select * 
from layoffs_staging2;

-- BIGGEST ONE TIME LAYOFF
select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging2;

-- LAYOFFS BY COMPANIES
select company, sum(total_laid_off) 
from layoffs_staging2
group by company
order by 2 desc;

-- TIME PERIOD
select min(`date`), max(`date`)
from layoffs_staging2;

-- LAYOFFS BY YEAR
select year(`date`), sum(total_laid_off) 
from layoffs_staging2
group by year(`date`)
order by 1 desc;

-- TOTAL LAYOFFS PER MONTH
select 
	    date_format(`date`, '%Y-%m') as `month`,
        sum(total_laid_off) as total_layoffs
from layoffs_staging2
where date_format(`date`, '%Y-%m') is not null
group by `month`
order by 1 asc; 

with Rolling_total as
(
select substring(`date`,1,7) as `month`, sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `month`
order by 1 asc
)
select `month`,total_off,
 sum(total_off) over(
 order by `month`) as rolling_total
from Rolling_total;


select company, year(`date`) as `Year`, sum(total_laid_off) as laid_off_total 
from layoffs_staging2
group by company, `Year`
order by 3 desc;

-- TOP 5 COMPANY BY LAYOFFS PER YEAR
with Company_year as
(
select company, year(`date`) as `Year`, sum(total_laid_off) as laid_off_total 
from layoffs_staging2
group by company, `Year`
), Company_year_rank as
(
select *, dense_rank() over(
partition by `Year` 
order by laid_off_total desc) as Ranking
from Company_year
where `Year` is not null
)
select *
from Company_year_rank
where Ranking <= 5;

-- TOP 5 INDUSTRY BY LAYOFFS PER YEAR
with Industry_year as
(
select industry, year(`date`) as `Year`, sum(total_laid_off) as laid_off_total 
from layoffs_staging2
group by industry, `Year`
), Industry_year_rank as
(
select *, dense_rank() over(
partition by `Year` 
order by laid_off_total desc) as Ranking
from Industry_year
where `Year` is not null
)
select *
from Industry_year_rank
where Ranking <= 5;

-- TOP 5 COUNTRY BY LAYOFFS PER YEAR
with Country_year as
(
select country, year(`date`) as `Year`, sum(total_laid_off) as laid_off_total 
from layoffs_staging2
group by country, `Year`
), Country_year_rank as
(
select *, dense_rank() over(
partition by `Year` 
order by laid_off_total desc) as Ranking
from Country_year
where `Year` is not null
)
select *
from Country_year_rank
where Ranking <= 5; 

-- TOP 3 STAGE BY LAYOFFS PER YEAR
select year(`date`) as `Year`, stage, sum(total_laid_off) as total_layoffs
from layoffs_staging2
where `date` and stage is not null
group by `Year`, stage
order by `Year`, total_layoffs desc;

with stage_year as
(
select year(`date`) as `Year`, stage, sum(total_laid_off) as total_layoffs
from layoffs_staging2
where `date` and stage is not null
group by `Year`, stage
), ranked as
(
select *, dense_rank() over(
partition by `Year`
order by total_layoffs desc) as ranking
from stage_year
)
select *
from ranked
where ranking <= 3;

-- TOP 10 LOCATIONS BY LAYOFFS
select
	  location,
      sum(total_laid_off) as total_layoffs
 from layoffs_staging2
 group by location
 order by total_layoffs desc
 limit 10;
