select*
from layoff_staging2;

select max(total_laid_off), max(percentage_laid_off)
from layoff_staging2;

select*
from layoff_staging2
where percentage_laid_off = 1
order by funds_raised_millions desc;

select company, sum(total_laid_off)
from layoff_staging2
group by company
order by 2 desc;

select min(`date`), max(`date`)
from layoff_staging2;

select industry, sum(total_laid_off)
from layoff_staging2
group by industry
order by 2 desc;

SELECT country, SUM(total_laid_off)
FROM layoff_staging2
GROUP BY country
ORDER BY 2 DESC;

select year (`date`), sum(total_laid_off)
from layoff_staging2
group by year (`date`)
order by 1 desc;

select stage, sum(total_laid_off)
from layoff_staging2
group by stage
order by 2 desc;

select substring(`date` ,1,7) as `Month`,sum(total_laid_off)
from layoff_staging2
where substring(`date` ,1,7) is not null
group by `Month`
order by 1 asc;

with Rolling_Total as 
(
select substring(`date` ,1,7) as `Month`,sum(total_laid_off) as total_off
from layoff_staging2
where substring(`date`,1,7) is not null
group by `Month`
order by 1 asc
)
select `Month`, 
total_off, 
sum(total_off) over(order by `Month`) as rolling_total
from Rolling_Total;

select company, sum(total_laid_off)
from layoff_staging2
group by company
order by 2 desc;

select company, year (`date`), sum(total_laid_off)
from layoff_staging2
group by company, Year (`date`)
order by 1 asc;

with company_year (company, years, total_laid_off) as
(
select company, year (`date`), sum(total_laid_off)
from layoff_staging2
group by company, Year (`date`)
), Company_Year_Rank as
(select*, dense_rank() over (partition by years order by total_laid_off) as Ranking
from company_year
where years is not null 
and total_laid_off is not null
order by Ranking asc
)
select*
from Company_Year_Rank
where Ranking <= 5
;


with company_year (company, years, total_laid_off) as
(
select company, year (`date`), sum(total_laid_off)
from layoff_staging2
group by company, Year (`date`)
)
select*
from company_year;

select company, sum(total_laid_off)
from layoff_staging2
group by company;
