# query
# query the number of accounts in each category:
# "low salary" income < 20000
# "avg salary" income >= 20000 and <= 50000
# "high salary" income > 50000

CREATE TABLE if not exists day1
(
    account_id INTEGER PRIMARY KEY,
    income     INTEGER NOT NULL
);

INSERT INTO day1
VALUES (3, 108939);
INSERT INTO day1
VALUES (2, 12747);
INSERT INTO day1
VALUES (8, 87709);
INSERT INTO day1
VALUES (6, 91796);

with cte as (select 'low salary', 0
             union all
             select 'avg salary', 0
             union all
             select 'high salary', 0)
select categroy, sum(accounts_count) as accounts_count
from (select case
                 when income < 20000 then 'low salary'
                 when income >= 20000 and income <= 50000 then 'avg salary'
                 else 'high salary'
                 end  as categroy,
             count(1) as accounts_count
      from day1
      group by categroy
      union all
      select *
      from cte) as t
group by categroy