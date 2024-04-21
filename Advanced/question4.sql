# SQL Query to Convert Columns to Rows
# For example, Suppose we have a revenue table given below:
# product	Jan	Feb
# A		1000 1200
# B		800 900
# C		1500 1800


# CREATE TABLE question4
# (
#     product VARCHAR(50),
#     Jan     integer,
#     Feb     integer
# );
# INSERT INTO question4 (product, Jan, Feb)
# VALUES ('A', 1000, 1200),
#        ('B', 800, 900),
#        ('C', 1500, 1800);

select product,
       'Jan' as month_date,
       Jan   as revenue
from question4
union all
select product,
       'Feb' as month_date,
       Feb   as revenue
from question4