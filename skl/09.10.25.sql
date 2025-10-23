09.10.2025

#1

SELECT emp_id, last_name, salary,
ROUND(salary * 1.123, 1) as "Nowa_pensja",
ROUND(salary * 1.123, 1) - salary  as "Podwyżka",
trunc (salary * 1.123)  
FROM employees;

#2
SELECT UPPER(last_name), LENGTH(first_name)
FROM employees
where substr(last_name,1,1) between 'B' AND 'N'
order by last_name;

#3
SELECT substr(first_name,1,1) || '.' "Pracownik", 
nvl(TO_CHAR(allowance),'brak_dodatku') "Dodatek" 
From employees;

#4
SELECT last_name, hire_date From employees
where months_between(Sysdate, hire_date) >= 25*12;

#5
SELECT last_name, round(months_between(sysdate, hire_date),0) "Okres_Zatrudnienia"
from employees
where substr(last_name,1,1) in ('B','D','F')
order by "Okres_Zatrudnienia";

#6
SELECT last_name, To_char(hire_date, 'Day, DD Mon,YYY', 'nls_date_language = Polish') "Data_Zatrudnienia"
, to_char(Next_day(add_months(hire_date,6),1), 'Day, DD Mon,YYY', 'nls_date_language = Polish') "Data_weryfikacji"
From employees;


#7

Select Next_day('20/01/01', 6) "sobota" from dual;

#8

Select power(2,10) "2^10=" from dual;

#9

SELECT last_name,
decode(jg_id, 2,'II',4,'IV',7,'VII',9,'IX', 'brak') 
from employees;

#10
Select first_name, last_name, salary+NVL(allowance,0) "pensja",
case
when salary+nvl(allowance,0) < 5000 then 'I'
when salary+nvl(allowance,0) > 8000 then 'III' 
else 'II'
end "grupa dofinansowania"

from employees;



#zad dom

#1 
Select last_name, salary, Round(nvl(allowance,0)/salary,2) from employees;

#2
Select substr(first_name,1,1) || '.', substr(last_name,1,1) || '.', substr(hire_date,1,2
) from employees; 

#3
Select next_day(add_months('04/02/24', 40*12),6) from dual;

#4







#funkcje grupowe i grupowanie 

#1
Select Max(salary), Min(salary), sum(salary), avg(salary) from employees;

#2
Select dep_id, max(salary), min(salary), avg(salary) from employees
where dep_id is not null
group by dep_id
order by dep_id;







#ćwiczenia 3

#operatory zbiorowe

#1
SELECT
  nazwisko,
  id_dzialu
FROM
  (
    SELECT
      nazwisko,
      id_dzialu,
      1 AS kolejnosc
    FROM
      pracownicy
    WHERE
      id_dzialu = 10
    UNION
    SELECT
      nazwisko,
      id_dzialu,
      2 AS kolejnosc
    FROM
      pracownicy
    WHERE
      id_dzialu = 50
    UNION
    SELECT
      nazwisko,
      id_dzialu,
      3 AS kolejnosc
    FROM
      pracownicy
    WHERE
      id_dzialu = 20
  )
ORDER BY
  kolejnosc;
