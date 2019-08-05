-- emp_no, birth_date, first_name, last_name, gender, hire_date
create table employees (
emp_no int not null primary key,
birth_date date not null,
first_name varchar(100) not null,
last_name varchar (100) not null,
gender varchar(1) not null,
hire_date date not null);

-- emp_no, title, from_date, to_date
create table titles (
emp_no int not null references employees(emp_no),
title varchar(100) not null,
from_date date, 
to_date date);

-- emp_no, salary, from_date, to_date
create table salaries (
emp_no int not null references employees(emp_no),
salary int not null,
from_date date not null, 
to_date date not null);

-- dept_no, emp_no, from_date, to_date
create table dept_manager (
dept_no varchar(10) not null references departments(dept_no),
emp_no int not null references employees(emp_no),
from_date date not null,
to_date date not null);

-- emp_no, dept_no, from_date, to_date
create table dept_emp (
emp_no int not null references employees(emp_no),
dept_no varchar(10) not null references departments(dept_no),
from_date date not null,
to_date date not null);	

-- dept_no, dept_name
create table departments (
dept_no varchar(10) not null primary key,
dept_name varchar (100) not null);

--SELECT 'postgresql' AS dbms,t.table_catalog,t.table_schema,t.table_name,c.column_name,c.ordinal_position,c.data_type,c.character_maximum_length,n.constraint_type,k2.table_schema,k2.table_name,k2.column_name FROM information_schema.tables t NATURAL LEFT JOIN information_schema.columns c LEFT JOIN(information_schema.key_column_usage k NATURAL JOIN information_schema.table_constraints n NATURAL LEFT JOIN information_schema.referential_constraints r)ON c.table_catalog=k.table_catalog AND c.table_schema=k.table_schema AND c.table_name=k.table_name AND c.column_name=k.column_name LEFT JOIN information_schema.key_column_usage k2 ON k.position_in_unique_constraint=k2.ordinal_position AND r.unique_constraint_catalog=k2.constraint_catalog AND r.unique_constraint_schema=k2.constraint_schema AND r.unique_constraint_name=k2.constraint_name WHERE t.TABLE_TYPE='BASE TABLE' AND t.table_schema NOT IN('information_schema','pg_catalog');

--number 1
select e.emp_no, e.last_name, e.first_name, e.gender, salaries.salary
from employees as e
join salaries on
 (e.emp_no = salaries.emp_no)

--number 2 
select * from employees 
where hire_date between '1986-01-01' and '1986-12-31'
	order by hire_date

--number 3
select e.last_name, e.first_name, e.emp_no, de.dept_no, de.from_date, de.to_date, d.dept_name
from employees as e
join dept_emp as de on
 (e.emp_no = de.emp_no)
join dept_manager as dm on
 (e.emp_no = dm.emp_no)
join departments as d on
 (d.dept_no = de.dept_no)
order by last_name, dept_name

--number 4
select e.last_name, e.first_name, e.emp_no, de.dept_no, d.dept_name
from employees as e
join dept_emp as de on
 (e.emp_no = de.emp_no)
join departments as d on
 (d.dept_no = de.dept_no)
order by dept_name, last_name

--number 5
select e.last_name, e.first_name, e.emp_no
from employees as e
where e.first_name = 'Hercules' and e.last_name like 'B%'

--number 6
select e.last_name, e.first_name, e.emp_no, d.dept_name
from employees as e
join dept_emp as de on
 (e.emp_no = de.emp_no)
join departments as d on
 (d.dept_no = de.dept_no)
	where d.dept_name = 'Sales'
order by last_name

--number 7
select e.last_name, e.first_name, e.emp_no, d.dept_name
from employees as e
join dept_emp as de on
 (e.emp_no = de.emp_no)
join departments as d on
 (d.dept_no = de.dept_no)
	where d.dept_name = 'Sales' or d.dept_name = 'Development'
order by last_name

--number 8
select e.last_name, count(e.last_name)
from employees as e
group by last_name
order by count(e.last_name) desc;