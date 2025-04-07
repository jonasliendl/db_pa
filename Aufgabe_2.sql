clear screen;
set serveroutput on;
-- Erstellen der Tabellen
-- CREATE TABLE PA_CONFIG (PLENGTH integer, PSHIFT integer);
-- INSERT INTO PA_CONFIG (PLENGTH, PSHIFT) values (5, 3);
-- CREATE TABLE PA_REFERENCE (ZAHL integer, FAKTOR integer);
-- CREATE TABLE PA_RESULT (ID integer, DESCRIPTION varchar2(255));
-- CREATE TABLE PA_PASSWD (PASSWD varchar2(255), ID integer);

-- Eigentlicher Inhalt
CREATE OR REPLACE PACKAGE GRWO_Passwoerter AS
    p_length INTEGER;
    p_shift INTEGER;
    TYPE passwort_ziffern_arr IS VARRAY OF INTEGER;
    PROCEDURE Init;
    PROCEDURE Generate(anzahl_datensaetze IN INTEGER);
    PROCEDURE CalControlCipher(pass_ziffern IN passwort_ziffern_arr, rest OUT INTEGER);
    PROCEDURE Action(passwort IN VARCHAR, fehlercode OUT INTEGER);
END GRWO_Passwoerter;
/

CREATE OR REPLACE PACKAGE BODY GRWO_Passwoerter AS
    PROCEDURE Init IS
        p_length INTEGER;
        p_shift INTEGER;
    BEGIN
        -- PLENGTH und PSHIFT extrahieren
        SELECT PLENGTH, PSHIFT INTO p_length, p_shift FROM PA_CONFIG WHERE ROWNUM = 1;
        
        -- Tabelle PA_REFERENCE leeren
        DELETE FROM PA_REFERENCE;
        
        -- Faktoren berechnen und Referenztabelle mit Zahlen und Faktoren bestücken
        INSERT INTO PA_REFERENCE (ZAHL, FAKTOR) VALUES
        (0, MOD(0 + p_shift, 10)),
        (1, MOD(1 + p_shift, 10)),
        (2, MOD(2 + p_shift, 10)),
        (3, MOD(3 + p_shift, 10)),
        (4, MOD(4 + p_shift, 10)),
        (5, MOD(5 + p_shift, 10)),
        (6, MOD(6 + p_shift, 10)),
        (7, MOD(7 + p_shift, 10)),
        (8, MOD(8 + p_shift, 10)),
        (9, MOD(9 + p_shift, 10));
    END Init;
    
    PROCEDURE Generate(anzahl_datensaetze IN INTEGER) IS
        v_password VARCHAR2;
        v_digit INTEGER;
    BEGIN
        -- Einfügen von Datensätze in PA_PASSWD
        -- Feld PASSWD hat Passwort
        -- Feld ID hat anfangs Code 9
        -- Passwort ist Zeichenkette mit vordefinierter Länge!
        -- Passwort besteht aus zufälligen Ziffern.
        FOR i IN 1 .. p_count LOOP
            v_password := '';
            
            -- Zufälliges Passwort generieren (nur Ziffern)
            FOR j IN 1 .. v_password_length LOOP
                v_digit := TRUNC(DBMS_RANDOM.VALUE(0, 10)); -- Zufallszahl zwischen 0 und 9
                v_password := v_password || TO_CHAR(v_digit);
            END LOOP;
            
            -- Datensatz in die Tabelle einfügen
            INSERT INTO PA_PASSWD (ID, PASSWD)
            VALUES (9, v_password);
        END LOOP;
    END Generate;
    
    PROCEDURE CalControlCipher(pass_ziffern IN passwort_ziffern_arr, rest OUT INTEGER) IS
        v_summe INTEGER := 0;
        v_faktor INTEGER;
    BEGIN
        -- Bekommt Array mit Ziffern aus dem Passwort (ohne Prüfzahl)
        -- Faktor aus PA_REFERENCE auf Ziffern anwenden
        -- Werte summieren
        -- Summe durch 10 dividieren
        -- Rest der Division ist die Prüfsumme -> Rückgabe
        FOR i IN 1 .. pass_ziffern.COUNT LOOP
            -- Faktor aus PA_REFERENCE holen
            SELECT FAKTOR 
            INTO v_faktor 
            FROM PA_REFERENCE 
            WHERE ZAHL = pass_ziffern(i);
            
            -- Ziffern mit Faktor multiplizieren
            v_summe = v_summe + (pass_ziffern(i) * v_faktor);
        END LOOP;

        return MOD(v_summe, 10);
    END CalControlCipher;
    
    PROCEDURE Action(passwort IN VARCHAR, fehlercode OUT INTEGER) IS
        v_rest INTEGER;
        v_digits_full passwort_ziffern_arr;
        v_digits passwort_ziffern_arr;
        v_num INTEGER;
        v_rest INTEGER;
    BEGIN
        -- Erthält eine Zeichenkette (Passwort)
        -- Check -> Stimmt Länge von Passwort? Nein (2)
        -- Check -> Enthält Zeichenkette nur Ziffern? Nein (1)
        -- Umwandeln von Zeichenkette in Integer-Array (ohne Prüfzahl)
        -- CalControlCipher aufrufen
        -- Check -> Rückgabewert der Funktion ist erstes Element der Zeichenkette? Ja (0) Nein (3)
        IF LENGTH(passwort) != p_length THEN
            fehlercode := 2;
        END IF;

        IF fehlercode = 0 THEN
            FOR i IN 1 .. LENGTH(passwort) LOOP
                IF SUBSTR(passwort, i, 1) NOT BETWEEN '0' AND '9' THEN
                    fehlercode := 1;
                END IF;
            END LOOP;
        END IF;

        IF fehlercode = 0 THEN
            v_digits_full := passwort_ziffern_arr(LENGTH(passwort));
            v_digits := passwort_ziffern_arr(LENGTH(passwort) - 1);

            FOR i IN 1 .. LENGTH(passwort) LOOP
                v_num := TO_NUMBER(SUBSTR(passwort, i, 1));

                IF i != 1 THEN
                    v_digits.EXTEND;
                    v_digits(v_digits.COUNT) := v_num;
                END IF;
                v_digits_full.EXTEND;
                v_digits_full(v_digits_full.COUNT) := v_num;
            END LOOP;

            CalControlCipher(v_digits, v_rest);

            IF v_rest != TO_NUMBER(SUBSTR(passwort, 1, 1)) THEN
                fehlercode := 3;
            END IF;
        END IF;

        return fehlercode;
    END Action;
END GRWO_Passwoerter;
/


BEGIN
    GRWO_Passwoerter.Init;
    grwo_passwoerter.Generate(5);
END;