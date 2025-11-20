#1. Wyświetl nazwy typów samolotów, dla których ogólna liczba samolotów jest większa niż 2 i dla
#których średni przebieg jest większy niż 550.000 km.


SELECT
    pt.NAME
FROM
    PLANE_TYPES pt
JOIN
    PLANES p ON pt.PT_ID = p.PT_ID
GROUP BY
    pt.NAME
HAVING
    COUNT(p.PL_ID) > 2
    AND AVG(p.MILEAGE) > 550000;
    
    
#2 Wyświetl nazwy linii lotniczych, a dla każdej z nich identyfikator pilota z największą liczbą
#przelatanych kilometrów w ramach danej linii lotniczej. Uwzględnij wszystkie linie lotnicze.
#Ustaw alias dla drugiej kolumny BEST_PILOT_ID.

SELECT
    a.NAME,
    p.PI_ID AS BEST_PILOT_ID
FROM
    AIRLINES a
LEFT JOIN
    PILOTS p ON a.AR_ID = p.AR_ID
WHERE
    p.MILEAGE = (
        SELECT MAX(p2.MILEAGE)
        FROM PILOTS p2
        WHERE p2.AR_ID = a.AR_ID
    )
    OR p.PI_ID IS NULL;
    
    

#3 Wyświetl nazwy linii lotniczych posiadających co najmniej 6 samolotów wyprodukowanych
#przez Boeing i w których piloci mają za sobą przelatane średnio ponad 300 000 km.

SELECT
    a.NAME
FROM
    AIRLINES a
JOIN
    PLANES pl ON a.AR_ID = pl.AR_ID
JOIN
    PLANE_TYPES pt ON pl.PT_ID = pt.PT_ID
WHERE
    pt.MANUFACTURER = 'Boeing'
    AND a.AR_ID IN (
        SELECT p.AR_ID
        FROM PILOTS p
        GROUP BY p.AR_ID
        HAVING AVG(p.MILEAGE) > 300000
    )
GROUP BY
    a.NAME
HAVING
    COUNT(pl.PL_ID) >= 6;
    
    
#4 Wyszukaj pilotów, którzy potrafią pilotować mniej niż 4 typy samolotów (uwzględnij zero). Dla
#każdego z pilotów wyświetl nazwisko i liczbę typów samolotów, które potrafi on pilotować.
#Posortuj wyniki malejąco według liczby typów samolotów i rosnąco według nazwiska pilota.


SELECT
    p.LAST_NAME,
    COUNT(ppt.PT_ID) AS PLANES
FROM
    PILOTS p
LEFT JOIN
    PI_PT ppt ON p.PI_ID = ppt.PI_ID
GROUP BY
    p.LAST_NAME
HAVING
    COUNT(ppt.PT_ID) < 4
ORDER BY
    PLANES DESC,
    p.LAST_NAME ASC;
    

#5. Wyświetl następujące informacje na temat linii lotniczych: nazwę linii, nazwy posiadanych
#przez nią typów samolotów, liczbę posiadanych przez daną linię samolotów każdego typu. W
#wynikach powinny znaleźć się informacje tylko o tych liniach lotniczych, które są z United
#States i które posiadają łącznie mniej niż 8 samolotów (wszystkich). Wyniki posortuj według
#nazwy linii (rosnąco), liczby samolotów poszczególnych typów (malejąco), nazwy typu
#samolotu (rosnąco). Zobacz poniżej przykładowe wyniki zapytania.

SELECT
    a.NAME AS AIRLINE,
    pt.NAME AS PLANE_NAME,
    COUNT(pl.PL_ID) AS PLANE_COUNT
FROM
    AIRLINES a
JOIN
    PLANES pl ON a.AR_ID = pl.AR_ID
JOIN
    PLANE_TYPES pt ON pl.PT_ID = pt.PT_ID
WHERE
    a.COUNTRY = 'United States'
    AND a.AR_ID IN (
        SELECT p2.AR_ID
        FROM PLANES p2
        GROUP BY p2.AR_ID
        HAVING COUNT(p2.PL_ID) < 8
    )
GROUP BY
    a.NAME, pt.NAME
ORDER BY
    a.NAME ASC,
    PLANE_COUNT DESC,
    pt.NAME ASC;
    
    

#6 Ułóż zapytanie wyświetlające informacje na temat pilotów. Każda kolumna powinna mieć alias
#i format danych zgodny z poniższą tabelą. Posortuj wyniki wg kolumny ID. Dla każdego pilota
#powinny zostać wyświetlone następujące informacje:

SELECT
    p.PI_ID AS ID,
    p.FIRST_NAME || ' ' || p.LAST_NAME AS NAME,
    a.NAME AS AIRLINE,
    TO_CHAR(p.HIRE_DATE, 'DD/MM/YYYY') AS HIRE_DATE,
    ROUND(SYSDATE - p.HIRE_DATE) AS EXPERIENCE,
    COUNT(ppt.PT_ID) AS PLANE_TYPES
FROM
    PILOTS p
JOIN
    AIRLINES a ON p.AR_ID = a.AR_ID
LEFT JOIN
    PI_PT ppt ON p.PI_ID = ppt.PI_ID
GROUP BY
    p.PI_ID,
    p.FIRST_NAME,
    p.LAST_NAME,
    a.NAME,
    p.HIRE_DATE
ORDER BY
    ID;
    
    
    