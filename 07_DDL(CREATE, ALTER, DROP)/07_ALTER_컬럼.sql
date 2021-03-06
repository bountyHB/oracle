/*
   <ALTER>
      오라클에서 제공하는 객체를 수정하는 구문이다.    
*/


-- 실습에 사용할 테이블 생성
CREATE TABLE DEPT_COPY 
AS SELECT *
   FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;


/*
   1. 컬럼 추가 / 수정 / 삭제 / 이름 변경

   1) 컬럼 추가 (ADD)
      ALTER TABLE 테이블명 ADD 컬럼명 데이터타입(크기) [DEFAULT 기본값];
*/


-- CNAME 컬럼을 기본값을 지정하지 않고 추가
-- 기본값을 지정하지 않으면 새로 추가된 컬럼은 NULL 값으로 채워진다.
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);

-- LNAME 컬럼을 기본값을 지정하여 추가
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '대한민국';

SELECT * FROM DEPT_COPY;


/*
   2) 컬럼 수정 (MODIFY)
      ALTER TABLE 테이블명 MODIFY 컬럼명 변경할데이터타입;
      ALTER TABLE 테이블명 MODIFY 컬럼명 DEFALUT 기본값;
*/


-- DEPT_ID 컬럼의 데이터 타입을 CHAR(2) -> CHAR(3) 으로 변경
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);
-- 더 작은 값으로의 변경은 데이터 손실이 일어나기 때문에 불가
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(2);
-- 컬럼에 값이 없으면 데이터타입 변경이 가능하다
ALTER TABLE DEPT_COPY MODIFY CNAME NUMBER;

-- DEPT_COPY 테이블에서 
-- DEPT_TITLE 컬럼의 데이터 타입을 VARCHAR2(40)
ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(40);
-- LOCATION_ID 컬럼의 데이터 타입을 VARCHAR2(2)
ALTER TABLE DEPT_COPY MODIFY LOCATION_ID VARCHAR2(2);
-- LNAME 컬럼의 기본값을 미국으로 변경하기
ALTER TABLE DEPT_COPY MODIFY LNAME DEFAULT '미국';

-- 다중 수정
ALTER TABLE DEPT_COPY 
MODIFY DEPT_TITLE VARCHAR2(40)
MODIFY LOCATION_ID VARCHAR2(2)
MODIFY LNAME DEFAULT '미국';

-- LNAME은 여전히 대한민국으로, 데이터가 바뀌지는 않는다.
-- 그러나 다음에 추가되는 값들은 NULL일시 DEFAULT인 미국으로 저장되게 된다.
SELECT * FROM DEPT_COPY;


/*
   3) 컬럼 삭제 (DROP)
      ALTER TABLE 테이블명 DROP COLUMN 컬럼명;
*/


-- DEPT_ID 컬럼 지우기
ALTER TABLE DEPT_COPY DROP COLUMN DEPT_ID;

SELECT * FROM DEPT_COPY;

-- DDL 구문에서는 ROLLBACK으로 복구가 되지 않는다.
ROLLBACK; 

-- 최소 한 개의 컬럼은 존재해야 한다.
ALTER TABLE DEPT_COPY DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY DROP COLUMN LOCATION_ID;
ALTER TABLE DEPT_COPY DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY DROP COLUMN LNAME; -- 삭제되지 않음

SELECT *
FROM MEMBER_GRADE;

SELECT *
FROM MEMBER;

-- 자식테이블에서 참조되고 있는 컬럼이 있다면 삭제가 불가능하다.
ALTER TABLE MEMBER_GRADE DROP COLUMN GRADE_CODE;

-- 컬럼에 걸려있는 제약조건까지 지워버리면 삭제가 가능해진다.
ALTER TABLE MEMBER_GRADE DROP COLUMN GRADE_CODE CASCADE CONSTRAINTS;


SELECT * FROM DEPT_COPY;


/*
   4) 컬럼명 변경 (RENAME)
      ALTER TABLE 테이블명 RENAME COLUMN 기존 컬럼명 TO 변경할 컬럼명;
*/


-- DEPT_COPY 테이블의 LNAME 컬럼명을 LOCATION_NAME으로 변경
ALTER TABLE DEPT_COPY RENAME COLUMN LNAME TO LOCATION_NAME;

SELECT *
FROM DEPT_COPY;

DROP TABLE DEPT_COPY;
DROP TABLE MEMBER;
DROP TABLE MEMBER_GRADE;