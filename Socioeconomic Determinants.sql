CREATE TABLE economic_info (
    CountryName VARCHAR(50),
    CountryCode VARCHAR(3),
    Region VARCHAR(30),
    IncomeGroup VARCHAR(20),
    Year INT,
    LifeExpectancy FLOAT,
    Undernourishment FLOAT,
    CO2 DECIMAL(15 , 4 ),
    HealthExpenditure DECIMAL(15 , 4 ),
    EducationExpenditure DECIMAL(15 , 4 ),
    Unemployment DECIMAL(15 , 4 ),
    Corruption FLOAT,
    Sanitation DECIMAL(15 , 4 ),
    Injuries DECIMAL(15 , 4 ),
    Communicable DECIMAL(15 , 4 ),
    NonCommunicable DECIMAL(15 , 4 )
);

LOAD DATA INFILE 'C://ProgramData//MySQL//MySQL Server 9.0//Uploads//life_expectancy.csv'
INTO TABLE economic_info
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(CountryName, CountryCode, Region, IncomeGroup, Year, @LifeExpectancy, @Undernourishment,
@CO2, @HealthExpenditure, @EducationExpenditure, @Unemployment, @Corruption,
@Sanitation, @Injuries, @Communicable, @NonCommunicable)
set
	Undernourishment = nullif(@Undernourishment, ''),
    LifeExpectancy = NULLIF(@LifeExpectancy, ''),
	CO2 = NULLIF(@CO2, ''),
    HealthExpenditure = NULLIF(@HealthExpenditure, ''),
    EducationExpenditure = NULLIF(@EducationExpenditure, ''),
    Unemployment = NULLIF(@Unemployment, ''),
    Corruption = NULLIF(@Corruption, ''),
    Sanitation = NULLIF(@Sanitation, ''),
    Injuries = NULLIF(@Injuries, ''),
    Communicable = NULLIF(@Communicable, ''),
    NonCommunicable = NULLIF(@NonCommunicable, '');
    
/*
The above code is modified because there are many columns with missing values
*/


CREATE TABLE CountryStats (
    CountryCode VARCHAR(3),
    Year INT,
    AvgLifeExpectancy DECIMAL(10 , 2 ),
    TotalCO2 DECIMAL(10 , 2 )
);

-- inserting values

insert into CountryStats (CountryCode, Year, AvgLifeExpectancy, TotalCO2)
select
CountryCode,
Year,
avg(LifeExpectancy) as 'AvgLifeExpectancy',
sum(CO2) as 'TotalCO2'
from
economic_info
group by CountryCode, Year;

-- Update the IncomeGroup of a specific country in the economic_info table based on changes in its economic status.

CREATE TABLE economic_info_backup AS SELECT * FROM
    economic_info;-- backup created for updates

UPDATE economic_info_backup e
        JOIN
    countrystats c ON e.countrycode = e.countrycode
        AND e.year = c.year 
SET 
    e.IncomeGroup = CASE
        WHEN
            c.AvgLifeExpectancy < 50
                AND c.TotalCO2 < 1000
        THEN
            'Low Income'
        WHEN
            c.AvgLifeExpectancy < 60
                AND c.TotalCO2 < 2000
        THEN
            'Lower Middle Income'
        WHEN
            c.AvgLifeExpectancy < 70
                AND c.TotalCO2 < 3000
        THEN
            'Upper Middle Income'
        ELSE 'High Income'
    END;

SELECT 
    *
FROM
    economic_info_backup;

-- delete unnecessary columns with lots of missing values

alter table economic_info_backup
drop column corruption;

-- 2. Common Table Expressions (CTEs)

SELECT 
    countryname,
    ROUND(AVG(LifeExpectancy), 2) AS AvgLifeExpectancy
FROM
    economic_info_backup
GROUP BY CountryName
ORDER BY AvgLifeExpectancy;

with above_average_life (CountryName, avg_life)
as
(select countryname, round(avg(LifeExpectancy),2)
from
economic_info_backup
group by CountryName)
select e.countryname, av.avg_life, year
from economic_info_backup e
join above_average_life av on e.CountryName = av.CountryName 
where e.LifeExpectancy > av.avg_life
order by avg_life;

-- Create a CTE that ranks countries within each Region based on their HealthExpenditure in descending order.

WITH ranked_countries AS
(
    SELECT 
        countryname, 
        region, 
        AVG(HealthExpenditure) AS avg_health_expenditure,
        RANK() OVER (PARTITION BY region ORDER BY AVG(HealthExpenditure) DESC) AS rnk
    FROM 
        economic_info_backup
    GROUP BY 
        countryname, region
)
SELECT 
    countryname, 
    region, 
    avg_health_expenditure,
    rnk
FROM 
    ranked_countries
ORDER BY 
    region, rnk;

-- Utilize a CTE to calculate the percentage change in CO2 emissions for each country between two specified years.

SELECT 
    e1.countryname,
    e1.year AS Year_Current,
    e1.co2 AS CO2_Current,
    e2.year AS Year_Previous,
    e2.co2 AS CO2_Previous,
    ((e1.co2 - e2.co2) / e2.co2) * 100 AS '% Change in CO2 Emissions'
FROM
    economic_info_backup e1
        JOIN
    economic_info_backup e2 ON e1.countryname = e2.countryname
        AND e1.year = e2.year + 1
WHERE
    e1.year = 2010 AND e2.year = 2009;

-- Combine multiple CTEs to find countries that have both high LifeExpectancy and low Undernourishment rates.

SELECT 
    CountryName,
    Region,
    MAX(LifeExpectancy) 'High Life Expectancy',
    MIN(Undernourishment) AS 'Low Undernourishment'
FROM
    economic_info_backup
GROUP BY countryname , region
ORDER BY MAX(LifeExpectancy) DESC , MIN(Undernourishment) ASC;

WITH RankedCountries AS (
    SELECT 
        countryname, 
        region, 
        LifeExpectancy, 
        Undernourishment,
        RANK() OVER (PARTITION BY region ORDER BY LifeExpectancy DESC, Undernourishment ASC) AS rnk
    FROM 
        economic_info_backup
)
SELECT 
    countryname, 
    region, 
    LifeExpectancy, 
    Undernourishment,
    rnk AS RankWithinRegion
FROM 
    RankedCountries
ORDER BY 
    region, rnk;


/*
I believe this is one way of solving the task without a cte. However, let me try and do this with a CTE and
create a ranking system.
*/

with ranked_countries
as
(
select CountryName, Region, LifeExpectancy, Undernourishment,
rank() over(partition by Region order by LifeExpectancy desc, Undernourishment asc) as rnk
from
economic_info_backup
)
select Countryname, Region, LifeExpectancy, Undernourishment, rnk as 'Ranking Within Region'
from
ranked_countries
order by region, rnk;

-- 3. Window Functions
-- Important clauses in WindowFunctions row_number, over, partition by, rank, dense_rank, lag and lead
-- Calculate the running average of LifeExpectancy over the years for each country using a window function.

SELECT 
    CountryName, 
    Year, 
    LifeExpectancy,
    ROUND(AVG(LifeExpectancy) OVER (PARTITION BY CountryName ORDER BY Year
    range BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 2) AS RunningAvgLifeExpectancy
FROM 
    economic_info_backup
ORDER BY 
    CountryName, Year;
    
-- Assign a rank to each country within its Region based on CO2 emissions using the RANK() window function.

select countryname, region, round(avg(co2),2) as 'Avg CO2 Emissions',
rank() over(partition by Region order by avg(co2) desc) as 'Ranking of Emissions'
from
economic_info_backup
group by CountryName, region;

-- Use the LAG() or LEAD() window function to compare a country's LifeExpectancy to its previous or subsequent year.

select countryname, Year,
lag(LifeExpectancy) over(partition by region) as 'Lagged Life Expectancy',
lead(LifeExpectancy) over(partition by region) as 'Lead Life Expectancy'
from
economic_info_backup
where countryname = 'Albania'
order by year;-- haven't understood this fully yet.

SELECT 
    region,
    year,
    ROUND(AVG(LifeExpectancy), 2) AS 'Avg Life Expectancy',
    ROUND(SUM(CO2), 2) AS 'Total CO2 Emissions'
FROM
    economic_info_backup
GROUP BY region , year;

-- Determine the maximum and minimum HealthExpenditure for each IncomeGroup in a specific year.

SELECT 
    IncomeGroup,
    Year,
    MAX(HealthExpenditure) AS 'Highest Healthcare Expenditure',
    MIN(HealthExpenditure) AS 'Lowest Healthcare Expenditure'
FROM
    economic_info_backup
GROUP BY IncomeGroup , Year;

-- Count the number of countries in each IncomeGroup and Region combination.

SELECT 
    Region, IncomeGroup, COUNT(*) AS 'Total Count'
FROM
    economic_info_backup
GROUP BY Region , IncomeGroup;

-- Calculate the median Unemployment rate for each Year and Region.

SELECT 
    Unemployment, region, COUNT(*) AS 'Total Count'
FROM
    economic_info
GROUP BY Unemployment , Region
HAVING COUNT(*) > 1;-- I know how to calculate mean, but median and mode in SQL is difficult.
-- Median is supposed to be the most repeated value, so I thought of using having clause. I'm not sure if this is
-- correct.

SELECT DISTINCT
    countryname
FROM
    economic_info_backup
WHERE
    LifeExpectancy > 80;

-- Retrieve the top 10 countries with the highest HealthExpenditure in a specific year, sorted by
-- HealthExpenditure in descending order.

SELECT 
    countryname, HealthExpenditure
FROM
    economic_info
WHERE
    year = 2019
ORDER BY HealthExpenditure DESC
LIMIT 10;

-- Filter out countries with missing data in the Corruption column and display the remaining countries sorted
-- by IncomeGroup.

SELECT 
    e1.CountryName,
    e1.LifeExpectancy,
    e1.Year,
    ROUND(AVG(e2.LifeExpectancy), 2) AS 'Global Average'
FROM
    economic_info_backup e1
        JOIN
    economic_info_backup e2 ON e1.year = e2.year
GROUP BY CountryName , e1.year , e1.LifeExpectancy
ORDER BY e1.year , e1.CountryName;

-- 7. Subqueries

SELECT 
    CountryName, HealthExpenditure, IncomeGroup
FROM
    economic_info_backup e
WHERE
    HealthExpenditure > (SELECT 
            AVG(HealthExpenditure)
        FROM
            economic_info_backup e2
        WHERE
            e.IncomeGroup = e2.IncomeGroup)
ORDER BY HealthExpenditure DESC;

-- Find the Region with the highest average LifeExpectancy using a subquery.

SELECT 
    Region,
    ROUND(AVG(LifeExpectancy), 2) AS 'Highest Avg Life Expectancy'
FROM
    economic_info_backup
GROUP BY Region
HAVING AVG(LifeExpectancy) = (SELECT 
        MAX(avg_life_expectancy)
    FROM
        (SELECT 
            AVG(LifeExpectancy) AS avg_life_expectancy
        FROM
            economic_info_backup
        GROUP BY region) x);

-- Now using CTE to solve the same task

with cte
as
(select Region, avg(LifeExpectancy) as AvgLifeExpectancy
from
economic_info_backup
group by Region)
select Region, round(AvgLifeExpectancy, 2) as 'Highest Average Life Expectancy'
from
cte
where AvgLifeExpectancy = (select max(AvgLifeExpectancy) from cte);

-- Identify countries with CO2 emissions exceeding the average CO2 emissions of countries in the same
-- IncomeGroup and Year using a subquery.

SELECT 
    e1.CountryName, e1.CO2 AS 'CO2 Emissions'
FROM
    economic_info_backup e1
WHERE
    e1.CO2 > (SELECT 
            AVG(CO2)
        FROM
            economic_info_backup e2
        WHERE
            e2.IncomeGroup = e1.IncomeGroup
                AND e2.year = e1.year)
ORDER BY e1.CO2 DESC;

-- 8. String Functions
-- Extract the first three characters of the CountryName to create a new column representing a country code prefix.

SELECT 
    UPPER(SUBSTRING(countryname, 1, 3))
FROM
    economic_info_backup; -- this part extracts the first 3 letters in uppercase to be assigned as new country codes

alter table economic_info_backup
add column new_country_code varchar (3);-- this part adds a new column

UPDATE economic_info_backup 
SET 
    new_country_code = UPPER(SUBSTRING(countryname, 1, 3));

alter table economic_info_backup
drop column new_country_code;

-- Concatenate the CountryName and Year columns to create a unique identifier for each row.

SELECT 
    CONCAT(countryname, ' ', year) AS 'unique identifier'
FROM
    economic_info_backup;
    
-- 10. Conditional Logic
-- Use CASE statements to categorize countries into different groups based on their LifeExpectancy
-- (e.g., 'High', 'Medium', 'Low').

select countryname,
case
when LifeExpectancy between 50 and 60 then 'Low'
when LifeExpectancy between 61 and 70 then 'Medium'
else 'High'
end as 'Life Expectancy Category'
from
economic_info_backup;

-- Create a new column that indicates whether a country's HealthExpenditure is above or below the average for
-- its IncomeGroup.

alter table economic_info_backup
add column country_health varchar(10);

alter table economic_info_backup
modify column country_health varchar(20);

WITH income_group_avg AS (
    SELECT IncomeGroup, AVG(HealthExpenditure) AS avg_health_expenditure
    FROM economic_info_backup
    GROUP BY IncomeGroup
)
UPDATE economic_info_backup e
JOIN income_group_avg iga ON e.IncomeGroup = iga.IncomeGroup
SET e.country_health = CASE 
    WHEN e.HealthExpenditure > iga.avg_health_expenditure THEN 'Above Average'
    ELSE 'Below Average'
END;