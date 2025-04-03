SELECT k.*, r.Datum AS "Rekrutierungsdatum"
FROM Mafiosis a
JOIN rekrutiert r 
	ON a.Spitzname = r.SpitznameAgent
JOIN Mafiosis k
	ON r.SpitznameKomplize = k.Spitzname
WHERE a.Spitzname = 'Polpettone';