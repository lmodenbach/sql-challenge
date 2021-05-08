--Order of operations based on dependencies demonstrated in the ERD:
--NOTE: some fine tuned reordering would have worked, for instance departments could 
--      come first just as the independant titles can 
--NOTE: thanks to QuickDBD!


--titles: independant, title_id is only/primary key
CREATE TABLE titles (
	title_id VARCHAR PRIMARY KEY,
	titles VARCHAR
);

--employees: emp_title_id is a foreign key depending on titles.title_id,
--           emp_no is the primary key used as foreign key in other tables
CREATE TABLE employees (
	emp_no INT PRIMARY KEY,
	emp_title_id VARCHAR,
	birth_date DATE,
	first_name VARCHAR,
	last_name VARCHAR,
	sex VARCHAR,
	hire_date DATE,
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);

--departments: independent, provides dept_no as primary key
CREATE TABLE departments (
	dept_no VARCHAR PRIMARY KEY,
	dept_name VARCHAR
);

--dept_managers: foreign key dept_no depends on departments.dept_no, foreign
--               key emp_no depends on employees.emp_no, primary key cannot be 
--               a foreign key (must be unique) so we do a composite key of both 
--               data fields
CREATE TABLE dept_managers (
	dept_no VARCHAR,
	emp_no INT, 
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY (dept_no, emp_no)
);

--dept_emp: foreign key dept_no depends on departments.dept_no, foreign key emp_no
--          depends on employees.emp_no, again primary key must be unique so we do
--          a composite key
CREATE TABLE dept_emp (
	emp_no INT,
	dept_no VARCHAR, 
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY (emp_no, dept_no)
);

--salaries: foreign key emp_no depends on employees.emp_no, salaries has no appropriate 
--          primary key as both salary values and emp_no values can appear multiple times
CREATE TABLE salaries (
	emp_no INT,
	salary INT,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);
