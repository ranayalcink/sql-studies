/* Right here, I was practicing stored procedures. 
	- why we use stored procedures
	- what are the differences betweenn stored procedures, routines and user-defined functions
	- explain every procedures
*/
use employees;

drop procedure if exists select_employees;

DELIMITER $$
CREATE PROCEDURE select_employees()
BEGIN
	SELECT * FROM employees
    LIMIT 1000;
END $$
DELIMITER ;

CALL employees.select_employees();

drop procedure if exists average_salary;

DELIMITER $$
CREATE PROCEDURE average_salary()
BEGIN
	SELECT AVG(salary) FROM salaries;
END $$
DELIMITER ; 
CALL average_salary();


drop procedure if exists emp_salary;

DELIMITER $$
CREATE PROCEDURE emp_salary(IN p_emp_no INTEGER)
BEGIN
	SELECT
		e.first_name,
        e.last_name,
        s.salary,
        s.from_date,
        s.to_date
	FROM employees e 
			JOIN
		salaries s ON e.emp_no = s.emp_no
	WHERE e.emp_no = p_emp_no;
END $$

DELIMITER ;

drop procedure if exists avg_emp_salary;
DELIMITER $$
CREATE PROCEDURE avg_emp_salary(IN p_emp_no INTEGER)
BEGIN
	SELECT
		e.first_name,
        e.last_name,
        AVG(s.salary)
	FROM employees e 
			JOIN
		salaries s ON e.emp_no = s.emp_no
	WHERE e.emp_no = p_emp_no
    GROUP BY e.first_name, e.last_name;
END $$

DELIMITER ;

drop procedure if exists avg_emp_salary_out;

DELIMITER $$
CREATE PROCEDURE avg_emp_salary_out(IN p_emp_no INTEGER, OUT p_avg_salary DECIMAL(10,2))
BEGIN
	SELECT
        AVG(s.salary)
	INTO p_avg_salary
    FROM employees e 
			JOIN
		salaries s ON e.emp_no = s.emp_no
	WHERE e.emp_no = p_emp_no;
END $$

DELIMITER ;

drop procedure if exists emp_info;

DELIMITER $$
CREATE PROCEDURE emp_info(in p_first_name VARCHAR(255), in p_last_name VARCHAR(255), out p_emp_no INTEGER)
BEGIN
	SELECT
        emp_no 
	INTO p_emp_no
	FROM employees e
    WHERE e.first_name = p_first_name AND e.last_name = p_last_name;
END $$

DELIMITER ; 

SET @v_emp_no = 0;
CALL emp_info('Aruna','Journel',@v_emp_no);
SELECT @v_emp_no;

DELIMITER $$
CREATE FUNCTION f_emp_avg_salary(p_emp_no INTEGER) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN

DECLARE v_avg_salary DECIMAL(10,2);

	SELECT
        AVG(s.salary)
	INTO v_avg_salary
    FROM employees e 
			JOIN
		salaries s ON e.emp_no = s.emp_no
	WHERE e.emp_no = p_emp_no;

RETURN v_avg_salary;
END $$

DELIMITER ;

DROP FUNCTION IF EXISTS emp_info;
DELIMITER $$
CREATE FUNCTION emp_info(p_first_name VARCHAR(250), p_last_name VARCHAR(250)) RETURNS DECIMAL(10,2)
DETERMINISTIC NO SQL READS SQL DATA
BEGIN

DECLARE v_salary DECIMAL(10,2);
DECLARE v_max_from_date DATE;

SELECT
	MAX(from_date)
INTO v_max_from_date
FROM employees e
		JOIN
	salaries s ON e.emp_no = s.emp_no
WHERE e.first_name = p_first_name AND e.last_name = p_last_name;

SELECT
	s.salary
INTO v_salary
FROM employees e
		JOIN
		 salaries s ON e.emp_no = s.emp_no
WHERE
    e.first_name = p_first_name
        AND e.last_name = p_last_name
        AND s.from_date = v_max_from_date;
                RETURN v_salary;
END$$

DELIMITER ;

SELECT EMP_INFO('Aruna', 'Journel');
	
