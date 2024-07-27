-- #SELECT * FROM shopdb.t_product;

-- -- SHOW databases;
-- -- USE shopdb;
-- -- SHOW TABLES;
-- -- DESC t_member;

-- ######################
-- -- 모든 칼럼 초기화
-- use employees; -- 임플로이스 데이터베이스/스키마 지정 
-- select * from emp;
-- select * from emp limit 5; -- 출력 행의 수 지정 

-- -- 복수의 컬럼 조회 
-- SELECT ename, job FROM emp limit 10;

-- -- 단일 컴럼 조회 
-- SELECT job From emp; -- All is 생략 되어 있음 
-- SELECT ALL job FROM emp;

-- -- 중복 제거 조회 
-- SELECT distinct job FROM emp;

-- -- 컴럼명 별칭
-- SELECT ename AS name FROM emp;
-- SELECT ename 이름 FROM emp;
-- SELECT ename "이   름" FROM emp;
-- select ename '이 름' from emp;
-- SELECT ename "\"NAME\":이름" FROM emp;
-- SELECT ename, '   ' 기타 FROM emp;  -- 존재하지 않는 컬럼 만들어서 표시 가능
-- SELECT ename, 'etc' 기타 FROM emp;

-- SELECT ename, sal, sal * 0.1, sal*0.1 AS bonus FROM emp;


-- -- 정렬 
-- SELECT ename, job FROM emp;
-- SELECT ename, job FROM emp ORDER BY ename; -- ASC 생략 - 기본 오름차순
-- SELECT ename, job FROM emp ORDER BY ename ASC; 
-- SELECT ename, job FROM emp ORDER BY ename DESC; -- 내림차순
--  
--  SELECT job, ename 
--  FROM emp
--  ORDER BY job DESC, ename ASC;
--  
--   SELECT job, ename 
--  FROM emp
--  ORDER BY 1 DESC, 2 ASC; -- 컬럼명 대신 순서 지정 가능 
--  
--  -- 조건 지정 
--  -- =, !=, <>, >, >=, <, <= 
--  -- AND, OR, NOT 
--  -- 잡이 메니저인 레코드만 조회 
-- SELECT * FROM emp WHERE job = 'MANAGE'; --  문자 조건 지정 (단일 따움표로 해야함) 

-- -- empno 가 7566 인 레코드 조회 
-- SELECT * FROM emp WHERE empno = 7566;  -- 숫자 조건 지정 
--  
--  -- hiredate 가 1987년 이전인 레코드 조회하기 
-- SELECT * FROM emp WHERE hiredate < '1987-01-01' ;

-- -- job이 Manage 이고 hiredate가 1987년 이전인 레코드 조회 
-- SELECT * FROM emp WHERE job = 'manager' && hiredate < '1987-01-01'; -- AND 도 가능 

-- -- hiredate 가 1981년이 아닌 레코드 조회 
-- SELECT * FROM emp WHERE NOT(hiredate  >= '1981-01-01' AND hiredate <= '1981-12-31');
-- 				
-- -- dname 이 RESEARCH 이거나 SALES인 레코드 조회 
-- SELECT * FROM dept WHERE dname = 'RESEARCH' OR dname = 'SALES'; 

-- -- In 연산자 사용 
-- SELECT * FROM dept WHERE dname IN ('research', 'sales');
-- SELECT * FROM dept WHERE dname NOT IN ('research', 'sales');


-- -- sal 이 2000이상 ~ 3000이하인 레코드 조회 
-- SELECT * FROM emp WHERE sal >= 2000 AND sal < 3000;
-- SELECT * FROM emp WHERE sal BETWEEN 2000 AND 2999;

-- -- 문자열 검색 --------
-- -- LIKE 한 글자 매치 _ , 0 또는 여러 글자 일치 % 
-- -- 이름이 A가 포함된 레코드 조회 
-- SELECT * FROM emp WHERE ename LIKE '%A%'; -- 이름에 에이가 포함된 친구
-- SELECT * FROM emp WHERE ename LIKE '_A%'; -- 이름 두번째 에이가 포함된 친구
-- SELECT * FROM emp WHERE ename LIKE 'A%'; -- 이름에 에이가 포함된 친구

-- -- NULL 데이터 조회 
-- 	-- COMM 이 NULL인 레코드 
-- SELECT * FROM emp WHERE comm = NULL; -- 불가능 
-- SELECT * FROM emp WHERE comm IS NOT NULL; -- can 
-- -- only can use English when did you Paste C / V 
-- -- When did you equals something USE 'IS NOT or IS' 

-- ## Join the Result 
-- SELECT deptno, job FROM emp WHERE job = 'CLERK' AND deptno = 10
-- UNION -- Delete dupe
-- SELECT deptno, job FROM emp WHERE job = 'CLERK' AND deptno = 20;

-- SELECT deptno, job FROM emp WHERE job = 'CLERK' AND deptno = 10
-- UNION ALL -- No delete print All 
-- SELECT deptno, job FROM emp WHERE job = 'CLERK' AND deptno = 20;


-- ####### 내장 함수 #########
-- -- String () 
-- SELECT ASCII('a') FROM dual;
-- SELECT ASCII('A');
-- SELECT CHAR(65);

-- -- Length () 
-- SELECT bit_length('ㄱㄴㄷ'), CHAR_LENGTH('ㄱㄴㄷ'), LENGTH('abc222');
-- SELECT bit_length('abc'), CHAR_LENGTH('ㄱㄴㄷ'), LENGTH('abc222');

-- -- concat
-- SELECT ename, 
-- concat(sal, 'won') SALLL, 
-- CONCAT(ename, '-', job, sal) NAME_LEVEL_MONEY,
-- CONCAT_WS('-', ename, job, sal) NAME_LEVEL_MONEY FROM emp;


-- -- deptno = 20, Recod : job Sort
-- SELECT * FROM emp WHERE deptno = 20 ORDER BY FIELD (job, 'MANAGE', 'ANALYST', 'CLERK');

-- -- when print 1000 
-- -- SELECT sal, FORMAT(sal, 0) FMT1, format(sal, 2)FMT2

-- -- STRINF 
-- SELECT LEFT('ABCDEFG', 3) LEFT22, RIGHT('VWXYZ', 2) RIGHT22, MID('12345', 3, 2);

-- -- upper <-> lower
-- SELECT ename, LOWER(job), UPPER('level') FROM emp;

-- -- pill
-- SELECT deptno, LPAD(deptno, 3, 0), RPAD(deptno, 3, 0) FROM emp;

-- -- DELETE String -- ABC --
-- SELECT LENGTH('  ABC   '), LENGTH( LTRIM('  ABC   ') ) DELTL ;
--  -- SELECT LENGTH('  ABC   '), RENGTH( LTRIM('  ABC   ') ) DELTr ;
-- --  SELECT LENGTH('  ABC   '), LENGTH( TRIM('  ABC   ') ) DELTall ;

-- return String 
SELECT ename, job, REPLACE(job, 'PRESIDENT', 'CEO') FROM emp;

-- ename s 2 ~ 3 make *** 
SELECT ename, INSERT (ename, 2, 3, '***')FROM emp;

SELECT substring('Hello', 3, 2);


############ Number Fnction() 
SELECT sal * 0.3333,
CEIL (sal * 0.3333) c, 
CEILING(sal * 0.3333) cc,
FLOOR(sal * 0.3333) F,
ROUND(sal * 0.3333) R,
MOD(sal, 3) M,
sal % 3,
sal MOD 3,
TRUNCATE(sal * 0.3333, 1) t1 FROM emp;


### DATE fun()

-- SELECT SYSDATE(), NOW(), -- ...


-- type change
SELECT '1' + '2', CONCAT(1, 2), 1 > 2, 1 < 2;

SELECT CAST('2024-01-02' AS DATE) TO_DATE, CAST(SYSDATE() AS CHAR) To_CHAR;

-- inpust String change to MYSQL data && time format 
SELECT STR_TO_DATE('01, 5, 2024', '%d, %m, %Y');

#### SYSTEM info () 
SELECT USER(), DATABASE ();

#### flow Control INner fun()
-- IF (condition , ture , false) == 3 hang op
-- IF NULL (con1 con2)  1 is Null => DO con2
-- NULL IF  (con1 con2 ) 1 and 2 == SAME, NULL : !=, DO s1

SELECT ename, job, IF (job IN ('SALESMAN' ,'CLERK' ), 'Sawon' , 'CHEK') FROM emp ORDER BY 3 DESC;

-- comm이 0이면 NULL, not comm
-- comm == NULL , make 999
SELECT ename, comm, NULLIF (comm, 0) FROM emp;
SELECT ename, comm, IFNULL (comm = 0, 999) FROM emp;

-- CSSE WHEN THEN ELSE 
SELECT ename, sal, job,
CASE WHEN job = 'CLERK' THEN 0.1 
	WHEN job = 'SALESMAN' THEN 0.2 
    ELSE 0.01 END * sal AS bonus,
    
    CASE job WHEN 'CLERK' THEN 0.1 
				WHEN 'SALESMAN' THEN 0.2 
				ELSE 0.01 END * sal AS bonus2
                
                FROM emp;
                
                
### Groub fun()

SELECT COUNT(*) ALLs ,
		COUNT(comm) NoneNull2,
        COUNT( DISTINCT mgr) exceptDUP
FROM emp;

SELECT SUM( comm ) SUMS,
sum( comm ) / count(*) AVG11, -- Include NULL => 157.1429
 AVG(comm) avg22,  -- except NULL => 550
 AVG( ifnull(comm, 0)) avg33,
 MAX(comm),
 MIN(comm)
FROM emp;











