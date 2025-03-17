SELECT vd.victim_detail_no, vd.personal_statement, vd.record_date, vd.victim_id
FROM crime c
INNER JOIN victim v ON c.crime_id = v.crime_id
INNER JOIN victim_detail vd ON v.victim_id = vd.victim_id
WHERE vd.record_date > TO_DATE('09/01/2024', 'MM/DD/YYYY')
UNION
SELECT vd.victim_detail_no, vd.personal_statement, vd.record_date, vd.victim_id
FROM crime c
INNER JOIN victim v ON c.crime_id = v.crime_id
INNER JOIN victim_detail vd ON v.victim_id = vd.victim_id
WHERE vd.record_date < TO_DATE('01/31/2024', 'MM/DD/YYYY')
ORDER BY record_date;