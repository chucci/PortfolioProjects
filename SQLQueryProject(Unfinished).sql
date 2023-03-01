select *
from PortfolioProject..CovidDeaths
where continent is not null
order by 3,4

--select *
--from PortfolioProject..CovidVaccinations
--order by 3,4

--select the data to be used

Select Location, date, total_cases, new_cases, total_deaths, population
from PortfolioProject..CovidDeaths
where continent is not null
order by 1,2

-- total cases vs total deaths

--Select Location, date, total_cases,total_deaths, 
--(cast(total_deaths as decimal (10,2)) / (cast(total_cases as decimal (10,2))) * 100 as DeathPercentage
--from PortfolioProject..CovidDeaths
--order by 1,2

--SELECT Location, date, total_cases, total_deaths, 
--       (CAST(total_deaths AS DECIMAL(10,2)) / CAST(total_cases AS DECIMAL(10,2))) * 100 as DeathPercentage
--FROM PortfolioProject..CovidDeaths
--ORDER BY 1, 2;

--SELECT Location, date, total_cases, total_deaths, 
--       CASE WHEN total_cases = 0 THEN NULL ELSE 
--       (CAST(NULLIF(total_deaths,'') AS DECIMAL(10,2)) / CAST(NULLIF(total_cases,'') AS DECIMAL(10,2))) * 100 END as DeathPercentage
--FROM PortfolioProject..CovidDeaths
--ORDER BY 1, 2;

--SELECT Location, date, total_cases, total_deaths, 
--       CASE WHEN total_cases = 0 THEN NULL ELSE 
--       ROUND((CAST(NULLIF(total_deaths,'') AS DECIMAL(20,4)) / CAST(NULLIF(total_cases,'') AS DECIMAL(20,4))) * 100, 2) END as DeathPercentage
--FROM PortfolioProject..CovidDeaths
--ORDER BY 1, 2;

--SELECT Location, FORMAT(date, 'yyyy-MM-dd') AS date, 
--       FORMAT(total_cases, '#,###') AS total_cases, 
--       FORMAT(total_deaths, '#,###') AS total_deaths, 
--       CASE WHEN total_cases = 0 THEN NULL ELSE 
--       FORMAT((CAST(NULLIF(total_deaths,'') AS DECIMAL(20,4)) / CAST(NULLIF(total_cases,'') AS DECIMAL(20,4))) * 100, '0.00') + '%' END as DeathPercentage
--FROM PortfolioProject..CovidDeaths
--ORDER BY 1, 2;

SELECT Location, CONVERT(VARCHAR(10), date, 120) AS date, 
       FORMAT(CAST(total_cases AS INT), '#,###') AS total_cases, 
       FORMAT(CAST(total_deaths AS INT), '#,###') AS total_deaths, 
       CASE WHEN total_cases = 0 THEN NULL ELSE 
       FORMAT((CAST(NULLIF(total_deaths,'') AS DECIMAL(20,4)) / CAST(NULLIF(total_cases,'') AS DECIMAL(20,4))) * 100, '0.00') + '%' END as DeathPercentage
FROM PortfolioProject..CovidDeaths
where location like '%states%'
and continent is not null
ORDER BY 1, 2;

-- total cases vs popultaion

--SELECT Location, CONVERT(VARCHAR(10), date, 120) AS date, 
--       FORMAT(CAST(total_cases AS INT), '#,###') AS total_cases, 
--       FORMAT(CAST(population AS INT), '#,###') AS population, 
--       CASE WHEN total_cases = 0 THEN NULL ELSE 
--       FORMAT((CAST(NULLIF(total_cases,'') AS DECIMAL(20,4)) / CAST(NULLIF(population,'') AS DECIMAL(20,4))) * 100, '0.00') + '%' END as DeathPercentage
--FROM PortfolioProject..CovidDeaths
--ORDER BY 1, 2;

SELECT Location, CONVERT(VARCHAR(10), date, 120) AS date, 
       FORMAT(CAST(total_cases AS BIGINT), '#,###') AS total_cases, 
       FORMAT(CAST(population AS BIGINT), '#,###') AS population, 
       CASE WHEN total_cases = 0 THEN NULL ELSE 
       FORMAT((CAST(NULLIF(total_cases,'') AS DECIMAL(20,4)) / CAST(NULLIF(population,'') AS DECIMAL(20,4))) * 100, '0.00') + '%' END as DeathPercentage
FROM PortfolioProject..CovidDeaths
where location like '%states%'
and continent is not null

ORDER BY 1, 2;



-- countries with highest infection rate compared to population


--SELECT Location 
--       FORMAT(CAST MAX(total_cases AS BIGINT), '#,###') AS HighestInfectionCount, 
--       FORMAT(CAST(population AS BIGINT), '#,###') AS population, 
--       CASE WHEN total_cases = 0 THEN NULL ELSE 
--       FORMAT((CAST MAX(NULLIF(total_cases,'') AS DECIMAL(20,4)) / CAST(NULLIF(population,'') AS DECIMAL(20,4))) * 100, '0.00') + '%' END as PercentPopulationInfected
--FROM PortfolioProject..CovidDeaths
--ORDER BY 1, 2;


SELECT Location, 
       FORMAT(MAX(CAST(total_cases AS BIGINT)), '#,###') AS HighestInfectionCount, 
       FORMAT(CAST(population AS BIGINT), '#,###') AS population, 
       CASE WHEN MAX(total_cases) = 0 THEN NULL ELSE 
       FORMAT((MAX(CAST(NULLIF(total_cases,'') AS DECIMAL(20,4))) / CAST(NULLIF(population,'') AS DECIMAL(20,4))) * 100, '0.00') + '%' END as PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
GROUP BY Location, population
ORDER BY 1, 2;

SELECT Location, 
       FORMAT(MAX(CAST(total_cases AS BIGINT)), '#,###') AS HighestInfectionCount, 
       FORMAT(CAST(population AS BIGINT), '#,###') AS population, 
       CASE WHEN MAX(total_cases) = 0 THEN NULL ELSE 
       FORMAT((MAX(CAST(NULLIF(total_cases,'') AS DECIMAL(20,4))) / CAST(NULLIF(population,'') AS DECIMAL(20,4))) * 100, '0.00') + '%' END as PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
GROUP BY Location, population
ORDER BY PercentPopulationInfected desc

-- countries with highest death count

--Select Location,FORMAT (MAX(CAST(total_deaths as INT)), '#,###') as TotalDeathCount
--FROM PortfolioProject..CovidDeaths
--where continent is not null
--GROUP BY Location
--ORDER BY TotalDeathCount desc

Select Location, MAX(CAST(Total_Deaths as INT)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
where continent is not null
GROUP BY Location
ORDER BY TotalDeathCount desc

-- VIA Continent


-- Continents with the highest death count per population

Select continent, MAX(CAST(Total_Deaths as INT)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
where continent is not null
GROUP BY continent
ORDER BY TotalDeathCount desc

-- Global Numbers
--SELECT CONVERT(VARCHAR(10), date, 120) AS date, 
--       FORMAT(CAST(total_cases AS INT), '#,###') AS total_cases, 
--       FORMAT(CAST(total_deaths AS INT), '#,###') AS total_deaths, 
--       CASE WHEN total_cases = 0 THEN NULL ELSE 
--       FORMAT((CAST(NULLIF(total_deaths,'') AS DECIMAL(20,4)) / CAST(NULLIF(total_cases,'') AS DECIMAL(20,4))) * 100, '0.00') + '%' END as DeathPercentage
--FROM PortfolioProject..CovidDeaths
----where location like '%states%'
--and continent is not null
--ORDER BY 1, 2;

SELECT date, 
       FORMAT(SUM(CAST(new_cases AS INT)), '#,###') AS TotalCases, 
       FORMAT(SUM(CAST(new_deaths AS INT)), '#,###') AS TotalDeaths,
       CASE WHEN SUM(CAST(NULLIF(new_cases, '') AS INT)) = 0 AND SUM(CAST(NULLIF(new_deaths, '') AS INT)) = 0 THEN NULL 
            ELSE FORMAT((SUM(CAST(NULLIF(new_deaths, '') AS INT)) / SUM(CAST(NULLIF(new_cases, '') AS INT))) * 100, '0.00') + '%' END AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY date;

-- with no date
SELECT 
       FORMAT(SUM(CAST(new_cases AS INT)), '#,###') AS TotalCases, 
       FORMAT(SUM(CAST(new_deaths AS INT)), '#,###') AS TotalDeaths,
       CASE WHEN SUM(CAST(NULLIF(new_cases, '') AS INT)) = 0 AND SUM(CAST(NULLIF(new_deaths, '') AS INT)) = 0 THEN NULL 
            ELSE FORMAT((SUM(CAST(NULLIF(new_deaths, '') AS INT)) / SUM(CAST(NULLIF(new_cases, '') AS INT))) * 100, '0.00') + '%' END AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
and location like '%states%'
ORDER BY 1,2

--SELECT 
--       FORMAT(SUM(CAST(new_cases AS INT)), 'N0') AS TotalCases, 
--       FORMAT(SUM(CAST(new_deaths AS INT)), 'N0') AS TotalDeaths,
--       CASE WHEN SUM(CAST(NULLIF(new_cases, '') AS INT)) = 0 AND SUM(CAST(NULLIF(new_deaths, '') AS INT)) = 0 THEN NULL 
--            ELSE FORMAT((SUM(CAST(NULLIF(new_deaths, '') AS INT)) / SUM(CAST(NULLIF(new_cases, '') AS INT))) * 100, '0.00') + '%' END AS DeathPercentage
--FROM PortfolioProject..CovidDeaths
--WHERE continent IS NOT NULL
----GROUP BY date
--ORDER BY 1,2

SELECT date,
       SUM(CASE WHEN ISNUMERIC(new_cases) = 1 THEN CAST(new_cases AS INT) ELSE 0 END) AS TotalCases,
       SUM(CASE WHEN ISNUMERIC(new_deaths) = 1 THEN CAST(new_deaths AS INT) ELSE 0 END) AS TotalDeaths,
       CASE WHEN SUM(CASE WHEN ISNUMERIC(new_cases) = 1 THEN CAST(new_cases AS INT) ELSE 0 END) = 0 THEN NULL 
            ELSE FORMAT((SUM(CASE WHEN ISNUMERIC(new_deaths) = 1 THEN CAST(new_deaths AS INT) ELSE 0 END) / NULLIF(SUM(CASE WHEN ISNUMERIC(new_cases) = 1 THEN CAST(new_cases AS INT) ELSE 0 END), 0)) * 100, '0.00') + '%' END AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY date;

SELECT date,
       SUM(CASE WHEN ISNUMERIC(new_cases) = 1 THEN CAST(new_cases AS INT) ELSE 0 END) AS TotalCases,
       SUM(CASE WHEN ISNUMERIC(new_deaths) = 1 THEN CAST(new_deaths AS INT) ELSE 0 END) AS TotalDeaths,
       SUM(CASE WHEN ISNUMERIC(new_cases) = 1 THEN CAST(new_cases AS INT) ELSE 0 END) / NULLIF(SUM(CASE WHEN ISNUMERIC(new_cases) = 1 THEN CAST(new_cases AS INT) ELSE 0 END), 0) AS RawDeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY date;

-- In here I'am figuring out why the DeathPercentage gets 0%

-- Total Population vs Vaccinations 

Select dea.continent, dea.date, dea.location, dea.population, vac.new_vaccinations
from PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
on dea.location = vac.location and dea.date = vac.date




