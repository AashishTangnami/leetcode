/*
Generate the following two result sets:
Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format:
There are a total of [occupation_count] [occupation]s.
where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS and [occupation] is the lowercase occupation name. If more than one Occupation has the same [occupation_count], they should be ordered alphabetically.
Note: There will be at least two entries in the table for each type of occupation.
Input Format
The OCCUPATIONS table is described as follows:  Occupation will only contain one of the following values: Doctor, Professor, Singer or Actor.
Sample Input
An OCCUPATIONS table that contains the following records:

Sample Output
Ashely(P)
Christeen(P)
Jane(A)
Jenny(D)
Julia(A)
Ketty(P)
Maria(A)
Meera(S)
Priya(S)
Samantha(D)
There are a total of 2 doctors.
There are a total of 2 singers.
There are a total of 3 actors.
There are a total of 3 professors.
Explanation
The results of the first query are formatted to the problem description's specifications.
The results of the second query are ascendingly ordered first by number of names corresponding to each profession (), and then alphabetically by profession (, and ).

*/

-- with cte as (select concat(NAME, '(', SUBSTR(OCCUPATION, 1, 1), ')') as formated_name from occupations)
-- nd_cte as (
--     select CONCAT('There are a total of ', COUNT(*), ' ', OCCUPATION, 's.') as total_occupants from occupations 
-- group by occupation
-- )
-- SELECT cte.formatted_name, nd_cte.total_occupants 
-- FROM cte, nd_cte;


-- WITH cte AS (
--     SELECT CONCAT(NAME, '(', SUBSTR(OCCUPATION, 1, 1), ')') AS formatted_name
--     FROM OCCUPATIONS
--     ORDER BY NAME ASC
-- ),
-- second_cte AS (
--     SELECT CONCAT('There are a total of ', COUNT(*), ' ', OCCUPATION, 's.') AS total_occupants 
--     FROM OCCUPATIONS
--     GROUP BY OCCUPATION
--     ORDER BY COUNT(*), OCCUPATION ASC
-- )
-- SELECT formatted_name FROM cte
-- UNION ALL
-- SELECT total_occupants FROM second_cte;


WITH cte AS (
    -- Query to get the formatted names with the first letter of the occupation -- THIS IS FIRST QUERY
    SELECT CONCAT(NAME, '(', SUBSTR(OCCUPATION, 1, 1), ')') AS result, NAME
    FROM OCCUPATIONS
),
nd_cte AS (
    -- Query to get the count of each occupation-- THIS IS SECOND SUB QUERY.
    SELECT CONCAT('There are a total of ', COUNT(*), ' ', LOWER(OCCUPATION), 's.') AS result, NULL AS NAME -- NAME CANNOT BE GROUPED BY OCCUPATION THUS IT IS NULL.
    FROM OCCUPATIONS
    GROUP BY OCCUPATION
)

-- Union the two result sets together, ordering the final result set
SELECT result 
FROM (
    SELECT result, NAME FROM cte
    UNION ALL
    SELECT result, NAME FROM nd_cte
) AS final_result
-- Order by name for non-null names, and fallback to 'Z' for null names to ensure occupation counts appear last
ORDER BY COALESCE(NAME, 'Z'), result ASC;
