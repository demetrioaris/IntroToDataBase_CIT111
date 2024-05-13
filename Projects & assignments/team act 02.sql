use employees;
SELECT 
    YEAR(s.from_date) AS Year, 
    CONCAT('$', FORMAT(MAX(s.salary), 2, 'enUS')) AS Salary,
    (
        SELECT CONCAT(first_name, ' ', last_name)
        FROM employees e
        WHERE e.emp_no = (
            SELECT emp_no
            FROM salaries
            WHERE YEAR(from_date) = Year
            ORDER BY salary DESC
            LIMIT 1
        )
    ) AS Employee_Name
FROM 
    salaries s
GROUP BY 
    Year;


