-- MafiaFamilien
INSERT INTO MafiaFamilien (Bezeichnung, Stammort, GeschJaehrlicherUmsatz) VALUES
('Cosa Nordica', 'Hamburg', 12.5);

INSERT INTO MafiaFamilien (Bezeichnung, Stammort, GeschJaehrlicherUmsatz) VALUES
('La Bavarese', 'München', 8.3);

INSERT INTO MafiaFamilien (Bezeichnung, Stammort, GeschJaehrlicherUmsatz) VALUES
('Ndranghetto', 'Leipzig', 15.0);

-- Mafiosis
INSERT INTO Mafiosis VALUES ('Der Löwe', 45, 'Gefürchteter Boss mit goldener Uhr', 'Hamburg', 'Cosa Nordica');
INSERT INTO Mafiosis VALUES ('Schleicher', 38, 'Unauffällig, aber tödlich', 'Berlin', 'Cosa Nordica');
INSERT INTO Mafiosis VALUES ('Capo Toni', 50, 'Eiskalter Stratege', 'München', 'La Bavarese');
INSERT INTO Mafiosis VALUES ('Der Bayer', 33, 'Hat immer Weißbier dabei', 'München', 'La Bavarese');
INSERT INTO Mafiosis VALUES ('Zunge', 29, 'Redet sich immer raus', 'Dresden', 'Ndranghetto');
INSERT INTO Mafiosis VALUES ('Polpettone', 31, 'Spingt im Kreis', 'Leipzig', 'Ndranghetto');
INSERT INTO Mafiosis VALUES ('De Sachse', 29, 'Redet sich immer raus', 'Dresden', 'Ndranghetto');

-- StraftatKategorien
INSERT INTO StraftatKategorie VALUES ('Erpressung', 'Drohung zur Herausgabe von Geld oder Eigentum');
INSERT INTO StraftatKategorie VALUES ('Schmuggel', 'Illegaler Transport von Waren');
INSERT INTO StraftatKategorie VALUES ('Auftragsmord', 'Gezielter Mord gegen Bezahlung');
INSERT INTO StraftatKategorie VALUES ('Geldwäsche', 'Verschleierung illegaler Herkunft von Geld');
INSERT INTO StraftatKategorie VALUES ('Drogenhandel', 'Illegaler Verkauf von Beteubungsmittel');

-- Straftaten
INSERT INTO Straftaten VALUES (1001, 'Hamburg', 'Bedrohung eines Restaurantbesitzers', 'Erpressung');
INSERT INTO Straftaten VALUES (1002, 'München', 'Import von Falschware aus Osteuropa', 'Schmuggel');
INSERT INTO Straftaten VALUES (1003, 'Berlin', 'Gezielter Mord an rivalisierendem Mafioso', 'Auftragsmord');
INSERT INTO Straftaten VALUES (1004, 'Leipzig', 'Kauf von Immobilien zur Geldwäsche', 'Geldwäsche');
INSERT INTO Straftaten VALUES (1005, 'Leipzig', 'Illegaler Schmuggel von 1.000 Riechklebern', 'Drogenhandel');

-- rekrutiert
INSERT INTO rekrutiert VALUES ('Der Löwe', 'Schleicher', TO_DATE('2020-05-10', 'YYYY-MM-DD'));
INSERT INTO rekrutiert VALUES ('Capo Toni', 'Der Bayer', TO_DATE('2021-03-15', 'YYYY-MM-DD'));
INSERT INTO rekrutiert VALUES ('Zunge', 'Der Bayer', TO_DATE('2022-11-20', 'YYYY-MM-DD'));
INSERT INTO rekrutiert VALUES ('Polpettone', 'Zunge', TO_DATE('2022-11-22', 'YYYY-MM-DD'));
INSERT INTO rekrutiert VALUES ('Polpettone', 'De Sachse', TO_DATE('2022-11-30', 'YYYY-MM-DD'));

-- begeht
INSERT INTO begeht VALUES ('Der Löwe', 1001);
INSERT INTO begeht VALUES ('Capo Toni', 1002);
INSERT INTO begeht VALUES ('Schleicher', 1003);
INSERT INTO begeht VALUES ('Zunge', 1004);
INSERT INTO begeht VALUES ('Der Bayer', 1002);
INSERT INTO begeht VALUES ('De Sachse', 1005);
INSERT INTO begeht VALUES ('Polpettone', 1005);
