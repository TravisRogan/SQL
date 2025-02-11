SELECT
d.Donor_ID,
c.Display_Name,
c2.Congregation_Name AS 'Home Campus', 
dd.Amount ,
p.Program_Name AS 'Campus Distribution'
FROM Donors d 
JOIN Donations d2 on d.Donor_ID = d2.Donor_ID 
JOIN Donation_Distributions dd on dd.Donation_ID = d2.Donation_ID 
JOIN Contacts c on c.Contact_ID = d.Contact_ID 
JOIN Households h on c.Household_ID = h.Household_ID 
JOIN Congregations c2 on c2.Congregation_ID = h.Congregation_ID
JOIN Programs p on p.Program_ID = dd.Program_ID 
WHERE d2.Donation_Date BETWEEN '10-21-2024' AND '01-23-2025'
AND c2.Congregation_ID <> p.Congregation_ID 
AND p.Program_ID IN (26,118,119,120,205,254,317,318,328, 341)
