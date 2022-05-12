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

-- 테이블 삭제
DROP TABLE MEMBER;

-- 테이블 생성
CREATE TABLE MEMBER (
   NO NUMBER  NOT NULL,
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


-- (1) 테이블 생성 (CHECK 제약조건)
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
   NO NUMBER  NOT NULL,
   ID VARCHAR2(20)  NOT NULL,
   PASSWORD VARCHAR2(20) NOT NULL,
   NAME VARCHAR2(15) NOT NULL,
   GENDER CHAR(3) CONSTRAINT MEMBER_GENGER_CK CHECK(GENDER IN ('남','여')), -- 리터럴 값만 가능
   AGE NUMBER,
   ENROLL_DATE DATE DEFAULT SYSDATE,
   CONSTRAINT MEMBER_ID_UQ UNIQUE(ID),
   CONSTRAINT MEMBER_AGE_CH CHECK(AGE > 0)  -- 테이블 레벨로 지정
);

-- 정상적으로 INSERT 됨 
INSERT INTO MEMBER VALUES(1, 'USER1', '1234', '김삿갓', '남', 24, DEFAULT);
-- 정상적으로 INSERT 됨
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
-- 제약조건에 위배되어 불가능
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
WHERE UC.TABLE_NAME LIKE 'MEMBER';