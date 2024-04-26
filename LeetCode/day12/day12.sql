# 1398. Customers Who Bought Products A and B but Not C
# SQL Schema
# Table: Customers
#
# +---------------------+---------+
# | Column Name         | Type    |
# +---------------------+---------+
# | customer_id         | int     |
# | customer_name       | varchar |
# +---------------------+---------+
# customer_id is the primary key for this table.
# customer_name is the name of the customer.
#
#
# Table: Orders
#
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | order_id      | int     |
# | customer_id   | int     |
# | product_name  | varchar |
# +---------------+---------+
# order_id is the primary key for this table.
# customer_id is the id of the customer who bought the product "product_name".
#
#
# Write an SQL query to report the customer_id and customer_name of customers who bought products "A", "B" but did not buy the product "C" since we want to recommend them buy this product.
#
# Return the result table ordered by customer_id.
#
# The query result format is in the following example.
#
#
#
# Customers table:
# +-------------+---------------+
# | customer_id | customer_name |
# +-------------+---------------+
# | 1           | Daniel        |
# | 2           | Diana         |
# | 3           | Elizabeth     |
# | 4           | Jhon          |
# +-------------+---------------+
#
# Orders table:
# +------------+--------------+---------------+
# | order_id   | customer_id  | product_name  |
# +------------+--------------+---------------+
# | 10         |     1        |     A         |
# | 20         |     1        |     B         |
# | 30         |     1        |     D         |
# | 40         |     1        |     C         |
# | 50         |     2        |     A         |
# | 60         |     3        |     A         |
# | 70         |     3        |     B         |
# | 80         |     3        |     D         |
# | 90         |     4        |     C         |
# +------------+--------------+---------------+
#
# Result table:
# +-------------+---------------+
# | customer_id | customer_name |
# +-------------+---------------+
# | 3           | Elizabeth     |
# +-------------+---------------+
# Only the customer_id with id 3 bought the product A and B but not the product C.

# CREATE TABLE if not exists day12_customers
# (
#     customer_id   integer,
#     customer_name varchar(30)
# );
# CREATE TABLE if not exists day12_orders
# (
#     order_id     integer,
#     customer_id  varchar(30),
#     product_name varchar(30)
# );
#
# INSERT INTO day12_customers (customer_id, customer_name)
# VALUES (1, 'Daniel'),
#        (2, 'Diana'),
#        (3, 'Elizabeth'),
#        (4, 'Jhon');
#
# INSERT INTO day12_orders (order_id, customer_id, product_name)
# VALUES (10, 1, 'A'),
#        (20, 1, 'B'),
#        (30, 1, 'D'),
#        (40, 1, 'C'),
#        (50, 2, 'A'),
#        (60, 3, 'A'),
#        (70, 3, 'B'),
#        (80, 3, 'D'),
#        (90, 4, 'C');

select c.customer_id,
       c.customer_name
from day12_customers c
         join day12_orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
having sum(if(o.product_name = 'A', 1, 0)) > 0
   and sum(if(o.product_name = 'B', 1, 0)) > 0
   and sum(if(o.product_name = 'C', 1, 0)) = 0