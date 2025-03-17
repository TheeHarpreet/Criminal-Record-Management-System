SELECT c.crime_id, c.crime_type, c.crime_date, c.crime_state, s.suspect_id, s.first_name, s.surname, s.nationality, s.medical_record
FROM crime c
INNER JOIN crime_suspect cs ON c.crime_id = cs.crime_id
INNER JOIN suspect s ON cs.suspect_id = s.suspect_id
WHERE s.nationality = 'British'
ORDER BY c.crime_date;