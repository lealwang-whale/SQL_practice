# Find the people who are login more than 3 consecutive dates

# login_events
# +---+----------+
# |id |login_date|
# +---+----------+
# |01 |2021-02-28|
# |01 |2021-03-01|
# |01 |2021-03-02|
# |01 |2021-03-04|
# |01 |2021-03-05|
# |01 |2021-03-06|
# |01 |2021-03-08|
# |02 |2021-03-01|
# |02 |2021-03-02|
# |03 |2021-03-03|
# |03 |2021-03-04|
# |03 |2021-03-05|
# +---+----------+

#users
# +---+----------+
# |id |name|
# +---+----------+
# |01 |Mary|
# |02 |Ben|
# |03 |Jiff|

CREATE TABLE if not exists question2_login_events
(
    user_id    integer,
    login_date date
);

CREATE TABLE if not exists question2_users
(
    id   integer,
    name varchar(30)
);

INSERT INTO question2_login_events(user_id, login_date)
VALUES (01, '2021-02-28'),
       (01, '2021-03-01'),
       (01, '2021-03-02'),
       (01, '2021-03-04'),
       (01, '2021-03-05'),
       (01, '2021-03-06'),
       (01, '2021-03-08'),
       (02, '2021-03-01'),
       (02, '2021-03-02'),
       (03, '2021-03-03'),
       (03, '2021-03-04'),
       (03, '2021-03-05');

INSERT INTO question2_users(id, name)
VALUES (01, 'Mary'),
       (02, 'Ben'),
       (03, 'Jiff');


select user_id,
       name
from (select user_id,
             name,
             count(1) as day_cnt
      from (select user_id,
                   name,
                   login_date,
                   date_sub(login_date, interval row_number() over (partition by user_id order by login_date)
                            day) as date_diff
            from question2_users u
                     join question2_login_events e on u.id = e.user_id) as t
      group by user_id, name, date_diff) as m
where day_cnt >= 3
group by user_id,
         name
