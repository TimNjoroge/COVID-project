
use PortfolioProject;
select * from CovidDeaths;
select * from CovidVaccinations;

/*Data exploration*/

/* SCENARIO 1 - Calculating % deaths for those diagnosed with COVID by country since 2020*/

select 
location,
date,
total_cases,
total_deaths,
(total_deaths/total_cases)*100 as PercentageDeath
from CovidDeaths
order by location, date desc;

/* SCENARIO 2 - Calculating % deaths for those diagnosed with COVID for a specific country*/

select 
location,
date,
total_cases,
total_deaths,
(total_deaths/total_cases)*100 as PercentageDeath
from CovidDeaths
where location like '%canada%'
order by date desc;

/*SCENARIO 3- Perecentage of the population diagonised with COVID specific country eg USA since 2020*/


select 
location,
date,
total_cases,
population,
(total_cases/population)*100 as PercentageDiagonised
from CovidDeaths
where location like '%states%'
order by date desc;


/*Scenario 4 - Countries with the highest infection rate compared to population*/


select 
location,
max(total_cases) as HighestInection,
population,
max((total_cases/population)*100) as PercentageDiagonised
from CovidDeaths
group by location, population
order by PercentageDiagonised desc;


/*Scenario 4 - Countries with the highest death count per population*/

select 
location,
max(cast(total_deaths as int)) as HighestDeathCount, /* converting total_deaths datatype from string to integer*/
population
from CovidDeaths
where location not in('World','Upper middle income', 'High income', 'Asia','Lower middle income','South America', 'European Union','Africa', 'High income', 'North America', 'Europe')
group by location, population
order by HighestDeathCount desc;

/*Scenario 4 - continent with the highest death count */

select 
location,
max(cast(total_deaths as int)) as HighestDeathCount /* converting total_deaths datatype from string to integer*/
from CovidDeaths
where continent is  null
and location not in('World','Upper middle income', 'High income','Lower middle income', 'European Union', 'International', 'Low income')
group by location
order by HighestDeathCount desc;


/*Scenario 5 - Global death % rate*/
select
sum(new_cases) as TotalCases,
sum(cast(new_deaths as int)) as TotalDeaths,
sum(cast(new_deaths as int))/sum(new_cases)*100 as PercentageDeath
from CovidDeaths;


/* Scenario 6 - Population of the world that has been vaccination*/

Select
cd.continent,
cd.location,
sum(cast(new_vaccinations as int)),
--cd.date,
cd.population
from PortfolioProject.dbo.CovidDeaths as cd
inner join PortfolioProject.dbo.CovidVaccinations as cv
		on cd.location = cv.location
		and cd.date=cv.date
where cd.continent is not null 
group by cd.continent, cd.location, cd.population
order by cd.location


/* Scenario 7 - creating a view*/

create view continetDeath as

/*Scenario 4 - continent with the highest death count */

select 
location,
max(cast(total_deaths as int)) as HighestDeathCount /* converting total_deaths datatype from string to integer*/
from CovidDeaths
where continent is  null
and location not in('World','Upper middle income', 'High income','Lower middle income', 'European Union', 'International', 'Low income')
group by location
--order by HighestDeathCount desc;

select * from [dbo].[continetDeath]