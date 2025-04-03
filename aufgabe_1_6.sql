SELECT m.Spitzname, m."Alter", m.Beschreibung, m.Aufenthaltsort, m.FamilienBezeichnung, mf.Stammort, mf.GeschJaehrlicherUmsatz
FROM Mafiosis m
LEFT JOIN rekrutiert r 
	ON m.Spitzname = r.SpitznameAgent
JOIN MafiaFamilien mf
	ON mf.Bezeichnung = m.FamilienBezeichnung
GROUP BY m.Spitzname, m."Alter", m.Beschreibung, m.Aufenthaltsort, m.FamilienBezeichnung, mf.Stammort, mf.GeschJaehrlicherUmsatz
HAVING COUNT(r.SpitznameKomplize) = 0;