# leetcode 1045. Customers Who Bought All Products
#
# Table: Customer
#
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | customer_id | int     |
# | product_key | int     |
# +-------------+---------+
# This table may contain duplicates rows.
# customer_id is not NULL.
# product_key is a foreign key (reference column) to Product table.
#
#
# Table: Product
#
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | product_key | int     |
# +-------------+---------+
# product_key is the primary key (column with unique values) for this table.
#
#
# Write a solution to report the customer ids from the Customer table that bought all the products in the Product table.
#
# Return the result table in any order.
#
# The result format is in the following example.
#
#
#
# Example 1:
#
# Input:
# Customer table:
# +-------------+-------------+
# | customer_id | product_key |
# +-------------+-------------+
# | 1           | 5           |
# | 2           | 6           |
# | 3           | 5           |
# | 3           | 6           |
# | 1           | 6           |
# +-------------+-------------+
# Product table:
# +-------------+
# | product_key |
# +-------------+
# | 5           |
# | 6           |
# +-------------+
# Output:
# +-------------+
# | customer_id |
# +-------------+
# | 1           |
# | 3           |
# +-------------+
# Explanation:
# The customers who bought all the products (5 and 6) are customers with IDs 1 and 3.

# CREATE TABLE if not exists question5_customers
# (
#     customer_id integer,
#     product_key integer
# );
# INSERT INTO question5_customers (customer_id, product_key)
# VALUES (1, 5),
#        (2, 6),
#        (3, 5),
#        (3, 6),
#        (1, 6);
#
# CREATE TABLE if not exists question5_products
# (
#     product_key integer
# );
#
# INSERT INTO question5_products (product_key)
# VALUES (5),
#        (6);

with cte as (select customer_id,
                    count(distinct product_key) as product_cnt
             from question5_customers
             group by customer_id)

select customer_id
from cte c
         join (select count(*) as cnt from question5_products) p on c.product_cnt = p.cnt
