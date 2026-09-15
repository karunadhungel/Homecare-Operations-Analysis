-- View all records
SELECT *
FROM homecare_operations;


-- Scheduled vs. worked hours by staff
SELECT
staff_id,
SUM(scheduled_hours) AS total_scheduled_hours,
SUM(worked_hours) AS total_worked_hours
FROM homecare_operations
GROUP BY staff_id;


-- Missed visits by staff
SELECT
staff_id,
COUNT(*) AS missed_visits
FROM homecare_operations
WHERE missed_visit = 'Yes'
GROUP BY staff_id
ORDER BY missed_visits DESC;


-- Service demand
SELECT
service_type,
SUM(scheduled_hours) AS total_scheduled_hours,
SUM(worked_hours) AS total_worked_hours
FROM homecare_operations
GROUP BY service_type
ORDER BY total_scheduled_hours DESC;


-- Missed visits by region
SELECT
region,
COUNT(*) AS missed_visits
FROM homecare_operations
WHERE missed_visit = 'Yes'
GROUP BY region
ORDER BY missed_visits DESC;


-- Hour gaps
SELECT
client_id,
staff_id,
service_type,
scheduled_hours,
worked_hours,
scheduled_hours - worked_hours AS hour_gap
FROM homecare_operations
ORDER BY hour_gap DESC;


-- Completion rate by staff
SELECT
staff_id,
SUM(scheduled_hours) AS scheduled_hours,
SUM(worked_hours) AS worked_hours,
ROUND(
SUM(worked_hours) * 100.0 / SUM(scheduled_hours),
2
) AS completion_rate
FROM homecare_operations
GROUP BY staff_id
ORDER BY completion_rate DESC;
