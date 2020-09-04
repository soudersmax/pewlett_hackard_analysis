-- Retirement Eligibilty Table
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- JOIN practice
-- Joining departments and managers tables (inner join)
-- Select the columns we want in the table
SELECT d.dept_name,
	dm.emp_no,
	dm.from_date,
	dm.to_date
-- left table 
FROM departments as d
-- right table
INNER JOIN dept_manager as dm
-- matched column
ON d.dept_no = dm.dept_no;

-- Recreate retirement_info with dept_emp AGAIN (Left Join)
-- Use aliases to shorten input
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
-- Create a new table to hold the data
INTO current_emp
-- assign the left table and define ri alias
FROM retirement_info as ri
-- assign the right table and the type of join and define
-- de alias
LEFT JOIN dept_emp as de
-- matched column
ON ri.emp_no = de.emp_no
-- Filter for current employees
WHERE de.to_date = ('9999-01-01');

-- Employee Count by department number --> new table for export
SELECT COUNT(ce.emp_no), de.dept_no
INTO dept_retirement
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no; 

--emp_info table for List 1 
SELECT e.emp_no, 
	e.first_name, 
e.last_name,
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

-- List of managers per department
SELECT  dm.dept_no,
		d.dept_name,
		dm.emp_no,
		ce.last_name,
		ce.first_name,
		dm.from_date,
		dm.to_date
INTO manager_info
FROM dept_manager AS dm
	INNER JOIN departments AS d
		ON (dm.dept_no = d.dept_no)
	INNER JOIN current_emp AS ce
		ON (dm.emp_no = ce.emp_no);

-- List of department retirees
SELECT  de.emp_no,
		ce.first_name,
		ce.last_name,
		d.dept_name
INTO dept_info
FROM current_emp as ce
	INNER JOIN dept_emp AS de
		ON (ce.emp_no = de.emp_no)
	INNER JOIN departments AS d
		ON (de.dept_no = d.dept_no);
-- Create list for sales showing ce. first, last, no, and department name
SELECT  ce.emp_no,
		ce.first_name,
		ce.last_name,
		d.dept_name
FROM current_emp AS ce
	INNER JOIN dept_emp AS de
		ON (ce.emp_no = de.emp_no)
	INNER JOIN departments AS d
		ON (de.dept_no = d.dept_no)
WHERE (d.dept_name = 'Sales');

-- Create list for sales and development showing ce. first, last, no, and department name
SELECT  ce.emp_no,
		ce.first_name,
		ce.last_name,
		d.dept_name
FROM current_emp AS ce
	INNER JOIN dept_emp AS de
		ON (ce.emp_no = de.emp_no)
	INNER JOIN departments AS d
		ON (de.dept_no = d.dept_no)
WHERE d.dept_name IN ('Sales', 'Development');