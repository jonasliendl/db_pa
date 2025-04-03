SELECT m.Spitzname as "Spitzname", m.FamilienBezeichnung as "Bezeichnung Familie"
FROM Mafiosis m
JOIN begeht b 
	ON b.Spitzname = m.Spitzname
JOIN Straftaten s 
	ON s.Vorgangsnummer = b.Vorgangsnummer
WHERE s.KategorieBezeichnung = 'Drogenhandel';