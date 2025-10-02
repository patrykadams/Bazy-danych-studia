#zad1
SELECT * from departments;

#zad 2 
DESC employees;

#zad 3
SELECT * from DEPARTMENTS, Positions, JOB_GRADES;
SELECT * from DEPARTMENTS;
SELECT * from Positions;
SELECT * from JOB_GRADES;

#zad 4 
Select dep_id FROM departments;

SELECT DISTINCT dep_id FROM employees
where dep_id IS NOT NULL;

#zad 5
SELECT first_name, last_name, salary*12 AS "Roczna Pensja" FROM EMPLOYEES;

#zad 6
SELECT first_name || ' ' || last_name from employees
where dep_id = 40;

#zad 7
SELECT last_name, manager_id, salary from employees
where salary Between '3000' and '8000';

#zad8
SELECT last_name, salary, hire_date from employees
where first_name like 'Nic%' OR last_name like 'Nic%';

#zad 9
select name, max_salary-min_salary as "roznica" FROM job_grades;
 
#zad 10
SELECT first_name, last_name, manager_id from employees
where first_name like '_a%' and first_name not like '%i%';


#zad 11
SELECT last_name from employees
where dep_id = '30'
order by last_name ASC;

#zad 12
SELECT first_name, last_name from employees
where dep_id is null;
select hire_date from employees;

#zad 13
select last_name, hire_date from employees 
where hire_date between '97/01/01' and '98/12/31'
order by hire_date asc;

#zad 14 
select last_name, salary from employees
where dep_id in (20,40,50)
order by salary desc;

#zad 15
select last_name, salary as "pensja", allowance as "dodatek", salary+allowance as "całość" from employees
where (salary+allowance < 5000) or (allowance is  null and salary < 5000)
order by salary, allowance;

#zad 16
select last_name, dep_id, jg_id from employees
where jg_id not like '4' and jg_id not like '9'
order by dep_id asc, jg_id desc;

select last_name, dep_id, jg_id from employees
where jg_id not in (4,9)
order by dep_id asc, jg_id desc;


#zadania domowe 
# 1 
Select name, location from departments
order by name asc;

#2 
select * from employees 
where manager_id is null;

#3 
select distinct pos_id from employees 
where dep_id = '30';
select hire_date from employees;
#4 
select emp_id from employees
where hire_date like '01%' and salary+allowance >= 7000;
