INSERT INTO instagram.date(day, month, year, weekday, month_name)
SELECT DISTINCT
CAST(SUBSTRING(cts, 9, 2) AS INTEGER) AS day,
CAST(SUBSTRING(cts, 6, 2) AS INTEGER) AS month,
CAST(SUBSTRING(cts, 1, 4) AS INTEGER) AS year,
to_char(to_timestamp(cts, 'YYYY-MM-DD HH24:MI:SS'), 'Day') AS weekday,
to_char(to_timestamp(cts, 'YYYY-MM-DD HH24:MI:SS'), 'Month') AS month_name
FROM instadw.posts;