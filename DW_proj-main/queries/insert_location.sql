-- INSERT INTO instagram.location(location_id, name, street, zip, city, region, cd, phone)
-- select distinct
-- id,
-- name,
-- street, 
-- zip,
-- city,
-- region,
-- cd,
-- phone
-- from instadw.locations;



INSERT INTO instagram.locations(
	location_id, location_name, location_street, location_zip, city_id, city_code, city, region, country_id, country_code, country_name)
SELECT DISTINCT
	id, name, street, zip, dir_city_id, dir_city_slug, city, region, dir_country_id, cd, dir_country_name
FROM instadw.locations;