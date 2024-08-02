# MySQL

1. 0725
- ( MySQL 8.0.39 ), (Workbench 8.0.34), (OS MAC)
- https://dev.mysql.com/downloads/mysql/
- https://downloads.mysql.com/archives/workbench/
- 데이터베이스 => sample data (employees.sql)
- mysql -u root -p : 입력 후 패스워드 입력
- (대소문자 상관없음, 구분 X)
- SHOW DATABASES;
- source employees.sql
- USE employees;
- SHOW tables;
- SELECT * FROM BONUS;
- SELECT * FROM DEPT;
- SELECT * FROM EMP;
- SELECT * FROM SALGRADE;
- select, Where, group by


<img width="461" alt="image" src="https://github.com/user-attachments/assets/84986b53-98a5-40ed-97b6-bf0a4efaaea3">


2. 0726
- JOIN (Cross : table1 + table2), (equi / Nonequi : 일치 /비일치 데이터), (self : table1행 + table1행)
- InnerJoin / OuterJoin : 아직 이해 못함
- INSERT 문 
- (AUTO_increment : 키값을 입력하지 않아도 자동으로 1씩 증가되게 함
- transaction : Start transaction(시작) => commit(종료:반영) / Rollback(복귀)
- autocommit : SHOW VARIABLES LIKE 'AUTTOCOMMIT'; (오토커밋 상태 확인)
- set autocommit = 0; 해제 / set autocommit = 1; 설정
- Update 문
- delete 문 (행단위로 데이터 삭제, 테이블 삭제의 경우 delete<truncate<drop)
  
   
3. [데이터정의(테이블), 데이터컨트롤, 트랜잭션컨트롤, 데이터조작]
- DDL : data definition [Create,Alter,Drop : 생성/수정/삭제]
- DCL : data Control [Grant,Revoke : 권한부여/회수]
- TCI : Transaction Control [start transaction, commit, rollback]
- DML : data Manipulation [ Select, insert, update, delete]


4. 0729 (복습 병행)
- MySQL = 오픈소스라서 완벽하지 않을 수 있음 (ex: MAC 튕김 현상)
- 제공된 employees DB는 전통적으로 MySQL에서 제공하는 DB
- MySQL에서만, 데이터베이스 생성 == 스키마 생성 
- MySQL은 기본적으로 테이블 이름, 칼럼 이름등을 모두 소문자로 처리함
- 워크벤치는 세미콜론 필수아님, CLI에서는 필수 
- 맥 호환성 문제로 실패한 부분은, 챕터4 ERD 실습 부분;
    (다이어그램을 테이블로 변환 ↔ DB를 다이어그램으로 변환)
    * 모델링 소프트웨어는 그 밖에도 많이 존재함
-SSL : 보완을 위한 암호 규약, 서버와 클라이언트 통신시 암호화를 시켜줌 



5. 0730
- 학습곡선  : 데이터베이스 개념 → JDBC → 스프링/부트 → JPA :
   
<img width="401" alt="image" src="https://github.com/user-attachments/assets/b4c08003-f5b4-4539-a0eb-143da11a66be">

6. 0802
   



