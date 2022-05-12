/*
   <제약조건>
      사용자가 원하는 조건의 데이터만 유지하기 위해서 테이블 작성 시 각 컬럼에 대해 제약조건을 설정할 수 있다.
      제약조건은 데이터 무결성 보장을 목적으로 한다. (데이터의 정확성과 일관성을 유지시키는 것)
      
      1. NOT NULL 제약조건
         해당 컬럼에 반드시 값이 있어야만 하는 경우에 사용한다.
         삽입 / 수정 시 NULL 값을 허용하지 않도록 제한한다.
*/


-- 기존 MEMBER 테이블은 값에 NULL이 있어도 행의 추가가 가능하다.
INSERT INTO MEMBER VALUES(NULL, NULL, NULL, NULL);

-- 테이블 삭제
DROP TABLE MEMBER;

-- NOT NULL 제약조건을 설정한 테이블 생성
CREATE TABLE MEMBER (
   ID VARCHAR2(20) NOT NULL,
   PASSWORD VARCHAR2(20) NOT NULL,
   NAME VARCHAR2(15) NOT NULL,
   ENROLL_DATE DATE DEFAULT SYSDATE
);

-- NOT NULL 제약조건에 위배되어 오류 발생
INSERT INTO MEMBER VALUES(NULL, NULL, NULL, NULL);

-- NOT NULL 제약조건이 걸려있는 컬럼에는 반드시 값이 있어야 한다.
INSERT INTO MEMBER VALUES('USER1', '1234', '홍길동', NULL);
INSERT INTO MEMBER VALUES('USER1', '1234', '홍길동', SYSDATE);
INSERT INTO MEMBER VALUES('USER1', '1234', '홍길동', DEFAULT);
INSERT INTO MEMBER (ID, PASSWORD, NAME) VALUES('USER1', '1234', '홍길동');

-- 테이블의 데이터를 수정하는 SQL 구문
UPDATE MEMBER
SET ID = NULL
WHERE NAME = '홍길동';

-- 제약조건 확인
-- 사용자가 작성한 제약조건을 확인하는 뷰 테이블이다.
SELECT *
FROM USER_CONSTRAINTS;

-- 사용자가 작성한 제약조건이 걸려있는 컬럼을 확인하는 뷰 테이블이다.
SELECT *
FROM USER_CONS_COLUMNS;

-- 필요한 부분만 JOIN 하여 구문 작성 
SELECT UC.CONSTRAINT_NAME, 
       UC.TABLE_NAME, 
       UCC.COLUMN_NAME, 
       UC.CONSTRAINT_TYPE
FROM USER_CONSTRAINTS UC
JOIN USER_CONS_COLUMNS UCC ON (UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
WHERE UC.TABLE_NAME = 'MEMBER';