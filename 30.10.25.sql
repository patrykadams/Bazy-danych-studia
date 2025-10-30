# Bazy danych Katedra Technologii Informacyjnych UEP
#
#Ćwiczenia praktyczne #4
#Poniższe zadania należy wykonać używając podzapytań nieskorelowanych. Dobrą praktyką jest
#sformułowanie i przetestowanie podzapytania przed przystąpieniem do tworzenia zapytania
#głównego. Pozwala to zweryfikować poprawność podzapytania i sprawdzić czy daje ono spodziewane
#wyniki.
#1. Wyświetl identyfikator i nazwisko dla pracowników, których szefem jest Anderson.
#2. Wyświetl nazwisko, identyfikator szefa i pensję dla pracowników, którzy pracują w tym samym
#dziale co pracownik o nazwisku Anderson, z wyłączeniem jego samego.
#3. Wyświetl nazwiska pracowników zatrudnionych dłużej niż Nichols.
#4. Wyświetl nazwisko i identyfikator grupy zaszeregowania dla pracowników, których
#wynagrodzenie jest wyższe niż średnie wynagrodzenie wszystkich pracowników.
#Wynagrodzenie oblicz jako sumę pensji i dodatku.
#5. Wyświetl nazwiska i pensje pracowników, którzy nie pracują w pokoju 201 ani 205.
#6. Napisz zapytanie wyświetlające nazwisko, pensję, identyfikator działu i identyfikator grupy
#zaszeregowania dla pracowników, których dział i grupa zaszeregowania są takie same, jak dział
#i grupa zaszeregowania jakiegokolwiek pracownika otrzymującego dodatek. Wskazówka: użyj
#podzapytania wielokolumnowego.
#7. Wyświetl dane pracowników, którzy zostali zatrudnieni w tym samym roku i pracują na tym
#samym stanowisku co Parker.
#8. Wyświetl nazwiska pracowników, których pensja jest niższa niż pensje wszystkich
#pracowników zatrudnionych na stanowisku o nazwie 'Specjalista'.
#9. Dla każdego pracownika wyświetl nazwisko oraz stosunek jego płacy do średniej płacy wśród
#wszystkich pracowników. Obliczone wartości zaokrąglij do drugiego miejsca po przecinku.
#Nadaj drugiej kolumnie alias "Płaca do średniej" oraz posortuj malejąco wyniki wg niej.
#10. Znajdź działy, w których średnia pensja przewyższa średnią pensję wszystkich pracowników.
#Wyświetl nazwę działu oraz średnią pensję jego pracowników.


#30.10.25



-- #1
SELECT emp_id, last_name
FROM employees
WHERE manager_id = (SELECT emp_id 
                    FROM employees
                    WHERE last_name = 'Anderson');

-- #2
SELECT last_name, manager_id, salary
FROM employees
WHERE dep_id IN (SELECT dep_id 
                 FROM employees 
                 WHERE last_name = 'Anderson')
  AND last_name != 'Anderson';

-- #3
SELECT last_name 
FROM employees
WHERE hire_date < (SELECT hire_date
                   FROM employees
                   WHERE last_name = 'Nichols');

-- #4
SELECT last_name, jg_id
FROM employees
WHERE salary + NVL(allowance, 0) > (SELECT AVG(salary + NVL(allowance, 0)) 
                                    FROM employees);

-- #5
SELECT last_name, salary
FROM employees
WHERE dep_id NOT IN (SELECT dep_id 
                     FROM departments 
                     WHERE location IN ('Pokój 201', 'Pokój 205'));

-- #6
SELECT last_name, salary, dep_id, jg_id
FROM employees
WHERE (dep_id, jg_id) IN (SELECT dep_id, jg_id
                          FROM employees
                          WHERE NVL(allowance, 0) > 0);

-- #7
SELECT emp_id, first_name, last_name
FROM employees
WHERE (pos_id, TO_CHAR(hire_date, 'YYYY')) IN (
      SELECT pos_id, TO_CHAR(hire_date, 'YYYY')
      FROM employees
      WHERE last_name = 'Parker'
  )
  AND last_name != 'Parker';

-- #8
SELECT last_name 
FROM employees 
WHERE salary < ALL (SELECT salary 
                    FROM employees 
                    WHERE pos_id = 4);

-- #9
SELECT 
    last_name, 
    ROUND(salary / AVG(salary) OVER (), 2) AS "Płaca do średniej"
FROM 
    employees
ORDER BY 
    "Płaca do średniej" DESC;

-- #10
SELECT 
    d.name, 
    ROUND(AVG(e.salary), 2) AS "Średnia w dziale"
FROM 
    employees e
JOIN 
    departments d ON e.dep_id = d.dep_id
GROUP BY 
    d.name, d.dep_id
HAVING 
    AVG(e.salary) > (SELECT AVG(salary) 
                     FROM employees);