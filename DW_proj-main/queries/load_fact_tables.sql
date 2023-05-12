WITH post_stats AS (
    SELECT profile_id, SUM(numbr_likes) AS total_likes, SUM(number_comments) AS total_comments
    FROM dwproject.posts
    GROUP BY profile_id
)
INSERT INTO instagram.statistics (profile_id, time_id, date_id, number_of_followers, number_of_following, number_of_posts, total_likes, total_comments)
SELECT p.profile_id, t.time_id, d.date_id, profiles.followers_, profiles.following_, profiles.n_posts, ps.total_likes, ps.total_comments
FROM dwproject.profiles
JOIN instagram.profile p ON profiles.profile_id = p.profile_id
JOIN instagram.Time t ON EXTRACT(HOUR FROM profiles.cts) = t.hour AND EXTRACT(MINUTE FROM profiles.cts) = t.minute AND EXTRACT(SECOND FROM profiles.cts) = t.second
JOIN instagram.Date d ON EXTRACT(DAY FROM profiles.cts) = d.day AND EXTRACT(MONTH FROM profiles.cts) = d.month AND EXTRACT(YEAR FROM profiles.cts) = d.year
JOIN post_stats ps ON profiles.profile_id = ps.profile_id;











INSERT INTO instagram.post (profile_id, time_id, date_id, location_id, number_of_likes, number_of_comments, description, post_type)
SELECT p.profile_id, t.time_id, d.date_id, l.location_id, posts.numbr_likes, posts.number_comments, posts.description, posts.post_type
FROM dwproject.posts
JOIN instagram.profile p ON posts.profile_id = p.profile_id
JOIN instagram.Time t ON EXTRACT(HOUR FROM posts.cts) = t.hour AND EXTRACT(MINUTE FROM posts.cts) = t.minute AND EXTRACT(SECOND FROM posts.cts) = t.second
JOIN instagram.Date d ON EXTRACT(DAY FROM posts.cts) = d.day AND EXTRACT(MONTH FROM posts.cts) = d.month AND EXTRACT(YEAR FROM posts.cts) = d.year
JOIN instagram.Location l ON posts.location_id = l.location_id;
