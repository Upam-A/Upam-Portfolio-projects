/* Here's the dataset's link: https://www.kaggle.com/datasets/rafsunahmad/billionaires-data-by-country-2024
We are going to analyse the billionre's data set along with that visulise this in powerbi*/
-- 1. Which countries have the highest number of billionaires per million people in 2023?
select 
country,
BillionairesPerMillionPeople2023
from billionaires_by_country_2024
order by  BillionairesPerMillionPeople2023 desc
limit 10;

-- 2. What is the relationship between country land area and population density?
select 
country,
population_density_km,
Country_land_area
from billionaires_by_country_2024;

-- 3. What is the total net worth of billionaires per country in 2023?
select 
country,
sum(BillionairesTotalNetWorth2023) as total_net_worth
from billionaires_by_country_2024
group by country
order by total_net_worth desc;

-- 4. Which regions have the richest billionaires and highest total billionaire net worth?
select
region,
Max(BillionairesRichestNetWorth2023) as richest_billionre,
round(sum(BillionairesTotalNetWorth2023),2) as total_net_worth
from billionaires_by_country_2024
group by region;

-- 5. What is the average billionaire net worth for UN member countries?
select
avg(BillionairesTotalNetWorth2023) as avg_billonaire_networth
from billionaires_by_country_2024
where UNmember = 'TRUE';

-- 6. Which countries have the fastest-growing populations and their billionaire numbers?
select
country,
Population_growthRate,
BillionairesPerMillionPeople2023
from billionaires_by_country_2024
order by Population_growthRate desc;

-- 7. How does population density correlate with the number of billionaires?
select
country,
population_density_km,
BillionairesPerMillionPeople2023
from billionaires_by_country_2024;

-- 8. Which countries have the highest net worth of their richest billionaire in 2023?
select 
country,
BillionairesTotalNetWorth2023 
from billionaires_by_country_2024
order by BillionairesTotalNetWorth2023 desc
limit 10;
 
-- 9. What are the top 5 regions by the number of billionaires per million people in 2023?
select 
region,
avg(BillionairesPerMillionPeople2023) as avg_billionaires_perMillion
from billionaires_by_country_2024
group by region
order by avg_billionaires_perMillion desc
limit 5;

-- 10. Which countries contribute the most to global billionaire wealth in 2023?
select 
country,
BillionairesTotalNetWorth2023
from billionaires_by_country_2024
order by BillionairesTotalNetWorth2023 desc
limit 10;