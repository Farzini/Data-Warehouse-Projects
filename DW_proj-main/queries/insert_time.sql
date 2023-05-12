INSERT INTO instagram.time(hour, minute, second, is_night, is_day)
SELECT DISTINCT
CAST(SUBSTRING(cts, 12, 2) AS INTEGER) AS hour,
CAST(SUBSTRING(cts, 15, 2) AS INTEGER) AS minute,
CAST(SUBSTRING(cts, 18, 2) AS INTEGER) AS second,
CASE WHEN CAST(SUBSTRING(cts, 12, 2) AS INTEGER) >= 18 OR CAST(SUBSTRING(cts, 12, 2) AS INTEGER) < 6 THEN true ELSE false END AS is_night,
CASE WHEN CAST(SUBSTRING(cts, 12, 2) AS INTEGER) >= 6 AND CAST(SUBSTRING(cts, 12, 2) AS INTEGER) < 18 THEN true ELSE false END AS is_day
FROM instadw.posts;
