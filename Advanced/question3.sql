# SQL Query to Convert Rows to Columns
# For example, Suppose we have a table given below:
# product	month	revenue
# A	January	1000
# A	February	1200
# B	January	800
# B	February	900
# C	January	1500
# C	February	1800


# CREATE TABLE question3
# (
#     product VARCHAR(50),
#     month   VARCHAR(20),
#     revenue INT
# );
#
# INSERT INTO question3 (product, month, revenue)
# VALUES ('A', 'January', 1000),
#        ('A', 'February', 1200),
#        ('B', 'January', 800),
#        ('B', 'February', 900),
#        ('C', 'January', 1500),
#        ('C', 'February', 1800);

select product,
       max(if(month = 'January', revenue, 0))  as January,
       max(if(month = 'February', revenue, 0)) as February
from question3
group by product