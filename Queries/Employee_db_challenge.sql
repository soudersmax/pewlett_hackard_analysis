-- Retirement Titles Table - historical titles of those who are 
-- eligible for retirement
SELECT  e.emp_no,
		e.first_name, e.last_name,
		ti.title,ti.from_date,
		ti.to_date
INTO retirement_titles
FROM employees as e
	LEFT JOIN titles as ti
	ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
ORDER BY e.emp_no, ti.from_date DESC;
SELECT * FROM retirement_titles
;
-- Unique Titles Table - most recent titles of those who are 
-- eligible for retirement
SELECT DISTINCT ON (emp_no) emp_no,
					first_name,
                    last_name,
					title
INTO unique_titles
FROM retirement_titles 
ORDER BY emp_no, from_date DESC
;
-- Retiring Titles Count table - number of people from each title who
-- are eligible for retirement
SELECT COUNT (title),
			title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY "count" DESC
;
-- Mentorship Eligibility Table - employees 10 years out from retirement
-- who are eligible for mentorship program
SELECT DISTINCT ON (e.emp_no)
		e.emp_no,
		e.first_name,
		e.last_name,
		e.birth_date,
		de.from_date,
		de.to_date,
		ti.title
INTO mentorship_eligibility
FROM employees AS e
	LEFT JOIN dept_emp AS de
	ON (e.emp_no = de.emp_no)
	LEFT JOIN titles AS ti
	ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no, ti.from_date DESC;