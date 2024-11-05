/*
Amber's conglomerate corporation just acquired some new companies. Each of the companies follows this hierarchy: 
Given the table schemas below, write a query to print the company_code, founder name, total number of lead managers, total number of senior managers, total number of managers, and total number of employees. Order your output by ascending company_code.
Note:
The tables may contain duplicate records.
The company_code is string, so the sorting should not be numeric. For example, if the company_codes are C_1, C_2, and C_10, then the ascending company_codes will be C_1, C_10, and C_2.

*/



SELECT 
    C.company_code,
    C.founder,
    COUNT(DISTINCT E.lead_manager_code) AS TOTAL_LEAD_MANAGER,
    COUNT(DISTINCT E.senior_manager_code) AS TOTAL_SENIOR_MANAGER,
    COUNT(DISTINCT E.manager_code) AS TOTAL_MANAGER,
    COUNT(DISTINCT E.employee_code) AS TOTAL_EMPLOYEE
FROM 
    Company C
LEFT JOIN 
    Employee E ON C.company_code = E.company_code
GROUP BY
    C.company_code, C.founder
ORDER BY
    C.company_code ASC;