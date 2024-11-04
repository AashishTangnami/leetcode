/*
A median is defined as a number separating the higher half of a data set from the lower half. Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to  decimal places.
Input Format
The STATION table is described as follows:
ID Number
CITY VARCHAR(21)
STATE VARCHAR(2)
LAT_N Number
LONG_W Number
where LAT_N is the northern latitude and LONG_W is the western longitude.
*/
where LAT_N is the northern latitude and LONG_W is the western longitude.
*/

SELECT 
    ROUND(LAT_N,4)  
FROM (
    SELECT LAT_N, ROW_NUMBER() 
    OVER (ORDER BY LAT_N) AS row_num,
           COUNT(*) OVER () AS total_rows
         FROM STATION )
STATION
WHERE row_num =(TOTAL_ROWS + 1)/2;