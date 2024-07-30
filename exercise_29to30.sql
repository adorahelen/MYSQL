#####################################################
###### DDL ; Data Definition Language
USE modeldb;

-- 테이블 생성 i - 컬럼 레벨 제약 조건 지정
CREATE TABLE t_member (
	mid 		VARCHAR(20) PRIMARY KEY, -- 기본 키 
    mname		VARCHAR(20) NOT NULL,	
    mpw			VARCHAR(20) NOT NULL,
    email		VARCHAR(50) NOT NULL   UNIQUE,  
    gender  	CHAR(1)     CHECK(gender IN('M', 'F')),
    photo     	VARCHAR(50) DEFAULT 'default.png',
    birth_date	DATE,
    join_date	DATE		DEFAULT (CURRENT_DATE) 
);


-- 테이블 생성 ii
CREATE TABLE t_board(
	bno			INT				AUTO_INCREMENT,
    title		VARCHAR(100)	NOT NULL,
    content		VARCHAR(4000)	NOT NULL,
    writer		VARCHAR(20)		NOT NULL,
-- 	REFERENCES t_member(mid), -- 외래키 제약 조건은 컬럼 레벨로 지정 X
    hit			INT				DEFAULT 0,                                
	write_date	DATE			DEFAULT (CURRENT_DATE),
    
    CONSTRAINT  pk_t_board PRIMARY KEY(bno)
);        
        
-- 테이블 생성 iiit_boardt_membert_membert_replyt_reply
CREATE TABLE t_reply(
	rno 		INT				AUTO_INCREMENT, -- 기본키
	bno			INT				NOT NULL, -- 외래키
    reply		VARCHAR(1000)	NOT NULL,
    replier		VARCHAR(20)		NOT NULL, -- 외래키                            
	reply_date	DATE			DEFAULT (CURRENT_DATE),
    
    CONSTRAINT PRIMARY KEY(rno),
    CONSTRAINT fk_reply_bno FOREIGN KEY(bno)
							REFERENCES t_board(bno),
	CONSTRAINT FOREIGN KEY(replier) REFERENCES t_member(mid)
);
        
        DROP TABLE T_REPLY;
        DROP TABLE T_BOARD;
        DROP TABLE T_MEMBER;

USE employees;          
-- 테이블 삭제 
DROP TABLE t_emp2;        
        
-- CTAS ; Create Table As Select      
        
-- 테이블의 구조와 데이터를 모두 복사 - 제약조건은 제외        
CREATE TABLE t_emp2	 -- 복사 테이블
AS
SELECT * FROM emp;   -- 원본 테이블
           
-- 테이블의 구조와 데이터 일부를 복사 - 제약조건은 제외        
CREATE TABLE t_emp3	 -- 복사 테이블
AS
SELECT empno, ename, hiredate FROM emp;   -- 원본 테이블           
           
-- 테이블의 구조만 복사
CREATE TABLE t_emp4 AS SELECT * FROM emp WHERE 1 = 0;
           
           
###### 임시 테이블 생성
CREATE TEMPORARY TABLE IF NOT EXISTS
temp1 ( id INT, name CHAR(10) );           
           
SELECT * FROM temp111111111111111;
SELECT * FROM temp1;    

INSERT INTO temp1 VALUES( 1, 'Lee' );
INSERT INTO temp1 VALUES( 2, 'Han');       
           
           
           

USE modeldb;          
-- 테이블 삭제 
DROP TABLE table1;   -- 얘부터 삭제 불가 - 다른 테이블에서 참조 중
DROP TABLE table2;   -- 이 테이블을 삭제하고
DROP TABLE table1;   -- 다시 삭제 시도
           
           
########## ALTER ----------------------------
-- t_board 테이블에 외래키 fk_board_writer 추가
--        "     의 writer 컬럼이
-- t_member 테이블의 mid 컬럼을 참조하도록 처리
ALTER TABLE t_board ADD CONSTRAINT fk_board_writer
					    FOREIGN KEY(writer)
                        REFERENCES t_member(mid); 
           

USE employees;
-- 테이블의 컬럼 추가 / 수정 / 변경 / 삭제 
ALTER TABLE t_emp ADD work VARCHAR(10);  -- work 컬럼 추가 - 제일 마지막
ALTER TABLE t_emp ADD mgr INT AFTER deptno;-- mgr "   "  - deptno 뒤
ALTER TABLE t_emp ADD seq INT FIRST;	   -- seq "   "  - 제일 앞

ALTER TABLE t_emp RENAME COLUMN work TO part; -- 컬럼 이름 변경
ALTER TABLE t_emp MODIFY part VARCHAR(20) ;

ALTER TABLE t_emp DROP COLUMN seq;	-- 컬럼 삭제

-- 기본키 지정
ALTER TABLE t_emp2 ADD CONSTRAINT pk_emp2  PRIMARY KEY(empno);
ALTER TABLE t_emp2 ADD CONSTRAINT PRIMARY KEY(empno);
ALTER TABLE t_emp  ADD CONSTRAINT PRIMARY KEY(empno);

--  기본키 삭제
ALTER TABLE t_emp2 DROP PRIMARY KEY;
ALTER TABLE t_emp  DROP PRIMARY KEY;  -- AUTO_INCREMENT로 지정된 컬럼은 에러

ALTER TABLE t_emp  MODIFY empno INT;  -- 자동 증가 아닌 컬럼으로 수정하고	
ALTER TABLE t_emp  DROP PRIMARY KEY;  -- 이제 기본키 삭제 가능
										
DESC t_emp;

-- 외래키 추가 i
-- t_emp 테이블의 empno 컬럼이 
-- emp 테이블의 empno 컬럼을 참조하도록 처리
ALTER TABLE t_emp ADD CONSTRAINT fk_t_emp
					  FOREIGN KEY(empno)
                      REFERENCES emp(empno); 
-- 부모 테이블에 없는 데이터(1000, 2000 등)가 
-- 있을 때는 제약 조건 추가 불가
DELETE FROM t_emp; -- 데이터를 모두 지우고 제약 조건 재지정

INSERT INTO t_emp(empno, ename) VALUES(1111, 'San'); -- X emp에 없는 empno
INSERT INTO t_emp(empno, ename) VALUES(7788, 'San');
INSERT INTO t_emp(empno, ename) VALUES(9000, 'Han');

-- emp 테이블의 empno 9000 레코드를 삭제
DELETE FROM emp WHERE empno = 9000; -- t_emp 테이블에서 참조하고 있기 때문에 X
 
-- t_emp 테이블의 외래키 제약 조건 삭제
ALTER TABLE t_emp DROP FOREIGN KEY fk_t_emp; 
 

-- 외래키 추가 ii
-- t_emp 테이블의 empno 컬럼이 
-- emp 테이블의 empno 컬럼을 참조하도록 처리
-- 단, emp 테이블의 컬럼이 지워지면 NULL로 설정
ALTER TABLE t_emp ADD CONSTRAINT fk_t_emp
					  FOREIGN KEY(empno)
                      REFERENCES emp(empno)
                      ON DELETE SET NULL;
-- empno가 PK로 설정되어 있기 때문에 NULL 값 입력 불가
ALTER TABLE t_emp DROP PRIMARY KEY;  
ALTER TABLE t_emp MODIFY empno INT NULL;
-- 외래키 재지정
-- emp 테이블의 empno 9000 레코드를 삭제
DELETE FROM emp WHERE empno = 9000; 


-- 외래키 추가 iii
-- t_emp 테이블의 empno 컬럼이 
-- emp 테이블의 empno 컬럼을 참조하도록 처리
-- 단, emp 테이블의 컬럼이 지워지면 같이 삭제되도록 설정
ALTER TABLE t_emp ADD CONSTRAINT fk_t_emp_del
					  FOREIGN KEY(empno)
                      REFERENCES emp(empno)
                      ON DELETE CASCADE;

-- emp 테이블의 empno 7788 레코드를 삭제
DELETE FROM emp WHERE empno = 7788; 
                      
 
INSERT INTO t_emp(empno, ename) VALUE(7900, 'San');

-- t_emp 테이블의 ename 컬럼의 값이 중복되지 않도록 제약 조건 지정
ALTER TABLE t_emp ADD CONSTRAINT uq_ename UNIQUE(ename); -- X 중복 값이 존재 
DELETE FROM t_emp WHERE empno IS NULL;  -- 중복 값 제거하고 재지정
INSERT INTO t_emp(empno, ename) VALUE(7900, 'San');  -- X 중복 데이터 입력 

-- ALTER TABLE t_emp2 DROP PRIMARY KEY;
-- ALTER TABLE t_emp  DROP FOREIGN KEY fk_t_emp; 
-- unique 제약 조건은 인덱스로 지워줌
ALTER TABLE t_emp DROP INDEX uq_ename;


-- t_emp 테이블의 deptno 컬럼의 값은 10 이상으로 입력하도록 제약조건 지정
ALTER TABLE t_emp ADD CONSTRAINT chk_deptno CHECK( deptno >= 10 );
UPDATE t_emp SET deptno = 1  WHERE empno = 7900;  -- X
UPDATE t_emp SET deptno = 10 WHERE empno = 7900;  -- O

-- chk_deptno 조건 제거
ALTER TABLE t_emp DROP CHECK chk_deptno;
UPDATE t_emp SET deptno = 1  WHERE empno = 7900;  -- O


-- t_emp 테이블의 sal 컬럼의 기본값이 0이 되도록 제약 추가
ALTER TABLE t_emp MODIFY sal INT DEFAULT 0;
INSERT INTO t_emp(empno, ename) VALUE(7499, 'Kan');


-- t_emp 테이블의 hiredate 컬럼은 Null을 허용하지 않도록 제약 추가
ALTER TABLE t_emp MODIFY hiredate DATE NOT NULL; -- x 해당 컬럼에 NULL 존재
UPDATE t_emp SET hiredate = '1900-01-01' -- 해당 컬럼 NULL 값 변경
			 WHERE hiredate IS NULL;
-- 제약 재지정

-- t_emp 테이블의 hiredate 컬럼은 Null을 허용하도록 제약 변경
ALTER TABLE t_emp MODIFY hiredate DATE NULL;


## 테이블 이름 변경
RENAME TABLE t_emp TO t_employee;


CREATE TABLE test  ( num INT PRIMARY KEY);
CREATE TABLE test2 ( num INT, CONSTRAINT fk_num 
							  FOREIGN KEY(num) 
                              REFERENCES test(num)  );
INSERT INTO test  VALUES( 111 );
INSERT INTO test  VALUES( 222 );
INSERT INTO test2 VALUES( 111 ); 

DROP TABLE test2;

-- test 테이블 삭제하기
DROP TABLE test; -- 참조 테이블 있는 경우 X
ALTER TABLE test2 DROP CONSTRAINT fk_num; -- 1. 참조를 제거
DROP TABLE test; -- 삭제 가능

DELETE FROM test2;	-- 2. 참조 데이터를 제거
TRUNCATE TABLE test2;
DROP TABLE test2;

-- 3. 두 테이블 모두 제거

SELECT * FROM test;
SELECT * FROM test2;



############################################################
###### VIEW 
USE employees;
INSERT INTO EMP VALUES(7788,'SCOTT','ANALYST',7566,STR_TO_DATE('19,4,1987','%d,%m,%Y'),3000,NULL,20);
 
-- emp 테이블의 deptno 중 30에 해당하는 레코드만 조회하는
-- v_emp 뷰 생성 
CREATE VIEW v_emp 
AS ( SELECT * FROM emp WHERE deptno = 30 );

SELECT * FROM v_emp;	-- 생성된 뷰는 테이블처럼 사용 가능

-- 뷰 수정 - 
ALTER VIEW v_emp 
AS ( SELECT empno, ename, job, mgr MANAGER 
	 FROM emp WHERE deptno = 30 );
     
-- 이미 존재하는 변경 그렇지 않은 경우에는 생성     
CREATE OR REPLACE VIEW v_emp
AS ( SELECT empno 사원번호, ename 사원명, job 업무, mgr MANAGER 
	 FROM emp WHERE deptno = 30 );
     
-- 뷰 삭제
DROP VIEW v_emp;


#####################################################
######### INDEX
-- 테이블 생성 시 인덱스 지정
-- 테이블 이름 : test
-- 컬럼 1 : id  - 숫자, 1씩 자동 증가 및 기본키 설정
-- 컬럼 2 : idx_col - 문자(크기는 20)
CREATE TABLE test (
   id		INT AUTO_INCREMENT PRIMARY KEY,
   idx_col	VARCHAR(20),
   INDEX idx_test(idx_col)
);   
   
-- 인덱스 생성 - 중복 허용
CREATE INDEX idx_test ON test(idx_col);  
DROP INDEX idx_test ON test;   
   
   
-- 인덱스 생성 - 중복 허용 X
CREATE UNIQUE INDEX idx_test ON test(idx_col);  

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
    
	SELECT job  INTO  e_job FROM emp  WHERE empno = e_empno;
    
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




################## WHILE --------------------
-- IN 매개변수로 시작값과 최대값을 정수형으로 받아서
-- 시작값부터 최대값까지 누적 합계를 계산한 후 화면에 출력
-- ~~부터 ~~까지 누적 합계 : ~~
DROP PROCEDURE IF EXISTS emp_proc;
DELIMITER $$
CREATE PROCEDURE emp_proc(IN e_begin INT, IN e_max INT)	
BEGIN
	DECLARE i     INT DEFAULT 1;	-- 변수 선언 및 초기화
    DECLARE sum   INT DEFAULT 0;	--         "
     
    WHILE i <= 5 DO
		SET sum = sum + i;
        SET i = i + 1;
    END WHILE;
    SELECT '1부터 5까지의 합 : ', sum;
    
    SET sum = 0;
	SET i = 1;
        
    do_while:	-- 반복문의 레이블    
    WHILE i <= e_max DO
		IF i % 2 != 0 THEN	-- 2의 배수가 아니면 이하 수행 X
			SET i = i + 1;
            ITERATE do_while;	-- 다음 회차로 이동할 레이블 지정
        END IF;
        SET sum = sum + i;	-- 2의 배수들만 sum에 누적 저장
        
        IF sum > 10   THEN	-- sum의 10을 초과하면 반복 중단
			LEAVE do_while;	-- 반복을 중단할 레이블 지정
        END IF;
        SET i = i + 1;
    END WHILE;
    SELECT CONCAT(e_begin, '부터 ', e_max, '까지 누적 합계 : ', sum) AS RESULT;
END$$
DELIMITER ;

CALL emp_proc(1, 10);


### 오류 처리 i - 에러코드 -----------
SELECT * FROM no_table;

DROP PROCEDURE IF EXISTS err_proc;
DELIMITER $$
CREATE PROCEDURE err_proc()
BEGIN
	DECLARE CONTINUE HANDLER FOR 1146 SELECT '- NO TABLE! -' MSG;
		SELECT * FROM no_table;
END $$
DELIMITER ;
CALL err_proc();


### 오류 처리 ii - SQLEXCEPTION -----------
INSERT INTO dept VALUES(10, 'A', 'B');   -- PK 중복 

DROP PROCEDURE IF EXISTS err_proc;
DELIMITER $$
CREATE PROCEDURE err_proc()
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT '- SQLEXCEPTION! -' MSG;
    BEGIN 
		ROLLBACK;
	END;
        
	INSERT INTO dept VALUES(10, 'A', 'B'); 
END $$
DELIMITER ;
CALL err_proc();


####### 동적 SQL
PREPARE myQry FROM 'SELECT * FROM emp WHERE empno = 7900'; -- 쿼리 준비
EXECUTE myQry;				-- 준비해둔 쿼리 실행
DEALLOCATE PREPARE myQry;	-- 쿼리 실행 후 해제

CREATE TABLE emp_log(	-- 동적 SQL 실행 시간 저장 테이블
	id			INT AUTO_INCREMENT PRIMARY KEY,
	log_time	DATETIME
);

SET @now = SYSDATE();  -- 현재 날짜와 시간 정보 가져오기
PREPARE emp_log_qry FROM 'INSERT INTO emp_log VALUES(NULL, ?)';
EXECUTE emp_log_qry USING @now;
DEALLOCATE PREPARE emp_log_qry;

SELECT SYSDATE();
SELECT * FROM dept;
SELECT * FROM emp;



####################################################
##### STORED FUNCTION
SHOW GLOBAL VARIABLES LIKE 'log_bin_trust_function_creators';
SET GLOBAL log_bin_trust_function_creators = 1; -- function 저장 권한 설정

-- 1. 정수 두 개를 매개변수로 받아 더한 값을 반환하는 함수 
DELIMITER $$
CREATE FUNCTION plus(num1 INT, num2 INT)
	RETURNS INT  -- 반환 타입
BEGIN
	RETURN num1 + num2 ; 	-- 덧셈 연산하여 반환
END $$
DELIMITER ;
SELECT plus(1, 2); -- 뒤 생략 가능 FROM dual;


-- 2. 출생년도를 입력받아 나이를 반환하는 함수
DELIMITER $$
CREATE FUNCTION get_age(birth_year INT)
	RETURNS INT  -- 반환 타입
BEGIN
	RETURN YEAR( CURDATE() ) - birth_year; 	--
END $$
DELIMITER ;
SELECT get_age(2000); 

-- 함수 삭제
DROP FUNCTION get_age;



###########################################
##### CURSOR
DELIMITER $$ 

-- emp 테이블의 sal 평균
CREATE PROCEDURE cursor_proc()
BEGIN
	DECLARE salary     INT;						-- 급여
    DECLARE	sal_sum    INT DEFAULT 0;			-- 총 급여
    DECLARE read_cnt   INT DEFAULT 0; 			-- 읽은 행 수 
    DECLARE end_of_row BOOLEAN DEFAULT FALSE;   -- 마지막 행 여부
    
    DECLARE csr CURSOR FOR			-- 커서 선언
		SELECT sal FROM emp;		-- 급여 가져오기
    
	DECLARE CONTINUE HANDLER FOR	-- 반복 조건 
		NOT FOUND 					-- 더이상 읽을 것이 없는 경우
        SET end_of_row = TRUE; 		-- 마지막 행 TRUE 설정
    
    OPEN csr;						-- 커서 열기
		csr_loop : 
		LOOP
			FETCH csr INTO salary;	-- 커서에서 데이터 가져오기
        
			IF end_of_row THEN		-- 마지막 행이면 
				LEAVE csr_loop;  	-- 반복 종료
            END IF;
            
            SET sal_sum = sal_sum + salary; -- 급여 누적 시키고
            SET read_cnt = read_cnt + 1;	-- 읽은 행 수 하나를 증가 시킴            
		END LOOP;
        SELECT sal_sum / read_cnt AS 'AVERAGE SAL' ;
    CLOSE csr;						-- 커서 닫기   
END $$
DELIMITER ;
CALL cursor_proc();

SELECT AVG(sal) FROM emp;
SELECT * FROM emp;







