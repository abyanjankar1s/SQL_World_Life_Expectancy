SELECT * 
FROM worldlifexpectancy;

#Most improvement in life expectancy as per country. 
SELECT Country, 
MIN(Lifeexpectancy), 
MAX(Lifeexpectancy),
ROUND((MAX(Lifeexpectancy) - MIN(Lifeexpectancy)),1 )AS Diff
FROM worldlifexpectancy
GROUP BY Country
HAVING MIN(Lifeexpectancy) <> 0
AND MAX(Lifeexpectancy) <> 0
ORDER BY Diff DESC
; 

#Life Expectancy over 15 years as a whole world. 
SELECT Year, ROUND(AVG(Lifeexpectancy),1)  
FROM worldlifexpectancy
GROUP BY Year
ORDER BY Year
;

#relation to GDP 
SELECT Country, 
ROUND(AVG(Lifeexpectancy),1) AS Life_exp, 
ROUND(AVG(GDP),1) AS GDP
FROM worldlifexpectancy
GROUP BY Country
HAVING Life_exp > 0
AND GDP > 0 
ORDER BY Life_exp ASC
;

SELECT 
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP_Count,
AVG(CASE WHEN GDP >= 1500 THEN `Lifeexpectancy` ELSE NULL END) HIGH_GDP_Life_Exp,
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) Low_GDP_Count,
AVG(CASE WHEN GDP <= 1500 THEN `Lifeexpectancy` ELSE NULL END) Low_GDP_Life_Exp
FROM worldlifexpectancy 
;


#In terms of Status 
SELECT Status, COUNT(DISTINCT Country), ROUND(AVG(Lifeexpectancy),1)
FROM worldlifexpectancy
GROUP BY Status
;

#BMI 
SELECT Country, 
ROUND(AVG(Lifeexpectancy),1) AS Life_exp, 
ROUND(AVG(BMI),1) AS BMI
FROM worldlifexpectancy
GROUP BY Country
HAVING Life_exp > 0
AND BMI > 0 
ORDER BY BMI ASC
;


#Mortality with Rolling Total 
SELECT Country,
Year,
Lifeexpectancy, 
AdultMortality,
SUM(AdultMortality) OVER (PARTITION BY Country ORDER BY Year) AS Rolling_total
FROM worldlifexpectancy
WHERE Country LIKE '%United%'
; 



