.

🗄️ Bazy Danych — Uniwersytet Ekonomiczny w Poznaniu
🎓 Katedra Technologii Informacyjnych
Repozytorium zawiera materiały, przykłady i ćwiczenia z przedmiotu Bazy Danych, prowadzonego na III roku Informatyki i Ekonometrii. Celem zajęć jest zapoznanie studentów z podstawami relacyjnych baz danych oraz języka SQL (Structured Query Language).

🎯 Cele przedmiotu
Zrozumienie zasad działania systemów zarządzania bazami danych (SZBD).

Poznanie modeli danych, w szczególności modelu relacyjnego.

Nabycie umiejętności formułowania zapytań SQL i analizy danych.

Zrozumienie podstawowych operacji: selekcji, projekcji, łączenia danych i sortowania wyników.





Nauka podstawowych elementów języków DDL, DML, DCL oraz zarządzania transakcjami.


🧩 Zakres materiału
I. Wprowadzenie do baz danych

Modele danych : Hierarchiczny , Sieciowy , Relacyjny , Obiektowy , Nierelacyjny (NoSQL).






Model Relacyjny : Dane przechowywane w tabelach (relacjach). Struktura: wiersze (rekordy) i kolumny (atrybuty).





Połączenie do BD: Parametry połączenia do bazy venusdb.ue.poznan przez serwer kti-lab1.ue.poznan.pl na porcie 1521.





II. Język SQL — Podstawy

SQL (Structured Query Language): Język deklaratywny używany do definiowania, pobierania i manipulowania danymi.



Pojęcia składniowe:

Słowo kluczowe (SELECT, FROM).

Klauzula (np. SELECT last_name).

Polecenie (kombinacja klauzul zakończona średnikiem).


Typy poleceń SQL:


DQL: SELECT (zapytania/pobieranie danych).


DML: INSERT, UPDATE, DELETE, MERGE (manipulacja danymi).


DDL: CREATE, ALTER, DROP, RENAME, TRUNCATE (definicja struktury).


DCL: GRANT, REVOKE (kontrola dostępu).


TCL: COMMIT, ROLLBACK, SAVEPOINT (zarządzanie transakcjami).


Podstawowe operacje SELECT:


Projekcja: Wybór kolumn (np. SELECT column).



Selekcja: Wybór wierszy (WHERE condition(s)).



Sortowanie: ORDER BY {column|expression|alias} [ASC|DESC].



Operatory w WHERE: =, >, <, BETWEEN, IN, LIKE (%, _), IS NULL.






Operatory logiczne: AND, OR, NOT.


Aliasy: Dla kolumn (AS "Nazwisko") i tabel (FROM employees e).


III. Język SQL — Funkcje i Grupowanie Danych

Funkcje:


Jednowierszowe : Przetwarzają każdy wiersz , zwracają jedną wartość dla wiersza. Mogą być użyte w SELECT, WHERE, ORDER BY.





Grupowe (agregujące) : Przetwarzają zbiory wierszy, dając jeden rezultat dla każdej grupy. Ignorują wartości puste, z wyjątkiem COUNT(*).




Wartość Pusta (NULL) : Nie jest to 0 ani spacja. W wyrażeniu arytmetycznym powoduje, że rezultat jest NULL.




Funkcja NVL(expr1, expr2): Konwertuje expr1 z NULL na określoną wartość expr2.


Przykłady Funkcji Jednowierszowych:


Znakowe: UPPER, LOWER, LENGTH, SUBSTR.




Numeryczne: ROUND, TRUNC, MOD.



Daty: SYSDATE , MONTHS_BETWEEN, ADD_MONTHS, NEXT_DAY, LAST_DAY.



Konwersja Typów: TO_CHAR (na tekst) , TO_NUMBER (na liczbę) , TO_DATE (na datę).




Warunkowe: Funkcja DECODE lub wyrażenie CASE.



Tabela DUAL: Używana do wyrażeń niezwiązanych z tabelą (np. SELECT SYSDATE FROM dual).



Funkcje Grupowe: COUNT, AVG, SUM, MAX, MIN, STDDEV, VARIANCE.




Klauzula GROUP BY : Dzieli wiersze na grupy. Kolumny nieagregowane w SELECT muszą być w GROUP BY.




Klauzula HAVING : Wyodrębnia grupy spełniające warunek. Stosowana po GROUP BY.



IV. Łączenie tabel i Operatory zbiorowe

Operacja złączenia (JOIN) : Pobieranie danych z więcej niż jednej tabeli.



Typy złączeń:


Iloczyn kartezjański (CROSS JOIN / FROM table1, table2).




Złączenie równościowe (INNER JOIN ON/WHERE e.id = d.id).




Złączenie nierównościowe (np. BETWEEN - często używane do JOB_GRADES).



Złączenia zewnętrzne: Lewostronne (LEFT OUTER JOIN), Prawostronne (RIGHT OUTER JOIN), Pełne (FULL OUTER JOIN).



Samozłączenie (SELF JOIN): Tabela łączona sama ze sobą.



Operatory zbiorowe : Łączenie rezultatów zapytań składowych.



UNION: Wszystkie wiersze z obu zapytań, bez duplikatów.


UNION ALL: Wszystkie wiersze, włącznie z duplikatami.


INTERSECT: Wiersze wspólne dla obu zapytań.


MINUS: Wiersze z pierwszego zapytania, których nie ma w drugim.


Wytyczne: Klauzule SELECT muszą być zgodne pod względem liczby elementów i ich typów danych. ORDER BY tylko na końcu.


V. Podzapytania (Subqueries)

Podzapytanie: Polecenie SELECT zagnieżdżone w klauzuli innego zapytania. Używane do uzupełnienia głównego zapytania.





Typy podzapytań:



Jednowierszowe/Skalarne : Zwracają dokładnie jedną wartość. Używają operatorów =, >, <.






Wielowierszowe: Zwracają wiele wierszy. Używają operatorów [NOT] IN, ANY, ALL.






Wielokolumnowe: Zwracają więcej niż jedną kolumnę. Używają złożonej klauzuli WHERE.





Podział (korelacja):



Nieskorelowane : Wykonywane jeden raz przed głównym zapytaniem. Wynik jest niezależny od wierszy przetwarzanych w zapytaniu głównym.






Skorelowane : Wykonywane jeden raz dla każdego wiersza kandydującego w zapytaniu głównym. Wynik zależy od wartości w wierszu przetwarzanym przez zapytanie główne.






Operator [NOT] EXISTS:




EXISTS: Prawdziwy, jeśli podzapytanie zwraca co najmniej jeden wiersz.



NOT EXISTS: Prawdziwy, jeśli podzapytanie nie zwraca żadnych wierszy.


Podzapytanie może zwracać stałą wartość (np. 'X') dla lepszej wydajności
