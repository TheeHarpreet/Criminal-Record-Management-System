CREATE OR REPLACE TRIGGER suspect_trigger
BEFORE INSERT OR UPDATE ON suspect
FOR EACH ROW
DECLARE 
    phone_dummy INTEGER;
BEGIN
    SELECT COUNT(*) INTO phone_dummy 
    FROM suspect
    WHERE phone = :NEW.phone;
    IF phone_dummy = phone THEN 
    Raise_application_error(-20005, 'Phone' || :new.phone || 'is already a phone which exists, please enter another one');
    END IF;
END;

INSERT INTO suspect(phone) VALUES ('7678701231');