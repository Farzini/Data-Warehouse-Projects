INSERT INTO instagram.profile (profile_id, profile_name, first_last_name, description, url)
SELECT
  profile_id,
  profile_name,
  firstname_lastname,
  description,
  url
FROM (
  SELECT
    profile_id,
    profile_name,
    firstname_lastname,
    description,
    url,
    ROW_NUMBER() OVER (PARTITION BY profile_id ORDER BY followers_ DESC) AS row_num
  FROM instadw.profiles
) subquery
WHERE row_num = 1
ON CONFLICT DO NOTHING;
