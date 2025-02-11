-- This was ultimately a simple code, but required some consideration to make sure the joins were done properly. I've annotated within the code where the potential 
-- hiccups would've occured.

SELECT
d.Donor_ID,
c.Display_Name,
c2.Congregation_Name AS 'Home Campus', 
dd.Amount ,
p.Program_Name AS 'Campus Distribution'
FROM Donors d 
JOIN Donations d2 on d.Donor_ID = d2.Donor_ID 
JOIN Donation_Distributions dd on dd.Donation_ID = d2.Donation_ID
  -- This is the table where we can see what specific ministry a donation is tied to
JOIN Contacts c on c.Contact_ID = d.Contact_ID 
JOIN Households h on c.Household_ID = h.Household_ID 
JOIN Congregations c2 on c2.Congregation_ID = h.Congregation_ID
  -- Each persons home campus is tied to their household
JOIN Programs p on p.Program_ID = dd.Program_ID 
  -- While programs also can join on congregations since congregation_ID is a foreign key, I needed to join on 
  -- Donation_Distributions in order to properly compare the data. See below:
WHERE d2.Donation_Date BETWEEN '10-21-2024' AND '01-23-2025'
  -- The dates requested by the finance departmnet
AND c2.Congregation_ID <> p.Congregation_ID 
  -- To ensure that the congregation ID of the household (households is joined to c2) does not match the donation congregation (congregation ID is a foreign key in
  -- Programs, which is joined to Donation_Distributions
AND p.Program_ID IN (26,118,119,120,205,254,317,318,328, 341)
 -- The year-end giving program ID's to ensure that we don't bog down the report with other giving
