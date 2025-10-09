🗄️ Bazy Danych — Wprowadzenie do SQL
Katedra Technologii Informacyjnych, Uniwersytet Ekonomiczny w Poznaniu

Repozytorium zawiera materiały, przykłady i ćwiczenia z przedmiotu Bazy Danych, prowadzonego na III roku Informatyki i Ekonometrii. Celem zajęć jest zapoznanie studentów z podstawami relacyjnych baz danych oraz języka SQL (Structured Query Language).

🎯 Cele przedmiotu
Zrozumienie zasad działania systemów zarządzania bazami danych (SZBD).

Poznanie modeli danych, w szczególności modelu relacyjnego.

Nabycie umiejętności formułowania zapytań SQL i analizy danych.

Zrozumienie podstawowych operacji: selekcji, projekcji, łączenia danych i sortowania wyników.

Nauka podstawowych elementów języków DDL, DML, DCL oraz zarządzania transakcjami.

🧩 Zakres materiału
Wprowadzenie do baz danych
Pojęcie i rola baz danych.

Modele danych:

Hierarchiczny

Sieciowy

Relacyjny

Obiektowy

Nierelacyjny (NoSQL)

Relacyjny model danych:

Dane przechowywane w tabelach (relacjach).

Struktura: wiersze (rekordy) i kolumny (atrybuty).

Klucze główne i obce, integralność danych.

Język SQL — Podstawy
SQL jako język deklaratywny.

Składnia zapytań i pojęcia składniowe:

Słowa kluczowe (SELECT, FROM, WHERE).

Klauzule i polecenia.

Aliasy, operatory i warunki logiczne.

Typy poleceń SQL:

DQL – zapytania (SELECT).

DML – manipulacja danymi (INSERT, UPDATE, DELETE, MERGE).

DDL – definicja struktury (CREATE, ALTER, DROP).

DCL – kontrola dostępu (GRANT, REVOKE).

TCL – zarządzanie transakcjami (COMMIT, ROLLBACK, SAVEPOINT).

Podstawowe operacje:

Selekcja (SELECT…WHERE) – wybór wierszy.

Projekcja (SELECT kolumny) – wybór kolumn.

Sortowanie (ORDER BY).

Filtrowanie przy użyciu operatorów:

Porównania: =,>,<,BETWEEN,IN,LIKE,IS NULL.

Logicznych: AND,OR,NOT.

Operatory arytmetyczne i konkatenacja tekstu.

🧩 Język SQL — Funkcje i Grupowanie Danych
Funkcje SQL

Cel: Wykonanie operacji na argumentach i zwrócenie pojedynczej wartości.


Typy funkcji:


Jednowierszowe: Przyjmują jedną wartość dla wiersza, zwracają jedną wartość dla każdego wiersza.


Mogą być użyte w klauzulach SELECT, WHERE, ORDER BY.

Mogą być zagnieżdżane.


Grupowe (agregujące): Przyjmują jedną wartość dla grupy wierszy, dając jeden rezultat dla każdej grupy.



Wartość Pusta (NULL):

Pole tabeli nie zawiera żadnej wartości.

To nie 0 ani spacja.

Jeśli wartość kolumny w wyrażeniu arytmetycznym jest NULL, wartość wyrażenia jest NULL.


NVL(expr1,expr2): Konwertuje expr1 z NULL na określoną wartość expr2 (np. 0).

Przykłady Funkcji Jednowierszowych

Znakowe: UPPER (duże litery), LOWER (małe litery), LENGTH (długość), SUBSTR (podciąg).




Numeryczne: ROUND (zaokrąglanie), TRUNC (obcinanie), MOD (reszta z dzielenia).



Daty: SYSDATE (aktualna data), MONTHS_BETWEEN (różnica miesięcy), ADD_MONTHS (dodawanie miesięcy), NEXT_DAY (następny dzień tygodnia), LAST_DAY (ostatni dzień miesiąca).


Daty są przechowywane jako liczby, możliwe są operacje arytmetyczne (np. date+number dodaje dni, date−date daje liczbę dni).


Konwersja Typów:


TO_CHAR: Konwersja liczby lub daty na VARCHAR2 (tekst).


TO_NUMBER: Konwersja łańcucha znaków na wartość liczbową.


TO_DATE: Konwersja łańcucha znaków na wartość daty.

Warunkowe:

Funkcja DECODE.

Wyrażenie CASE.


DUAL: Tabela używana do wyświetlenia wartości stałej lub wyrażenia, które nie jest oparte na tabeli.

Grupowanie Danych
Funkcje Grupowe
Przetwarzają zbiory wierszy, dając jeden rezultat dla każdej grupy (lub dla całej tabeli).

Wszystkie funkcje grupowe z wyjątkiem COUNT(∗) ignorują wartości puste.


Składnia: DISTINCT (nie uwzględnia duplikatów), ALL (uwzględnia duplikaty, domyślnie).

Główne Funkcje:


COUNT(…): Liczba wierszy (np. COUNT(∗) liczy wszystkie, COUNT(kolumna) liczy tylko nie-NULL).


AVG(expr): Wartość średnia.


SUM(expr): Suma wartości.


MAX(expr): Wartość maksymalna.


MIN(expr): Wartość minimalna.


STDDEV(expr): Odchylenie standardowe.


VARIANCE(expr): Wariancja.

Klauzula GROUP BY
Dzieli wiersze tabeli na mniejsze grupy na podstawie wartości w wyspecyfikowanej liście kolumn.


Zasada: Jeżeli SELECT zawiera funkcję grupową, kolumny nieagregowane muszą znaleźć się w klauzuli GROUP BY.


Ograniczenia: W GROUP BY nie można używać aliasów kolumn.

Klauzula HAVING
Wyodrębnia grupy spełniające określony warunek.


Kolejność: Stosowana po klauzuli GROUP BY (w przeciwieństwie do WHERE, która filtruje wiersze przed grupowaniem).



Warunek: Wyrażenie warunkowe, które pozwala wyodrębnić grupy, dla których przyjmuje wartość TRUE.
