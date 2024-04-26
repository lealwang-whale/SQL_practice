# Table: Users
#
# +----------------+---------+
# | Column Name    | Type    |
# +----------------+---------+
# | user_id        | int     |
# | name           | varchar |
# +----------------+---------+
# user_id is the primary key (column with unique values) for this table.
# This table contains the ID and the name of the user. The name consists of only lowercase and uppercase characters.
#
#
# Write a solution to fix the names so that only the first character is uppercase and the rest are lowercase.
#
# Return the result table ordered by user_id.
#
# The result format is in the following example.
#

# Example 1:
#
# Input:
# Users table:
# +---------+-------+
# | user_id | name  |
# +---------+-------+
# | 1       | aLice |
# | 2       | bOB   |
# +---------+-------+
# Output:
# +---------+-------+
# | user_id | name  |
# +---------+-------+
# | 1       | Alice |
# | 2       | Bob   |
# +---------+-------+

# CREATE TABLE if not exists day7
# (
#     user_id integer,
#     name    varchar(30)
# );
#
# INSERT INTO day7
# VALUES (1, 'aLice');
#
# INSERT INTO day7
# VALUES (2, 'bOB');

select user_id,
       concat(upper(substring(name, 1, 1)), lower(substring(name, 2))) as name
from day7
order by user_id;