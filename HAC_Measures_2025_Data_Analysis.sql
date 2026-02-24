-- Q1: What are the average HAC rates by measure in 2025?
SELECT
	Measure,
    ROUND(AVG(Rate), 4) AS AVG_HAC_Rate
FROM hac_measures_clean
GROUP BY Measure;

/*
- Falls and trauma average about 0.3335, far higher than the other measures
- Foreign objects retained after surgery is rare but an average of 0.0121 is still significant given the severity of surgical errors
- Air embolism and Blood incompatibility are nearly zero, indicating strong rarity of these measures in 2025
*/

-- Q2: Which measures show the highest and lowest HAC rates nationally?
SELECT 
    Measure, 
    MAX(Rate) AS Max_Rate, 
    MIN(Rate) AS Min_Rate
FROM HAC_Measures_Clean
GROUP BY Measure
ORDER BY Max_Rate DESC;

/*
- Falls and trauma show the widest range, with some hospitals reporting as high as 16 cases per 1000 discharges
- Foreign objects retained after surgery peaks at 1.541, rare but serious when it occurs
- Air embolism and Blood incompatibility remain very rare, with maximum rates of less that 0.5
- All measures have minimums of 0, so many hospitals reported no cases at all - reinforcing the idea that HAC's are preventable
*/

-- Q3:Which measures contribute most to variation in patient safety outcomes?
-- Use coefficient of variation (CV) measure relative dispersion instead of relying solely on standard deviation
SELECT 
    Measure,
    COUNT(DISTINCT Provider_ID) AS Provider_Count,
    ROUND(AVG(Rate), 4) AS Avg_Rate,
    ROUND(STDDEV_SAMP(Rate), 4) AS Std_Dev,
    ROUND(STDDEV_SAMP(Rate) / NULLIF(AVG(Rate), 0), 4) AS CV
FROM hac_measures_clean
GROUP BY Measure
HAVING COUNT(*) > 1
ORDER BY CV DESC;

/*
Blood incompatibility and Air embolism show the highest CV, but their mean rates are nearly zero. 
The inflated CV is driven by low base rates and not meaningful dispersion as is usually the case.
In practical terms, Falls and trauma contributes more to overall performance variation since it has the highest average rate and largest standard deviation.
*/

-- Q4: What condition areas should be prioritized to reduce hospital-acquired conditions and improve patient safety outcomes?
/*
- Falls and trauma is the most impactful and urgent condition area to address since it has the highest average rate (0.3325 per 1000 discharges),  widest range (up to 16 cases per 1000 discharges), and largest standard deviation (0.581)
- While infrequent (Average = 0.0121, Max = 1.541), the consequences of Foreign object retained after surgery are serious enough to warrant continued vigilance and stricter surgical protocols
- Air embolism and Blood incompatibility shouldn't be ignored even though they were not major drivers of patient outcome variation in 2025
