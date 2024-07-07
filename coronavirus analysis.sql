select * from [dbo].[Corona Virus Dataset]
Where Province IS NULL 
OR Latitude is  NULL
OR [CountryRegion] IS NULL
OR Longitude IS NULL
OR Date IS NULL 
OR Confirmed IS NULL
OR Deaths IS NULL
OR Recovered IS NULL;


SELECT  Count (*) AS TotalROWS from [dbo].[Corona Virus Dataset] ;

Select Min (Date) AS Start_Date,
Max(Date) AS Last_Date
from [dbo].[Corona Virus Dataset];

Select count (Distinct Datepart (Year, Date) * 100 + Datepart (Month , Date)) AS NumberOfMonths from [dbo].[Corona Virus Dataset];
SELECT Date from [dbo].[Corona Virus Dataset];
select Distinct DATEPART(Year,Date) AS CovidYear from [dbo].[Corona Virus Dataset] ;
select Distinct DATEPART(Month,Date) AS CovidMonth from [dbo].[Corona Virus Dataset] 
ORDER BY CovidMonth ASC;

Select 
 Distinct DATEPART(Month,Date) AS CovidMonth , 
 DATEPART(Year,Date) AS CovidYear, 
 AVG (Confirmed) AS AverageConfirmed, 
AVG  (Deaths) AS AverageDeaths,
AVG (Recovered ) AS  AverageRecovered

from [dbo].[Corona Virus Dataset] 
Group by DATEPART(Month,Date), DATEPART(Year,Date)
Order by DATEPART(Year,Date), DATEPART(Month,Date); ----monthly avg


With ConfirmedFrequencies AS (
    SELECT
    Confirmed,
    DATEPART(Year, Date)CovidYear,
    DATEPART(Month, Date)CovidMonth,
    COUNT(*) AS Frequency,
    Row_Number () OVER(PARTITION BY DATEPART(YEAR, DATE), DATEPART(MONTH, DATE) ORDER BY COUNT(*) DESC ) AS rn
    from [dbo].[Corona Virus Dataset] 
    group by DATEPART(Year, Date),
    DATEPART(Month, Date),Confirmed

),
 DeathsFrequencies AS (
    Select Deaths,
    DATEPART(Year, Date)CovidYear,
    DATEPART(Month,Date)CovidMonth,
    Count(*) as Frequency,
    ROW_NUMBER() OVER(Partition By Datepart(Year, Date), Datepart(Month,Date) ORDER BY Count(*)Desc) AS rn
    from [dbo].[Corona Virus Dataset] 
    GROUP BY DATEPART(Year, Date), DATEPART(Month, Date), Deaths
),

RecoveredFrequencies AS (
    SELECT Recovered,
    Datepart(Year, Date) AS CovidYear,
    Datepart(Month, Date) AS CovidMonth,
    Count(*) as Frequency,
    ROW_NUMBER() OVER (Partition BY Datepart(Year, Date), Datepart(Month, Date) ORDER BY Count(*) Desc) AS rn 
    from [dbo].[Corona Virus Dataset] 
    GROUP BY Datepart(Year, Date), Datepart(Month, Date), Recovered
)
SELECT
c.CovidMonth,
c.CovidYear, 
c.Confirmed as ConfirmedFrequencies,
d.Deaths as DeathsFrequecies,
r.Recovered as RecoveredFrequencies
from ConfirmedFrequencies as c 
join DeathsFrequencies d ON c.CovidMonth = d.CovidMonth AND c.CovidYear = d.CovidYear AND c.rn = 1 AND d.rn = 1
JOIN RecoveredFrequencies r ON c.CovidMonth = r.CovidMonth AND c.CovidYear = r.CovidYear AND r.rn = 1
ORDER BY c.CovidMonth, c.CovidYear;


With LowestConfirmed AS (
    Select  DATEPART(Year,Date) AS CovidYear,
    MIN (Confirmed) AS LowestConfirmed
    from [dbo].[Corona Virus Dataset]
    Group by DATEPART(Year,Date)

),
LowestDeaths AS (
    Select 
    DATEPART(Year,Date) AS CovidYear,
MIN (Deaths) AS LowestDeaths
from [dbo].[Corona Virus Dataset]
Group by DATEPART(Year,Date)
),

LowestRecovered AS (
    SELECT DATEPART(Year,Date) AS CovidYear,
MIN (Recovered) AS LowestRecovered
from [dbo].[Corona Virus Dataset]
group by DATEPART(Year,Date)
)

SELECT 
c.CovidYear,
c.LowestConfirmed,
d.LowestDeaths,
r.LowestRecovered
from LowestConfirmed c 
join LowestDeaths d ON c.CovidYear = d.CovidYear
JOIN LowestRecovered r ON c.CovidYear = r.CovidYear

Order by c.CovidYear;



With HighestConfirmed AS (
    Select  DATEPART(Year,Date) AS CovidYear,
    MAX (Confirmed) AS HighestConfirmed
    from [dbo].[Corona Virus Dataset]
    Group by DATEPART(Year,Date)

),
HighestDeaths AS (
    Select 
    DATEPART(Year,Date) AS CovidYear,
MAX (Deaths) AS HighestDeaths
from [dbo].[Corona Virus Dataset]
Group by DATEPART(Year,Date)
),

HighestRecovered AS (
    SELECT DATEPART(Year,Date) AS CovidYear,
MAX (Recovered) AS HighestRecovered
from [dbo].[Corona Virus Dataset]
group by DATEPART(Year,Date)
)

SELECT 
c.CovidYear,
c.HighestConfirmed,
d.HighestDeaths,
r.HighestRecovered
from HighestConfirmed c 
join HighestDeaths d ON c.CovidYear = d.CovidYear
JOIN HighestRecovered r ON c.CovidYear = r.CovidYear
Order by c.CovidYear;


With TotalConfirmedCase AS (
    SELECT 
     DATEPART(Month, Date) AS CovidMonth,
     DATEPART(YEAR, Date) AS CovidYear,
     SUM(Confirmed) AS TotalConfirmed
     from [dbo].[Corona Virus Dataset]
     GROUP BY DATEPART(Month, Date),  DATEPART(YEAR, Date)
),
 TotalDeathsCase AS (
    SELECT 
     DATEPART(Month, Date) AS CovidMonth,
     DATEPART(YEAR, Date) AS CovidYear,
     SUM(Deaths) AS TotalDeaths
     from [dbo].[Corona Virus Dataset]
     GROUP BY DATEPART(Month, Date),  DATEPART(YEAR, Date)
 ),
 TotalRecorveredCase AS (
    SELECT 
     DATEPART(Month, Date) AS CovidMonth,
     DATEPART(YEAR, Date) AS CovidYear,
     SUM(Recovered) AS TotalRecovered
     from [dbo].[Corona Virus Dataset]
     GROUP BY DATEPART(Month, Date),  DATEPART(YEAR, Date)
 )

Select
    c.CovidMonth,
    c.CovidYear,
    c.TotalConfirmed,
    d.TotalDeaths,
    r.TotalRecovered
    from TotalConfirmedCase c 
    Join TotalDeathsCase d ON c.CovidMonth = d.CovidMonth AND c.CovidYear = d.CovidYear 
    JOIN TotalRecorveredCase r on c.CovidMonth = r.CovidMonth AND c.CovidYear = r.CovidYear
    ORDER BY c.CovidMonth, c.CovidYear;

Select Datepart(YEAR, Date) AS CovidYear, DATEPART(Month, Date) AS CovidMonth, AVG(Deaths) AS AverageDeaths,
COUNT (Deaths) AS TotalDeaths,
VAR (Deaths) AS DeathsVariance,
STDEV (Deaths) AS DeathsST
FROM [dbo].[Corona Virus Dataset]
Group by Datepart(YEAR, Date),DATEPART(Month, Date) 
Order by CovidMonth, CovidYear;

Select Datepart(YEAR, Date) AS CovidYear, DATEPART(Month, Date) AS CovidMonth,AVG(Confirmed) AS AverageConfirmed,
COUNT (Confirmed) AS TotalConfirmed,
VAR (Confirmed) AS ConfirmedVariance,
STDEV (Confirmed) AS ConfirmedST
FROM [dbo].[Corona Virus Dataset]
Group by Datepart(YEAR, Date),DATEPART(Month, Date) 
Order by CovidMonth, CovidYear;

Select AVG(Recovered) AS AverageRecovered,
COUNT (Recovered) AS TotalRecovered,
VAR (Recovered) AS RecoveredVariance,
STDEV (Recovered) AS RecoveredST
FROM [dbo].[Corona Virus Dataset];


Select Top 1 CountryRegion, MAX (Confirmed) AS HighestConfirmed
from [dbo].[Corona Virus Dataset]
GROUP by CountryRegion
ORDER BY HighestConfirmed desc;

Select Top 1 CountryRegion, MIN (Deaths) AS LowestDeaths
from [dbo].[Corona Virus Dataset]
GROUP by CountryRegion
ORDER BY LowestDeaths desc;


Select Top 5 CountryRegion, MAX (Recovered) AS HighestRecovered
from [dbo].[Corona Virus Dataset]
GROUP by CountryRegion
ORDER BY HighestRecovered desc;
