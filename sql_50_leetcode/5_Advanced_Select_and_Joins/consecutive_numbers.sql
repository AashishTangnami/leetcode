/*

Table: Logs

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
In SQL, id is the primary key for this table.
id is an autoincrement column starting from 1.
 

Find all numbers that appear at least three times consecutively.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Logs table:
+----+-----+
| id | num |
+----+-----+
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |
+----+-----+
Output: 
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
Explanation: 1 is the only number that appears consecutively for at least three times.


*/

SELECT DISTINCT l1.num AS ConsecutiveNums
FROM logs l1, logs l2, logs l3
WHERE l1.id = l2.id + 1 
  AND l1.num = l2.num
  AND l1.id = l3.id + 2 
  AND l1.num = l3.num;

--- OR -----

with CTE as (
	select
		num,
		id,
		lead(num, 1)  over (order by id) num1,
		lead(num, 2)  over (order by id) num2,
		lead(id, 1) over (order by id) id1,
		lead(id, 2) over (order by id) id2
	from logs
)

select distinct num as "ConsecutiveNums" from cte
where num = num1 and num = num2 and id = id1 - 1 and id = id2 -2;


----- OR -----


select distinct num "ConsecutiveNums"
from (
    select 
        num, 
        num = lag(num, 1) over (order by id) 
            and num = lead(num, 1) over (order by id) 
            and id - 1 = lag(id, 1) over (order by id) 
            and id + 1 = lead(id, 1) over (order by id) consecutive
    from logs
) c
where consecutive

------- OR -------

WITH nums_with_prev_and_next_nums AS (
    SELECT id,
           LAG(num) OVER(ORDER BY id) AS prev_num,
           num AS curr_num,
           LEAD(num) OVER(ORDER BY id) AS next_num
      FROM logs
)
SELECT DISTINCT curr_num AS ConsecutiveNums
  FROM nums_with_prev_and_next_nums
 WHERE prev_num = curr_num AND curr_num = next_num;