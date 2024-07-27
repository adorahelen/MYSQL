USE employees;
SELECT 
    EMPNO,
    ENAME,
    JOB,
    JSON_OBJECT('EMPNO',
            empno,
            'ENAME',
            ename,
            'JOB',
            job) AS json_data
FROM
    emp;
    
########## CROSS JOIN ########
SELECT * FROM emp CROSS JOIN dept;

#### Inner Join - Equi JOin

SELECT deptno, ename, sal FROM emp;
SELECT deptno, dname FROM dept;

SELECT emp.deptno, emp.ename, sal, dept.deptno, dept.dname
FROM emp INNER JOIN dept
ON emp.deptno = dept.deptno
ORDER BY 1;

-- 테이블 이름의 별칭을 이용하여 조인 

SELECT e.deptno, e.ename, sal, d.deptno, d.dname
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
ORDER BY 1;


-- 검색 조건을 지정하여 조인 - 10번 부서만 조회
SELECT e.deptno, e.ename, sal, d.deptno, d.dname
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
WHERE e.deptno = 10
ORDER BY 1;

-- INNER JOIN - NON equi JOIN : all empl s grade 
SELECT ename, sal  FROM emp;
SELECT grade FROM salgrade;

SELECT ename, sal, grade 
FROM emp JOIN salgrade
ON  sal BETWEEN losal AND hisal 
ORDER BY 3;


-- sal grade 별로 인원 수가 3 이상인 레코드 조회 
SELECT grade AS 호봉, COUNT(grade) 인원
FROM emp JOIN salgrade 
ON sal BETWEEN losal AND hisal 
GROUP BY grade
HAVING COUNT(grade) >= 3
ORDER BY 1;

-- 테이블 세개 조인 
SELECT dname, ename, sal, grade
FROM emp e INNER JOIN dept d
ON e.deptno = d.deptno
JOIN salgrade 
ON sal BETWEEN losal AND hisal
ORDER BY 1;

-- Inner Join - Self Join --
-- 모든 사원의 관리자 번호와 이름 조회
SELECT e.empno 사원번호 , e.ename 사원이름 , m.mgr 매니저번호, m.ename 매니저이름
FROM emp e JOIN emp m
ON e.mgr = m.empno -- mgr이 없는 데이터는 제외됨 
ORDER BY 1; 

### OUter join 
-- 모든 사원의 데이터 조회 igmnore mgr ㅡ
SELECT e.empno MAN, e.ename MANname,
m.empno MnagerNumber, m.ename ManageName
FROM emp e LEFT OUTER JOIN emp m 
ON e.mgr = m.empno
ORDER BY 1; 

-- 모든 사원의 deptno, dname, ename 조회
-- 단, 사원이 없는 부서도 조회 name is -----
SELECT d.deptno, d.dname, IFNULL(e.ename, '-----') ENAME
FROM emp e RIGHT JOIN dept d
ON e.deptno = d.deptno
ORDER BY 1;

## VIEW -- INLINE
-- 10 deptno, dname, ename
SELECT e.deptno, dname, ename
FROM ( SELECT * FROM emp WHERE deptno = 10 ) e,
(SELECT * FROM dept) d
WHERE e.deptno = d.deptno; 

