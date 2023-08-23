# sql-studies

### Udemy Course Information

This repository is created to solve different SQL queries. Below, you can find explanations for each query's purpose, where they could be useful, and the SQL features used. Additionally, these questions were taken from the Udemy course "SQL - MySQL for Data Analytics and Business Intelligence" by 365 Careers. You can find the course at this link.

## SQL Practice Queries

This repository is created to solve different SQL queries. Below, you can find explanations for each query's purpose, where they could be useful, and the SQL features used. Additionally, it's noted that these questions were taken from a Udemy course.

### Query 1 - Average Salary by Department

This query calculates the average salary of male and female employees in each department. Such a query could be used by data analysts or HR specialists to analyze gender-based salary disparities within the company. SQL features used:

- **JOIN:** Utilized to combine employee, department, and salary data.
- **GROUP BY:** Groups the data by department and gender to calculate average salaries.
- **ROUND:** Used to round the average salaries.

This query could be beneficial for individuals interested in investigating gender-based salary trends within a company.

### Query 2 - Highest Department Number

This query finds the highest department number. Such a query could be useful for understanding the department structure in the database and managing department numbers when adding new ones. SQL features used:

- **MIN** and **MAX:** Used to find the lowest and highest values of the `dept_no` field.

This query could be helpful for database administrators or anyone involved in database design and management.

### Query 3 - Employee Information and Departments

This query retrieves the lowest department number and managerial information for a given employee number. Additionally, a "manager" value is assigned based on specific conditions. This query could help track employee department history and managerial roles. SQL features used:

- **Subquery:** Utilized to retrieve the employee's lowest department number from the `dept_emp` table.
- **CASE:** Used to assign the "manager" value based on certain conditions.

This query could benefit HR specialists or department managers looking to understand employee department history.

### Query 4 - Employees Hired in 2000

This query lists all employees hired in the year 2000. Such a query could be used to track and analyze hiring trends for a specific year. SQL features used:

- **YEAR:** Used to extract the year from the `hire_date` field.

This query could be useful for HR professionals or managers interested in analyzing hiring patterns.

### Query 5 - Engineers and Senior Engineers

This query retrieves employees from the 'titles' table with titles containing "engineer" and "senior engineer". Such a query could be used to identify employees with specific titles for analysis. SQL features used:

- **LIKE:** Used to find fields containing specific words or phrases.

This query could be valuable for department managers or analysts seeking specific job titles within the workforce.

### Query 6 - Employee's Last Department

This query retrieves the last department where a specific employee worked. An accompanying stored procedure (`last_dept`) is created for this purpose. Such a query could be used to track department history and understand where an employee was working at a specific point. SQL features used:

- **Stored Procedure:** Utilized to retrieve the last department for an employee.

This query could be beneficial for HR or management professionals interested in tracking department history.

### Query 7 - Contracts with High Value and Duration

This query counts the number of contracts in the 'salaries' table with a duration longer than one year and a value equal to or exceeding $100,000. Such a query could help identify high-value and long-term contracts. SQL features used:

- **DATEDIFF:** Used to calculate the difference between dates.

This query could be useful for financial or HR analysts interested in analyzing contract values and durations.

### Query 9-10 - Highest and Lowest Salaries with Functions

These queries involve functions that retrieve the highest and lowest salaries for a specific employee. Additionally, a function (`min_or_max_salary`) is created to check an employee's salaries based on specific criteria. Such queries could be used to analyze an employee's salary history. SQL features used:

- **Functions:** The `highest_salary`, `lowest_salary`, and `min_or_max_salary` functions are utilized.

These queries could be valuable for finance analysis or professionals monitoring employee salaries.

