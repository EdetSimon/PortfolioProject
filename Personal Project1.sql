-- Coronavirus Deaths(During the Covid Time)

SELECT *
FROM coviddeaths
WHERE continent IS NOT NULL
ORDER BY 3,4;

-- Selecting the Data that we're going to be using

SELECT location, `date`, total_cases, new_cases, total_deaths, population
FROM coviddeaths
ORDER BY 1,2 ASC;

-- To have the same information that I'm walking with, you need to convert date to (YEAR-MONTH-DAY)
-- follow the next steps to do that

SELECT `date`
FROM coviddeaths;

UPDATE coviddeaths
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE coviddeaths
MODIFY COLUMN `date` DATE;

-- Looking at the Total cases vs the Total Deaths
-- Shows the likelihood of dying if you contracted Covid in Your Country

SELECT location, `date`, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM coviddeaths
WHERE location LIKE 'Nigeria'
ORDER BY 1,2 ASC;

-- Looking at the Total cases vs the Population
-- Shows what percentage of Population had Covid

SELECT location, `date`, population, total_cases, (total_cases/population)*100 AS PercentPopulationInfected
FROM coviddeaths
-- WHERE location LIKE '%states%'
ORDER BY 1,2;


-- Looking at Countries with Highest Infection Rate compared to Population

SELECT location, population, MAX(total_cases) AS HighestInfectionCount, (total_cases/population)*100 AS 
PercentPopulationInfected
FROM coviddeaths
-- WHERE location LIKE '%states%'
GROUP BY location, population, total_cases
ORDER BY PercentPopulationInfected DESC; 

-- Showing the Countries with Highest Death Count per Population

SELECT location, MAX(CAST(total_deaths AS SIGNED)) AS totaldeathcount
FROM coviddeaths
-- WHERE location LIKE '%states%'
GROUP BY location
ORDER BY totaldeathcount DESC; 


-- Showing the Continents with the Highest Death Counts

SELECT continent, MAX(CAST(total_deaths AS SIGNED)) AS totaldeathcount
FROM coviddeaths
-- WHERE location LIKE '%states%'
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY totaldeathcount DESC;

-- Global Numbers

SELECT `date`, SUM(new_cases)AS totalcases, SUM(new_deaths) AS totaldeaths, SUM(new_deaths)/SUM(new_cases)*100 AS DeathPercentage
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY `date`
ORDER BY 1,2 ASC;

-- Death Percentage in the whole Continent
SELECT SUM(new_cases)AS totalcases, SUM(new_deaths) AS totaldeaths, SUM(new_deaths)/SUM(new_cases)*100 AS DeathPercentage
FROM coviddeaths
WHERE continent IS NOT NULL
ORDER BY 1,2 ASC;


SELECT *
FROM covidvaccinations;






























