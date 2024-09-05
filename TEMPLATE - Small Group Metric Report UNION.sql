-- Use this report to generate data for CMT small group reporting
SELECT 
    c.Display_Name,
    gp.Start_Date,
    gp.End_Date,
    g.Group_Name,
    c2.Congregation_Name,
    g.Congregation_ID,
    gt.Group_Type,
    g.Group_Focus_ID,
    gf.Group_Focus 
FROM 
    Group_Participants gp 
    JOIN Participants p ON gp.Participant_ID = p.Participant_ID 
    JOIN Contacts c ON c.Contact_ID = p.Contact_ID 
    JOIN Groups g ON g.Group_ID = gp.Group_ID 
    JOIN Congregations c2 ON c2.Congregation_ID = g.Congregation_ID
    JOIN Group_Types gt ON gt.Group_Type_ID = g.Group_Type_ID
    JOIN Group_Focuses gf on gf.Group_Focus_ID = g.Group_Focus_ID 
WHERE 
    g.Group_Focus_ID = 1
    -- Small Groups
    AND gp.End_Date IS NULL
    AND g.Congregation_ID = 13
    --CHANGE TO CHANGE CAMPUSES

UNION

SELECT 
    c.Display_Name,
    gp.Start_Date,
    gp.End_Date,
    g.Group_Name,
    c2.Congregation_Name,
    g.Congregation_ID,
    gt.Group_Type,
    g.Group_Focus_ID,
    gf.Group_Focus 
FROM 
    Group_Participants gp 
    JOIN Participants p ON gp.Participant_ID = p.Participant_ID 
    JOIN Contacts c ON c.Contact_ID = p.Contact_ID 
    JOIN Groups g ON g.Group_ID = gp.Group_ID
    JOIN Congregations c2 ON c2.Congregation_ID = g.Congregation_ID
    JOIN Group_Types gt ON gt.Group_Type_ID = g.Group_Type_ID
     JOIN Group_Focuses gf on gf.Group_Focus_ID = g.Group_Focus_ID
WHERE 
    gp.End_Date IS NULL 
    AND g.Group_Focus_ID = 6
    --Focused Groups
    AND g.Congregation_ID = 13
    -- CHANGE TO CHANGE CAMPUSES

UNION

SELECT 
    c.Display_Name,
    gp.Start_Date,
    gp.End_Date,
    g.Group_Name,
    c2.Congregation_Name,
    g.Congregation_ID,
    gt.Group_Type,
    g.Group_Focus_ID,
    gf.Group_Focus 
FROM 
    Group_Participants gp 
    JOIN Participants p ON gp.Participant_ID = p.Participant_ID 
    JOIN Contacts c ON c.Contact_ID = p.Contact_ID 
    JOIN Groups g ON g.Group_ID = gp.Group_ID
    JOIN Congregations c2 ON c2.Congregation_ID = g.Congregation_ID
    JOIN Group_Types gt ON gt.Group_Type_ID = g.Group_Type_ID 
     JOIN Group_Focuses gf on gf.Group_Focus_ID = g.Group_Focus_ID
WHERE 
    gp.End_Date IS NULL 
    AND g.Group_Focus_ID = 5
    -- Rooted Groups
    AND g.Congregation_ID = 13
    -- CHANGE TO CHANGE CAMPUSES
ORDER BY 
    Congregation_Name, Group_Focus_ID, Group_Name, Display_Name;
