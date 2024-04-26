#write a solution to calculate bonus for each employee. if an ID of an employee
#is an odd number and the name of the employee doesn't start from 'M' then
#bonus is 100% otherwise 0

#result: employee_id asc


# CREATE TABLE if not exists day11
# (
#     employee_id integer,
#     name        varchar(30),
#     salary      integer
# );
#
# INSERT INTO day11 (employee_id, name, salary)
# VALUES (2, 'Meir', 3000),
#        (3, 'Michael', 3800),
#        (7, 'Addilyn', 7400),
#        (8, 'Juan', 6100),
#        (9, 'Kannon', 7700);

select employee_id,
       if(mod(employee_id, 2) = 1 and substr(name, 1, 1) != 'M', salary, 0) as bonus
from day11