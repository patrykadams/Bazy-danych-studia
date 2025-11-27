ALTER TABLE DEPARTMENTS DROP PRIMARY KEY CASCADE
;
DROP TABLE DEPARTMENTS CASCADE CONSTRAINTS
;

CREATE TABLE DEPARTMENTS
(
  DEP_ID        INTEGER,
  NAME      VARCHAR2(30 BYTE)               NOT NULL,
  LOCATION  VARCHAR2(30 BYTE),
  CONSTRAINT PK_DEP_ID PRIMARY KEY (DEP_ID),
  CONSTRAINT UK_DEP_NAME UNIQUE (NAME)
)
;

ALTER TABLE POSITIONS DROP PRIMARY KEY CASCADE
;
DROP TABLE POSITIONS CASCADE CONSTRAINTS
;

CREATE TABLE POSITIONS
(
  POS_ID        INTEGER,
  NAME      VARCHAR2(30 BYTE)               NOT NULL,
  CONSTRAINT PK_POS_ID PRIMARY KEY (POS_ID),
  CONSTRAINT UK_POS_NAME UNIQUE (NAME)
)
;

ALTER TABLE JOB_GRADES DROP PRIMARY KEY CASCADE
;
DROP TABLE JOB_GRADES CASCADE CONSTRAINTS
;

CREATE TABLE JOB_GRADES
(
  JG_ID        INTEGER,
  NAME         VARCHAR2(5 BYTE),
  MIN_SALARY  NUMBER(7,2)                   NOT NULL,
  MAX_SALARY  NUMBER(7,2)                   NOT NULL,
  CONSTRAINT CHK_MIN_MAX CHECK (MIN_SALARY < MAX_SALARY),
  CONSTRAINT PK_JG_ID PRIMARY KEY (JG_ID),
  CONSTRAINT UK_JG_NAME UNIQUE (NAME)
)
;

ALTER TABLE EMPLOYEES DROP PRIMARY KEY CASCADE
;
DROP TABLE EMPLOYEES CASCADE CONSTRAINTS
;

CREATE TABLE EMPLOYEES
(
  EMP_ID      INTEGER,
  FIRST_NAME  VARCHAR2(20 BYTE)             NOT NULL,
  LAST_NAME   VARCHAR2(30 BYTE)             NOT NULL,
  HIRE_DATE   DATE  DEFAULT sysdate         NOT NULL,
  SALARY      NUMBER(7,2)                   NOT NULL,
  ALLOWANCE   NUMBER(7,2),
  POS_ID      INTEGER NOT NULL,
  JG_ID       INTEGER NOT NULL,
  MANAGER_ID  INTEGER,
  DEP_ID      INTEGER,
  CONSTRAINT PK_EMP_ID PRIMARY KEY (EMP_ID),
  CONSTRAINT FK_EMP_POS_ID FOREIGN KEY (POS_ID) REFERENCES POSITIONS (POS_ID),
  CONSTRAINT FK_EMP_JG_ID FOREIGN KEY (JG_ID) REFERENCES JOB_GRADES (JG_ID),
  CONSTRAINT FK_EMP_MANAGER_ID FOREIGN KEY (MANAGER_ID) REFERENCES EMPLOYEES (EMP_ID),
  CONSTRAINT FK_EMP_DEP_ID FOREIGN KEY (DEP_ID) REFERENCES DEPARTMENTS (DEP_ID)
)
;

CREATE INDEX FK_EMP_POS_ID ON EMPLOYEES (POS_ID);
CREATE INDEX FK_EMP_JG_ID ON EMPLOYEES (JG_ID);
CREATE INDEX FK_EMP_MANAGER_ID ON EMPLOYEES (MANAGER_ID);
CREATE INDEX FK_EMP_DEP_ID ON EMPLOYEES (DEP_ID);


DELETE FROM EMPLOYEES;
DELETE FROM POSITIONS;
DELETE FROM JOB_GRADES;
DELETE FROM DEPARTMENTS;

INSERT INTO DEPARTMENTS ( DEP_ID, NAME, LOCATION ) VALUES ( 
10, 'Zarząd', 'Pokój 306'); 
INSERT INTO DEPARTMENTS ( DEP_ID, NAME, LOCATION ) VALUES ( 
20, 'Marketing', 'Pokój 201'); 
INSERT INTO DEPARTMENTS ( DEP_ID, NAME, LOCATION ) VALUES ( 
30, 'Sprzedaż', 'Pokój 205'); 
INSERT INTO DEPARTMENTS ( DEP_ID, NAME, LOCATION ) VALUES ( 
40, 'Księgowość', 'Pokój 113'); 
INSERT INTO DEPARTMENTS ( DEP_ID, NAME, LOCATION ) VALUES ( 
50, 'Administracja', 'Pokój 100'); 
INSERT INTO DEPARTMENTS ( DEP_ID, NAME, LOCATION ) VALUES ( 
60, 'IT', 'Pokój 120'); 

INSERT INTO POSITIONS ( POS_ID, NAME ) VALUES ( 1, 'Prezes');
INSERT INTO POSITIONS ( POS_ID, NAME ) VALUES ( 2, 'Kierownik');
INSERT INTO POSITIONS ( POS_ID, NAME ) VALUES ( 3, 'Starszy specjalista');
INSERT INTO POSITIONS ( POS_ID, NAME ) VALUES ( 4, 'Specjalista');
INSERT INTO POSITIONS ( POS_ID, NAME ) VALUES ( 5, 'Stażysta');

INSERT INTO JOB_GRADES ( JG_ID, NAME, MIN_SALARY, MAX_SALARY ) VALUES ( 
1, 'I', 18000, 22000); 
INSERT INTO JOB_GRADES ( JG_ID, NAME, MIN_SALARY, MAX_SALARY ) VALUES ( 
2, 'II', 14500, 17999); 
INSERT INTO JOB_GRADES ( JG_ID, NAME, MIN_SALARY, MAX_SALARY ) VALUES ( 
3, 'III', 11500, 14499); 
INSERT INTO JOB_GRADES ( JG_ID, NAME, MIN_SALARY, MAX_SALARY ) VALUES ( 
4, 'IV', 9000, 11499); 
INSERT INTO JOB_GRADES ( JG_ID, NAME, MIN_SALARY, MAX_SALARY ) VALUES ( 
5, 'V', 7000, 8999); 
INSERT INTO JOB_GRADES ( JG_ID, NAME, MIN_SALARY, MAX_SALARY ) VALUES ( 
6, 'VI', 5000, 6999); 
INSERT INTO JOB_GRADES ( JG_ID, NAME, MIN_SALARY, MAX_SALARY ) VALUES ( 
7, 'VII', 3500, 4999); 
INSERT INTO JOB_GRADES ( JG_ID, NAME, MIN_SALARY, MAX_SALARY ) VALUES ( 
8, 'VIII', 2000, 3499); 
INSERT INTO JOB_GRADES ( JG_ID, NAME, MIN_SALARY, MAX_SALARY ) VALUES ( 
9, 'IX', 1000, 1999); 

INSERT INTO EMPLOYEES ( EMP_ID, FIRST_NAME, LAST_NAME, POS_ID, JG_ID, MANAGER_ID,
HIRE_DATE, SALARY, DEP_ID, ALLOWANCE ) VALUES ( 
100, 'John', 'Smith', 1, 2, NULL, TO_DATE( '01/01/1999 12:00:00', 'MM/DD/YYYY HH:MI:SS')
, 15500, 10, 1700); 
INSERT INTO EMPLOYEES ( EMP_ID, FIRST_NAME, LAST_NAME, POS_ID, JG_ID, MANAGER_ID,
HIRE_DATE, SALARY, DEP_ID, ALLOWANCE ) VALUES ( 
101, 'Jessica', 'Torn', 2, 5, 100, TO_DATE( '05/15/1997 12:00:00', 'MM/DD/YYYY HH:MI:SS')
, 8800, 10, NULL); 
INSERT INTO EMPLOYEES ( EMP_ID, FIRST_NAME, LAST_NAME, POS_ID, JG_ID, MANAGER_ID,
HIRE_DATE, SALARY, DEP_ID, ALLOWANCE ) VALUES ( 
102, 'Nick', 'Ford', 2, 4, 100, TO_DATE( '09/01/2003 12:00:00', 'MM/DD/YYYY HH:MI:SS')
, 9800, 10, NULL); 
INSERT INTO EMPLOYEES ( EMP_ID, FIRST_NAME, LAST_NAME, POS_ID, JG_ID, MANAGER_ID,
HIRE_DATE, SALARY, DEP_ID, ALLOWANCE ) VALUES ( 
103, 'Diana', 'Wilson', 2, 5, 100, TO_DATE( '06/01/2001 12:00:00', 'MM/DD/YYYY HH:MI:SS')
, 7900, 10, 600); 
INSERT INTO EMPLOYEES ( EMP_ID, FIRST_NAME, LAST_NAME, POS_ID, JG_ID, MANAGER_ID,
HIRE_DATE, SALARY, DEP_ID, ALLOWANCE ) VALUES ( 
104, 'Jennifer', 'Kent', 3, 6, 101, TO_DATE( '04/15/2003 12:00:00', 'MM/DD/YYYY HH:MI:SS')
, 5800, 20, NULL); 
INSERT INTO EMPLOYEES ( EMP_ID, FIRST_NAME, LAST_NAME, POS_ID, JG_ID, MANAGER_ID,
HIRE_DATE, SALARY, DEP_ID, ALLOWANCE ) VALUES ( 
105, 'David', 'Brown', 4, 8, 104, TO_DATE( '10/01/2002 12:00:00', 'MM/DD/YYYY HH:MI:SS')
, 3100, 20, 400); 
INSERT INTO EMPLOYEES ( EMP_ID, FIRST_NAME, LAST_NAME, POS_ID, JG_ID, MANAGER_ID,
HIRE_DATE, SALARY, DEP_ID, ALLOWANCE ) VALUES ( 
106, 'Nicole', 'Foster', 5, 9, 104, TO_DATE( '09/01/2000 12:00:00', 'MM/DD/YYYY HH:MI:SS')
, 1800, NULL, NULL); 
INSERT INTO EMPLOYEES ( EMP_ID, FIRST_NAME, LAST_NAME, POS_ID, JG_ID, MANAGER_ID,
HIRE_DATE, SALARY, DEP_ID, ALLOWANCE ) VALUES ( 
107, 'Steven', 'Anderson', 3, 6, 101, TO_DATE( '02/15/1998 12:00:00', 'MM/DD/YYYY HH:MI:SS')
, 5900, 30, NULL); 
INSERT INTO EMPLOYEES ( EMP_ID, FIRST_NAME, LAST_NAME, POS_ID, JG_ID, MANAGER_ID,
HIRE_DATE, SALARY, DEP_ID, ALLOWANCE ) VALUES ( 
108, 'Lisa', 'Davis', 4, 7, 107, TO_DATE( '05/15/1997 12:00:00', 'MM/DD/YYYY HH:MI:SS')
, 4200, 30, NULL); 
INSERT INTO EMPLOYEES ( EMP_ID, FIRST_NAME, LAST_NAME, POS_ID, JG_ID, MANAGER_ID,
HIRE_DATE, SALARY, DEP_ID, ALLOWANCE ) VALUES ( 
109, 'Anne', 'Taylor', 4, 8, 107, TO_DATE( '07/01/2001 12:00:00', 'MM/DD/YYYY HH:MI:SS')
, 3100, 30, 500); 
INSERT INTO EMPLOYEES ( EMP_ID, FIRST_NAME, LAST_NAME, POS_ID, JG_ID, MANAGER_ID,
HIRE_DATE, SALARY, DEP_ID, ALLOWANCE ) VALUES ( 
110, 'Patricia', 'Blake', 5, 9, 107, TO_DATE( '11/15/1998 12:00:00', 'MM/DD/YYYY HH:MI:SS')
, 1400, 30, NULL); 
INSERT INTO EMPLOYEES ( EMP_ID, FIRST_NAME, LAST_NAME, POS_ID, JG_ID, MANAGER_ID,
HIRE_DATE, SALARY, DEP_ID, ALLOWANCE ) VALUES ( 
111, 'John', 'Parker', 3, 5, 102, TO_DATE( '04/01/2001 12:00:00', 'MM/DD/YYYY HH:MI:SS')
, 8000, 40, NULL); 
INSERT INTO EMPLOYEES ( EMP_ID, FIRST_NAME, LAST_NAME, POS_ID, JG_ID, MANAGER_ID,
HIRE_DATE, SALARY, DEP_ID, ALLOWANCE ) VALUES ( 
112, 'Nicole', 'Spencer', 4, 7, 111, TO_DATE( '01/01/1997 12:00:00', 'MM/DD/YYYY HH:MI:SS')
, 3700, 40, NULL); 
INSERT INTO EMPLOYEES ( EMP_ID, FIRST_NAME, LAST_NAME, POS_ID, JG_ID, MANAGER_ID,
HIRE_DATE, SALARY, DEP_ID, ALLOWANCE ) VALUES ( 
113, 'Tom', 'Nichols', 4, 8, 111, TO_DATE( '01/15/2000 12:00:00', 'MM/DD/YYYY HH:MI:SS')
, 3200, 40, 300); 
INSERT INTO EMPLOYEES ( EMP_ID, FIRST_NAME, LAST_NAME, POS_ID, JG_ID, MANAGER_ID,
HIRE_DATE, SALARY, DEP_ID, ALLOWANCE ) VALUES ( 
114, 'Robert', 'Brown', 3, 6, 102, TO_DATE( '02/15/2001 12:00:00', 'MM/DD/YYYY HH:MI:SS')
, 6400, 50, 600); 
INSERT INTO EMPLOYEES ( EMP_ID, FIRST_NAME, LAST_NAME, POS_ID, JG_ID, MANAGER_ID,
HIRE_DATE, SALARY, DEP_ID, ALLOWANCE ) VALUES ( 
115, 'Barbara', 'Jackson', 5, 9, 114, TO_DATE( '05/01/1999 12:00:00', 'MM/DD/YYYY HH:MI:SS')
, 1200, NULL, NULL); 
INSERT INTO EMPLOYEES ( EMP_ID, FIRST_NAME, LAST_NAME, POS_ID, JG_ID, MANAGER_ID,
HIRE_DATE, SALARY, DEP_ID, ALLOWANCE ) VALUES ( 
116, 'Tony', 'Watson', 4, 7, 114, TO_DATE( '05/01/1999 12:00:00', 'MM/DD/YYYY HH:MI:SS')
, 4300, 50, NULL); 

COMMIT;



#2. Dodaj w tabeli DEPARTMENTS dział 'Zamówienia' z identyfikatorem 100 zlokalizowany w
#pokoju 225. Wyświetl zawartość tabeli w celu potwierdzenia dodania nowego działu.
SELECT *  FROM DEPARTMENTS;

INSERT INTO departments (dep_id, name, location)
VALUES (100,'Zamówienia',225);

#3 Utwórz tabelę EMP_COPY wykorzystując polecenie umieszczone w kursie. Wyświetl
#strukturę tabeli EMP_COPY w celu identyfikacji nazw kolumn
CREATE TABLE EMP_COPY
(
  EMP_ID      INTEGER,
  FIRST_NAME  VARCHAR2(20 BYTE)             NOT NULL,
  LAST_NAME   VARCHAR2(30 BYTE)             NOT NULL,
  HIRE_DATE   DATE  DEFAULT sysdate         NOT NULL,
  SALARY      NUMBER(7,2)                   NOT NULL,
  ALLOWANCE   NUMBER(7,2),
  MANAGER_ID  INTEGER,
  DEP_ID      INTEGER,
  CONSTRAINT PK_EMP_COPY_ID PRIMARY KEY (EMP_ID),
  CONSTRAINT FK_EMP_COPY_MANAGER_ID FOREIGN KEY (MANAGER_ID) REFERENCES EMP_COPY (EMP_ID),
  CONSTRAINT FK_EMP_COPY_DEP_ID FOREIGN KEY (DEP_ID) REFERENCES DEPARTMENTS (DEP_ID)
);

SELECT * from emp_copy;

#4 Wyobraź sobie, że zostałeś mianowany menedżerem nowo utworzonego działu
#'Zamówienia'. Dodaj odpowiedni wiersz w tabeli EMP_COPY zawierający Twoje dane
#(emp_id=1). Zdecyduj o wysokości swojej pensji. Jako datę zatrudnienia wprowadź dzisiejszą
#datę zaokrągloną do północy (bez części reprezentującej czas). W poleceniu INSERT podaj
#listę nazw kolumn. 


INSERT INTO EMP_COPY (
    EMP_ID, 
    FIRST_NAME, 
    LAST_NAME, 
    HIRE_DATE, 
    SALARY, 
    MANAGER_ID, 
    DEP_ID, 
    ALLOWANCE
)
VALUES (
    1, 
    'Patryk', 
    'Adamski', 
    ROUND(SYSDATE), 
    12000.00, 
    NULL, 
    NULL, 
    NULL
);

#5. Wyobraź sobie, że w swoim dziale zatrudniasz dwóch nowych pracowników (np. inne osoby
#z grupy). Dodaj dane o tych osobach do tabeli EMP_COPY z identyfikatorami 2 i 3. Ustaw dla
#nich wartość MANAGER_ID na Twój identyfikator. Zdecyduj o wysokości ich pensji. Daty
#zatrudnienia ustaw podobnie jak w zad. 4. W poleceniu INSERT nie podawaj listy nazw
#kolumn.

INSERT INTO EMP_COPY 
VALUES (
    3, 
    'Andrzej', 
    'Adamoski', 
    ROUND(SYSDATE), 
    1230.00, 
    1, 
    NULL, 
    NULL
);
#6
COMMIT;

#7  Skopiuj do tabeli EMP_COPY dane z tabeli EMPLOYEES o pracownikach, którzy pracują w
#działach o identyfikatorach: 10, 20 i 30. Zwróć uwagę na to, że w tabeli EMPLOYEES jest
#więcej kolumn niż w EMP_COPY.
INSERT INTO EMP_COPY (
    EMP_ID, 
    FIRST_NAME, 
    LAST_NAME, 
    HIRE_DATE, 
    SALARY, 
    ALLOWANCE, 
    MANAGER_ID, 
    DEP_ID
)
SELECT 
    EMP_ID, 
    FIRST_NAME, 
    LAST_NAME, 
    HIRE_DATE, 
    SALARY,
    NULL,
    MANAGER_ID, 
    DEP_ID
FROM 
    EMPLOYEES
WHERE 
    DEP_ID IN (10, 20, 30);
#8
COMMIT;

#9. Ustaw identyfikator swojego menedżera na wartość 100.

UPDATE EMP_COPY
SET 
    MANAGER_ID = 100
WHERE 
    EMP_ID = 1;


#10. W tabeli EMP_COPY zmień nazwisko pracownika o id=108 na Johnson.
UPDATE EMP_COPY
SET 
    LAST_NAME = 'JOHNSON'
WHERE EMP_ID = 108;

#11. W tabeli EMP_COPY odbierz dodatek wszystkim pracownikom pracującym w dziale o
#identyfikatorze 20 lub 30.

UPDATE EMP_COPY
SET 
    ALLOWANCE = 0
WHERE DEP_ID IN (20,30);

#12 W tabeli EMP_COPY ustaw pensję na wartość 6000 dla wszystkich pracowników, których
#pensja mieści się w zakresie od 5000 do 6000.

UPDATE EMP_COPY
SET
    SALARY = 6000
WHERE SALARY BETWEEN 5000 AND 6000;

# 13. Usuń pracownika Patricia Blake z tabeli EMP_COPY.
DELETE FROM EMP_COPY
WHERE FIRST_NAME = 'Patricia' AND LAST_NAME = 'Blake'; 

#14  W tabeli EMP_COPY przenieś Anne Taylor do swojego działu. W tym samym poleceniu ustaw
#wartość MANAGER_ID na swój identyfikator. Wskazówka: wykorzystaj podzapytania.

UPDATE EMP_COPY
SET 
    DEP_ID = (
        SELECT DEP_ID 
        FROM EMP_COPY 
        WHERE EMP_ID = 1 
    ),
    MANAGER_ID = 1
WHERE 
    FIRST_NAME = 'Anne' AND LAST_NAME = 'Taylor';
    
#15
COMMIT;

#16 Z tabeli EMP_COPY usuń wszystkich pracowników zatrudnionych w dziale o id=20. Wyświetl
#zawartość tabeli.
DELETE FROM EMP_COPY
WHERE DEP_ID = 20;


#17 Ustal punkt kontrolny A w aktualnej transakcji.
SAVEPOINT A;

#18 . Z tabeli EMP_COPY usuń wszystkich pracowników zatrudnionych w dziale o id=30. Wyświetl
#zawartość tabeli.
DELETE FROM EMP_COPY
WHERE DEP_ID = 20;
SELECT * FROM EMP_COPY;


#19
SAVEPOINT B;

#20Usuń wszystkie wiersze z tabeli EMP_COPY za pomocą odpowiedniego polecenia DML.
#Skorzystaj z wiedzy nabytej na wykładzie i przypomnij sobie jaka jest różnica pomiędzy
#poleceniami DELETE i TRUNCATE i które z nich jest poleceniem typu DML. Wyświetl
#zawartość tabel

DELETE FROM EMP_COPY;


#21
ROLLBACK TO A;

#22  Wycofaj operację usunięcia pracowników pracujących w dziale 30. Zweryfikuj zawartość
#tabeli EMP_COPY.

ROLLBACK;

#23 Wycofaj operację usunięcia pracowników pracujących w dziale 20. Zweryfikuj zawartość
tabeli EMP_COPY.

SELECT * FROM EMP_COPY
WHERE DEP_ID IN (20, 30, NULL) 
ORDER BY DEP_ID;