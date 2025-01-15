-- Crime Pattern Analysis --
-- 1. Crime Frequency by Type --
select `Crm Cd Desc`, Count(*) as `Crime_Count` 
from crimes
group by `Crm Cd Desc`
order by `Crime_Count` Desc
limit 10;

-- 2. Crime Trends Over Time --
select year(`Date Rptd`) as `Year`,
monthname(`Date Rptd`) as `Month`,
count(*) as `Crime_Count`
from crimes
where `Date Rptd` >= Date_sub(curdate(), interval 5 year)
group by `Year`, `Month`
order by `Year`, field(`Month`,'January','February','March', 'April','May','June',
'July','August','September','October','November', 'December');

-- 3. Seasonal Crime Patterns --
SELECT 
    CASE 
        WHEN MONTH(`Date Rptd`) IN (12, 1, 2) THEN 'Winter'
        WHEN MONTH(`Date Rptd`) IN (3, 4, 5) THEN 'Spring'
        WHEN MONTH(`Date Rptd`) IN (6, 7, 8) THEN 'Summer'
        ELSE 'Fall'
    END AS `Season`, 
    COUNT(*) AS `Crime_Count`
FROM crimes
GROUP BY `Season`
ORDER BY `Crime_Count` DESC;

-- 4. Crime by Hour of the Day --
SELECT HOUR(TIME(`TIME OCC`)) AS `Hour`,
COUNT(*) AS `Crime_Count`
FROM crimes
GROUP BY `Hour`
ORDER BY `Hour`;

-- 5. Crime Status Analysis --
SELECT `Status Desc`, COUNT(*) AS `Crime_Count`
FROM crimes
GROUP BY `Status Desc`
ORDER BY `Crime_Count` DESC;

-- Demographic Analysis --
-- 6. Victim Gender Analysis --
SELECT `Vict Sex`, COUNT(*) AS `Crime_Count`
FROM crimes
GROUP BY `Vict Sex`;

-- 7. Victim Age Distribution--
SELECT 
    CASE 
        WHEN `Vict Age` < 18 THEN '<18'
        WHEN `Vict Age` BETWEEN 18 AND 30 THEN '18-30'
        WHEN `Vict Age` BETWEEN 31 AND 50 THEN '31-50'
        ELSE '50+'
    END AS `Age_Group`, 
    COUNT(*) AS `Crime_Count`
FROM crimes
GROUP BY `Age_Group`
ORDER BY `Age_Group`;

-- 8. Victim Descent Analysis -- 
SELECT `Vict Descent`, COUNT(*) AS `Crime_Count`
FROM crimes
GROUP BY `Vict Descent`
ORDER BY `Crime_Count` DESC
LIMIT 5;

-- Geographic Analysis--
-- 9. Crime Count by Area -- 
SELECT `AREA NAME`, COUNT(*) AS `Crime_Count`
FROM crimes
GROUP BY `AREA NAME`
ORDER BY `Crime_Count` DESC;

-- 10. Crime Hotspots --
SELECT `AREA NAME`, COUNT(*) AS `Crime_Count`
FROM crimes
GROUP BY `AREA NAME`
ORDER BY `Crime_Count` DESC
LIMIT 5;

-- 11. Crime Distribution by Location --
SELECT `LOCATION`, COUNT(*) AS `Crime_Count`
FROM crimes
GROUP BY `LOCATION`
ORDER BY `Crime_Count` DESC
LIMIT 10;