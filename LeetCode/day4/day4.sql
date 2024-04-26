# leetcode 1321
# You are the restaurant owner and you want to analyze a possible expansion
# (there will be at least one customer every day).
#
# Compute the moving average of how much the customer paid in a seven days window
# (i.e., current day + 6 days before). average_amount should be rounded to two decimal places.
#
# Return the result table ordered by visited_on in ascending order.
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | customer_id   | int     |
# | name          | varchar |
# | visited_on    | date    |
# | amount        | int     |
# +---------------+---------+
# In SQL,(customer_id, visited_on) is the primary key for this table.
# This table contains data about customer transactions in a restaurant.
# visited_on is the date on which the customer with ID (customer_id) has visited the restaurant.
# amount is the total paid by a customer.
# Customer table:
# +-------------+--------------+--------------+-------------+
# | customer_id | name         | visited_on   | amount      |
# +-------------+--------------+--------------+-------------+
# | 1           | Jhon         | 2019-01-01   | 100         |
# | 2           | Daniel       | 2019-01-02   | 110         |
# | 3           | Jade         | 2019-01-03   | 120         |
# | 4           | Khaled       | 2019-01-04   | 130         |
# | 5           | Winston      | 2019-01-05   | 110         |
# | 6           | Elvis        | 2019-01-06   | 140         |
# | 7           | Anna         | 2019-01-07   | 150         |
# | 8           | Maria        | 2019-01-08   | 80          |
# | 9           | Jaze         | 2019-01-09   | 110         |
# | 1           | Jhon         | 2019-01-10   | 130         |
# | 3           | Jade         | 2019-01-10   | 150         |
# +-------------+--------------+--------------+-------------+
#
# CREATE TABLE if not exists day4
# (
#     customer_id INTEGER,
#     name        varchar(30) NOT NULL,
#     visited_on  date,
#     amount      float
# );
#
# INSERT INTO day4
# VALUES (1, 'Jhon', '2019-01-01', 100);
# INSERT INTO day4
# VALUES (2, 'Daniel', '2019-01-02', 110);
# INSERT INTO day4
# VALUES (3, 'Jade', '2019-01-03', 120);
# INSERT INTO day4
# VALUES (4, 'Khald', '2019-01-04', 130);
# INSERT INTO day4
# VALUES (5, 'Winston', '2019-01-05', 110);
# INSERT INTO day4
# VALUES (6, 'Elvis', '2019-01-06', 140);
# INSERT INTO day4
# VALUES (7, 'Anna', '2019-01-07', 150);
# INSERT INTO day4
# VALUES (8, 'Maria', '2019-01-08', 80);
# INSERT INTO day4
# VALUES (9, 'Jaze', '2019-01-09', 110);
# INSERT INTO day4
# VALUES (1, 'Jhon', '2019-01-10', 130);
# INSERT INTO day4
# VALUES (3, 'Jade', '2019-01-10', 150);
select *
from day4;

select visited_on,
       amount,
       round(amount / 7, 2) as average_amount
from (select visited_on,
             sum(amount) over (order by visited_on range between interval 6 day preceding and current row ) as amount
      from (select visited_on, sum(amount) as amount
            from day4
            group by visited_on) as t) as t1
where visited_on >= (select min(visited_on) from day4) + 6;

with cte as (select visited_on,
                    sum(amount) as amount
             from day4
             group by visited_on)
select t.date                    as visited_on,
       sum(amount)               as amount,
       round(sum(amount) / 7, 2) as average_amount
from (select c1.visited_on as date, c2.amount
      from cte c1,
           cte c2
      where c1.visited_on - c2.visited_on <= 6
        and c1.visited_on - c2.visited_on >= 0) as t
where t.date >= (select min(day4.visited_on) from day4) + 6
group by t.date


