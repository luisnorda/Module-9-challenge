CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" VARCHAR   NOT NULL,
    "birth_date" VARCHAR   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR(2)   NOT NULL,
    "hire_date" VARCHAR   NOT NULL
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL
);

CREATE TABLE "titles" (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL
);

ALTER TABLE "departments"
ADD PRIMARY KEY ("dept_no");

ALTER TABLE "employees"
ADD PRIMARY KEY ("emp_no");

ALTER TABLE "titles"
ADD PRIMARY KEY ("title_id");


ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "dept_emp" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

-- DATA ANALYSIS
	-- 1 query
	-- List the employee number, last name, first name, sex, and salary of each employee.
select e.emp_no, e.first_name, e.last_name, e.sex, s.salary
from employees e
join salaries s On e.emp_no = s.emp_no;

	-- 2 query
	-- List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT emp_no, first_name, last_name, hire_date
from employees
where hire_date LIKE '%/1986';

	-- 3 query
	-- List the manager of each department along with their department number, department name, employee number, last name, and first name.
select e.emp_no, e.emp_title_id, e.first_name, e.last_name, t.title, de.dept_no, d.dept_name
from employees e
join titles t on (e.emp_title_id = t.title_id)
join dept_emp de on (de.emp_no = e.emp_no)
join departments d on (d.dept_no = de.dept_no)
where t.title_id = 'm0001' 

	-- 4 query
	-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
select e.emp_no, e.first_name, e.last_name, de.dept_no, d.dept_name
from employees e
join dept_emp de on (de.emp_no = e.emp_no)
join departments d on (d.dept_no = de.dept_no); 

	-- 5 query
	-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
from employees
where first_name = 'Hercules' and last_name LIKE 'B%';

	-- 6 query
	-- List each employee in the Sales department, including their employee number, last name, and first name.
select e.emp_no, e.first_name, e.last_name, d.dept_name
from employees e
join dept_emp de on (de.emp_no = e.emp_no)
join departments d on (d.dept_no = de.dept_no)
where d.dept_no = 'd007';

	-- 7 query
	-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
select e.emp_no, e.first_name, e.last_name, d.dept_name
from employees e
join dept_emp de on (de.emp_no = e.emp_no)
join departments d on (d.dept_no = de.dept_no)
where d.dept_no = 'd007' OR d.dept_no = 'd005';

	-- 8 query
	-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, COUNT(last_name) AS "name_count"
FROM employees
Group By last_name
Order By "name_count" DESC;
