# Ćwiczenia praktyczne #3
# I. Operatory zbiorowe
# 1. Wyświetl listę pracowników zatrudnionych w działach 10, 50 i 20, w tej kolejności,
# używając operatorów UNION i dodając sztuczną kolumnę w odpowiednim miejscu. Dla
# każdego pracownika wyświetl nazwisko oraz identyfikator działu.
# 2. Wykorzystując operator INTERSECT Znajdź identyfikator działu, w którym pracują 4 osoby i
# który znajduje się w pokoju o numerze z zakresu <200, 299>.
# 3. Wyświetl identyfikatory działów, w których średnia pensja jest większa od 4000 i które nie
# znajdują się w pokojach 113 oraz 205. Zastosuj operator MINUS.
# II. Operatory zbiorowe – zadania domowe
# 1. Wyświetl nazwiska pracowników należących do grupy zaszeregowania o id równym 7, którzy
# zostali zatrudnieni przed 1 stycznia 1998, używając odpowiedniego operatora zbiorowego.
# 2. Dla wszystkich czterech tabel wyświetl ich nazwy oraz liczbę wierszy. Wskazówka: dla każdej
# tabeli ułóż osobne zapytanie i połącz ich wyniki w jedną całość. Nazwy tabel umieść w
# sztucznej kolumnie. Nadaj aliasy: "Nazwa tabeli" i "Liczba wierszy", posortuj wyniki malejąco
# wg liczby wierszy.
# III. Łączenie tabel
# 1. Ułóż zapytanie wyświetlające nazwisko, id działu i nazwę działu dla wszystkich pracowników,
# którzy są zatrudnieni w jakimś dziale. Uporządkuj wyniki rosnąco względem nazwy działu.
# 2. Wyświetl nazwisko, pensję oraz nazwę działu dla pracowników, których pensja jest wyższa
# niż 4000 i którzy otrzymują dodatek.
# 3. Ułóż zapytanie wyświetlające nazwisko, nazwę grupy zaszeregowania, nazwę działu dla
# wszystkich pracowników, których grupa zaszeregowania ma dolne ograniczenie płacy
# (min_salary) o wartości co najmniej 4000.
# 4. Dla pracowników pracujących w działach 20 i 30 wyświetl nazwisko, nazwę działu, nazwisko
# szefa i nazwę działu, w którym jest zatrudniony szef.
# 5. Znajdź pracowników, którzy zostali zatrudnieni w firmie wcześniej niż ich szef. Wyświetl
# nazwisko pracownika i nazwisko szefa.
# 6. Wyświetl nazwisko, nazwę działu dla wszystkich pracowników włącznie z tymi, którzy nie są
# przypisani do żadnego działu. Zastąp wartości puste w kolumnie zawierającej nazwę działu
# łańcuchem znaków 'Bez działu'.
# 7. Wyświetl nazwy stanowisk i liczbę pracowników pracujących na danym stanowisku. Posortuj
# rosnąco wg liczby pracowników, nadaj alias "Liczba pracowników".
# 8. Zmodyfikuj zapytanie z zad. 7 tak, aby liczba pracowników na stanowisku była wyliczana
# osobno dla każdego działu. Wyświetl nazwę działu (alias "Dział"), nazwę stanowiska (alias
# "Stanowisko") i liczbę pracowników. Posortuj dane alfabetycznie wg 1 i 2 kolumny.
# 9. Dla każdego działu wyświetl jego nazwę, liczbę pracowników, którzy w nim pracują
# oraz sumę ich pensji. Uwzględnij również działy bez pracowników oraz pracowników
# bez działów (zamień pustą wartość nazwy działu na znak '-' a pustą sumę pensji na
# 0). Posortuj wyniki alfabetycznie wg nazwy działu, nadaj aliasy "Dział", "Liczba
# pracowników" i "Suma pensji".
# 10.Dla każdego pracownika wyświetl jego imię i nazwisko, nazwę działu, nazwę
# stanowiska, nazwę grupy zaszeregowania oraz złączenia imienia i nazwiska szefa.
# Puste wartości zastąp słowem 'brak'. Posortuj dane wg nazwisk i imion.

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
LEFT JOIN employees e1 ON e.manager_id = e1.emp_id
LEFT JOIN departments d ON e.dep_id = d.dep_id
JOIN job_grades j ON e.jg_id = j.jg_id
ORDER BY e.first_name, e.last_name;
