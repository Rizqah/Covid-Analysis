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

Select AVG (Confirmed) AS AverageConfirmed, 
AVG  (Deaths) AS AverageDeaths,
AVG (Recovered ) AS  AverageRecovered

from [dbo].[Corona Virus Dataset] ;

SELECT Confirmed, COUNT (*) AS ConfirmedFrequency
from [dbo].[Corona Virus Dataset]
GROUP BY Confirmed
ORDER BY ConfirmedFrequency desc;


SELECT Deaths, COUNT (*) AS DeathsFrequency
from [dbo].[Corona Virus Dataset]
GROUP BY Deaths
ORDER BY DeathsFrequency desc;

SELECT Recovered, COUNT (*) AS RecoveredFrequency
from [dbo].[Corona Virus Dataset]
GROUP BY Recovered
ORDER BY RecoveredFrequency desc;

SELECT Distinct DATEPART(Year,Date) AS CovidYear,
MIN (Confirmed) AS LowestConfirmed
from [dbo].[Corona Virus Dataset]
GROUP BY DATEPART(Year,Date) 
ORDER BY LowestConfirmed asc;

SELECT Distinct DATEPART(Year,Date) AS CovidYear,
MIN (Deaths) AS LowestDeaths
from [dbo].[Corona Virus Dataset]
GROUP BY DATEPART(Year,Date) 
ORDER BY LowestDeaths asc;

SELECT Distinct DATEPART(Year,Date) AS CovidYear,
MIN (Recovered) AS LowestRecovered
from [dbo].[Corona Virus Dataset]
GROUP BY DATEPART(Year,Date) 
ORDER BY LowestRecovered asc;


SELECT Distinct DATEPART(Year,Date) AS CovidYear,
MAX (Confirmed) AS LowestConfirmed
from [dbo].[Corona Virus Dataset]
GROUP BY DATEPART(Year,Date) 
ORDER BY LowestConfirmed asc;

SELECT Distinct DATEPART(Year,Date) AS CovidYear,
MAX (Recovered) AS LowestRecovered
from [dbo].[Corona Virus Dataset]
GROUP BY DATEPART(Year,Date) 
ORDER BY LowestRecovered asc;

SELECT Distinct DATEPART(Year,Date) AS CovidYear,
MAX (Deaths) AS LowestDeaths
from [dbo].[Corona Virus Dataset]
GROUP BY DATEPART(Year,Date) 
ORDER BY LowestDeaths asc;


Select Distinct DATEPART(Month, Date) AS CovidMonth,
COUNT(Confirmed) as TotalConfirmed
from [dbo].[Corona Virus Dataset]
GROUP by DATEPART(Month, Date)
Order BY CovidMonth asc;


Select Distinct DATEPART(Month, Date) AS CovidMonth,
COUNT(Deaths) as TotalDeaths
from [dbo].[Corona Virus Dataset]
GROUP by DATEPART(Month, Date)
Order BY DATEPART(Month, Date)  asc;


Select Distinct DATEPART(Month, Date) AS CovidMonth,
COUNT(Recovered) as TotalRecovered
from [dbo].[Corona Virus Dataset]
GROUP by DATEPART(Month, Date)
Order BY DATEPART(Month, Date)  asc;


Select AVG(Deaths) AS AverageDeaths,
COUNT (Deaths) AS TotalDeaths,
VAR (Deaths) AS DeathsVariance,
STDEV (Deaths) AS DeathsST
FROM [dbo].[Corona Virus Dataset];

Select AVG(Confirmed) AS AverageConfirmed,
COUNT (Confirmed) AS TotalConfirmed,
VAR (Confirmed) AS ConfirmedVariance,
STDEV (Confirmed) AS ConfirmedST
FROM [dbo].[Corona Virus Dataset];

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