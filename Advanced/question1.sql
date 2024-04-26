# Accumulative Login Count for Users per month for each year
#
# source table - events:
# user_id date visit_count
# 1, 2023-10-13, 5
# 2, 2023-10-13, 5
# 1, 2023-10-14, 15
# 2, 2023-11-15, 12
# 3, 2023-11-21, 8
#
# output format:
# user_id year_month total_cnt acc_cnt
# 1, 202310, 20, 20
# 2, 202310, 5, 5
# 2, 202311, 12, 17
# 3, 202311, 8, 8

# CREATE TABLE if not exists question1
# (
#     user_id     integer,
#     sell_date   date,
#     visit_count integer
# );
#
# INSERT INTO question1
# VALUES (1, '2023-10-13', 5);
# INSERT INTO question1
# VALUES (2, '2023-10-13', 5);
# INSERT INTO question1
# VALUES (1, '2023-10-14', 15);
# INSERT INTO question1
# VALUES (2, '2023-11-15', 12);
# INSERT INTO question1
# VALUES (3, '2023-11-21', 8);

select *
from question1;

# select user_id, sell_date, visit_count, sum(visit_count) over (order by sell_date asc)
# from question1;

select user_id,
       year_month_date,
       total_cnt,
       sum(total_cnt) over (partition by user_id order by year_month_date asc) as acc_cnt
from (select user_id,
             date_format(sell_date, '%Y%m') as year_month_date,
             sum(visit_count)               as total_cnt
      from question1
      group by user_id,
               date_format(sell_date, '%Y%m')) as t;
