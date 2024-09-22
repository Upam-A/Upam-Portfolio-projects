/*Here's the dataset's link: https://www.kaggle.com/datasets/rafsunahmad/billionaires-data-by-country-2024
 Advanced Billionre's Data Analysis with sql, python, visulisation on PowerBI */

-- 11. Is there a correlation between population growth rate and billionaire wealth concentration across countries?
select
country,
Population_growthRate,
BillionairesRichestNetWorth2023,
BillionairesPerMillionPeople2023
from billionaires_by_country_2024;

-- 12. Which regions/countries have the most efficient wealth distribution among billionaires?
select
region,
round(sum(BillionairesRichestNetWorth2023)/count(BillionairesRichestBillionaire2023),2) 
as avg_wealth_per_billionaire
from billionaires_by_country_2024
group by region
order by  avg_wealth_per_billionaire desc;

-- 13. Does higher population density lead to a greater concentration of billionaires per capita?
select
country,
population_density_km,
BillionairesPerMillionPeople2023
from billionaires_by_country_2024;

-- 14. What is the distribution of billionaire net worth within each country, and how does it vary by region?
select
country,
region,
BillionairesRichestNetWorth2023,
BillionairesTotalNetWorth2023
from billionaires_by_country_2024
where BillionairesTotalNetWorth2023 > 0;

-- 15. What factors are most predictive of a high concentration of billionaires per capita in a country?
select
population_2024,
Population_growthRate,
Country_land_area,
population_density_km,
BillionairesPerMillionPeople2023
from billionaires_by_country_2024;

-- 16. What is the relationship between the size of the country's land area and its ability to sustain high billionaire net worth?
select
country,
Country_land_area,
BillionairesTotalNetWorth2023
from billionaires_by_country_2024;

-- 17. Which countries have outliers in terms of their population growth rate and billionaire wealth accumulation?
select
country,
Population_growthRate,
BillionairesTotalNetWorth2023
from billionaires_by_country_2024;

-- 18. How does billionaire wealth in the top 10 richest countries compare to the wealth of the rest of the world?
select
country,
sum(BillionairesTotalNetWorth2023) as total_net_worth
from billionaires_by_country_2024
group by country
order by total_net_worth desc
limit 10;

-- 19. How does population size relate to the presence of the richest billionaires?
select 
country,
population_2024,
BillionairesRichestNetWorth2023
from billionaires_by_country_2024;

-- 20. What is the relationship between regional UN membership and billionaire wealth accumulation?
select
region,
UNmember, 
round(sum(BillionairesTotalNetWorth2023),2) as total_net_worth
from billionaires_by_country_2024
where UNmember = 'TRUE'
group by region;

-- 21. How do the wealthiest billionaires' net worths change relative to population growth rates across regions?
select 
region,
round(avg(Population_growthRate),2) as avg_population_growth,
max(BillionairesRichestNetWorth2023) as richest_billionaire_net_worth
from billionaires_by_country_2024
group by region;
