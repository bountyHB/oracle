/*
   5. FOREIGN KEY(왜래 키) 제약조건
      - 다른 테이블에 존재하는 값만을 가져야하는 컬럼에 부여하는 제약조건이다. (단, NULL 값도 가질 수 있다.)
        즉, 외래 키로 참조한 컬럼의 값만 기록할 수 있다.
      
      1) 컬럼 레벨
         컬럼명 자료형(크기) [CONSTRAINT 제약조건명] REFERENCES 참조할테이블명[(기본 키)] [삭제룰]         
         
      2) 테이블 레벨
         [CONSTRAINT 제약조건명] FOREIGN KEY(컬럼명) REFERENCES 참조할테이블명[(기본 키)] [삭제룰]

			* 삭제룰
         부모 테이블의 데이터가 삭제되었을 때의 옵션을 지정할 수 있다.
         
         1) ON DELETE RESTRICT (기본값)
         : 자식 테이블의 참조 키가 부모 테이블의 키 값을 참조하는 경우 부모 테이블의 행을 삭제할 수 없다. (기본값)
         
         2) ON DELETE SET NULL
         : 부모 테이블의 데이터 삭제시 참조하고 있는 자식 테이블의 컬럼 값이 NULL로 변경된다.
         
         3) ON DELETE CASCADE
         : 부모 테이블의 데이터 삭제시 참조하고 있는 자식 테이블의 행 전체가 삭제된다.


*/


-- 부모 테이블 생성
-- 회원 등급에 대한 데이터를 보관하는 테이블
CREATE TABLE MEMBER_GRADE (
   GRADE_CODE NUMBER,
   GRADE_NAME VARCHAR2 (20) NOT NULL,
   CONSTRAINT MEMBER_GRADE_PK PRIMARY KEY(GRADE_CODE)
);

INSERT INTO MEMBER_GRADE VALUES (10, '일반회원');
INSERT INTO MEMBER_GRADE VALUES (20, '우수회원');
INSERT INTO MEMBER_GRADE VALUES (30, '특별회원');


-- (1) 자식 테이블 생성 (ON DELETE RESTRICT)(기본값)
DROP TABLE MEMBER

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
   -- 테이블 레벨 방식
-- CONSTRAINT MEMBER_GRADE_ID_FK FOREIGN KEY (GRADE_ID) REFERENCES MEMBER_GRADE /*(GRADE_CODE)*/,
-- 기본 키 지정 생략가능
   CONSTRAINT MEMBER_AGE_CH CHECK(AGE > 0)
);

-- 어디선가 MEMBER_GRADE를 참조하고 있으면 삭제되지 않는다.
-- 참조중인 MEMBER 테이블을 먼저 삭제해야 가능
DROP TABLE MEMBER_GRADE;

SELECT * FROM MEMBER_GRADE;
SELECT * FROM MEMBER;

-- MEMBER_GRADE 테이블에서 GRADE_CODE가 10인 데이터 지우기
-- 자식테이블에서 참조하고 있는 값이 있으면 부모테이블에 있는 행은 삭제 불가
DELETE FROM MEMEBER_GRADE WHERE GRADE_CODE = 10; 
-- 참조하고 있지 않는 행은 삭제 가능
DELETE FROM MEMEBER_GRADE WHERE GRADE_CODE = 30; 

-- 방금 한 작업 취소
ROLLBACK;


-- (2) 자식 테이블 생성 (ON DELETE SET NULL)
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
   NO NUMBER,
   ID VARCHAR2(20) NOT NULL,
   PASSWORD VARCHAR2(20) NOT NULL,
   NAME VARCHAR2(15) NOT NULL,
   GENDER CHAR(3),
   AGE NUMBER,
   GRADE_ID NUMBER CONSTRAINT MEMBER_GRADE_ID_FK REFERENCES MEMBER_GRADE (GRADE_CODE) ON DELETE SET NULL,
   ENROLL_DATE DATE DEFAULT SYSDATE,
   CONSTRAINT MEMBER_NO_PK PRIMARY KEY(NO), 
   CONSTRAINT MEMBER_ID_UQ UNIQUE(ID),
   CONSTRAINT MEMBER_GENGER_CK CHECK(GENDER IN ('남','여')),
   CONSTRAINT MEMBER_AGE_CH CHECK(AGE > 0)
);

-- 데이터 넣기
INSERT INTO MEMBER VALUES(1, 'USER1', '1234', '김삿갓', '남', 24, 10, DEFAULT);
INSERT INTO MEMBER VALUES(2, 'USER2', '1234', '성춘향', '여', 18, NULL, DEFAULT);

-- MEMBER_GRADE 테이블에서 GRADE_CODE가 10인 데이터 지우기
DELETE FROM MEMBER_GRADE WHERE GRADE_CODE = 10; 

-- 자식 테이블을 조회해 보면 삭제된 행을 참조하고 있던 컬럼의 값이 NULL로 변경되어 있다.
SELECT * FROM MEMBER;
-- 첫번째 행이 NULL로 채워져 있다.
SELECT * FROM MEMBER_GRADE;

-- 되돌리기
ROLLBACK;
-- 롤백하면 원래대로 1행이 되돌아옴
SELECT * FROM MEMBER_GRADE;
-- 롤백해도 데이터 입력후 커밋을 안했기 때문에 MEMBER 는 확인해도 아무것도 없음
SELECT * FROM MEMBER;


-- (3) 자식 테이블 생성 (ON DELETE CASCADE)
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
   NO NUMBER,
   ID VARCHAR2(20) NOT NULL,
   PASSWORD VARCHAR2(20) NOT NULL,
   NAME VARCHAR2(15) NOT NULL,
   GENDER CHAR(3),
   AGE NUMBER,
   GRADE_ID NUMBER CONSTRAINT MEMBER_GRADE_ID_FK REFERENCES MEMBER_GRADE (GRADE_CODE) ON DELETE CASCADE,
   ENROLL_DATE DATE DEFAULT SYSDATE,
   CONSTRAINT MEMBER_NO_PK PRIMARY KEY(NO), 
   CONSTRAINT MEMBER_ID_UQ UNIQUE(ID),
   CONSTRAINT MEMBER_GENGER_CK CHECK(GENDER IN ('남','여')),
   CONSTRAINT MEMBER_AGE_CH CHECK(AGE > 0)
);

-- 데이터 넣기
INSERT INTO MEMBER VALUES(1, 'USER1', '1234', '김삿갓', '남', 24, 10, DEFAULT);
INSERT INTO MEMBER VALUES(2, 'USER2', '1234', '성춘향', '여', 18, NULL, DEFAULT);

-- MEMBER_GRADE 테이블에서 GRADE_CODE가 10인 데이터 지우기
DELETE FROM MEMBER_GRADE WHERE GRADE_CODE = 10; 

-- 자식 테이블을 조회해 보면 삭제된 행을 참조하고 있던 컬럼의 행 전체가 삭제되어 있다.
SELECT * FROM MEMBER;
-- 첫번째 행이 삭제되어있다.
SELECT * FROM MEMBER_GRADE;

-- 되돌리기
ROLLBACK;
-- 롤백하면 원래대로 1행이 되돌아옴
SELECT * FROM MEMBER_GRADE;
-- 롤백해도 데이터 입력후 커밋을 안했기 때문에 MEMBER 는 확인해도 아무것도 없음
SELECT * FROM MEMBER;


-- 외래 키 제약조건
INSERT INTO MEMBER VALUES(1, 'USER1', '1234', '김삿갓', '남', 24, 10, DEFAULT);
-- 50이라는 값이 MEMBER_GRADE 테이블에 GRADE_CODE 컬럼에서 제공하는 값이 아니므로 외래 키 제약조건에 위배되어 에러 발생
-- parent key not found 에러 발생
INSERT INTO MEMBER VALUES(2, 'USER2', '1234', '성춘향', '여', 18, 50, DEFAULT);
-- GRADE_ID 컬럼에 NULL 사용 가능
INSERT INTO MEMBER VALUES(3, 'USER3', '1234', '홍길동', '남', 30, NULL, DEFAULT);


-- 실습문제
-- MEMBER 테이블과 MEMBER_GRADE 테이블을 조인하여 아이디, 이름, 회원 등급을 조회
SELECT M.ID, M.NAME, MG.GRADE_NAME
FROM MEMBER M
LEFT JOIN MEMBER_GRADE MG ON (M.GRADE_ID = MG.GRADE_CODE);

-- 제약조건 확인
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