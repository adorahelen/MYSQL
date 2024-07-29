USE modeldb;

-- create table 
CREATE TABLE t_member ( 
mid 	varchar(20) 	PRIMARY KEY,
mname 	VARCHAR(20) 	NOT NULL,
mpw   	VARCHAR(20) 	NOT NULL,
email 	VARCHAR (50) 	NOT NULL  UNIQUE,
gender 	CHAR(1) 		CHECK(gender IN('M', 'F')),
photo	VARCHAR(50) 	DEFAULT 'default.png',
birth_date DATE,
join_date DATE DEFAULT(current_date)
); 


-- table level condition declare
CREATE TABLE t_board(
bno	INT AUTO_INCREMENT,
title	varchar(100) NoT NULL,
content varchar(4000) NOT NULL,
writter Varchar(20) NOT NULL,
-- references t_member(mid), 외래키는 컬럼 레벨에서 제약 조건 지정 못함 (당연하지, 테이블에서 해야지)

hit int default 0,
write_date DATE default(Current_date),

constraint pk_t_board PRiMARY key(bno)
);

CREATE TABLE t_reply(
rno int auto_increment,
bno int NOT NULL,  
reply varchar(1000) NOT NULL,
replier varchar(20) NOT NULL,
reply_date date default(current_date),

	constraint primary key(rno),
	constraint fk_reply_bno foreign key(bno) references t_board(bno),
    constraint foreign key(replier) references t_member(mid)
    );
    
    USE employees;
    Drop TABLE t_temp2;
    -- 모든 데이터 카피, 하지만 제약조건은 제외
    CREATE TABLE t_emp2 AS SELECT * FROM emp;
    SELECT * from t_emp2;
    
    CREATE TABLE t_emp3 as select empno, ename, hiredate from emp;
    
    CREATE TABLE t_emp4 AS SELECT * from emp Where 1=0;
    
    ##### 
    CREATE temporary table if not exists
    temp1 (id INT, name char(10) );
    select *from temp1;
    
INSERT INTO temp1 Values (1, 'lee');
insert into temp1 values (2, 'park');

use modelDB;
DROP TABLE table2; -- 1부터 지우기 안됬던 이유는 2에서 참조중이라서 2 -> 1 순으로 삭제 진행 함

Alter table t_board ADD constraint fk_board_writer
foreign key(writter)
references t_member(mid);	

use employees;

Alter table t_emp ADD work Varchar(10); 
Alter table t_emp ADD mgr Int AFTER deptno; 
Alter table t_emp ADD seq Int first; 
Alter table t_emp rename column work to part;
alter table t_emp drop column seq;
Alter table t_emp Modify part varchar(20);
select *from t_emp;

-- alter of key
Alter table t_emp drop primary key;
-- declare key
alter table t_emp2 add constraint pk_emp2 primary key(empno);
alter table t_emp2 Drop primary key;



ALter table t_emp add constraint fk_t_emp foreign key(empno) references emp(empno);
-- 부모 테이블에 없는 데이터가 있어서 , 제약 조건 추가 불가능 

Alter table t_emp modify empno Int;
Alter table t_emp drop primary key;

Desc t_emp;
use employees;
Alter table t_emp2 add constraint pk_emp2 primary key(empno);
alter table t_emp add constraint fk_t_emp foreign key(empno) references emp(empno);

-- 
delete from t_emp;

Insert into t_emp(empno, enamel) values (1111, 'San');
Insert into t_emp(empno, enamel) values (7788, 'San');
Insert into t_emp(empno, enamel) values (9000, 'Han');

delete from emp where empno = 9000;
rollback;

-- Alter table t_emp add constraint fk_t_emp, foregin key(empno) references emp(empno) in delete set NULL;

Alter table t_emp Drop primary key;
alter table t_emp modify empno int NULL;

Alter table t_emp add constraint fk_t_emp_del foreign key(empno) references emp(empno) on delete cascade;

Insert into t_emp(empno, enamel) value(7900, 'san');
Alter table t_emp add constraint uq_ename UNIQUE(enamel);

DELETE from T_emp where empno = 7900;
INsert into t_emp(empno, enamel) value(7900, 'san');

Alter table t_emp Drop index uq_ename;

Alter table t_emp ADD constraint chk_deptno CHECK (deptno >= 10);
UPdate t_emp set deptno = 10 where empno = 7900;

ALTER TABLE t_emp modify hiredate DATE NOT NULL;

Alter table t_emp modify sal Int default 0;

alter table. t_emp modify hiredate date not null;
update t_emp set hiredate = '1900-01-01' where hiredate is null;

alter table t_emp modify hiredate date NULL;
rename table t_emp to t_employee;

CREATE table test ( num int primary key);
create table test2 (num int, constraint fk_num foreign key(num) references test(num) on delete cascade );
Insert into test values( 111);
insert into test values (222);

insert into test2 values (111);

Delete from test where num = 111;

select * from test;
select *from test2;
-- cascade 로 엮어놔서 하나 지웠을때 같이 지워짐 (참조하는 거 까지같이 지우)


DROP table test;
DROP table test2;
 CREATE table test ( num int primary key);
create table test2 (num int, constraint fk_num foreign key(num) references test(num) );
Insert into test values( 111);
insert into test values (222);

insert into test2 values (111);

Delete from test where num = 111;

select *from test;
-- 1. 참조를 제거 2. 참조 데이터를 제거 3. 두 테이블 모두 제거 
Alter table test2 DROP constraint fk_num; -- 참조를 제거
Drop table test;
delete from test;
rollback;


