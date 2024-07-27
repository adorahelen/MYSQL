-- INSERT INTO t_emp( empno, enamel, deptno, sal, hiredate) VALUES(1000, 'kim', 40, 1000, '2020-10-10' );
-- INSERT INTO t_emp VALUES(2000, 'kim', 40, 1000, '2020-10-10');
-- INSERT INTO t_emp (empno, enamel, hiredate )
-- VALUES (3000, 'sam' , NOW() );
-- INSERT INTO t_emp ( enamel, hiredate )
-- VALUES ('sara' , NOW() );
-- INSERT INTO t_emp
-- SELECT empno, ename, deptno, sal, hiredate 
-- FROM emp
-- WHERE deptno = 10; 

-- test data - prime key dup
-- INSERT IGNORE INTO t_emp(empno, enamel) VALUES (9000, 'tester');
-- INSERT IGNORE INTO t_temp(empno, enamel) VALUES (9000, 'tester');
-- INSERT IGNORE INTO t_emp(empno, enamel) VALUES (9001, 'tester');
-- INSERT IGNORE INTO t_emp(empno, enamel) VALUES (9002, 'tester');

-- CREATE TABLE t_temp2
-- AS 
-- SELECT empno, ename, hiredate
-- FROM emp;
-- SELECT * from t_temp2;


SHOW VARIABLES LIKE 'autocommit';
SET autocommit = 0;
START transaction;

### -- ###
-- UPDATE t_emp SET deptno = 50; 
-- ROLLBACK; 
-- DELETE FROM t_emp;

-- IF deptno , =NULL 
-- UPDATE t_emp SET deptno = 90 WHERE deptno IS NULL;
COMMIT;

UPDATE t_emp SET sal = 9000, hiredate = NOW()
WHERE deptno = 90 AND hiredate IS NULL;

INSERT INTO t_emp(empno, enamel) VALUES (9001, 'tester') ON DUPLICATE KEY UPDATE enamel = 'uploader';
INSERT INTO t_temp(empno, enamel) VALUES (9002, 'tester');

COMMIT;

DELETE FROM t_emp WHERE enamel = 'uploader';


ROLLBACK;
