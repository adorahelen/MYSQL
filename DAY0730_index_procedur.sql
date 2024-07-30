use employees;
select * from emp;

CREATE VIEW v_emp 
AS ( SELECT * FROM emp where deptno = 30);

SELECT * FROM v_emp;
ALTER VIEW v_emp
AS ( SELECT empno, ename, job, mgr MANAGER
	From emp Where deptno = 30 );
    
CREATE OR REPLACE VIEW v_emp
AS ( SELECT empno 사원번호, ename 사원명, job 업무, mgr Manager From emp Where deptno = 30);

DROP VIEW v_emp;


-- 테이블 생성 시 인덱스 지정 
-- 테이블 이름은 : 테스트
-- 커럼 1 : 아이디 (숫자, 1씩 자동증가 및 기본키로 설정) 
-- 컬럼 2 : 아이디 엑스 언더바 컬 
CREATE TABLE test(
	id INT AUTO_INCREMENT PRIMARY KEY,
    idx_col	VARCHAR(20),
    INDEX idx_test(idx_col)
    );
    
    use employees;
    INSERT INTO test VALUE(1, 'test');
	INSERT Into test VALUE(1, 'test');
    
    DROP INDEX idx_testw ON test;
    ALTER TABLE test DROP INDEX idx_test;
    
    SHOW INDEX FROM TEST;
    
    CREATE UNIQUE INDEX idx_test ON test(idx_col);
	INSERT INTO test VALUE(1, 'test');
	INSERT Into test VALUE(1, 'test');
    

 CREATE INDEX idx_testw ON test(idx_col);
 
 DELETE FROM test;
 SELECT * from test;
 
 ALTER TABLE t_emp2 ADD INDEX (deptno);
 SHow index from t_emp2;
 
 ALTER TABLE t_emp2 ADD FULLTEXT(job) 
 
-- 기존 테이블에 인덱스 추가
ALTER TABLE t_emp2 ADD INDEX(deptno);
ALTER TABLE t_emp2 ADD FULLTEXT(job); -- 텍스트 검색 최적화 - CHAR, VARCHAR 등
   
-- 인덱스 제거
ALTER TABLE test DROP INDEX idx_test;
   
SHOW INDEX FROM test;   
   
INSERT INTO test VALUES(1, 'test');
INSERT INTO test VALUES(2, 'test');
DELETE FROM test WHERE id = 2;
SELECT * FROM test;



#####################################################
#### STORED PROGRAM

#### STORED PROCEDURE -------------------------------
-- 1. 매개변수 X ---------------------
DELIMITER $$
CREATE PROCEDURE emp_proc()	
BEGIN
	SELECT * FROM emp;
END$$
DELIMITER ;

-- 프로시저 호출
CALL emp_proc();

-- 프로시저 삭제
DROP PROCEDURE IF EXISTS emp_proc;


-- 2. 매개변수 1개 ----------------
DROP PROCEDURE IF EXISTS emp_proc;
DELIMITER $$
CREATE PROCEDURE emp_proc(IN e_job VARCHAR(9))	
BEGIN
	SELECT * FROM emp WHERE job = e_job;
END$$
DELIMITER ;

CALL emp_proc('MANAGER');


-- 3. 매개변수 2개 ----------------
DROP PROCEDURE IF EXISTS emp_proc;
DELIMITER $$
CREATE PROCEDURE emp_proc(IN e_job VARCHAR(9),
						  IN e_deptno INT)	
BEGIN
	SELECT * FROM emp WHERE job = e_job AND deptno = e_deptno;
END$$
DELIMITER ;

CALL emp_proc('MANAGER', 10);


-- 4. 출력 매개변수 ----------------
DROP PROCEDURE IF EXISTS emp_proc;
DELIMITER $$
CREATE PROCEDURE emp_proc(IN e_job VARCHAR(9),
						  OUT e_sal INT)	
BEGIN
	SELECT AVG(sal) INTO e_sal
    FROM   emp 
    WHERE  job = e_job;
END$$
DELIMITER ;

CALL emp_proc('MANAGER', @avg_sal);
SELECT @avg_sal 'MANAGER-AVG SAL';


-- 5. 입출력 매개변수 ----------------
-- empno와 sal 인상률(5%)을 매개변수로 받아서 인상된 sal 반환
DROP PROCEDURE IF EXISTS emp_proc;
DELIMITER $$
CREATE PROCEDURE emp_proc(IN e_empno INT,
						  INOUT e_sal FLOAT)	
BEGIN
	SELECT sal * e_sal / 100 + sal   INTO  e_sal
    FROM   emp
    WHERE  empno = e_empno;
END$$
DELIMITER ;

SET @e_sal = 5.0;	-- sal 인상률
CALL emp_proc(7369, @e_sal);
SELECT @e_sal;


####### IF ELSE ------------
-- empno를 매개변수로 받아서
-- sal가 5000 이상이면 ~~,
--       2000 이상이면 ~~~
--       그외의 경우이면 ~~~
DROP PROCEDURE IF EXISTS emp_proc;
DELIMITER $$
CREATE PROCEDURE emp_proc(IN e_empno INT)	
BEGIN
	DECLARE e_sal INT;				-- 변수 선언
    DECLARE e_result VARCHAR(20);	--    "
    
	SELECT sal   INTO  e_sal FROM emp  WHERE empno = e_empno;
    
    IF     e_sal >= 5000	THEN SET e_result = 'HIGH';	-- 변수에 값 저장
    ELSEIF e_sal >= 2000	THEN SET e_result = 'MID';
    ELSE   					     SET e_result = 'LOW';
    END IF;
    
    SELECT e_result;
END$$
DELIMITER ;

CALL emp_proc(7369);	
CALL emp_proc(7566);	
CALL emp_proc(7839);


############## CASE ---------------------------------
-- empno를 매개변수로 받아서
-- job이 CLERK이면 '사원', MANAGER이면 '관리자', 그외의 경우이면 '기타'로 표시
DROP PROCEDURE IF EXISTS emp_proc;
DELIMITER $$
CREATE PROCEDURE emp_proc(IN e_empno INT)	
BEGIN
	DECLARE e_job VARCHAR(9);				-- 변수 선언
    DECLARE e_result VARCHAR(20);	--    "
    
	SELECT sal   INTO  e_sal FROM emp  WHERE empno = e_empno;
    
    CASE e_job  WHEN 'CLERK'	THEN SET e_result = '사원';	-- 변수에 값 저장
				WHEN 'MANAGER'  THEN SET e_result = '관리자';
				ELSE   			     SET e_result = '기타';
    END CASE;
    
    SELECT e_result;
END$$
DELIMITER ;

CALL emp_proc(7369);	
CALL emp_proc(7566);	
CALL emp_proc(7839);

################## WHILE

DROP PROCEDURE IF EXISTS emp_proc;
DELIMITER  $$
CREATE PROCEDURE emp_proc(IN e_begin INT, IN e_max INT)
BEGIN 
	DECLARE e_job VARCHAR(9);
    DECLARE e_result VARCHAR(20);
    
    WHILE e_begin <= e_max DO
		SET sum = sum + e_begin + 
    
    SELECT CONCAT(e_begin, '부터' , e_amx)   AS RESULT;
END$$
DELIMITER ;

SET sum = 0;
SET i = 1;

WHILE i <= e_max DO
	IF i % 2 != 0 THEN -- 2의 배수가 아니면 이하 수행 안함 
    END IF;
    
    SET sum = sum + I;


CREATE table emp_log(
	id INT AUTO_INCREMENT primary KEY, 
    log_time DATEtime 
    );
    
SET @now = SYSDATE();
-- REPAIR emp_log_gry from 'adasasadsa '(valu??)';


SHOW GLOBAL VARIABLES LIKE 'log_bin_trust_function_creators' ;














