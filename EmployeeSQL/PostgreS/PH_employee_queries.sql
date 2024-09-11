DROP TABLE departments
DROP TABLE  employees
DROP TABLE  dept_manager
DROP TABLE  salaries
DROP TABLE  titles
DROP TABLE  dept_emp

CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(255) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

CREATE TABLE employees (
	emp_no INT NOT NULL,
	emp_title_id VARCHAR(10) NOT NULL,
	birth_date DATE	NOT NULL,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR (50) NOT NULL,
	sex VARCHAR(1) NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no)
);

CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (dept_no, emp_no)
);

CREATE TABLE salaries (
  	emp_no INT NOT NULL,
  	salary INT NOT NULL,
  	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  	PRIMARY KEY (emp_no)
);

CREATE TABLE titles (
	title_id VARCHAR(10) NOT NULL,
  	title VARCHAR(100) NOT NULL,
  	PRIMARY KEY (title_id)
);

CREATE TABLE dept_emp (
  emp_no INT,
  dept_no VARCHAR(4),
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
  PRIMARY KEY (emp_no, dept_no)
);

select * from departments;
select * from employees;
select * from dept_manager;
select * from salaries;
select * from titles;
select * from dept_emp;

--List the employee number, last name, first name, sex, and salary of each employee
SELECT e.emp_no, e.last_name,e.first_name,e.sex,s.salary
FROM employees as e
JOIN salaries as s ON e.emp_no = s.emp_no
;

--List the first name, last name, and hire date for the employees who were hired in 1986
SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986
;

--List the manager of each department along with their department number, department name, employee number, last name, and first name
SELECT d.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name
FROM dept_manager as dm
JOIN departments as d ON dm.dept_no = d.dept_no
JOin employees as e ON dm.emp_no = e.emp_no
;

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name
SELECT de.dept_no, e.emp_no, e.last_name, e.first_name,d.dept_name
FROM dept_emp as de
JOIN employees as e ON de.emp_no = e.emp_no
JOIN departments as d ON de.dept_no = d.dept_no
;

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B 
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'
;

--List each employee in the Sales department, including their employee number, last name, and first name
SELECT e.emp_no, e.last_name, e.first_name
FROM dept_emp as de
JOIN departments as d ON de.dept_no = d.dept_no
JOIN employees as e ON de.emp_no = e.emp_no
WHERE d.dept_name = 'Sales'
;

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp as de
JOIN departments as d ON de.dept_no = d.dept_no
JOIN employees as e ON de.emp_no = e.emp_no
WHERE d.dept_name IN ('Sales', 'Development')
;

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name)
SELECT last_name, COUNT(*) AS frequency_counts
FROM employees
GROUP BY last_name
ORDER BY frequency_counts DESC
;