-- Exploratory Data Analysis

-- This data set is about layoffs around the world. It has the information about companies that did the layoffs and much more.

SELECT * 
FROM layoffs_staging2;

-- Retrieving the maximum number of people laid_off and the maximum percentage.

SELECT MAX(total_laid_off), MAX(percentage_laid_off) 
FROM layoffs_staging2;

-- Listing the companies in the order of most layoffs.

SELECT * 
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

-- Calculating the sum of total layoffs by each company.

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- Looking at the date range in which the layoffs started and ended in this data set.

SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

-- Evaluating the sum of layoffs by each industry.

SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

-- Evaluating the sum of layoffs by each country. 

SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

-- Looking at the layoffs in each year.

SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;

-- Stage of the companies.

SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage 
ORDER BY 2 DESC;

-- Average percentage of the companies.

SELECT company, AVG(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company 
ORDER BY 2 DESC;

-- Looking at the layoffs in the order of month and year.

SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC;

-- Calculating Rolling Total.

WITH Rolling_Total AS
(
SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`, total_off,
SUM(total_off) OVER(ORDER BY `MONTH`) AS rolling_total
FROM Rolling_Total;

-- Sum of total layoffs by each company in different years.

SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;

-- Using Dense_Rank to give ranks to the companies and looking at the top 5 companies with highest layoffs in each year.

WITH Comapany_Year(company,years,total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
), Company_Year_Rank AS

(SELECT *, 
DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM  Comapany_Year
WHERE years IS NOT NULL
)
SELECT *
FROM Company_Year_Rank
WHERE Ranking <=5; 





 













 












































































