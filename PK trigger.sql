-- this command will add FK constraint to emp table, based on the recursive relationship
ALTER TABLE emp ADD CONSTRAINT fk_manager FOREIGN KEY (mgr)REFERENCES emp(empno);

-- this command is to create and drop sequences for PK columns in emp and dept tables
DROP sequence dept_seq;
CREATE sequence dept_seq start with 50;
DROP sequence emp_seq;
CREATE sequence emp_seq start with 8000;

COMMIT;
create or replace trigger emp_T1
BEFORE insert on emp
for each row
begin
IF :NEW.empno  IS NULL THEN
SELECT emp_SEQ.NEXTVAL INTO :NEW.empno FROM SYS.DUAL;
END IF;
end;
/
commit;
