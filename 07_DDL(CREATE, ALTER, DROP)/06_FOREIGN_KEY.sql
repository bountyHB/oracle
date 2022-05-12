/*
   5. FOREIGN KEY(왜래 키) 제약조건
      - 다른 테이블에 존재하는 값만을 가져야하는 컬럼에 부여하는 제약조건이다. (단, NULL 값도 가질 수 있다.)
        즉, 외래 키로 참조한 컬럼의 값만 기록할 수 있다.
      
      1) 컬럼 레벨
         컬럼명 자료형(크기) [CONSTRAINT 제약조건명] REFERENCES 참조할테이블명[(기본 키)] [삭제룰]         
         
      2) 테이블 레벨
         [CONSTRAINT 제약조건명] FOREIGN KEY(컬럼명) REFERENCES 참조할테이블명[(기본 키)] [삭제룰]
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


-- 자식 테이블 생성
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
   -- 테이블 레벨 방식
-- CONSTRAINT MEMBER_GRADE_ID_FK FOREIGN KEY (GRADE_ID) REFERENCES MEMBER_GRADE /*(GRADE_CODE)*/, -- 생략가능
   CONSTRAINT MEMBER_AGE_CH CHECK(AGE > 0)
);

-- 어디선가 MEMBER_GRADE를 참조하고 있으면 삭제되지 않는다.
-- 참조중인 MEMBER 테이블을 먼저 삭제해야 가능
DROP TABLE MEMBER_GRADE;

SELECT * FROM MEMBER_GRADE;
SELECT * FROM MEMBER;

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