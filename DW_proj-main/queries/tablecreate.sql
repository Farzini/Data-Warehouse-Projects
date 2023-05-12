-- DROP TABLE IF EXISTS instagram.location CASCADE;
-- CREATE TABLE instagram.location(
-- 	location_id BIGINT PRIMARY KEY,
-- 	name VARCHAR(255) NOT NULL,
-- 	street VARCHAR(255),
-- 	zip VARCHAR(255),
-- 	city VARCHAR(255),
-- 	region VARCHAR(255),
-- 	cd VARCHAR(16),
-- 	phone VARCHAR(255)
-- );


DROP TABLE IF EXISTS instagram.locations CASCADE;
CREATE TABLE instagram.locations(
	location_id BIGINT PRIMARY KEY,
		--location_code NUMERIC(6)
		location_name VARCHAR(255) NOT NULL,
		location_street VARCHAR(255),
		location_zip VARCHAR(255),
	city_id VARCHAR(255),   
		city_code VARCHAR(255),
		city VARCHAR(255),
	--region_id INTEGER,
		--region_code NUMERIC(6),
	region VARCHAR(255),
	country_id VARCHAR(255),
		country_code VARCHAR(255),
		country_name VARCHAR(255)
);

DROP TABLE IF EXISTS instagram.profile CASCADE;
CREATE TABLE instagram.profile(
	profile_id BIGINT PRIMARY KEY,
	profile_name VARCHAR(255) NOT NULL,
	first_last_name VARCHAR(255),
	description TEXT,
	url TEXT
);

DROP TABLE IF EXISTS instagram.date CASCADE;
CREATE TABLE instagram.date(
	date_id SERIAL PRIMARY KEY,
	day INTEGER,
	month INTEGER,
	year INTEGER,
	weekday VARCHAR(16),
	month_name VARCHAR(16)
);

DROP TABLE IF EXISTS instagram.time CASCADE;
CREATE TABLE instagram.time(
	time_id SERIAL PRIMARY KEY,
	hour INTEGER,
	minute INTEGER,
	second INTEGER,
	is_night BOOLEAN,
	is_day BOOLEAN
);

DROP TABLE IF EXISTS instagram.post;
CREATE TABLE instagram.post(
    post_id INT PRIMARY KEY,
    profile_id INT,
    time_id INT,
    date_id INT,
    location_id INT,
    number_of_likes INT,
    number_of_comments INT,
    description TEXT,
    post_type TEXT,
    FOREIGN KEY (profile_id) REFERENCES instagram.profile(profile_id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (time_id) REFERENCES instagram.time(time_id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (date_id) REFERENCES instagram.date(date_id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (location_id) REFERENCES instagram.locations(location_id) ON DELETE SET NULL ON UPDATE CASCADE
);

DROP TABLE IF EXISTS instagram.statistics;
CREATE TABLE instagram.statistics (
    statistics_id INT PRIMARY KEY,
    profile_id INT,
    time_id INT,
    date_id INT,
    number_of_followers INT,
    number_of_following INT,
    number_of_posts INT,
    total_likes INT,
    total_comments INT,
    FOREIGN KEY (profile_id) REFERENCES instagram.profile(profile_id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (time_id) REFERENCES instagram.time(time_id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (date_id) REFERENCES instagram.date(date_id) ON DELETE SET NULL ON UPDATE CASCADE
);