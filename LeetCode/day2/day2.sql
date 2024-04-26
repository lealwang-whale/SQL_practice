# query
# Write a solution to swap the seat id of every two consecutive students.
# If the number of students is odd, the id of the last student is not swapped.
# Example 1:
#
# Input:
# Seat table:
# +----+---------+
# | id | student |
# +----+---------+
# | 1  | Abbot   |
# | 2  | Doris   |
# | 3  | Emerson |
# | 4  | Green   |
# | 5  | Jeames  |
# +----+---------+
# Output:
# +----+---------+
# | id | student |
# +----+---------+
# | 1  | Doris   |
# | 2  | Abbot   |
# | 3  | Green   |
# | 4  | Emerson |
# | 5  | Jeames  |
# +----+---------+
# Explanation:
# Note that if the number of students is odd, there is no need to change the last one's seat.

CREATE TABLE if not exists day2
(
    id      INTEGER PRIMARY KEY,
    student varchar(30) NOT NULL
);

INSERT INTO day2
VALUES (1, 'Abbot');
INSERT INTO day2
VALUES (2, 'Doris');
INSERT INTO day2
VALUES (3, 'Emerson');
INSERT INTO day2
VALUES (4, 'Green');
INSERT INTO day2
VALUES (5, 'Jeames');

select *
from day2;

with cte as (select id,
                    student,
                    lead(student, 1) over () as lead_stu,
                    lag(student, 1) over ()  as lag_stu,
                    count(1) over ()         as total_cnt
             from day2)

select id,
       case
           when mod(id, 2) = 1 and id <> total_cnt then lead_stu
           when mod(id, 2) = 0 then lag_stu
           else student end as student
from cte
