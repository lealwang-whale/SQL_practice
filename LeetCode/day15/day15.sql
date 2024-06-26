# leetcode 1212. Team Scores in Football Tournament 🔒
#
# Description
# Table: Teams
#
# +---------------+----------+
# | Column Name   | Type     |
# +---------------+----------+
# | team_id       | int      |
# | team_name     | varchar  |
# +---------------+----------+
# team_id is the column with unique values of this table.
# Each row of this table represents a single football team.
#
#
# Table: Matches
#
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | match_id      | int     |
# | host_team     | int     |
# | guest_team    | int     |
# | host_goals    | int     |
# | guest_goals   | int     |
# +---------------+---------+
# match_id is the column of unique values of this table.
# Each row is a record of a finished match between two different teams.
# Teams host_team and guest_team are represented by their IDs in the Teams table (team_id), and they scored host_goals and guest_goals goals, respectively.
#
#
# You would like to compute the scores of all teams after all matches. Points are awarded as follows:
# A team receives three points if they win a match (i.e., Scored more goals than the opponent team).
# A team receives one point if they draw a match (i.e., Scored the same number of goals as the opponent team).
# A team receives no points if they lose a match (i.e., Scored fewer goals than the opponent team).
# Write a solution that selects the team_id, team_name and num_points of each team in the tournament after all described matches.
#
# Return the result table ordered by num_points in decreasing order. In case of a tie, order the records by team_id in increasing order.
#
# The result format is in the following example.
#
#
#
# Example 1:
#
# Input:
# Teams table:
# +-----------+--------------+
# | team_id   | team_name    |
# +-----------+--------------+
# | 10        | Leetcode FC  |
# | 20        | NewYork FC   |
# | 30        | Atlanta FC   |
# | 40        | Chicago FC   |
# | 50        | Toronto FC   |
# +-----------+--------------+
# Matches table:
# +------------+--------------+---------------+-------------+--------------+
# | match_id   | host_team    | guest_team    | host_goals  | guest_goals  |
# +------------+--------------+---------------+-------------+--------------+
# | 1          | 10           | 20            | 3           | 0            |
# | 2          | 30           | 10            | 2           | 2            |
# | 3          | 10           | 50            | 5           | 1            |
# | 4          | 20           | 30            | 1           | 0            |
# | 5          | 50           | 30            | 1           | 0            |
# +------------+--------------+---------------+-------------+--------------+
# Output:
# +------------+--------------+---------------+
# | team_id    | team_name    | num_points    |
# +------------+--------------+---------------+
# | 10         | Leetcode FC  | 7             |
# | 20         | NewYork FC   | 3             |
# | 50         | Toronto FC   | 3             |
# | 30         | Atlanta FC   | 1             |
# | 40         | Chicago FC   | 0             |
# +------------+--------------+---------------+

# CREATE TABLE if not exists day15_teams
# (
#     name_id   integer,
#     team_name varchar(15)
# );
#
# CREATE TABLE if not exists day15_matches
# (
#     match_id    integer,
#     host_team   integer,
#     guest_team  integer,
#     host_goals  integer,
#     guest_goals integer
# );
#
# INSERT INTO day15_teams (name_id, team_name)
# VALUES (10, 'Leetcode FC'),
#        (20, 'NewYork FC'),
#        (30, 'Atlanta FC'),
#        (40, 'Chicago FC'),
#        (50, 'Toronto FC');
#
# INSERT INTO day15_matches (match_id, host_team, guest_team, host_goals, guest_goals)
# VALUES (1, 10, 20, 3, 0),
#        (2, 30, 10, 2, 2),
#        (3, 10, 50, 5, 1),
#        (4, 20, 30, 1, 0),
#        (5, 50, 30, 1, 0);

with cte as (select team_id,
                    sum(host_point) as host_point
             from (select host_team as team_id,
                          sum(
                                  case
                                      when host_goals > guest_goals then 3
                                      when host_goals = guest_goals then 1
                                      else 0 end
                          )         as host_point
                   from day15_matches m
                   group by host_team
                   union all
                   select guest_team as team_id,
                          sum(
                                  case
                                      when host_goals < guest_goals then 3
                                      when host_goals = guest_goals then 1
                                      else 0 end
                          )          as host_point
                   from day15_matches m
                   group by guest_team) t
             group by team_id)
select t.name_id,
       team_name,
       coalesce(host_point, 0) as num_points
from day15_teams t
         left join cte c on t.name_id = c.team_id
order by num_points desc, team_id asc;


select t.name_id,
       t.team_name,
       sum(
               case
                   when m.host_team = t.name_id and m.host_goals > m.guest_goals then 3
                   when m.guest_team = t.name_id and m.host_goals < m.guest_goals then 3
                   when m.host_goals = m.guest_goals then 1
                   else 0 end
       ) as num_points
from day15_teams t
         left join day15_matches m on t.name_id = m.host_team or t.name_id = m.guest_team
group by t.name_id, t.team_name
order by num_points desc, t.name_id asc;