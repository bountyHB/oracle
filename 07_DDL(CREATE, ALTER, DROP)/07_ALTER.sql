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







/*
      4) 이름명 변경 (RENAME)
         ALTER TABLE 테이블명 RENAME COLUMN 기존 컬럼명 TO 변경할 컬럼명;
*/






