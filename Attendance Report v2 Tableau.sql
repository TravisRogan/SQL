-- This 2.0 Version of SQL includes a Holdiay left join so that columns can be filtered on Easter/Christmas, etc.
-- This also includes an attendance type so that Kids and Adults attendance numbers do not need to be separate 
-- ADULT ATTENDANCE

Select
--CONVERT (VARCHAR(10), e.Event_Start_Date, 101) AS 'DATE' ,

em.Numerical_Value AS "Attendance",
DATEPART(wk,e.Event_Start_Date) AS 'Week Number',
CONCAT(
	DATEPART(HOUR, e.Event_Start_Date),
	':',
	RIGHT('0' + CAST(DATEPART(MINUTE, e.event_Start_Date) AS VARCHAR(2)),2)) AS 'Time',
e.Event_Start_Date AS 'Date',
e.Event_Title AS 'Event',
c.Congregation_Name AS 'Campus',
h.Holiday_Name AS 'Holiday',
'Adults' AS 'Attendance Type'
FROM Event_Metrics em
JOIN Events e on em.Event_ID = e.Event_ID
JOIN Metrics m on m.Metric_ID = em.Metric_ID
JOIN NWCC_Metric_Congregations nmc on nmc.Metric_ID = em.Metric_ID
JOIN Congregations c on nmc.Congregation_ID = c.Congregation_ID
LEFT JOIN Holidays h on h.Holiday_ID = e.Holiday_ID
WHERE em.Metric_ID IN (1,2,3,6,7,8,25)
-- These are the metric ID numbers for 7 campuses including South as of 2024
-- Change the date in order to adjust the attendance timeframe
AND e.Event_Type_ID = 7
-- This is the event type ID used for the sunday/saturday worship events where metrics are recorded


UNION

-- KIDS ATTENDANCE

SELECT COUNT (ep.Event_Participant_ID) AS Attendance,
DATEPART(wk,e.Event_Start_Date) AS 'Week Number',
CONCAT(
	DATEPART(HOUR, e.Event_Start_Date),
	':',
	RIGHT('0' + CAST(DATEPART(MINUTE, e.event_Start_Date) AS VARCHAR(2)),2)) AS 'Time',
e.Event_Start_Date ,
e.Event_Title,
c2.Congregation_Name,
h.Holiday_Name,
'Kids' AS 'Attendance Type'
FROM Event_Participants ep
JOIN Events e on e.Event_ID = ep.Event_ID
JOIN Participants p on ep.Participant_ID = p.Participant_ID
JOIN Group_Participants gp ON ep.Group_Participant_ID = gp.Group_Participant_ID 
JOIN Congregations c2 on e.Congregation_ID = c2.Congregation_ID
LEFT JOIN Holidays h on h.Holiday_ID = e.Holiday_ID
WHERE e.Program_ID IN (35,36,34,173, 250, 293,342)
-- 34 = City, 35 = Sewickley, 36 = Wexford, 173 = Dormont, 250 = Beaver, 293 = Robinson, 342 = south
AND ep.Participation_Status_ID = 3
-- Status of Attended to show kids who checked in
and gp.Group_Role_ID = 2 
-- Group role of "group member" to distinguish from volunteers that should be "team member"
GROUP BY DATEPART(wk,e.Event_Start_Date), e.Event_Start_Date, e.Congregation_ID ,c2.Congregation_Name, e.Event_Title, h.Holiday_Name 


ORDER BY e.Event_Start_Date DESC
