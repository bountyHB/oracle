---------------------------------------------------------------------
-- 실습 문제
-- 도서관리 프로그램을 만들기 위한 테이블 만들기
-- 이때, 제약조건에 이름을 부여하고, 각 컬럼에 주석 달기


-- 1. 출판사들에 대한 데이터를 담기 위한 출판사 테이블(TB_PUBLISHER) 
--  1) 컬럼 : PUB_NO(출판사 번호) -- 기본 키
--           PUB_NAME(출판사명) -- NOT NULL
--           PHONE(출판사 전화번호) -- 제약조건 없음

CREATE TABLE TB_PUBLISHER (
   PUB_NO NUMBER CONSTRAINT PUBLISHER_NO_PK PRIMARY KEY,
   PUB_NAME VARCHAR2(20) CONSTRAINT PUBLISHER_NAME_NN NOT NULL,
   PHONE NUMBER
);

COMMENT ON COLUMN TB_PUBLISHER.PUB_NO IS '출판사 번호';
COMMENT ON COLUMN TB_PUBLISHER.PUB_NAME IS '출판사명';
COMMENT ON COLUMN TB_PUBLISHER.PHONE IS '출판사 전화번호';

SELECT * FROM TB_PUBLISHER;

--  2) 3개 정도의 샘플 데이터 추가하기
INSERT INTO TB_PUBLISHER VALUES(001,'기억출판사', 12345678);
INSERT INTO TB_PUBLISHER VALUES(002,'니은출판사', 12345678);
INSERT INTO TB_PUBLISHER VALUES(003,'디귿출판사', 12345678);

DROP TABLE TB_PUBLISHER;

-- 2. 도서들에 대한 데이터를 담기 위한 도서 테이블 (TB_BOOK)
--  1) 컬럼 : BK_NO (도서번호) -- 기본 키
--           BK_TITLE (도서명) -- NOT NULL
--           BK_AUTHOR(저자명) -- NOT NULL
--           BK_PRICE(가격)
--           BK_PUB_NO(출판사 번호) -- 외래 키 (TB_PUBLISHER 테이블을 참조하도록)
--                                  이때 참조하고 있는 부모 데이터 삭제 시 자식 데이터도 삭제 되도록 옵션 지정
CREATE TABLE TB_BOOK (
   BK_NO NUMBER PRIMARY KEY,
   BK_TITLE VARCHAR2(20) CONSTRAINT BK_TITLE_NN NOT NULL,
   BK_AUTHOR VARCHAR2(20) CONSTRAINT BK_AUTHOR_NN NOT NULL,
   BK_PRICE NUMBER,
   BK_PUB_NO NUMBER CONSTRAINT TB_PUBLISHER_FK REFERENCES TB_PUBLISHER 
);

COMMENT ON COLUMN TB_BOOK.BK_NO IS '도서번호';
COMMENT ON COLUMN TB_BOOK.BK_TITLE IS '도서명';
COMMENT ON COLUMN TB_BOOK.BK_AUTHOR IS '저자명';
COMMENT ON COLUMN TB_BOOK.BK_PRICE IS '가격';
COMMENT ON COLUMN TB_BOOK.BK_PUB_NO IS '출판사 번호';


--  2) 5개 정도의 샘플 데이터 추가하기
INSERT INTO TB_BOOK VALUES (01,'가나다','김삿갓',5000, 001);
INSERT INTO TB_BOOK VALUES (02,'라마바','홍길동',5000, 002);
INSERT INTO TB_BOOK VALUES (03,'사아자','이몽룡',5000, 003);
INSERT INTO TB_BOOK VALUES (04,'차카타','성춘향',5000, 001);
INSERT INTO TB_BOOK VALUES (05,'파하','심청이',5000, 002);

SELECT * FROM TB_BOOK;
DROP TABLE TB_BOOK;
-- 3. 회원에 대한 데이터를 담기 위한 회원 테이블 (TB_MEMBER)
--  1) 컬럼 : MEMBER_NO(회원번호) -- 기본 키
--           MEMBER_ID(아이디)   -- 중복 금지
--           MEMBER_PWD(비밀번호) -- NOT NULL
--           MEMBER_NAME(회원명) -- NOT NULL
--           GENDER(성별)        -- 'M' 또는 'F'로 입력되도록 제한
--           ADDRESS(주소)       
--           PHONE(연락처)       
--           STATUS(탈퇴 여부)     -- 기본값으로 'N'  그리고 'Y' 혹은 'N'으로 입력되도록 제약조건
--           ENROLL_DATE(가입일)  -- 기본값으로 SYSDATE, NOT NULL

CREATE TABLE TB_MEMBER(
   MEMBER_NO NUMBER CONSTRAINT MEM_NO_PK PRIMARY KEY,
   MEMBER_ID VARCHAR2(20) CONSTRAINT MEM_ID_UQ UNIQUE,
   MEMBER_PWD NUMBER CONSTRAINT MEM_PWD_NN NOT NULL,
   MEMBER_NAME VARCHAR2(15) CONSTRAINT MEM_NAME_NN NOT NULL,
   GENDER VARCHAR2(10) CONSTRAINT GENDER_CH CHECK(GENDER IN ('M','F')),       
   ADDRESS VARCHAR2(20),      
   PHONE NUMBER,       
   STATUS VARCHAR2(10) DEFAULT ('N') CONSTRAINT STATUS_CH CHECK(STATUS IN ('Y','N')), 
   ENROLL_DATE DATE DEFAULT SYSDATE CONSTRAINT EMROLL_DATE_NN NOT NULL
);

COMMENT ON COLUMN TB_MEMBER.MEMBER_NO IS '회원번호';
COMMENT ON COLUMN TB_MEMBER.MEMBER_ID IS '아이디';
COMMENT ON COLUMN TB_MEMBER.MEMBER_PWD IS '비밀번호';
COMMENT ON COLUMN TB_MEMBER.MEMBER_NAME IS '회원명';
COMMENT ON COLUMN TB_MEMBER.GENDER IS '성별';
COMMENT ON COLUMN TB_MEMBER.ADDRESS IS '주소';
COMMENT ON COLUMN TB_MEMBER.PHONE IS '연락처';
COMMENT ON COLUMN TB_MEMBER.STATUS IS '탈퇴 여부';
COMMENT ON COLUMN TB_MEMBER.ENROLL_DATE IS '가입일';

--  2) 3개 정도의 샘플 데이터 추가하기

INSERT INTO TB_MEMBER VALUES (001, 'ABCD', 1234, '김삿갓', 'F', '서울시', 8782034, 'N', '22-05-08');
INSERT INTO TB_MEMBER VALUES (002, 'EFGH', 1234, '홍길동', 'M', '부산시', 8781234, 'Y', '22-05-02');
INSERT INTO TB_MEMBER VALUES (005, 'IJKL', 1234, '이몽룡', 'M', '제주시', 8782334, 'N', '22-05-05');

SELECT * FROM TB_MEMBER;

-- 4. 도서를 대여한 회원에 대한 데이터를 담기 위한 대여 목록 테이블(TB_RENT)
--  1) 컬럼 : RENT_NO(대여번호) -- 기본 키
--           RENT_MEM_NO(대여 회원번호) -- 외래 키 (TB_MEMBER와 참조하도록)
--                                      이때 부모 데이터 삭제 시 NULL 값이 되도록 옵션 설정
--           RENT_BOOK_NO(대여도서번호) -- 외래 키 ( TB_BOOK와 참조하도록)
--                                      이때 부모 데이터 삭제 시 NULL 값이 되도록 옵션 설정
--           RENT_DATE(대여일) -- 기본값 SYSDATE
CREATE TABLE TB_RENT (
   RENT_NO NUMBER CONSTRAINT RENT_NO_PK PRIMARY KEY,
   RENT_MEM_NO NUMBER CONSTRAINT RENT_MEM_NO_FK REFERENCES TB_MEMBER,
   RENT_BOOK_NO NUMBER CONSTRAINT RENT_BOOK_NO_FK REFERENCES TB_BOOK,
   RENT_DATE DATE DEFAULT SYSDATE
);


--  2) 샘플 데이터 3개 정도 


-- 5. 2번 도서를 대여한 회원의 이름, 아이디, 대여일, 반납 예정일(대여일 + 7일)을 조회하시오


-- 6. 회원번호가 1번인 회원이 대여한 도서들의 도서명, 출판사명, 대여일, 반납예정일을 조회하시오


----------------------------------------------------------------------------------------------------------------