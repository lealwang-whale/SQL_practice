#query
#
# CREATE TABLE if not exists day3_movies
# (
#     movie_id INTEGER PRIMARY KEY,
#     title    varchar(30) NOT NULL
# );
#
# CREATE TABLE if not exists day3_users
# (
#     user_id INTEGER PRIMARY KEY,
#     name    varchar(30) NOT NULL
# );
#
# CREATE TABLE if not exists day3_movie_rating
# (
#     movie_id  INTEGER,
#     user_id   INTEGER,
#     rating    integer not null,
#     create_at date,
#     FOREIGN KEY (movie_id) REFERENCES day3_movies (movie_id),
#     FOREIGN KEY (user_id) REFERENCES day3_users (user_id)
# );
#
# INSERT INTO day3_movies
# VALUES (1, 'Avengers');
# INSERT INTO day3_movies
# VALUES (2, 'Frozen 2');
# INSERT INTO day3_movies
# VALUES (3, 'Joker');
#
# INSERT INTO day3_users
# VALUES (1, 'Daniel');
# INSERT INTO day3_users
# VALUES (2, 'Monica');
# INSERT INTO day3_users
# VALUES (3, 'Maria');
# INSERT INTO day3_users
# VALUES (4, 'James');
#
#
# INSERT INTO day3_movie_rating
# VALUES (1, 1, 3, '2020-01-12');
# INSERT INTO day3_movie_rating
# VALUES (1, 2, 4, '2020-02-21');
# INSERT INTO day3_movie_rating
# VALUES (1, 3, 2, '2020-02-12');
# INSERT INTO day3_movie_rating
# VALUES (1, 4, 1, '2020-01-01');
# INSERT INTO day3_movie_rating
# VALUES (2, 1, 5, '2020-02-17');
# INSERT INTO day3_movie_rating
# VALUES (2, 2, 2, '2020-02-01');
# INSERT INTO day3_movie_rating
# VALUES (2, 3, 2, '2020-03-01');
# INSERT INTO day3_movie_rating
# VALUES (3, 1, 3, '2020-02-22');
# INSERT INTO day3_movie_rating
# VALUES (3, 2, 4, '2020-02-25');

# Find the name of the user who has rated the greatest number of movies.
# In case of a tie, return the lexicographically smaller user name.
# Find the movie name with the highest average rating in February 2020.
# In case of a tie, return the lexicographically smaller movie name.

(select u.name as results
 from day3_users u
          join day3_movie_rating r on u.user_id = r.user_id
 group by u.user_id, u.name
 order by count(1) desc, u.name asc
 limit 1)
union all
(select m.title as results
 from day3_movies m
          join day3_movie_rating r on m.movie_id = r.movie_id
 where date_format(r.create_at, '%Y-%m') = '2020-02'
 group by m.movie_id, m.title
 order by avg(r.rating) desc, m.title asc
 limit 1)




