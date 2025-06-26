-- Full Table Preview
Select *
FROM dev_api_usage_logs;

-- SQL Logic Summary: Simple table check for structure and values.
--     Ensures correct import and column availability before analysis.
-- Insights for Stakeholders: Confirms availability of key metrics — IPs, timestamps, and byte volume — to drive usage and security analysis.


-- Create Unified Timestamp Columns
ALTER TABLE dev_api_usage_logs
ADD COLUMN creation_datetime DATETIME,
ADD COLUMN end_datetime DATETIME,
ADD COLUMN event_datetime DATETIME;


UPDATE dev_api_usage_logs
SET creation_datetime = STR_TO_DATE(CONCAT(creation_date, ' ', creation_time), '%Y-%m-%d %H:%i:%s'),
    end_datetime = STR_TO_DATE(CONCAT(end_date, ' ', end_time), '%Y-%m-%d %H:%i:%s'),
    event_datetime = STR_TO_DATE(CONCAT(event_date, ' ', event_time), '%Y-%m-%d %H:%i:%s');
    
    
-- SQL Logic Summary: Combines separate date/time text fields into unified DATETIME columns.
--     Enables time-based filtering, grouping, and latency calculations.
-- Insights for Stakeholders: Normalized timestamps allow tracking of API patterns, developer adoption curves, and session-level behavior.

-- -----------------------------------------------------------------------------------------------------------------------------------------

-- Which countries or IPs show unusually high API activity in short time frames?
-- 		 High-Frequency API Activity by IP + Country + Hour

SELECT src_ip, 
src_ip_country_code, 
       COUNT(*) AS request_count, 
       HOUR(event_datetime) AS hour_slot
FROM dev_api_usage_logs
GROUP BY src_ip, src_ip_country_code, HOUR(event_datetime)
ORDER BY request_count DESC
LIMIT 20;

-- SQL Logic Summary: Aggregates API calls per IP and country, segmented by hour.
--     Surfaces IPs with unusually high activity in short timeframes.
-- Insights for Stakeholders: Detects potential abuse or bot-like behavior. Supports throttling or alerting for anomalous usage.
--     Example Insight: IP '165.225.26.101' in DE made 6 requests at 11PM — candidate for review.


-- --------------------------------------------------------------------------------------------------------

-- What are the peak hours for API activity globally?
-- 		Global API Activity by Hour (Peak Usage)

SELECT HOUR(event_datetime) AS hour, 
COUNT(*) AS api_hits
FROM dev_api_usage_logs
GROUP BY hour
ORDER BY api_hits DESC;

-- SQL Logic Summary: Counts total API events grouped by hour of day (0–23).
--     Reveals when developer/API usage is most active.
-- Insights for Stakeholders: Highest usage observed at 9AM (65 hits) and 11PM (58 hits) — could reflect dev workflows across time zones.
--     Helps product teams optimize API uptime and support availability.

-- ----------------------------------------------------------------------------------------

-- Are there IPs or sessions where bytes_out is high but bytes_in is low?
-- 		 IPs with High bytes_out vs bytes_in (Possible Scrapers)

SELECT src_ip, ROUND(AVG(bytes_in)) AS avg_in, 
ROUND(AVG(bytes_out) )AS avg_out
FROM dev_api_usage_logs
GROUP BY src_ip
HAVING avg_out > 5 * avg_in;

-- SQL Logic Summary: Identifies IPs with significantly higher outbound data compared to inbound.
--     Flags traffic patterns consistent with scraping or automated access.
-- Insights for Stakeholders: IPs like '65.49.1.96' (avg_out: 8980, avg_in: 1674) show suspicious data behavior — engineering could consider rate-limiting or blacklisting.


-- ----------------------------------------------------------------------------------------------------------------------------------

-- How long are average API sessions (end_time - creation_time)?
-- 		  Session Duration Analysis (End Time - Start Time)

SELECT src_ip, 
       TIMESTAMPDIFF(SECOND, creation_datetime, end_datetime) AS session_duration
FROM dev_api_usage_logs
WHERE end_datetime > creation_datetime;

-- SQL Logic Summary: Calculates session length in seconds between API request creation and end.
-- Insights for Stakeholders: Session durations are consistently 600 seconds — may reflect fixed session expiration or timeout behavior in SDK/API.
--     Useful for backend engineers evaluating timeouts, retries, or client-side disconnects.


-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- What regions show the highest number of distinct API interactions?
--  	API Interaction Volume by Region

SELECT src_ip_country_code, 
COUNT(*) AS total_events, 
COUNT(DISTINCT src_ip) AS unique_ips
FROM dev_api_usage_logs
GROUP BY src_ip_country_code
ORDER BY total_events DESC;


-- SQL Logic Summary: Aggregates total and unique API interactions by country.
--     Measures regional SDK/API engagement.
-- Insights for Stakeholders: US shows highest volume (113 events, 19 IPs) followed by CA (72 events, 4 IPs).
--     Helps product and sales identify key markets for SDK adoption and support focus.



























