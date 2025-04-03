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
    TYPE passwort_ziffern_arr IS VARRAY(4) OF INTEGER;
    PROCEDURE Init;
    PROCEDURE Generate(anzahl_datensaetze IN INTEGER);
    PROCEDURE CalControlCipher(pass_ziffern IN passwort_ziffern_arr, rest OUT INTEGER);
    PROCEDURE Action(passwort IN VARCHAR, fehlercode OUT INTEGER);
END GRWO_Passwoerter;
/

CREATE OR REPLACE PACKAGE BODY GRWO_Passwoerter AS
    PROCEDURE Init IS
    BEGIN
        dbms_output.put_line('Start Init');
        -- PLENGTH und PSHIFT extrahieren
        SELECT PLENGTH, PSHIFT INTO p_length, p_shift FROM PA_CONFIG WHERE ROWNUM = 1;
        
        -- Tabelle PA_REFERENCE leeren
        DELETE FROM PA_REFERENCE;
        
        -- Faktoren berechnen und Referenztabelle mit Zahlen und Faktoren bestücken
        INSERT INTO PA_REFERENCE (ZAHL, FAKTOR) VALUES
        (0, MOD(0 + p_shift, 10)),
        (1, MOD(1 + p_shift, 10)),
        (2, MOD(2 +p_shift, 10)),
        (3, MOD(3 + p_shift, 10)),
        (4, MOD(4 + p_shift, 10)),
        (5, MOD(5 + p_shift, 10)),
        (6, MOD(6 + p_shift, 10)),
        (7, MOD(7 + p_shift, 10)),
        (8, MOD(8 + p_shift, 10)),
        (9, MOD(9 + p_shift, 10));
        dbms_output.put_line('End Init');
    END Init;
    
    PROCEDURE Generate(anzahl_datensaetze IN INTEGER) IS
    BEGIN
        -- Einfügen von Datensätze in PA_PASSWD
        -- Feld PASSWD hat Passwort
        -- Feld ID hat anfangs Code 9
        -- Passwort ist Zeichenkette mit vordefinierter Länge!
        -- Passwort besteht aus zufälligen Ziffern.
        dbms_output.put_line('Start Generate');
        
        dbms_output.put_line('End Generate');
    END Generate;
    
    PROCEDURE CalControlCipher(pass_ziffern IN passwort_ziffern_arr, rest OUT INTEGER) IS
    BEGIN
        -- Bekommt Array mit Ziffern aus dem Passwort (ohne Prüfzahl)
        -- Faktor aus PA_REFERENCE auf Ziffern anwenden
        -- Werte summieren
        -- Summe durch 10 dividieren
        -- Rest der Division ist die Prüfsumme -> Rückgabe
        dbms_output.put_line('Start Cal');
        dbms_output.put_line('End Cal');
    END CalControlCipher;
    
    PROCEDURE Action(passwort IN VARCHAR, fehlercode OUT INTEGER) IS
    BEGIN
        -- Enthält eine Zeichenkette (Passwort)
        -- Check -> Stimmt Länge von Passwort? Nein (2)
        -- Check -> Enthält Zeichenkette nur Ziffern? Nein (1)
        -- Umwandeln von Zeichenkette in Integer-Array (ohne Prüfzahl)
        -- CalControlCipher aufrufen
        -- Check -> Rückgabewert der Funktion is erstes Element der Zeichenkette? Ja (0) Nein (3)
        dbms_output.put_line('Start Action');
        dbms_output.put_line('End Action');
    END Action;
END GRWO_Passwoerter;
/


BEGIN
    GRWO_Passwoerter.Init;
    grwo_passwoerter.Generate(1);
END;