drop table if exists instadw.locations;
create table instadw.locations(
	idx integer,
	sid bigint,
	id bigint,
	name varchar(255),
	street varchar(255),
	zip varchar(255),
	city varchar(255),
	region varchar(255),
	cd varchar(16),
	phone varchar(255),
    aj_exact_city_match varchar(255),
	aj_exact_country_match varchar(255),
	blurb text,
	dir_city_id varchar(255),
    dir_city_name varchar(255),
    dir_city_slug varchar(255),
	dir_country_id varchar(255),
	dir_country_name varchar(255),
    lat varchar(255),
	lng varchar(255),
	primary_alias_on_fb varchar(255),
	slug varchar(255),
	website text,
	cts varchar(255)
);

DROP TABLE if exists instadw.posts;
create table instadw.posts(
	idx integer,
	sid bigint, 
	sid_profile bigint,
	post_id varchar(255),
	profile_id bigint,
	location_id bigint,
	cts varchar(255),--timestamp when post was created
	post_type int,
	description text,
	numbr_likes int,
	number_comments int
);

DROP TABLE if exists instadw.profiles;
create table instadw.profiles(
	idx integer,
	sid bigint,
	profile_id bigint, 
	profile_name varchar(255),
	firstname_lastname varchar(255),
	descritpion text,
	following_ int,
	followers_ int,
	n_posts int,
	url text,
	cts varchar(255), --timestamp when profile was visited
	is_business_ account boolean
);


TRUNCATE TABLE <tablename>;
COPY '<path>'
WITH
(FORMAT CSV,
DELIMITER ',',
HEADER,
QUOTE '"',
ENCODING 'UTF8');