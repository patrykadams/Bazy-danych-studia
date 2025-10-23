-- #1
SELECT 
    last_name, 
    dep_id, 
    1 AS sort_order
FROM employees
WHERE dep_id = 10

UNION

SELECT 
    last_name, 
    dep_id, 
    2 AS sort_order
FROM employees
WHERE dep_id = 50

UNION

SELECT 
    last_name, 
    dep_id, 
    3 AS sort_order
FROM employees
WHERE dep_id = 20

ORDER BY sort_order, last_name;


-- #2
SELECT dep_id
FROM employees
GROUP BY dep_id
HAVING COUNT(*) = 4

INTERSECT

SELECT dep_id
FROM departments
WHERE room_no BETWEEN 200 AND 299;


-- #3
SELECT 
    e.last_name,
    j.name AS job_grade,
    d.name AS department_name
FROM employees e
JOIN job_grades j ON e.jg_id = j.jg_id
JOIN departments d ON e.dep_id = d.dep_id
WHERE j.min_salary >= 4000;


-- #4
SELECT 
    e.last_name AS employee_last_name,
    e1.last_name AS manager_last_name,
    d.name AS department_name,
    j.name AS job_grade
FROM employees e
JOIN employees e1 ON e.manager_id = e1.emp_id
JOIN departments d ON e.dep_id = d.dep_id
JOIN job_grades j ON e.jg_id = j.jg_id
WHERE e1.dep_id IN (20, 30);


-- #5
SELECT 
    e.last_name AS employee_last_name,
    e1.last_name AS manager_last_name
FROM employees e
JOIN employees e1 ON e.manager_id = e1.emp_id
WHERE e.hire_date < e1.hire_date;


-- #6
SELECT 
    e.last_name,
    NVL(d.name, 'bez działu') AS department_name
FROM employees e
LEFT JOIN departments d ON e.dep_id = d.dep_id;


-- #7
SELECT 
    p.name AS position_name,
    COUNT(e.emp_id) AS "Liczba pracowników"
FROM employees e
JOIN positions p ON e.pos_id = p.pos_id
GROUP BY p.name
ORDER BY COUNT(e.emp_id);


-- #8
SELECT 
    d.name AS department_name,
    p.name AS position_name,
    COUNT(e.emp_id) AS "Liczba pracowników"
FROM employees e
JOIN positions p ON e.pos_id = p.pos_id
JOIN departments d ON e.dep_id = d.dep_id
GROUP BY d.name, p.name
ORDER BY d.name, p.name;


-- #9
SELECT 
    NVL(d.name, '-') AS "Dział",
    COUNT(e.emp_id) AS "Liczba pracowników",
    NVL(SUM(e.salary), 0) AS "Suma pensji"
FROM departments d
FULL JOIN employees e ON e.dep_id = d.dep_id
GROUP BY d.name
ORDER BY NVL(d.name, '-');


-- #10
SELECT 
    NVL(e.first_name, 'brak') AS first_name,
    NVL(e.last_name, 'brak') AS last_name,
    NVL(d.name, 'brak') AS department_name,
    NVL(j.name, 'brak') AS job_grade,
    NVL(e1.first_name || ' ' || e1.last_name, 'brak') AS "Szef"
FROM employees e
FULL JOIN employees e1 ON e.manager_id = e1.emp_id
FULL JOIN departments d ON e.dep_id = d.dep_id
FULL JOIN job_grades j ON e.jg_id = j.jg_id
ORDER BY e.first_name, e.last_name;
