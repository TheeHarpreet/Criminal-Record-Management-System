SELECT v.victim_id, v.first_name, v.surname, v.address, v.date_of_birth, v.gender, v.phone, v.crime_id
FROM crime c
INNER JOIN victim v ON c.crime_id = v.crime_id
WHERE v.date_of_birth < TO_DATE('01/01/2005', 'MM/DD/YYYY')
UNION
SELECT v.victim_id, v.first_name, v.surname, v.address, v.date_of_birth, v.gender, v.phone, v.crime_id
FROM crime c
INNER JOIN victim v ON c.crime_id = v.crime_id
WHERE v.date_of_birth > TO_DATE('01/01/1980', 'MM/DD/YYYY') AND v.date_of_birth < TO_DATE('12/31/2004', 'MM/DD/YYYY')
GROUP BY  v.victim_id, v.first_name, v.surname, v.address, v.date_of_birth, v.gender, v.phone, v.crime_id;