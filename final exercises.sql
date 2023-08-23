use employees;
# Exercise 1
# Find the average salary of the male and female employees in each department.

SELECT
	d.dept_name,
    e.gender,
    ROUND(AVG(s.salary),1) as avg_salary
FROM
	employees e
		JOIN
	dept_manager dm ON dm.emp_no = e.emp_no
		JOIN
	departments d ON dm.dept_no = d.dept_no
		JOIN
	salaries s ON e.emp_no = s.emp_no
GROUP BY d.dept_name, e.gender
ORDER BY d.dept_name, e.gender;

# Exercise 2
# Then, find the highest department number.

SELECT
	MIN(dept_no),
    MAX(dept_no)
FROM
	dept_emp;
    
# Exercise 3
/* Obtain a table containing the following three fields for all individuals whose employee number 
is not greater than 10040:
- employee number
- the lowest department number among the departments where the employee has worked in (Hint: use
a subquery to retrieve this value from the 'dept_emp' table)
- assign '110022' as 'manager' to all individuals whose employee number is lower than or equal to 10020, and '110039' to those whose number is between 10021 and 10040 inclusive.
Use a CASE statement to create the third field.
If you've worked correctly, you should obtain an output containing 40 rows. */

SELECT 
    emp_no,
    (SELECT 
            MIN(dept_no)
        FROM
            dept_emp de
		WHERE
			de.emp_no = e.emp_no) dept_no,
    CASE
        WHEN e.emp_no <= 10020 THEN 110022
        ELSE '110039'
    END AS manager
FROM
    employees e
WHERE
    emp_no <= 10040; 
    

# Exercise 4
# Retrieve a list with all employees that have been hired in the year 2000.

SELECT
	*
FROM
	employees
WHERE YEAR(hire_date) = 2000;

# Exercise 5
# Retrieve a list with all employees from the ‘titles’ table who are engineers. 
# Repeat the exercise, this time retrieving a list with 
# employees from the ‘titles’ table who are senior engineers.

SELECT
	*
FROM
	titles
WHERE
	title LIKE '%engineer%';

SELECT
	*
FROM
	titles
WHERE
	title LIKE '%senior engineer%';
    
    
# Exercise 6
# Create a procedure that asks you to insert an employee number to obtain an output containing 
# the same number, as well as the number and name of the last department the employee has worked for.
# Finally, call the procedure for employee number 10010.
# If you've worked correctly, you should see that employee number 10010 has worked for department number 6 - "Quality Management".

DROP PROCEDURE IF EXISTS last_dept;

DELIMITER $$

CREATE PROCEDURE last_dept(IN p_emp_no INT)
BEGIN
	SELECT
		e.emp_no,
		de.dept_no,
		d.dept_name
	FROM
		dept_emp de
			JOIN
		departments d ON de.dept_no = d.dept_no
			JOIN
		employees e ON de.emp_no = e.emp_no
	WHERE 
		p_emp_no = de.emp_no AND
        de.from_date = (SELECT
            MAX(from_date)
        FROM
            dept_emp
        WHERE
            emp_no = p_emp_no);
END $$

DELIMITER ;



/*Exercise 7
How many contracts have been registered in the ‘salaries’ table with duration of more than 
one year and of value higher than or equal to $100,000?
*/

SELECT 
	COUNT(*)
FROM 
	salaries 
WHERE 
	salary >= 100000 AND
    DATEDIFF(to_date, from_date) > 365; 


/*Exercise 9
Define a function that retrieves the largest contract salary value of an employee. Apply it to employee number 11356.
In addition, what is the lowest contract salary value of the same employee? 
You may want to create a new function that to obtain the result.
*/

DROP FUNCTION IF EXISTS highest_salary;

DELIMITER $$

CREATE FUNCTION highest_salary(p_emp_no INTEGER) RETURNS DECIMAL(10,2)
DETERMINISTIC

BEGIN
	DECLARE v_highest_salary DECIMAL(10,2);
	SELECT
		MAX(s.salary) INTO v_highest_salary
	FROM
		salaries s
	WHERE
		s.emp_no = p_emp_no;
	RETURN v_highest_salary;
END $$

DELIMITER ;

DROP FUNCTION IF EXISTS lowest_salary;

DELIMITER $$

CREATE FUNCTION lowest_salary(p_emp_no INTEGER) RETURNS DECIMAL(10,2)
DETERMINISTIC

BEGIN
	DECLARE v_lowest_salary DECIMAL(10,2);
	SELECT
		MIN(s.salary) INTO v_lowest_salary
	FROM
		salaries s
	WHERE
		s.emp_no = p_emp_no;
	RETURN v_lowest_salary;
END $$

DELIMITER ;
/*
Exercise 10
Based on the previous exercise, you can now try to create a third function that also accepts a second parameter. Let this parameter be a character sequence. 
Evaluate if its value is 'min' or 'max' and based on that retrieve either the lowest or the highest salary, 
respectively (using the same logic and code structure from Exercise 9). If the inserted value is any string value 
different from ‘min’ or ‘max’, let the function return the difference between the highest and the lowest salary of that employee.
*/

DROP FUNCTION IF EXISTS min_or_max_salary;

DELIMITER $$

CREATE FUNCTION min_or_max_salary(p_emp_no INTEGER, p_min_or_max CHAR(5)) RETURNS DECIMAL(10,2)
DETERMINISTIC

BEGIN
	DECLARE v_salary DECIMAL(10,2);
	SELECT
		CASE 
			WHEN p_min_or_max = 'MIN' THEN MIN(s.salary)
            WHEN p_min_or_max = 'MAX' THEN MAX(s.salary)
		END
    INTO v_salary
	FROM
		salaries s
	WHERE
		s.emp_no = p_emp_no;
	RETURN v_salary;
END $$

DELIMITER ;