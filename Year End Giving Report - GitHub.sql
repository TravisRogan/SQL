-- This code was used to generate 3 tables of data regarding year-end giving stats over the past 3 years.
-- In order to get columns for each year, I had to use CASE statements.

-- This query returns the number of unique givers that gave to year end giving campaigns across all of our campuses
SELECT
    p.program_name,
    COUNT(DISTINCT CASE 
        WHEN d2.Donation_Date BETWEEN '2024-10-01' AND '2025-02-01' THEN d.Donor_ID 
    END) AS "Donors (2024)",
    COUNT(DISTINCT CASE 
        WHEN d2.Donation_Date BETWEEN '2023-10-01' AND '2024-02-01' THEN d.Donor_ID 
    END) AS "Donors (2023)",
    COUNT(DISTINCT CASE 
        WHEN d2.Donation_Date BETWEEN '2022-10-01' AND '2023-02-01' THEN d.Donor_ID 
    END) AS "Donors (2022)"
FROM Donors d
JOIN Donations d2 ON d2.Donor_ID = d.Donor_ID 
JOIN Donation_Distributions dd ON dd.Donation_ID = d2.Donation_ID 
JOIN Programs p ON p.Program_ID = dd.Program_ID 
-- Program_ID is what defines a gift as being designated to a year-end giving fund
WHERE p.Program_ID IN (26, 118, 119, 120, 205, 254, 317, 318, 328, 341)
GROUP BY p.Program_Name
ORDER BY p.Program_Name;

-- This query returns the number of gifts given to each's campus's year-end fund $1000+
SELECT
p.program_name,
COUNT(CASE 
        WHEN dd.Amount >= 1000  
        AND d2.Donation_Date BETWEEN '10-01-2024' AND '02-01-2025' THEN dd.Donation_Distribution_ID 
    END) AS "Donations 1000+ (2024)",
COUNT(CASE 
        WHEN dd.Amount >= 1000  
        AND d2.Donation_Date BETWEEN '10-01-2023' AND '02-01-2024' THEN dd.Donation_Distribution_ID 
    END) AS "Donations 1000+ (2023)",
COUNT(CASE 
        WHEN dd.Amount >= 1000  
        AND d2.Donation_Date BETWEEN '10-01-2022' AND '02-01-2023' THEN dd.Donation_Distribution_ID 
    END) AS "Donations 1000+ (2022)"    
FROM Donations d2
JOIN Donation_Distributions dd on dd.Donation_ID = d2.Donation_ID 
JOIN Programs p on p.Program_ID = dd.Program_ID 
WHERE p.Program_ID IN (26,118,119,120,205,254,317,318,328, 341)
GROUP BY p.Program_Name
ORDER BY p.Program_Name ;

-- This query returns the total amount of year-end giving donations for each campus' year-end giving fund.
SELECT
p.program_name,
SUM(CASE 
        WHEN d2.Donation_Date BETWEEN '10-01-2024' AND '02-01-2025' THEN dd.Amount 
    END) AS "Donations (2024)",
SUM(CASE 
        WHEN d2.Donation_Date BETWEEN '10-01-2023' AND '02-01-2024' THEN dd.Amount
    END) AS "Donations (2023)",
SUM(CASE 
        WHEN d2.Donation_Date BETWEEN '10-01-2022' AND '02-01-2023' THEN dd.Amount
    END) AS "Donations (2022)"    
FROM Donations d2
JOIN Donation_Distributions dd on dd.Donation_ID = d2.Donation_ID 
JOIN Programs p on p.Program_ID = dd.Program_ID 
WHERE p.Program_ID IN (26,118,119,120,205,254,317,318,328, 341)
GROUP BY p.Program_Name
ORDER BY p.Program_Name ;


