# top 3 salary employees from each department

# CREATE TABLE if not exists day6_employee
# (
#     id            integer,
#     name          varchar(30) NOT NULL,
#     salary        integer,
#     department_id integer
# );
#
# CREATE TABLE if not exists day6_department
# (
#     id   integer,
#     name varchar(30) NOT NULL
# );
#
# INSERT INTO day6_employee
# VALUES (1, 'Joe', 85000, 1);
# INSERT INTO day6_employee
# VALUES (2, 'Henry', 80000, 2);
# INSERT INTO day6_employee
# VALUES (3, 'Sam', 60000, 2);
# INSERT INTO day6_employee
# VALUES (4, 'Max', 90000, 1);
# INSERT INTO day6_employee
# VALUES (5, 'Janet', 69000, 1);
# INSERT INTO day6_employee
# VALUES (6, 'Randy', 85000, 1);
# INSERT INTO day6_employee
# VALUES (7, 'Will', 70000, 1);
#
# INSERT INTO day6_department
# VALUES (1, 'IT');
# INSERT INTO day6_department
# VALUES (2, 'Sales');

select department,
       employee,
       salary
from (select d.name                                                       as department,
             e.name                                                       as employee,
             salary,
             dense_rank() over (partition by d.id order by e.salary desc) as rank_num
      from day6_employee e
               join day6_department d on e.department_id = d.id) as t
where t.rank_num <= 3


