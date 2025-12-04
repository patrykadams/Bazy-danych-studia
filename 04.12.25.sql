DROP TABLE EMP_COPY;
DROP TABLE EMPL;
DROP TABLE DEPT;
DROP TABLE DEPART;

Begin RegenerateTables;
End;
/
#1 Utwórz tabelę WORKERS zgodnie z poniższą specyfikacją kolumn. Kolumnami
#obowiązkowymi są: FIRST_NAME, LAST_NAME i SALARY. Ograniczenie NOT NULL dla
#kolumny SALARY powinno mieć nazwę SALARY_NN. W poleceniu definicji tabeli zdefiniuj
#klucz podstawowy na podstawie kolumny W_ID i klucz unikalny dla pary kolumn
#FIRST_NAME i LAST_NAME.

CREATE TABLE WORKERS (
    W_ID NUMBER(3) PRIMARY KEY,
    FIRST_NAME VARCHAR2(30) NOT NULL,
    LAST_NAME VARCHAR2(30) NOT NULL,
    SALARY NUMBER(7,2) CONSTRAINT SALARY_NN NOT NULL,
    CONSTRAINT WORKERS_NAME_UK UNIQUE (FIRST_NAME, LAST_NAME)
);


#2 

ALTER TABLE WORKERS DROP CONSTRAINT WORKERS_NAME_UK;


SELECT constraint_name, constraint_type, search_condition
FROM user_constraints
WHERE table_name = 'WORKERS';  


-- I. PRZYGOTOWANIE ŚRODOWISKA
-- Usuwanie starych tabel i regeneracja
DROP TABLE EMP_COPY;
DROP TABLE EMPL;
DROP TABLE DEPT;
DROP TABLE DEPART;

BEGIN
  RegenerateTables;
END;
/

-- 1. Utwórz tabelę WORKERS (klucz główny, NOT NULL, UNIQUE)
CREATE TABLE WORKERS (
    W_ID NUMBER(3) PRIMARY KEY,
    FIRST_NAME VARCHAR2(30) NOT NULL,
    LAST_NAME VARCHAR2(30) NOT NULL,
    SALARY NUMBER(7,2) CONSTRAINT SALARY_NN NOT NULL,
    CONSTRAINT WORKERS_NAME_UK UNIQUE (FIRST_NAME, LAST_NAME)
);

-- 2. Usuń klucz unikalny dla pary kolumn FIRST_NAME i LAST_NAME
ALTER TABLE WORKERS DROP CONSTRAINT WORKERS_NAME_UK;

-- 3. Dodaj ograniczenie CHECK (nazwisko > 2 znaki) i przetestuj błąd
ALTER TABLE WORKERS ADD CONSTRAINT W_LAST_NAME_CK CHECK (LENGTH(LAST_NAME) > 2);

-- Próba dodania pracownika naruszającego ograniczenie (To polecenie zwróci błąd ORA-02290)
INSERT INTO WORKERS (W_ID, FIRST_NAME, LAST_NAME, SALARY) VALUES (10, 'Huang', 'Li', 4000);

-- 4. Usuń ograniczenie NOT NULL z kolumny SALARY
ALTER TABLE WORKERS DROP CONSTRAINT SALARY_NN;

-- 5. Dodaj kolumnę BOSS_ID i klucz obcy do tej samej tabeli
ALTER TABLE WORKERS ADD BOSS_ID NUMBER(3) CONSTRAINT BOSS_ID_FK REFERENCES WORKERS(W_ID);

-- 6. Dodaj informacje o dwóch pracownikach
INSERT INTO WORKERS (W_ID, FIRST_NAME, LAST_NAME, SALARY, BOSS_ID) VALUES (10, 'Jan', 'Kowalski', 4500, NULL);
INSERT INTO WORKERS (W_ID, FIRST_NAME, LAST_NAME, SALARY, BOSS_ID) VALUES (20, 'Jacek', 'Malinowski', 3000, 10);

-- 7. Spróbuj usunąć Jana Kowalskiego (To polecenie zwróci błąd ORA-02292 - rekord podrzędny istnieje)
DELETE FROM WORKERS WHERE W_ID = 10;

-- 8. Wyłącz klucz obcy i usuń wiersz (Powodzenie)
ALTER TABLE WORKERS DISABLE CONSTRAINT BOSS_ID_FK;
DELETE FROM WORKERS WHERE W_ID = 10;

-- 9. Spróbuj włączyć klucz obcy (To polecenie zwróci błąd ORA-02298 - brak rodzica dla sieroty)
ALTER TABLE WORKERS ENABLE CONSTRAINT BOSS_ID_FK;

-- 10. Dodaj brakującego szefa (nowe dane dla ID 10) i włącz klucz
INSERT INTO WORKERS (W_ID, FIRST_NAME, LAST_NAME, SALARY, BOSS_ID) VALUES (10, 'Zbigniew', 'Malicki', 5000, NULL);
ALTER TABLE WORKERS ENABLE CONSTRAINT BOSS_ID_FK;

-- 11. Spróbuj usunąć Zbigniewa Malickiego (To polecenie zwróci błąd ORA-02292 - klucz znów działa)
DELETE FROM WORKERS WHERE W_ID = 10;

-- 12. Usuń klucz obcy BOSS_ID_FK
ALTER TABLE WORKERS DROP CONSTRAINT BOSS_ID_FK;

-- 13. Nałóż klucz obcy z opcją ON DELETE CASCADE
ALTER TABLE WORKERS ADD CONSTRAINT BOSS_ID_FK_C FOREIGN KEY (BOSS_ID) REFERENCES WORKERS(W_ID) ON DELETE CASCADE;

-- 14. Wyświetl tabelę, usuń szefa (kaskadowo) i sprawdź wynik
SELECT * FROM WORKERS;
DELETE FROM WORKERS WHERE W_ID = 10;
SELECT * FROM WORKERS; -- Tabela powinna być pusta

-- 15. Usuń tabelę WORKERS
DROP TABLE WORKERS;


--------------------------------------------------------------------------------
-- II. PERSPEKTYWY (WIDOKI)
--------------------------------------------------------------------------------

-- 1. Utwórz perspektywę V_EMPLOYEES (alias w podzapytaniu)
CREATE OR REPLACE VIEW V_EMPLOYEES AS
SELECT EMPLOYEE_ID, LAST_NAME AS EMP_NAME, DEPARTMENT_ID
FROM EMPLOYEES;

-- 2. Wyświetl strukturę i dane
DESCRIBE V_EMPLOYEES;
SELECT * FROM V_EMPLOYEES;

-- 3. Wyświetl nazwiska pracowników z działu 30
SELECT EMP_NAME FROM V_EMPLOYEES WHERE DEPARTMENT_ID = 30;

-- 4. Przenieś pracownika 'Davis' do działu 20 i zatwierdź
UPDATE V_EMPLOYEES SET DEPARTMENT_ID = 20 WHERE EMP_NAME = 'Davis';
COMMIT;

-- 5. Utwórz perspektywę V_EMP_DEP_40 na podstawie V_EMPLOYEES
-- (tylko dział 40, aliasy w nagłówku, blokada przenoszenia)
CREATE OR REPLACE VIEW V_EMP_DEP_40 (EMP_NO, EMPLOYEE, DEP_NO) AS
SELECT EMPLOYEE_ID, EMP_NAME, DEPARTMENT_ID
FROM V_EMPLOYEES
WHERE DEPARTMENT_ID = 40
WITH CHECK OPTION CONSTRAINT V_EMP_DEP_40_CK;

-- 6. Wyświetl strukturę i dane
DESCRIBE V_EMP_DEP_40;
SELECT * FROM V_EMP_DEP_40;

-- 7. Spróbuj przenieść pracownika 'Nichols' do działu 20
-- To polecenie zwróci błąd ORA-01402 (naruszenie klauzuli WHERE ... WITH CHECK OPTION)
-- UPDATE V_EMP_DEP_40 SET DEP_NO = 20 WHERE EMPLOYEE = 'Nichols';

-- 8. Zmień nazwisko pracownika 'Nichols' na 'Nicholson' i zatwierdź
UPDATE V_EMP_DEP_40 SET EMPLOYEE = 'Nicholson' WHERE EMPLOYEE = 'Nichols';
COMMIT;

-- 9. Usuń perspektywy
DROP VIEW V_EMP_DEP_40;
DROP VIEW V_EMPLOYEES;

-- 10. Sprawdź zmianę nazwiska w tabeli bazowej
SELECT * FROM EMPLOYEES WHERE LAST_NAME = 'Nicholson';


--------------------------------------------------------------------------------
-- III. SEKWENCERY I SYNONIMY
--------------------------------------------------------------------------------

-- 1. Utwórz sekwencer DT_ID_SEQ
CREATE SEQUENCE DT_ID_SEQ
START WITH 200
INCREMENT BY 10
MAXVALUE 1000
NOCACHE;

-- 2. Utwórz synonim DZIALY dla tabeli DEPARTMENTS
CREATE SYNONYM DZIALY FOR DEPARTMENTS;

-- 3. Wyświetl zawartość przez synonim
SELECT * FROM DZIALY;

-- 4. Dodaj dwa nowe działy używając synonimu i sekwencera
INSERT INTO DZIALY (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
VALUES (DT_ID_SEQ.NEXTVAL, 'Logistics', NULL, 1700);

INSERT INTO DZIALY (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
VALUES (DT_ID_SEQ.NEXTVAL, 'Innovation', NULL, 1700);

-- 5. Wyświetl bezpośrednio tabelę DEPARTMENTS
SELECT * FROM DEPARTMENTS;

-- 6. Wycofaj zmiany i sprawdź wartość bieżącą sekwencera
ROLLBACK;
-- Uwaga: W sesji, która nie pobrała jeszcze NEXTVAL, CURRVAL może rzucić błąd.
-- Zakładamy, że sesja jest ciągła po wykonaniu pktu 4.
SELECT DT_ID_SEQ.CURRVAL FROM DUAL;

-- 7. Dodaj nowy dział bezpośrednio do tabeli (zauważ "dziurę" w numeracji po rollback)
INSERT INTO DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
VALUES (DT_ID_SEQ.NEXTVAL, 'Security', NULL, 1700);

-- 8. Zatwierdź zmiany
COMMIT;

-- 9. Usuń synonim
DROP SYNONYM DZIALY;

-- 10. Usuń sekwencer
DROP SEQUENCE DT_ID_SEQ;