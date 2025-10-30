Gotowe. Oto sformatowany tekst:

# Ćwiczenia praktyczne #1
# 1. Wyświetl zawartość tabeli EMPLOYEES.
# 2. Wyświetl strukturę tabeli EMPLOYEES.
# 3. Wyświetl kolejno wszystkie dane z tabel DEPARTMENTS, POSITIONS i JOB_GRADES. Dla każdej
# tabeli ułóż oddzielne zapytanie.
# 4. Wyświetl identyfikatory wszystkich działów. Powtórz to zapytanie dla tabeli pracowników.
# Porównaj wyniki. Spróbuj wyeliminować z drugiego zapytania powtórzenia i wartości puste
# (NULL).
# 5. Wyświetl imię, nazwisko, pensję dla wszystkich pracowników. Zmodyfikuj to zapytanie, tak aby
# pensja była w ujęciu rocznym. Zdefiniuj alias kolumny zawierającej roczną pensję na "Roczna
# pensja".
# 6. Wyświetl konkatenację (złączenie) imienia i nazwiska, a także identyfikator grupy
# zaszeregowania dla pracowników zatrudnionych w dziale o identyfikatorze 40. Imię i nazwisko
# powinny być rozdzielone znakiem spacji. Kolumna zawierająca konkatenację powinna mieć
# nagłówek "Imię i nazwisko".
# 7. Wyświetl nazwisko, identyfikator szefa i płacę dla pracowników, których płaca mieści się w
# przedziale <3000, 8000>.
# 8. Wyświetl nazwisko, pensję i datę zatrudnienia dla pracowników, których imię zaczyna się
# słowem „Nic”. Rozbuduj zapytanie tak, aby warunek dotyczący imienia uwzględniał również
# nazwiska.
# 9. Wyświetl nazwę i różnicę między maksymalną a minimalną płacą dla wszystkich grup
# zaszeregowania.
# 10. Wyświetl imię, nazwisko i identyfikator szefa dla pracowników, których imię nie zawiera litery
# 'i', a drugą literą nazwiska jest 'a'.
# 11. Wyświetl nazwisko dla pracowników zatrudnionych w dziale 30. Posortuj wyniki alfabetycznie
# wg nazwiska.
# 12. Wyświetl imię i nazwisko dla pracowników, którzy nie są przyporządkowani do żadnego działu.
# 13. Wyświetl nazwiska oraz daty zatrudnienia pracowników zatrudnionych w latach 1997-1998,
# posortowane rosnąco według daty ich zatrudnienia.
# 14. Wyświetl nazwisko i pensję dla pracowników zatrudnionych w działach 20, 40 i 50. Wyniki
# posortuj malejąco według pensji.
# 15. Wyświetl nazwisko, pensję i dodatek dla pracowników, którzy miesięcznie zarabiają mniej niż
# 5000 (włącznie z dodatkiem). Zwróć uwagę na to jak zapytanie traktuje pracowników, którzy
# nie otrzymują dodatku. Wyniki powinny być posortowane malejąco według pensji i dodatku.
# Ustaw aliasy dla kolumn z pensją i dodatkiem odpowiednio na: "Pensja", "Dodatek".
# 16. Wyświetl nazwisko, identyfikator działu i identyfikator grupy zaszeregowania dla
# pracowników, których identyfikator grupy zaszeregowania jest inny niż 4 i 8. Wyniki posortuj
# rosnąco według identyfikatora działu i malejąco według nazwiska. Sformułuj dwie wersje
# zapytania: pierwszą z operatorami porównania oraz drugą z operatorem należenia do zbioru.
# Zadania domowe
# 1. Wyświetl nazwę i lokalizację wszystkich działów, posortowane alfabetycznie wg nazwy działu.
# 2. Wyświetl dane pracownika, który jest szefem firmy (nie ma przypisanego kierownika).
# 3. Wyświetl identyfikatory stanowisk zajmowanych przez pracowników działu 30 (bez
# powtórzeń).
# Bazy danych Katedra Technologii Informacyjnych UEP
# 2
# 4. Znajdź pracowników, którzy zostali zatrudnieni w roku 2001 a ich pensja z dodatkiem wynosi
# co najmniej 7000.


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





#09.10.2025

# 1
SELECT 




