CREATE OR REPLACE TRIGGER victim_trigger
BEFORE INSERT OR UPDATE ON victim
FOR EACH ROW
DECLARE 
    victim_dummy number;
BEGIN
    SELECT COUNT(*) INTO victim_dummy 
    FROM victim
    WHERE crime_id = :new.crime_id 
    AND first_name = :new.first_name 
    AND surname = :new.surname 
    AND date_of_birth = :new.date_of_birth;
    IF victim_dummy > 0
    THEN Raise_application_error(-2001,'A victim with the details' || :new.crime_id || :new.first_name || :new.surname || :new.date_of_birth || 'already exists, please enter new details');
    END IF;
END;

INSERT INTO victim (crime_id, first_name, surname, date_of_birth) VALUES ('mur000208192024', 'Jimmy', 'James', '08/31/2003');