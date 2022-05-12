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


-- 위에서 추가한 데이터를 실제 데이터베이스에 반영한다.
-- (메모리 버퍼에 임시 저장된 데이터를 실제 테이블에 반영한다.)
COMMIT;

-- 오토 커밋은 꺼놓는게 좋다
SHOW AUTOCOMMIT;
SET AUTOCOMMIT ON;


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


/*
   2. UNIQUE 제약조건
      컬럼에 입력 값이 중복된 값을 가질 수 없도록 제한하는 제약조건이다.
*/


-- 아이디가 중복되어도 성공적으로 데이터가 삽입된다.
INSERT INTO MEMBER VALUES('USER1', '1234', '김삿갓', DEFAULT);
INSERT INTO MEMBER VALUES('USER1', '1234', '이몽룡', DEFAULT);

-- 테이블 삭제
DROP TABLE MEMBER;

-- 테이블 생성 (+ UNIQUE 조건)
CREATE TABLE MEMBER (
   ID VARCHAR2(20) NOT NULL UNIQUE,
   PASSWORD VARCHAR2(20) NOT NULL,
   NAME VARCHAR2(15) NOT NULL,
   ENROLL_DATE DATE DEFAULT SYSDATE
);

-- 정상적으로 INSERT 됨
INSERT INTO MEMBER VALUES('USER1', '1234', '김삿갓', DEFAULT);
-- UNIQUE 제약조건에 위배되어 INSERT 실패
INSERT INTO MEMBER VALUES('USER1', '1234', '이몽룡', DEFAULT);

-- 어떤 것이 위배되었는지 확인 할 수 있으나, 직관적이지 않음
SELECT UC.CONSTRAINT_NAME, 
       UC.TABLE_NAME, 
       UCC.COLUMN_NAME, 
       UC.CONSTRAINT_TYPE
FROM USER_CONSTRAINTS UC
JOIN USER_CONS_COLUMNS UCC ON (UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
WHERE UC.TABLE_NAME = 'MEMBER';

-- 테이블 삭제
DROP TABLE MEMBER;

-- 테이블 생성 (+ UNIQUE 조건)
-- UNIQUE 조건을 테이블 레벨로 지정하는 방식
-- 제약조건에 이름을 주어, 제약조건이 걸렸을 시 알아보기 쉽게 할 수 있다.
CREATE TABLE MEMBER (
   NO NUMBER CONSTRAINT MEMBER_NO_NN NOT NULL,
   ID VARCHAR2(20) CONSTRAINT MEMBER_ID_NN NOT NULL,
   PASSWORD VARCHAR2(20) CONSTRAINT MEMBER_PASSWORD_NN NOT NULL,
   NAME VARCHAR2(15) CONSTRAINT MEMBER_NAME_NN NOT NULL,
   ENROLL_DATE DATE DEFAULT SYSDATE,
   CONSTRAINT MEMBER_ID_UQ UNIQUE(ID) -- 테이블 레벨로 지정하는 방식
);

-- 정상적으로 INSERT 됨
INSERT INTO MEMBER VALUES('USER1', '1234', '김삿갓', DEFAULT);
-- 위배된 제약조건에 네이밍된 것이 출력
INSERT INTO MEMBER VALUES('USER1', '1234', '이몽룡', DEFAULT);

-- 어떤 것이 위배되었는지 확인 할 때 네이밍된 것이 출력
SELECT UC.CONSTRAINT_NAME, 
       UC.TABLE_NAME, 
       UCC.COLUMN_NAME, 
       UC.CONSTRAINT_TYPE
FROM USER_CONSTRAINTS UC
JOIN USER_CONS_COLUMNS UCC ON (UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
WHERE UC.TABLE_NAME = 'MEMBER';


-- 여러 개의 컬럼을 묶어서 하나의 UNIQUE 제약조건으로 설정할 수 있다. (단, 반드시 테이블 레벨로만 설정이 가능하다.)
-- 테이블 삭제
DROP TABLE MEMBER;

-- 테이블 생성 
CREATE TABLE MEMBER (
   NO NUMBER NOT NULL,
   ID VARCHAR2(20) NOT NULL,
   PASSWORD VARCHAR2(20) NOT NULL,
   NAME VARCHAR2(15) NOT NULL,
   ENROLL_DATE DATE DEFAULT SYSDATE,
   CONSTRAINT MEMBER_NO_ID_UQ UNIQUE(NO, ID)
);

-- 정상적으로 INSERT 됨
INSERT INTO MEMBER VALUES(1, 'USER1', '1234', '김삿갓', DEFAULT);
-- NO가 같고 ID가 같은 경우 : 오류
INSERT INTO MEMBER VALUES(1, 'USER1', '1234', '이몽룡', DEFAULT);
-- NO가 같고 ID가 다른 경우 : 오류
INSERT INTO MEMBER VALUES(1, 'USER1', '1234', '이몽룡', DEFAULT);
-- NO가 다르고 ID가 같은 경우 : 정상적으로 INSERT 됨
INSERT INTO MEMBER VALUES(2, 'USER1', '1234', '이몽룡', DEFAULT);


-- 묶여있는 컬럼들의 제약조건이 같게 나옴
-- 두개 컬럼의 값이 완전히 동일해야 제약조건에 걸림
SELECT UC.CONSTRAINT_NAME, 
       UC.TABLE_NAME, 
       UCC.COLUMN_NAME, 
       UC.CONSTRAINT_TYPE
FROM USER_CONSTRAINTS UC
JOIN USER_CONS_COLUMNS UCC ON (UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
WHERE UC.TABLE_NAME = 'MEMBER';


/*
   3. CHECK 제약조건
      컬럼에 기록되는 값에 조건을 설정하고 조건을 만족하는 값만 기록할 수 있다.
      비교 값은 리터럴만 사용이 가능하다. 변하는 값이나 함수는 사용할 수 없다.
      
      CHECK (비교연산자)
         CHECK(컬럼 [NOT] IN (값, 값, ...))
         CHECK(컬럼 BETWEEN 값 AND 값) 
         CHECK(컬럼 >= 값 AND 컬럼 <= 값) 
         CHECK(컬럼 LIKE '_문자') 
         ...
*/


DROP TABLE MEMBER;

CREATE TABLE MEMBER (
   NO NUMBER NOT NULL,
   ID VARCHAR2(20)  NOT NULL,
   PASSWORD VARCHAR2(20) NOT NULL,
   NAME VARCHAR2(15) NOT NULL,
   GENDER CHAR(3),
   AGE NUMBER,
   ENROLL_DATE DATE DEFAULT SYSDATE,
   CONSTRAINT MEMBER_ID_UQ UNIQUE(ID) 
);

-- 성별, 나이에 유효한 값이 아닌 값들도 INSERT 된다.
INSERT INTO MEMBER VALUES(1, 'USER1', '1234', '김삿갓', '남', 24, DEFAULT);
INSERT INTO MEMBER VALUES(2, 'USER2', '1234', '성춘향', '여', 18, DEFAULT);
INSERT INTO MEMBER VALUES(3, 'USER3', '1234', '홍길동', '강', 30, DEFAULT);
INSERT INTO MEMBER VALUES(4, 'USER4', '1234', '이몽룡', '남', -20, DEFAULT);

-- 제약 조건을 걸어 다시 생성
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
   NO NUMBER NOT NULL,
   ID VARCHAR2(20)  NOT NULL,
   PASSWORD VARCHAR2(20) NOT NULL,
   NAME VARCHAR2(15) NOT NULL,
   GENDER CHAR(3) CONSTRAINT MEMBER_GENGER_CK CHECK(GENDER IN ('남','여')), -- 리터럴 값만 가능
   AGE NUMBER,
   ENROLL_DATE DATE DEFAULT SYSDATE,
   CONSTRAINT MEMBER_ID_UQ UNIQUE(ID),
   CONSTRAINT MEMBER_AGE_CH CHECK(AGE > 0)
);


INSERT INTO MEMBER VALUES(1, 'USER1', '1234', '김삿갓', '남', 24, DEFAULT);
INSERT INTO MEMBER VALUES(2, 'USER2', '1234', '성춘향', '여', 18, DEFAULT);
-- GENDER 컬럼에 CHECK 제약조건으로 '남' 또는 '여'만 입력 가능하도록 설정이 되었기 때문에 에러가 발생한다.
INSERT INTO MEMBER VALUES(3, 'USER3', '1234', '홍길동', '강', 30, DEFAULT);
-- AGE 컬럼에 CHECK 제약조건으로 0보다 큰 값만 입력 가능하도록 설정이 되었기 때문에 에러가 발생한다.
INSERT INTO MEMBER VALUES(4, 'USER4', '1234', '이몽룡', '남', -20, DEFAULT);

COMMIT;

-- 업데이트할 때 조건을 주지 않으면 모든 행이 변경됨
UPDATE MEMBER
SET AGE = 10;

ROLLBACK; -- 최근에 커밋했던 시점으로 되돌아 감

-- 조건을 주어 업데이트
-- 제약조건 위배되어 불가능
UPDATE MEMBER
SET AGE = -10
WHERE ID = 'USER1';

SELECT UC.CONSTRAINT_NAME, 
       UC.TABLE_NAME, 
       UCC.COLUMN_NAME, 
       UC.CONSTRAINT_TYPE,
       UC.SEARCH_CONDITION
FROM USER_CONSTRAINTS UC
JOIN USER_CONS_COLUMNS UCC ON (UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
WHERE UC.TABLE_NAME = 'MEMBER';


/*
   4. PRIMARY KEY(기본 키) 제약조건
      - 테이블에서 한 행의 정보를 식별하기 위해 사용할 컬럼에 부여하는 제약조건이다.
      - 기본 키 제약조건을 설정하게 되면 자동으로 해당 컬럼에 NOT NULL, UNIQUE 제약조건이 설정된다.
      - 한 테이블에 한 개만 설정할 수 있다. (단, 한 개 이상의 컬럼을 묶어서 기본 키 제약조건을 설정할 수 있다.)

      - ID나 주민번호같이 비즈니스 로직에 영향을 주는 키들은 자연키라고 한다.
      - NO같이 비즈니스 로직에 영향을 주지 않는 키들을 대리키, 대체키라고 한다.
      - 주로 비즈니스와 관련없는 숫자값 (대리키)를 기본키로 사용한다.
*/


DROP TABLE MEMBER;

CREATE TABLE MEMBER (
   NO NUMBER,
--   NO NUMBER PRIMARY KEY, 컬럼레벨 방식
   ID VARCHAR2(20)  NOT NULL,
   PASSWORD VARCHAR2(20) NOT NULL,
   NAME VARCHAR2(15) NOT NULL,
   GENDER CHAR(3),
   AGE NUMBER,
   ENROLL_DATE DATE DEFAULT SYSDATE,
   CONSTRAINT MEMBER_NO_PK PRIMARY KEY(NO), --테이블레벨 방식
   CONSTRAINT MEMBER_ID_UQ UNIQUE(ID),
   CONSTRAINT MEMBER_GENGER_CK CHECK(GENDER IN ('남','여')),
   CONSTRAINT MEMBER_AGE_CH CHECK(AGE > 0)
);


INSERT INTO MEMBER VALUES(1, 'USER1', '1234', '김삿갓', '남', 24, DEFAULT);
INSERT INTO MEMBER VALUES(2, 'USER2', '1234', '성춘향', '여', 18, DEFAULT);
INSERT INTO MEMBER VALUES(3, 'USER3', '1234', '홍길동', '남', 30, DEFAULT);
INSERT INTO MEMBER VALUES(4, 'USER4', '1234', '이몽룡', '남', 20, DEFAULT);
-- 기본 키 중복으로 오류
INSERT INTO MEMBER VALUES(4, 'USER5', '1234', '심청이', '여', 16, DEFAULT);
-- 기본 키가 NULL 이므로 오류
INSERT INTO MEMBER VALUES(NULL, 'USER5', '1234', '심청이', '여', 16, DEFAULT);


SELECT UC.CONSTRAINT_NAME, 
       UC.TABLE_NAME, 
       UCC.COLUMN_NAME, 
       UC.CONSTRAINT_TYPE,
       UC.SEARCH_CONDITION
FROM USER_CONSTRAINTS UC
JOIN USER_CONS_COLUMNS UCC ON (UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
WHERE UC.TABLE_NAME = 'MEMBER';

SELECT * FROM MEMBER; 

--
DROP TABLE MEMBER;

-- 테이블 키를 두번 적용했기 때문에 오류가 난다.
CREATE TABLE MEMBER (
--   NO NUMBER,
   NO NUMBER PRIMARY KEY, --컬럼레벨 방식
   ID VARCHAR2(20)  NOT NULL,
   PASSWORD VARCHAR2(20) NOT NULL,
   NAME VARCHAR2(15) NOT NULL,
   GENDER CHAR(3),
   AGE NUMBER,
   ENROLL_DATE DATE DEFAULT SYSDATE,
   CONSTRAINT MEMBER_NO_PK PRIMARY KEY(NO), --테이블레벨 방식
   CONSTRAINT MEMBER_ID_UQ UNIQUE(ID),
   CONSTRAINT MEMBER_GENGER_CK CHECK(GENDER IN ('남','여')),
   CONSTRAINT MEMBER_AGE_CH CHECK(AGE > 0)
);


--
DROP TABLE MEMBER;

-- 컬럼을 묶어서 하나의 기본 키를 생성 (복합키)
-- (NO, ID를 묶음)

CREATE TABLE MEMBER (
   NO NUMBER,
   ID VARCHAR2(20),
   PASSWORD VARCHAR2(20) NOT NULL,
   NAME VARCHAR2(15) NOT NULL,
   GENDER CHAR(3),
   AGE NUMBER,
   ENROLL_DATE DATE DEFAULT SYSDATE,
   CONSTRAINT MEMBER_NO_ID_PK PRIMARY KEY(NO, ID), 
   CONSTRAINT MEMBER_ID_UQ UNIQUE(ID),
   CONSTRAINT MEMBER_GENGER_CK CHECK(GENDER IN ('남','여')),
   CONSTRAINT MEMBER_AGE_CH CHECK(AGE > 0)
);

INSERT INTO MEMBER VALUES(1, 'USER1', '1234', '김삿갓', '남', 24, DEFAULT);
INSERT INTO MEMBER VALUES(2, 'USER2', '1234', '성춘향', '여', 18, DEFAULT);
INSERT INTO MEMBER VALUES(3, 'USER3', '1234', '홍길동', '남', 30, DEFAULT);
INSERT INTO MEMBER VALUES(4, 'USER4', '1234', '이몽룡', '남', 20, DEFAULT);
INSERT INTO MEMBER VALUES(4, 'USER5', '1234', '심청이', '여', 16, DEFAULT);
-- 회원번호, 아이디가 세트로 동일한 값이 이미 존재하기 때문에 에러가 발생한다.
INSERT INTO MEMBER VALUES(4, 'USER5', '1234', '심청이', '여', 16, DEFAULT);
-- 기본 키로 설정된 컬럼에 둘 중에 NULL 값이 하나라도 있으면 에러가 발생한다. 
INSERT INTO MEMBER VALUES(NULL, 'USER5', '1234', '심청이', '여', 16, DEFAULT);
INSERT INTO MEMBER VALUES(5, NULL, '1234', '심청이', '여', 16, DEFAULT);


/*
   5. FOREIGN KEY(왜래 키) 제약조건
      - 다른 테이블에 존재하는 값만을 가져야하는 컬럼에 부여하는 제약조건이다. (단, NULL 값도 가질 수 있다.)
        즉, 외래 키로 참조한 컬럼의 값만 기록할 수 있다.
      
      1) 컬럼 레벨
         컬럼명 자료형(크기) [CONSTRAINT 제약조건명] REFERENCES 참조할테이블명[(기본 키)] [삭제룰]         
         
      2) 테이블 레벨
         [CONSTRAINT 제약조건명] FOREIGN KEY(컬럼명) REFERENCES 참조할테이블명[(기본 키)] [삭제룰]
*/


-- 회원 등급에 대한 데이터를 보관하는 테이블 (부모 테이블)
CREATE TABLE MEMBER_GRADE (
   GRADE_CODE NUMBER,
   GRADE_NAME VARCHAR2 (20) NOT NULL,
   CONSTRAINT MEMBER_GRADE_PK PRIMARY KEY(GRADE_CODE)
);

INSERT INTO MEMBER_GRADE VALUES (10, '일반회원');
INSERT INTO MEMBER_GRADE VALUES (20, '우수회원');
INSERT INTO MEMBER_GRADE VALUES (30, '특별회원');

DROP TABLE MEMBER;

CREATE TABLE MEMBER (
   NO NUMBER,
   ID VARCHAR2(20) NOT NULL,
   PASSWORD VARCHAR2(20) NOT NULL,
   NAME VARCHAR2(15) NOT NULL,
   GENDER CHAR(3),
   AGE NUMBER,
   -- 컬럼 레벨 방식
   -- MEMBER_GRADE를 참조하여,
   -- GRADE_ID는 GRADE_CODE에 있는 값만 가질 수 있게 된다.
   GRADE_ID NUMBER CONSTRAINT MEMBER_GRADE_ID_FK REFERENCES MEMBER_GRADE (GRADE_CODE),
   ENROLL_DATE DATE DEFAULT SYSDATE,
   CONSTRAINT MEMBER_NO_PK PRIMARY KEY(NO), 
   CONSTRAINT MEMBER_ID_UQ UNIQUE(ID),
   CONSTRAINT MEMBER_GENGER_CK CHECK(GENDER IN ('남','여')),
   --테이블 레벨 방식
-- CONSTRAINT MEMBER_GRADE_ID_FK FOREIGN KEY (GRADE_ID) REFERENCES MEMBER_GRADE /*(GRADE_CODE)*/, -- 생략가능
   CONSTRAINT MEMBER_AGE_CH CHECK(AGE > 0)
);

DROP TABLE MEMBER_GRADE; -- 어디선가 MEMBER_GRADE를 참조하고 있으면 삭제되지 않는다.
-- 참조중인 MEMBER 테이블을 먼저 삭제해야 가능

SELECT * FROM MEMBER_GRADE;
SELECT * FROM MEMBER;

INSERT INTO MEMBER VALUES(1, 'USER1', '1234', '김삿갓', '남', 24, 10, DEFAULT);
-- 50이라는 값이 MEMBER_GRADE 테이블에 GRADE_CODE 컬럼에서 제공하는 값이 아니므로 외래 키 제약조건에 위배되어 에러 발생
-- parent key not found 에러 발생
INSERT INTO MEMBER VALUES(2, 'USER2', '1234', '성춘향', '여', 18, 50, DEFAULT);
-- GRADE_ID 컬럼에 NULL 사용 가능
INSERT INTO MEMBER VALUES(3, 'USER3', '1234', '홍길동', '남', 30, NULL, DEFAULT);

-- MEMBER 테이블과 MEMBER_GRADE 테이블을 조인하여 아이디, 이름, 회원 등급을 조회
SELECT M.ID, M.NAME, MG.GRADE_NAME
FROM MEMBER M
LEFT JOIN MEMBER_GRADE MG ON (M.GRADE_ID = MG.GRADE_CODE);

SELECT UC.CONSTRAINT_NAME, 
       UC.TABLE_NAME, 
       UCC.COLUMN_NAME, 
       UC.CONSTRAINT_TYPE,
       UC.SEARCH_CONDITION
FROM USER_CONSTRAINTS UC
JOIN USER_CONS_COLUMNS UCC ON (UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
WHERE UC.TABLE_NAME LIKE 'MEMBER%';


SELECT *
FROM USER_CONSTRAINTS UC
JOIN USER_CONS_COLUMNS UCC ON (UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
WHERE UC.TABLE_NAME LIKE 'MEMBER%';




