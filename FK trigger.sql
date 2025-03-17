DROP TABLE tmpemp CASCADE CONSTRAINT;

CREATE TABLE tmpemp AS SELECT * FROM scott.emp;

SELECT * FROM tmpemp;

INSERT INTO tmpemp(empno, deptno) VALUES (1111, 10);
INSERT INTO tmpemp(empno, deptno) VALUES (2222, 50);

CREATE OR REPLACE TRIGGER tmpemp_fk
BEFORE INSERT OR UPDATE OF deptno ON tmpemp
FOR EACH ROW
DECLARE 
    dummy INTEGER;
BEGIN
    SELECT COUNT(*)
    INTO dummy
    FROM dept
    WHERE deptno = :NEW.deptno;
    IF dummy < 1 THEN
    raise_application_error(-20002, 'Department Number:' || :NEW.deptno || ' not in the department table');
    END IF;
END;

INSERT INTO tmpemp(empno, deptno) VALUES (3333, 50);