SELECT victim_id, first_name, surname, address, gender, phone, victim.crime_id
FROM victim, crime
WHERE victim.crime_id = crime.crime_id;