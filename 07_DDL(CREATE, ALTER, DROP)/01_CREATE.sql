/*
   <DDL(Data Definition Language)> 
      데이터 정의 언어로 오라클에서 제공하는 객체를 생성하고, 변경하고, 삭제하는 등
      실제 데이터 값이 아닌 데이터의 구조 자체를 정의하는 언어이다. (DB 관리자, 설계자)   

   <CREATE>
      데이터베이스 객체(테이블, 뷰, 사용자 등)를 생성하는 구문이다.
      
   <테이블 생성>
      CREATE 객체종류 테이블명(
         컬럼명 자료형(크기) [DEFAULT 기본값] [제약조건]
      );
      
      CREATE TABLE 테이블명(
         컬럼명 자료형(크기) [DEFAULT 기본값] [제약조건],
         컬럼명 자료형(크기) [DEFAULT 기본값] [제약조건],
         컬럼명 자료형(크기) [DEFAULT 기본값] [제약조건],
         ...
      );
*/


-- 회원에 대한 데이터를 담을 수 있는 MEMBER 테이블 생성
CREATE TABLE MEMBER (
   ID VARCHAR2(20), -- 영어로는 20글자, 한글로는 6글자
   PASSWORD VARCHAR2(20),
   NAME VARCHAR2(15),
   ENROLL_DATE DATE DEFAULT SYSDATE
);

-- 테이블에 대한 컬럼정보 확인
-- 테이블의 구조를 표시해 주는 구문이다.
DESC MEMBER;


/*
   데이터 딕셔너리
      - 데이터베이스에 있는 자원을 효율적으로 관리하기 위해서 다양한 객체들의 정보를 저장하는 시스템 테이블이다.
      - 데이터 딕셔너리는 사용자가 객체를 생성하거나 변경하는 등의 작업을 할 때,
        데이터베이스에 의해서 자동으로 갱신되는 테이블이다.
      - 데이터에 관한 데이터가 저장되어 있어서 메타 데이터라고도 한다.
      
   USER_TABLES      : 사용자가 가지고 있는 테이블의 구조를 확인하는 뷰 테이블이다.
   USER_TAB_COLUMNS : 테이블이나 뷰가 가지고 있는 컬럼과 관련된 정보를 조회하는 뷰 테이블이다.
*/


SELECT * 
FROM USER_TABLES;

SELECT * 
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'MEMBER';


/*
   <컬럼 주석>
      테이블 컬럼에 대한 설명을 작성할 수 있는 구문이다.
      
      COMMNET ON COLUMN 테이블명.컬럼명 IS '주석내용';
*/


COMMENT ON COLUMN MEMBER.ID IS '회원 아이디';
COMMENT ON COLUMN MEMBER.PASSWORD IS '회원 비밀번호';
COMMENT ON COLUMN MEMBER.NAME IS '회원 이름';
COMMENT ON COLUMN MEMBER.ENROLL_DATE IS '회원 가입일';


-- 테이블에 샘플 데이터 추가
-- DML(INSERT)을 사용해서 만들어진 테이블에 샘플 데이터를 추가할 수 있다.
-- INSERT INTO 테이블명 [(컬럼명, ..., 컬럼명)]VALUES (값, ..., 값)
-- 값에는 컬럼의 갯수, 순서, 타입이 일치해야 한다.
-- 컬럼명을 생략하면 모든 컬럼에다가 추가하게 된다

INSERT INTO MEMBER VALUES ('USER1', '1234', '홍길동', '2022-05-12'); -- 모든 컬럼에다가 데이터를 넣는다
INSERT INTO MEMBER VALUES ('USER2', '1234', '김삿갓', SYSDATE);
INSERT INTO MEMBER VALUES ('USER3', '1234', '이몽룡', DEFAULT);
-- DEFAULT SYSDATE로 생성했기때문에 날짜가 생성되어있음
INSERT INTO MEMBER(ID, PASSWORD) VALUES ('USER4', '1234'); 


-- 커밋
-- 위에서 추가한 데이터를 실제 데이터베이스에 반영한다.
-- (메모리 버퍼에 임시 저장된 데이터를 실제 테이블에 반영한다.)
COMMIT;

-- 오토 커밋은 꺼놓는게 좋다
SHOW AUTOCOMMIT;
SET AUTOCOMMIT ON;


/*
   <서브 쿼리를 이용한 테이블 생성>
      컬럼명, 데이터 타입, 값 등이 그대로 복사되지만, 
      제약조건의 경우 NOT NULL 제약조건을 제외한 나머지 제약조건은 복사되지 않는다.
*/


-- EMPLOYEE 테이블을 복사한 새로운 테이블 생성 (컬럼명, 데이터 타입, 값, NOT NULL 제약 조건을 복사)
CREATE TABLE EMPLOYEE_COPY
AS SELECT *
   FROM EMPLOYEE;

SELECT *
FROM EMPLOYEE_COPY;

-- MEMBER 테이블을 복사한 새로운 테이블 생성
CREATE TABLE MEMBER_COPY
AS SELECT *
   FROM MEMBER;

SELECT *
FROM MEMBER_COPY;


-- 테이블의 데이터를 제외한, 테이블의 구조만 복사하고 싶을 때
-- EMPLOYEE 테이블을 복사한 새로운 테이블 생성 (컬럼명, 데이터 타입, NOT NULL 제약조건을 복사)
CREATE TABLE EMPLOYEE_COPY2
AS SELECT *
   FROM EMPLOYEE
   WHERE 1 = 0; -- 모든 행에 대해서 매번 FALSE 이기 때문에 테이블의 구조만 복사되고 데이터 값은 복사되지 않는다.


-- 테이블에서 특정 조건을 걸어 복사하고 싶을 때
-- EMPLOYEE 테이블에서 사번, 직원명, 급여, 연봉을 저장하는 테이블 생성
CREATE TABLE EMPLOYEE_COPY3
AS SELECT EMP_ID "사번", 
          EMP_NAME "직원명", 
          SALARY "급여", 
          SALARY*12 "연봉" -- 산술식이 들어갔을 시 반드시 별칭 필요
   FROM EMPLOYEE;


DROP TABLE EMPLOYEE_COPY;
DROP TABLE EMPLOYEE_COPY2;
DROP TABLE EMPLOYEE_COPY3;
DROP TABLE MEMBER_COPY;