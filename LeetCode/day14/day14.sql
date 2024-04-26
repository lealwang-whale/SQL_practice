# 1440. Evaluate Boolean Expression
# Table Variables:
#
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | name          | varchar |
# | value         | int     |
# +---------------+---------+
# name is the primary key for this table.
# This table contains the stored variables and their values.
#
# Table Expressions:
#
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | left_operand  | varchar |
# | operator      | enum    |
# | right_operand | varchar |
# +---------------+---------+
# (left_operand, operator, right_operand) is the primary key for this table.
# This table contains a boolean expression that should be evaluated.
# operator is an enum that takes one of the values ('<', '>', '=')
# The values of left_operand and right_operand are guaranteed to be in the Variables table.
#
#
# Write an SQL query to evaluate the boolean expressions in Expressions table.
#
# Return the result table in any order.
#
# The query result format is in the following example.
#
# Variables table:
# +------+-------+
# | name | value |
# +------+-------+
# | x    | 66    |
# | y    | 77    |
# +------+-------+
#
# Expressions table:
# +--------------+----------+---------------+
# | left_operand | operator | right_operand |
# +--------------+----------+---------------+
# | x            | >        | y             |
# | x            | <        | y             |
# | x            | =        | y             |
# | y            | >        | x             |
# | y            | <        | x             |
# | x            | =        | x             |
# +--------------+----------+---------------+
#
# Result table:
# +--------------+----------+---------------+-------+
# | left_operand | operator | right_operand | value |
# +--------------+----------+---------------+-------+
# | x            | >        | y             | false |
# | x            | <        | y             | true  |
# | x            | =        | y             | false |
# | y            | >        | x             | true  |
# | y            | <        | x             | false |
# | x            | =        | x             | true  |
# +--------------+----------+---------------+-------+
# As shown, you need find the value of each boolean exprssion in the table using the variables table.

# CREATE TABLE if not exists day14_variables
# (
#     name  char(5),
#     value integer
# );
#
# CREATE TABLE if not exists day14_expressions
# (
#     left_operand  char(5),
#     operator      char(5),
#     right_operand char(5)
# );
#
# INSERT INTO day14_variables (name, value)
# VALUES ('x', 66),
#        ('y', 77);
#
# INSERT INTO day14_expressions (left_operand, operator, right_operand)
# VALUES ('x', '>', 'y'),
#        ('x', '<', 'y'),
#        ('x', '=', 'y'),
#        ('y', '>', 'x'),
#        ('y', '<', 'x'),
#        ('x', '=', 'x');

select left_operand,
       operator,
       right_operand,
       case
           when operator = '>' and v.value > v1.value then 'true'
           when operator = '<' and v.value < v1.value then 'true'
           when operator = '=' and v.value = v1.value then 'true'
           else 'false' end as value
from day14_expressions e
         join day14_variables v on v.name = e.left_operand
         join day14_variables v1 on v1.name = e.right_operand;


