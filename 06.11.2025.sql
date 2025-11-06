# Correlated Subqueries


# Practical Exercises #5
# 1. Display the ID, last name, and department name for all employees. In the
# SELECT clause, include a scalar subquery to retrieve the department name.
# 2. Find employees who earn more than the average salary of employees in their
# department. For each employee, display the last name, salary, department ID,
# and the average salary in that department. Sort the results in ascending order
# by the average salary.
# 3. For each grade group, find the employee who earns the most. Display the group
# ID, last name, and salary, and sort the results in ascending order by group IDs.
# 4. For each position, find the employee whose total pay (salary plus bonus) is the
# lowest. Display the position name, employee’s last name, and total pay (as
# above), and sort the results alphabetically by position names.
# 5. For each department, find the “manager,” meaning the person who does not
# have a supervisor in the same department. Display the department ID, last
# name, and supervisor ID, and sort the results in descending order by
# department ID.
# 6. Display the last names of employees who have one or more coworkers in their
# department with shorter tenure but higher salary.
# 7. Find employees who do not have subordinates.
# Hint: formulate a query with a correlated subquery using the NOT EXISTS
# operator.
# Homework
# 1. Find employees who earn the same amount as the lowest salary among
# employees in the same department. Sort the results in ascending order by
# salary.
# 2. Write a query displaying the IDs and last names of employees working in a
# department where there is at least one employee whose last name contains the
# letter 'e'.



                
#1               
SELECT e.emp_id, e.last_name, (SELECT name from departments where e.dep_id = dep_id) FROM employees e;

#2 
SELECT
    e.last_name,
    e.salary,
    e.dep_id,
    (
        SELECT AVG(e2.salary)
        FROM employees e2
        WHERE e2.dep_id = e.dep_id
    ) AS avg_dept_salary
FROM
    employees e
WHERE
    e.salary > (
        SELECT AVG(e3.salary)
        FROM employees e3
        WHERE e3.dep_id = e.dep_id
    )
ORDER BY
    avg_dept_salary ASC;
    
    
#3

SELECT
    jg.JG_ID,
    e.LAST_NAME,
    e.SALARY
FROM
    EMPLOYEES e,
    JOB_GRADES jg
WHERE
    e.SALARY BETWEEN jg.MIN_SALARY AND jg.MAX_SALARY
    AND e.SALARY = (
        SELECT MAX(e2.SALARY)
        FROM EMPLOYEES e2
        WHERE e2.SALARY BETWEEN jg.MIN_SALARY AND jg.MAX_SALARY
    )
ORDER BY
    jg.JG_ID ASC;
    

#4

SELECT
    p.NAME AS position_name,
    e.LAST_NAME,
    (e.SALARY + COALESCE(e.ALLOWANCE, 0)) AS total_pay
FROM
    EMPLOYEES e,
    POSITIONS p
WHERE
    e.POS_ID = p.POS_ID
    AND (e.SALARY + COALESCE(e.ALLOWANCE, 0)) = (
        SELECT MIN(e2.SALARY + COALESCE(e2.ALLOWANCE, 0))
        FROM EMPLOYEES e2
        WHERE e2.POS_ID = e.POS_ID
    )
ORDER BY
    p.NAME ASC;
    
    
#5
SELECT
    e.DEP_ID,
    e.LAST_NAME,
    e.MANAGER_ID
FROM
    EMPLOYEES e
WHERE
    e.EMP_ID NOT IN (
        SELECT e2.MANAGER_ID
        FROM EMPLOYEES e2
        WHERE
            e2.DEP_ID = e.DEP_ID
            AND e2.MANAGER_ID IS NOT NULL
    )
ORDER BY
    e.DEP_ID DESC;
    
    
#6
SELECT DISTINCT
    e1.LAST_NAME
FROM
    EMPLOYEES e1,
    EMPLOYEES e2
WHERE
    e1.DEP_ID = e2.DEP_ID         -- Ten sam dział
    AND e1.EMP_ID <> e2.EMP_ID    -- To nie jest ten sam pracownik
    AND e2.HIRE_DATE > e1.HIRE_DATE -- E2 ma krótszy staż (zatrudniony później)
    AND e2.SALARY > e1.SALARY;    -- E2 ma wyższą pensję
    
    
#7

SELECT
    e.LAST_NAME
FROM
    EMPLOYEES e
WHERE
    NOT EXISTS (
        SELECT
            1
        FROM
            EMPLOYEES sub
        WHERE
            sub.MANAGER_ID = e.EMP_ID
    );