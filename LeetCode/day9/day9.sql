# write a solution to find the second highest salary

CREATE TABLE if not exists day9
(
    id     integer,
    salary integer
);

INSERT INTO day9
VALUES (1, 100);
INSERT INTO day9
VALUES (2, 200);
INSERT INTO day9
VALUES (3, 300);

select salary
from (select salary,
             dense_rank() over (order by salary desc) as rn
      from day9) t
where rn = 2;


with cte as (select max(salary) as max_salary
             from day9)

select max(salary) as salary
from day9
where salary < (select * from cte)

