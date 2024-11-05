/*
Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation. The output column headers should be Doctor, Professor, Singer, and Actor, respectively.
Note: Print NULL when there are no more names corresponding to an occupation.
Input Format
The OCCUPATIONS table is described as follows:

Occupation will only contain one of the following values: Doctor, Professor, Singer or Actor.
Sample Input

Sample Output
Jenny    Ashley     Meera  Jane
Samantha Christeen  Priya  Julia
NULL     Ketty      NULL   Maria
Explanation
The first column is an alphabetically ordered list of Doctor names.
The second column is an alphabetically ordered list of Professor names.
The third column is an alphabetically ordered list of Singer names.
The fourth column is an alphabetically ordered list of Actor names.
The empty cell data for columns with less than the maximum number of names per occupation (in this case, the Professor and Actor columns) are filled with NULL values.


*/




-- WITH 
-- doctors AS (
--     SELECT name AS doctorName, ROW_NUMBER() OVER (PARTITION BY OCCUPATION ORDER BY name) AS rn
--     FROM OCCUPATIONS
--     WHERE occupation = 'Doctor'
-- ),
-- professors AS (
--     SELECT name AS professorName, ROW_NUMBER() OVER (PARTITION BY OCCUPATION ORDER BY name) AS rn
--     FROM OCCUPATIONS
--     WHERE occupation = 'Professor'
-- ),
-- singers AS (
--     SELECT name AS singerName, ROW_NUMBER() OVER (PARTITION BY OCCUPATION ORDER BY name) AS rn
--     FROM OCCUPATIONS
--     WHERE occupation = 'Singer'
-- ),
-- actors AS (
--     SELECT name AS actorName, ROW_NUMBER() OVER (PARTITION BY OCCUPATION ORDER BY name) AS rn
--     FROM OCCUPATIONS
--     WHERE occupation = 'Actor'
-- )

-- SELECT 
--     d.doctorName,
--     p.professorName,
--     s.singerName,
--     a.actorName

-- FROM 
-- ( SELECT DISTINCT rn FROM (
--     SELECT rn FROM doctors
--     UNION
--     SELECT rn FROM professors
--     UNION
--     SELECT rn FROM singers
--     UNION
--     SELECT rn FROM actors
-- )  t
--  ) nums
--     LEFT JOIN doctors d ON nums.rn = d.rn
--     LEFT JOIN professors p ON nums.rn = p.rn
--     LEFT JOIN singers s ON nums.rn = s.rn
--     LEFT JOIN actors a ON nums.rn = a.rn

-- ORDER BY
--     nums.rn;
    
SELECT 
    MAX(CASE WHEN occupation = 'Doctor' THEN name END) AS Doctor,
    MAX(CASE WHEN occupation = 'Professor' THEN name END) AS Professor,
    MAX(CASE WHEN occupation = 'Singer' THEN name END) AS Singer,
    MAX(CASE WHEN occupation = 'Actor' THEN name END) AS Actor
FROM (
    SELECT 
        name,
        occupation,
        ROW_NUMBER() OVER (PARTITION BY occupation ORDER BY name) AS rn
    FROM OCCUPATIONS
) tmp
GROUP BY rn
ORDER BY rn;