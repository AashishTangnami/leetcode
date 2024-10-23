/*
Game Play Analysis IV
Table: Activity

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key (combination of columns with unique values) of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
 

Write a solution to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date, then divide that number by the total number of players.

The result format is in the following example.

 

Example 1:

Input: 
Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-03-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+
Output: 
+-----------+
| fraction  |
+-----------+
| 0.33      |
+-----------+
Explanation: 
Only the player with id 1 logged back in after the first day he had logged in so the answer is 1/3 = 0.33
*/

-- Step 1: Find first login date for each player
WITH FirstLogins AS (
    SELECT player_id, MIN(event_date) as first_login
    FROM Activity
    GROUP BY player_id
),
-- Step 2: Check if they logged in next day
ConsecutiveLogins AS (
    SELECT 
        f.player_id,
        CASE WHEN EXISTS (
            SELECT 1 
            FROM Activity a 
            WHERE a.player_id = f.player_id 
            AND a.event_date = f.first_login + 1
        ) THEN 1 ELSE 0 END as logged_next_day
    FROM FirstLogins f
)
-- Step 3: Calculate fraction
SELECT ROUND(
    SUM(logged_next_day)::DECIMAL / COUNT(*)::DECIMAL, 
    2
) as fraction
FROM ConsecutiveLogins;

---- OR ----

WITH firstlogin AS (
    SELECT player_id, MIN(event_date) AS first_login
    FROM Activity
    GROUP BY player_id
)
SELECT ROUND(
    COUNT(DISTINCT CASE
    WHEN a2.event_date = a1.first_login + 1
    THEN a1.player_id
    END)::DECIMAL/ 
    COUNT(DISTINCT a1.player_id)::DECIMAL, 2
) AS fraction
FROM firstlogin a1
LEFT JOIN Activity a2
ON a1.player_id = a2.player_id
AND a2.event_date = a1.first_login + 1 ;



---- OR ----


WITH PlayerDates AS (
    SELECT 
        player_id,
        event_date,
        LEAD(event_date) OVER (
            PARTITION BY player_id 
            ORDER BY event_date
        ) as next_login,
        ROW_NUMBER() OVER (
            PARTITION BY player_id 
            ORDER BY event_date
        ) as login_order
    FROM Activity
)
SELECT ROUND(
    SUM(CASE 
        WHEN next_login = event_date + 1 
        THEN 1 ELSE 0 
    END)::DECIMAL / 
    COUNT(*)::DECIMAL,
    2
) as fraction
FROM PlayerDates
WHERE login_order = 1;