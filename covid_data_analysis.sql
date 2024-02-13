--General EDA

SELECT *
FROM covidvaccinations
ORDER BY 3,4;

SELECT *
FROM coviddeaths
ORDER BY 3,4;

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM coviddeaths
WHERE location = 'Jamaica'
ORDER BY 1, 2;

-- Looking at Total Cases vs Total Deaths
-- Shows likelihood of death if dying if you contract COVID in your location.

SELECT location, date, total_cases, new_cases, total_deaths, (total_deaths/total_cases)*100 AS death_rate
FROM coviddeaths
WHERE location = 'Jamaica'
ORDER BY 1, 2;

-- Looking at Total Cases vs Population
-- The cumulative incidence rate shows what percentage of population got COVID and evaluates the risk of transmission within a country.

SELECT location, date, total_cases, population, (total_cases/population)*100 AS case_rate
FROM coviddeaths
WHERE location = 'Jamaica'
ORDER BY 1, 2;

-- Looking at countries with highest infection rate compared to population

SELECT location, population, MAX(total_cases) as HighestInfectionCount, MAX(total_cases/population)*100 AS case_rate
FROM coviddeaths
GROUP BY location, population
ORDER BY case_rate DESC;

-- Looking at countries with highest infection rate compared to population

SELECT location, continent, MAX(total_deaths) as TotalDeathCount
FROM coviddeaths
WHERE continent is NOT NULL
GROUP BY location, continent
ORDER BY TotalDeathCount DESC

-- Continents with highest death count 

SELECT continent, MAX(total_deaths) as TotalDeathCount
FROM coviddeaths
WHERE continent is NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC

-- Global Numbers
-- The case fatality rate helps us to measure the severity of the disease outbreak 

SELECT date, 
        SUM(new_cases) as total_cases, 
        SUM(new_deaths) as total_deaths, 
        SUM(new_deaths)/SUM(new_cases)*100 as case_fatality_rate
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1, 2;

-- All-time global fatality rate : COVID-19
SELECT
        SUM(new_cases) as total_cases, 
        SUM(new_deaths) as total_deaths, 
        SUM(new_deaths)/SUM(new_cases)*100 as case_fatality_rate
FROM coviddeaths
WHERE continent IS NOT NULL
ORDER BY 1, 2;

-- Looking at total population vs vaccinations
SELECT 
      t1.continent, 
      t1.location, 
      t1.date, 
      t1.population, 
      t2.new_vaccinations,
      SUM(t2.new_vaccinations) 
                OVER (PARTITION BY t1.location 
                      ORDER BY t1.location, t1.date) AS cumulative_vaccinations,
      MAX(cumulative_vaccinations)
FROM coviddeaths t1
JOIN covidvaccinations t2 
-- joining on two columns allows us to analyze 
-- COVID-19 deaths and vaccinations that occurred 
-- on the same date in the same location.
  ON t1.location = t2. location 
  AND t1.date = t2.date
WHERE t1.continent IS NOT NULL
ORDER BY 2,3

-- USE CTE

WITH PopVsVac (continent, location, date, population, new_vaccinations, cumulative_vaccinations)
AS
(
    SELECT 
        t1.continent, 
        t1.location, 
        t1.date, 
        t1.population, 
        t2.new_vaccinations,
        SUM(t2.new_vaccinations) 
            OVER (PARTITION BY t1.location 
                ORDER BY t1.date) AS cumulative_vaccinations
    FROM coviddeaths t1
    JOIN covidvaccinations t2 
        ON t1.location = t2.location 
        AND t1.date = t2.date
    WHERE t1.continent IS NOT NULL
) 
SELECT 
    *, 
    (cumulative_vaccinations/population)*100 AS vaccination_percentage
FROM PopVsVac;

-- Create Temp Table: Select-Into Method
-- In this approach, you create a temporary table based on the result set obtained from a SELECT statement

SELECT 
    *, 
    (cumulative_vaccinations/population)*100 AS vaccination_percentage
FROM PopVsVac;

DROP TEMPORARY TABLE IF EXISTS PercentPopulationVaccinated;
CREATE TEMPORARY TABLE PercentPopulationVaccinated
(
    continent VARCHAR(255),
    location VARCHAR(255),
    date DATETIME,
    population DECIMAL(18, 2),
    new_vaccinations DECIMAL(18, 2),
    cumulative_vaccinations DECIMAL(18, 2)
);

INSERT INTO PercentPopulationVaccinated (continent, location, date, population, new_vaccinations, cumulative_vaccinations)
SELECT 
    t1.continent, 
    t1.location, 
    t1.date, 
    t1.population, 
    t2.new_vaccinations,
    SUM(t2.new_vaccinations) 
        OVER (
            PARTITION BY t1.location 
            ORDER BY t1.date) 
    AS cumulative_vaccinations
FROM 
    coviddeaths t1
JOIN 
    covidvaccinations t2 ON t1.location = t2.location AND t1.date = t2.date
WHERE 
    t1.continent IS NOT NULL;
--- Run subquery
SELECT 
    *, 
    (cumulative_vaccinations/population)*100 AS vaccination_percentage
FROM PercentPopulationVaccinated;

-- Create a view 

DROP VIEW IF EXISTS PercentPopulationVaccinatedView;
CREATE VIEW PercentPopulationVaccinatedView AS
SELECT 
    t1.continent, 
    t1.location, 
    t1.date, 
    t1.population, 
    t2.new_vaccinations,
    SUM(t2.new_vaccinations) 
        OVER (
            PARTITION BY t1.location 
            ORDER BY t1.date) 
    AS cumulative_vaccinations
FROM 
    coviddeaths t1
JOIN 
    covidvaccinations t2 ON t1.location = t2.location AND t1.date = t2.date
WHERE 
    t1.continent IS NOT NULL;

