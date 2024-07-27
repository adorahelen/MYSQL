SELECT * FROM employees.emp;  -- 주석
SELECT * FROM emp;			  # 주석
/*
	여러 줄 주석
*/

SHOW DATABASES;
USE shopdb;
SHOW TABLES;
DESC t_member;


####### SELECT #####################################
-- 모든 컬럼 조회
USE employees;		-- employees 데이터베이스/스키마 선택
SELECT * FROM emp; 
SELECT * FROM emp LIMIT 5;   -- 출력 행의 수 지정

-- 복수 컬럼 조회
SELECT ename, job FROM emp;

-- 단일 컬럼 조회
SELECT     job FROM emp;	-- ALL이 생략되어 있음
SELECT ALL job FROM emp;	

-- 중복 제거 조회
SELECT DISTINCT job FROM emp;

-- 컬럼명 별칭
SELECT ename AS name   FROM emp;
SELECT ename 이름       FROM emp;
SELECT ename "이  름"   FROM emp;
SELECT ename `이  름`   FROM emp;
SELECT ename "\"NAME\":이름" FROM emp;

SELECT ename, ' ' etc   FROM emp;	-- 존재하지 않는 컬럼도 표시 가능
SELECT ename, 'etc' 기타 FROM emp;

SELECT ename, sal, sal * 0.1, sal * 0.1 AS bonus FROM emp;
select ename, sal, sal * 0.1, sal * 0.1 as bonus from emp;
select ENAME, SAL, SAL * 0.1, SAL * 0.1 as BONUS from EMP;

-- 정렬
SELECT ename, job FROM emp;  
SELECT ename, job FROM emp ORDER BY ename; -- ASC 생략 - 기본 오름차순
SELECT ename, job FROM emp ORDER BY ename ASC;
SELECT ename, job FROM emp ORDER BY ename DESC; -- 내림차순

SELECT   job, ename 
FROM     emp 
ORDER BY job DESC, ename ASC; 
      -- 1차 정렬     2차 정렬

SELECT   job, ename 
FROM     emp 
ORDER BY 1 DESC, 2 ASC; -- 컬럼명 대신 순서 지정 가능



-- 조건 지정 ---------------------------------------------
-- =, !=, <>, >, >=, <, <=
-- AND, OR, NOT

-- job이 MANAGER인 레코드만 조회
SELECT * FROM emp WHERE job = 'MANAGER'; -- 문자 조건 지정
	
-- empno가 7566인 레코드 조회
SELECT * FROM emp WHERE empno = 7566;	 -- 숫자 조건 지정

-- hiredate가 1987년 이전인 레코드 조회
SELECT * FROM emp WHERE hiredate < '1987-01-01';  -- 날짜 조건 지정
    
-- job이 MANAGER이고 hiredate가 1987년 이전인 레코드 조회
SELECT * FROM emp WHERE job = 'manager' 
				  AND   hiredate < '1987-01-01';
    
-- hiredate가 1981년이 아닌 레코드 조회
SELECT * FROM emp WHERE NOT(hiredate >= '1981-01-01'
		                    AND   hiredate <= '1981-12-31');
   
   
-- dname이 RESEARCH이거나 SALES인 레코드 조회
SELECT * FROM dept WHERE dname = 'RESEARCH' OR dname = 'SALES';

-- IN 연산자 사용
SELECT * FROM dept WHERE dname IN('RESEARCH', 'SALES');
SELECT * FROM dept WHERE dname NOT IN('RESEARCH', 'SALES');


-- sal이 2000 이상 ~ 3000 이하인 레코드 조회
SELECT * FROM emp WHERE sal >= 2000 AND sal <= 3000;

-- BETWEEN AND 연산자
SELECT * FROM emp WHERE sal BETWEEN 2000 AND 3000;
   

-- sal이 2000 이상 ~ 3000 미만인 레코드 조회   
SELECT * FROM emp WHERE sal >= 2000 AND sal < 3000;
SELECT * FROM emp WHERE sal BETWEEN 2000 AND 2999;
   

-- 문자열 검색 ----------------
-- LIKE 한 글자 일치 _ , 0 또는 여러 글자 일치 %
SELECT * FROM emp WHERE ename LIKE '%A%'; -- 이름에 A가 포함된  
SELECT * FROM emp WHERE ename LIKE '_A%'; -- 이름 두번째에 A가 포함된
SELECT * FROM emp WHERE ename LIKE 'A%';  -- 이름이 A로 시작하는
   
   
-- NULL 데이터 조회
SELECT * FROM emp WHERE comm = NULL;  -- x comm이 NULL인 레코드 
SELECT * FROM emp WHERE comm IS NULL; -- o       " 
   
SELECT * FROM emp WHERE comm != NULL;     -- x comm이 NULL이 아닌 레코드 
SELECT * FROM emp WHERE comm IS NOT NULL; -- o       " 


## 결과 합치기 UNION -------
-- job이 CLERK이고, deptno가 20, 10인 레코드 조회
SELECT deptno, job FROM emp WHERE job = 'CLERK' AND deptno = 10;
SELECT deptno, job FROM emp WHERE job = 'CLERK' AND deptno = 20;


SELECT deptno, job FROM emp WHERE job = 'CLERK' AND deptno = 10
UNION   	-- 중복 제거하고 결합
SELECT deptno, job FROM emp WHERE job = 'CLERK' AND deptno = 20;

SELECT deptno, job FROM emp WHERE job = 'CLERK' AND deptno = 10
UNION ALL	-- 중복 제거 x, 결합
SELECT deptno, job FROM emp WHERE job = 'CLERK' AND deptno = 20;




##### 내장 함수 ############################################
## https://dev.mysql.com/doc/refman/8.0/en/functions.html
##
## 문자열 관련 함수
SELECT ASCII('a') FROM dual;
SELECT ASCII('A');
SELECT CHAR(65);

-- 길이 관련 함수
SELECT BIT_LENGTH('abc'),	-- 영문자 1 = 1byte
       CHAR_LENGTH('abc'),
       LENGTH('abc');
SELECT BIT_LENGTH('ㄱㄴㄷ'),  -- 한글 1 =  3byte
       CHAR_LENGTH('ㄱㄴㄷ'),
       LENGTH('ㄱㄴㄷ');
      
      
-- 결합
SELECT ename,
       CONCAT(sal, '원') 급여,
	   CONCAT(ename, '-', job, sal) 이름_직무_급여,
	   CONCAT_WS('-', ename, job, sal) 이름_직무_급여
FROM   emp;       

-- deptno가 20인 레코드를 job을 기준으로 정렬
SELECT * FROM emp WHERE deptno = 20 
ORDER BY FIELD(job, 'MANAGER', 'ANALYST', 'CLERK');


-- 세 자리마다 콤마 표시 조회
SELECT sal, FORMAT(sal, 0) FMT1,
			FORMAT(sal, 2) FMT2,
			FORMAT(sal * 1000, 2) FMT3
FROM   emp;

-- 문자열 추출 
SELECT LEFT('ABCDEFG', 3) 왼쪽,
       RIGHT('VWXYZ', 2) 오른쪽,
       MID('12345', 3, 2);

-- 대소문자 변환
SELECT ename, LOWER(job), UPPER('level') FROM emp;

-- 지정자릿수 채워넣기
SELECT deptno, LPAD(deptno, 3, 0), 
			   RPAD(deptno, 3, 0) FROM emp;
               
-- 공백 제거   _ _ABC_ _ _
SELECT LENGTH('  ABC   '),
       LENGTH( LTRIM('  ABC   ') ) 왼쪽공백제거,
       LENGTH( RTRIM('  ABC   ') ) 오른쪽공백제거,
       LENGTH( TRIM('  ABC   ') ) 양쪽공백제거;               
               
-- 문자열 변환 - PRESIDENT를 CEO로 
SELECT ename, job, REPLACE(job, 'PRESIDENT', 'CEO') FROM emp;

-- ename의 2번째부터 3개를 ***로 바꾸어 표시
SELECT ename, INSERT(ename, 2, 3, '***') FROM emp;

-- 문자열 추출 - 인덱스는 1부터 시작
SELECT SUBSTRING('Hello World', 3, 2),
       SUBSTRING('Hello World', 7),
       SUBSTR('Hello World', 3, 2),
       SUBSTR('Hello World', 7);



######### 숫자 관련 내장 함수 #####################
SELECT sal * 0.3333,
       CEIL(sal * 0.3333) C,
       CEILING(sal * 0.3333) CC, 
	   FLOOR(sal * 0.3333) F,
       ROUND(sal * 0.3333) R,
       MOD(sal, 3) M,
       sal % 3,
       sal MOD 3, 
       TRUNCATE(sal * 0.3333, 1) t1, 
       TRUNCATE(sal * 0.3333, 2) t2, 
       TRUNCATE(sal * 0.3333, 0) t3, 
       TRUNCATE(sal * 0.3333, -1) t4, 
       TRUNCATE(sal * 0.3333, -2) t5
FROM   emp;       


######## 날짜 관련 내장 함수 ##########################
SELECT SYSDATE(), NOW(), CURDATE(), CURTIME(), DATE( NOW() );

SELECT NOW(), YEAR( NOW() ) 연도, MONTH( NOW() ) 월,
       HOUR( NOW() ) 시, MINUTE( NOW() ) 분, SECOND( NOW() )초;
       
       
######## 형변환 관련 내장 함수 ########################
-- 묵시적 형변환
SELECT '1' + '2', 		-- 정수로 덧셈 연산
       CONCAT(1, 2), 	-- 문자로 결합 연산
       1 > 2, 			-- 0 false
       1 < 2; 			-- 1 true

-- 명시적 형변환
SELECT CAST('2024-01-02' AS DATE) T0_DATE,  -- 문자 >> 날짜로
       CAST( SYSDATE() AS CHAR) TO_CHAR;	-- 날짜 >> 문자로

-- 입력된 문자열을 MySQL 내장 날짜/시간 형식으로 변환
-- STR_TO_DATE(날짜|시간문자열, 포맷문자열)
SELECT STR_TO_DATE('01,5,2024', '%d,%m,%Y');  



####### 시스템 정보 관련 내장 함수 #######
SELECT USER(), DATABASE();




###### 흐름 제어 관련 내장 함수 ##########
-- IF(수식, 참, 거짓)		-- 삼항연산자 유사
-- IFNULL(수식1, 수식2)	-- 수식1이 널이면 수식2
-- NULLIF(수식1, 수식2)	-- 두 수식이 같으면 NULL, 다르면 수식1 반환

-- comm이 0이면 NULL, 아니면 COMM
SELECT ename, comm, NULLIF(comm, 0) FROM emp;

-- comm이 NULL이면 999로 표시
SELECT ename, comm, IFNULL(comm, 999) FROM emp;


-- job이 CLERK 또는 SALESMAN이면 사원, 그렇지 않으면 책임자로 표시하여
-- 책임자가 먼저 나오도록 조회
SELECT   ename, job, 
         IF( job IN('CLERK', 'SALESMAN'), '사원', '책임자')  
FROM     emp 
ORDER BY 3 DESC;


-- CASE WHEN THEN ELSE
SELECT ename, sal, job,
       CASE WHEN job = 'CLERK'    THEN 0.1
            WHEN job = 'SALESMAN' THEN 0.2
            ELSE 0.01 END * sal AS bonus,
       CASE job WHEN 'CLERK'      THEN 0.1
                WHEN 'SALESMAN'   THEN 0.2
                ELSE 0.01 END * sal AS bonus2
 FROM   emp;
 
 
 
            
######## 그룹 함수 ##############################
-- 레코드를 그룹화하여 조회
SELECT COUNT(*)     전체_행, 
       COUNT(mgr)   널_제외,
       COUNT( DISTINCT mgr) 중복_제외
FROM   emp;

SELECT SUM( comm ) 합계,
       SUM( comm ) / COUNT(*) 평균,
       AVG( comm ) 평균2,		-- 널 제외,
       AVG( IFNULL(comm,0) ) 평균3,        -- 널 포함
       MAX( comm ),
       MIN( comm ) 
FROM   emp;

             
##### GROUP BY 
-- 특정 조건으로 결과를 그룹화
-- SELECT에 사용된 그룹 함수 이외의 컬럼이나 표현식은
-- GROUP BY절에 명시해야 함
-- 
-- SELECT에 사용하지 않은 컬럼도 GROUP BY에 사용 가능
             
-- job의 sal 합계 조회
SELECT job, SUM(sal) FROM emp  GROUP BY job;   
SELECT job, SUM(sal) FROM emp  GROUP BY job, deptno;             
             
-- detpno 별로 sal 평균이 2000 이상인 레코드의 deptno, 인원 수, sal 평균 
SELECT deptno, COUNT(*), AVG(sal)
FROM   emp
-- WHERE  AVG(sal) >= 2000 -- 그룹함수 사용 시 조건은 HAVING으로 비교
GROUP BY deptno
HAVING  AVG(sal) >= 2000;  -- GROUP BY 다음에 명시

-- deptno 별로 CLERK의 평균 sal 조회 
-- 단, 인원 수가 2명 이상인 레코드만 대상
SELECT deptno, job, AVG(sal), COUNT(job)
FROM   emp
WHERE  job = 'CLERK' 
GROUP BY deptno
HAVING COUNT(job) >= 2;

-- deptno와 job의 sal 합계 및 인원 수 조회
SELECT deptno, job, SUM(sal), COUNT(*) 
FROM   emp 
GROUP BY 1, 2	-- 컬럼 이름 대신 순서로 지정 가능
ORDER BY 1;			

## ROLLUP - 부분합계, 총합계 출력
SELECT deptno, job, SUM(sal), COUNT(*) 
FROM   emp 
GROUP BY 1, 2	 
WITH ROLLUP;		


### 서브 쿼리 ###################################
-- 쿼리문 안에 포함된 쿼리문
-- 메인 쿼리 : 서브 쿼리를 포함하고 있는 쿼리문
-- 서브 쿼리 적용 위치
--    SELECT   (서브 쿼리문) - Sclar sub query 1행만 반환하는 경우
--    FROM     (서브 쿼리문) - Inline view
--    WHERE    (서브 쿼리문) - Sub query

### 단일행 서브쿼리 -----------------------
-- 수행 결과 한 행만 반환
-- =, >, <, >=, <=, != 사용

-- JAMES와 같은 부서에서 일하는 사람들 조회
SELECT ename, deptno FROM emp WHERE ename = 'JAMES';
SELECT ename, deptno FROM emp WHERE deptno = 30;

SELECT ename, deptno FROM emp 
WHERE deptno = ( SELECT deptno FROM emp 
				 WHERE ename = 'JAMES' );

-- 평균 sal 이상을 받는 사람들의 수 조회
SELECT AVG(sal) FROM emp;
SELECT COUNT(*) FROM emp WHERE sal >= 2073;

SELECT COUNT(*) FROM emp 
WHERE sal >= ( SELECT AVG(sal) FROM emp );



### 다중행 서브 쿼리 #########################
-- 서브 쿼리에서 뱐환되는 결과가 둘 이상의 행인 경우
-- IN = ANY = SOME, ALL

-- sal이 3000 이상인 사람들과 같은 부서의 사람들 조회
SELECT deptno, sal FROM emp WHERE sal >= 3000;
SELECT deptno, ename, sal FROM emp 
WHERE deptno IN (10, 20) ;

SELECT deptno, ename, sal FROM emp 
WHERE deptno IN ( SELECT DISTINCT deptno FROM emp 
				  WHERE sal >= 3000 )   ORDER BY 1;

SELECT deptno, ename, sal FROM emp 
WHERE deptno = SOME ( SELECT DISTINCT deptno FROM emp 
				      WHERE sal >= 3000 ) ORDER BY 1;

SELECT deptno, ename, sal FROM emp 
WHERE deptno = ANY ( SELECT DISTINCT deptno FROM emp 
				     WHERE sal >= 3000 ) ORDER BY 1;


## > ANY : 최소값보다 큼,   < ANY : 최대값보다 큼
-- job이 MANAGER인 사람들의 sal 조회
SELECT job, sal FROM emp WHERE job = 'MANAGER' ;

-- MANAGER들의 최소 sal 이상을 받는 사람들 조회
SELECT ename, job, sal FROM emp
WHERE  sal >= ANY ( SELECT sal FROM emp 
					WHERE job = 'MANAGER' );


## > ALL : 최대값보다 큼,   < ALL : 최소값보다 작음
-- MANAGER들의 최대 sal 이상을 받는 사람들 조회
SELECT ename, job, sal FROM emp
WHERE  sal >= ALL ( SELECT sal FROM emp 
					WHERE job = 'MANAGER' );


### 다중 컬럼 서브 쿼리 --------------------
-- 서브 쿼리에서 반환되는 결과가 둘 이상의 컬럼인 경우 
-- 각 부서별로 최소 급여를 받는 사람들 조회
SELECT deptno, MIN(sal) FROM emp GROUP BY deptno ORDER BY 1;

SELECT deptno, ename, sal FROM emp
WHERE (deptno, sal) 
IN    (SELECT deptno, MIN(sal) 
	   FROM emp GROUP BY deptno )
ORDER BY 1;


USE shopdb; -- --------------------
## json 데이터 형식으로 조회
SELECT mid, mname, maddress,
       JSON_OBJECT('mid', mid, 
				   'mname', mname, 
                   'maddress', maddress) AS json_data
FROM   t_member;




##### JOIN ###########################################
USE employees; -- -------------------

## CROSS JOIN 
SELECT * FROM emp CROSS JOIN dept;


## INNER JOIN - EQUI JOIN 
-- SELECT 열목록
-- FROM   테이블이름1 [INNER] JOIN 테이블이름2 
-- ON     조인조건
-- WHERE  검색조건
SELECT deptno, ename, sal FROM emp;
SELECT deptno, dname      FROM dept;

SELECT emp.deptno, ename, sal, dept.deptno, dname
FROM   emp INNER JOIN dept
ON     emp.deptno = dept.deptno
ORDER BY 1;

-- 테이블 이름의 별칭을 이용하여 조인
SELECT e.deptno, ename, sal, d.deptno, dname
FROM   emp e INNER JOIN dept d   -- 테이블 이름의 별칭 지정
ON     e.deptno = d.deptno
ORDER BY 1;

-- 검색 조건을 지정하여 조인 - 10번 부서만 조회
SELECT e.deptno, ename, sal, d.deptno, dname
FROM   emp e INNER JOIN dept d   -- 테이블 이름의 별칭 지정
ON     e.deptno = d.deptno
WHERE  e.deptno = 10
ORDER BY 1;


## INNER JOIN - NON EQUI JOIN
-- 모든 사원의 급여 등급 조회 
SELECT ename, sal FROM emp;
SELECT grade FROM salgrade;

SELECT ename, sal, grade AS 호봉
FROM   emp JOIN salgrade
ON     sal BETWEEN losal AND hisal 
ORDER BY 3;

-- sal의 grade 별로 인원 수가 3 이상인 레코드만 조회
SELECT grade AS 호봉, COUNT(grade) 인원
FROM   emp JOIN salgrade
ON     sal BETWEEN losal AND hisal 
GROUP BY 1
HAVING COUNT(grade) >= 3
ORDER BY 1;

## 테이블 세 개 조인
-- 모든 사원의 dname, ename, sal, grade를 조회 
SELECT dname, ename, sal, grade
FROM   emp e INNER JOIN dept d   -- 테이블 이름의 별칭 지정
ON     e.deptno = d.deptno
JOIN   salgrade
ON     sal BETWEEN losal AND hisal 
ORDER BY 1;


### INNER JOIN - SELF JOIN --------
-- 모든 사원의 관리자 번호와 이름 조회
SELECT e.empno 사원번호, e.ename 사원이름, 
	   m.empno 매니저번호, m.ename 매니저이름
FROM   emp e JOIN emp m
ON     e.mgr = m.empno   -- mgr이 없는 데이터는 제외됨 >> OUTER JOIN으로          
ORDER BY 1;



### OUTER JOIN 
-- 모든 사원의 관리자 번호와 이름 조회 - mgr이 없는 데이터 포함
SELECT e.empno 사원번호, e.ename 사원이름, 
	   m.empno 매니저번호, m.ename 매니저이름
FROM   emp e LEFT OUTER JOIN emp m -- 값이 있는 쪽에 표시
-- 왼쪽에 사원은 있고      오른쪽에 매니저는 없는
ON     e.mgr = m.empno           
ORDER BY 1;


-- 모든 사원의 deptno, dname, ename 조회
-- 단, 사원이 없는 부서는 이름에 -----로 표시
SELECT d.deptno, d.dname, IFNULL(e.ename, '-----') ENAME
FROM   emp e RIGHT JOIN dept d
ON     e.deptno = d.deptno
ORDER BY 1;


## INLINE VIEW ##########################
-- 10번 부서의 deptno, dname, ename 조회
SELECT e.deptno, dname, ename
FROM   ( SELECT * FROM emp WHERE deptno = 10 ) e,
       ( SELECT * FROM dept ) d
WHERE  e.deptno = d.deptno;



###################################################
## INSERT
-- 모든 컬럼에 데이터 입력 i
INSERT INTO t_emp( empno, ename, deptno, sal, hiredate )
           VALUES( 1000, 'Kim', 40, 1000, '2020-10-10' );

-- 모든 컬럼에 데이터 입력 ii
INSERT INTO t_emp
--         VALUES( 1000, 'Kim', 40, 1000, '2020-10-10' );  -- pk 중복 불가
		   VALUES( 2000, 'Kim', 40, 1000, '2020-10-10' );
           
-- 특정 컬럼에 데이터 입력 i
INSERT INTO t_emp( empno, ename, hiredate )
		   VALUES( 3000, 'Sam', NOW() );            
           
-- 특정 컬럼에 데이터 입력 ii
INSERT INTO t_emp( ename, hiredate )
           VALUES( 'Saa', NOW() ); 

           
-- 서브 쿼리로 여러 행 데이터 입력
INSERT INTO t_emp
SELECT empno, ename, deptno, sal, hiredate
FROM   emp
WHERE  deptno = 10;   -- 10번 부서의 데이터만 선택하여 삽입           
           
-- 테스트 데이터 - 기본 키 중복 
INSERT IGNORE INTO t_emp( empno, ename ) VALUES( 9000, 'tester'); 
INSERT IGNORE INTO t_emp( empno, ename ) VALUES( 9000, 'tester'); 
INSERT IGNORE INTO t_emp( empno, ename ) VALUES( 9001, 'tester'); 
INSERT IGNORE INTO t_emp( empno, ename ) VALUES( 9002, 'tester');            
        
        
### CTAS ; Create Table As Select
CREATE TABLE t_emp2
AS
SELECT empno, ename, hiredate
FROM   emp;	
        
        
### autocommit 여부 확인
SHOW VARIABLES LIKE 'autocommit';     

-- autocommit off 설정
SET autocommit = 0;    

-- 트랜잭션 시작 명시
START transaction;
        
        
 
 
######## UPDATE SET
-- 모든 데이터 수정
UPDATE t_emp SET deptno = 50;
ROLLBACK;  -- 실행 취소 

-- 특정 컬럼 하나의 값 변경
-- deptno가 널이면 90으로 변경
UPDATE t_emp SET deptno = 90 WHERE deptno IS NULL;
COMMIT;    -- DB 반영

-- 복수의 컬럼 값 변경
-- deptno가 90이고 hiredate가 널이면 
-- sal는 9000으로, hiredate는 지금 시점으로 수정
UPDATE t_emp SET sal = 9000, hiredate = NOW()
WHERE  deptno = 90 AND hiredate IS NULL;
COMMIT;
-- 기본 키 중복 시 데이터 변경 처리

 
INSERT INTO t_emp( empno, ename ) VALUES( 9001, 'tester')
  ON DUPLICATE KEY UPDATE ename = 'uploader1'; 

INSERT INTO t_emp( empno, ename ) VALUES( 9002, 'tester');  

COMMIT;

 
-- 모든 데이터 삭제
DELETE FROM t_emp;

-- 조건에 일치하는 모든 행 삭제        
DELETE FROM t_emp WHERE deptno = 90;
rollback;


        
           
SELECT * FROM t_emp;
SELECT * FROM t_emp2;
SELECT * FROM emp;
SELECT * FROM dept;
SELECT * FROM t_member;
SELECT * FROM salgrade;






