/*
   <DML(Data Manipulation Language)>
      데이터 조작 언어로 테이블에 값을 삽입, 수정, 삭제하는 구문이다.

   <INSERT>
      테이블에 새로운 행을 추가하는 구문이다.
      
      1) INSERT INTO 테이블명 VALUES(값, 값, 값, ..., 값);
         : 테이블의 모든 컬럼에 대한 값을 INSERT 하고자 할 때 사용한다.
           컬럼 순분을 지켜서 VALUES에 값을 나열해야 한다.
         
      2) INSERT INTO 테이블명 (컬럼, 컬럼, ..., 컬럼) VALUES(값, 값, 값, ..., 값);
         : 테이블에 내가 선택한 컬럼에만 값을 INSERT 하고자 할 때 사용한다.
           선택이 안된 컬럼들은 기본적으로 NULL 값이 들어간다.
           (단, NOT NULL 제약조건이 걸려있는 컬럼은 반드시 선택해서 값을 INSERT 해야 한다.)
           기본값(DEFAULT)이 지정되어 있으면 NULL이 아닌 기본값이 들어간다.

      3) INSERT INTO 테이블명 (서브 쿼리);
         : VALUES를 대신해서 서브 쿼리로 조회한 결과값을 통채로 INSERT 한다.
           서브 쿼리의 결과값이 INSERT 문에 지정된 테이블 컬럼의 개수와 데이터 타입이 같아야 한다.
*/


-- 테스트에 사용할 테이블 생성
CREATE TABLE EMP_01 (
   EMP_ID NUMBER PRIMARY KEY,
   EMP_NAME VARCHAR2(30) NOT NULL,
   DEPT_TITLE VARCHAR2(30),
   HIRE_DATE DATE DEFAULT SYSDATE
);


-- 1) 모든 컬럼에 대한 값을 INSERT
INSERT INTO EMP_01 
VALUES(100, '김삿갓', '서비스 개발팀', DEFAULT);

-- 모든 컬럼에 값을 지정하지 않아서 에러 발생
INSERT INTO EMP_01 
VALUES(200, '홍길동', '개발 지원팀');

-- 데이터 타입이 맞지 않아 에러 발생 
INSERT INTO EMP_01 
VALUES('고길동', '유아지원팀', 300, DEFAULT);

-- 에러는 발생하지 않지만 데이터가 잘 못 지정된다 
INSERT INTO EMP_01 
VALUES(300, '서비스 개발팀', '고길동', DEFAULT);


-- 2) 선택한 컬럼에만 값을 INSERT 
INSERT INTO EMP_01 (EMP_ID, EMP_NAME, DEPT_TITLE, HIRE_DATE)
VALUES (400, '둘리', '인사팀', NULL);

-- 순서를 바꿔서
INSERT INTO EMP_01 (EMP_NAME, EMP_ID, DEPT_TITLE, HIRE_DATE)
VALUES ('또치', 500, '보안팀', SYSDATE);

-- 특정 컬럼만 INSERT 
-- 따로 명시하지 않은 DEPT_TITLE은 NULL이지만, HIRE_DATE에는 DEFAULT 값인 SYSDATE가 들어가있다
INSERT INTO EMP_01 (EMP_ID, EMP_NAME)
VALUES (600, '도우너');

-- EMP_NAME 컬럼에 NOT NULL 제약조건이 걸려있기 때문에 불가해서 에러 발생
INSERT INTO EMP_01 (EMP_ID, DEPT_TITLE)
VALUES (700, '마케팅팀');

-- EMP_ID 컬럼에 PRIMARY KEY 제약조건이 걸려있기 때문에 에러 발생 (NOT NULL)
INSERT INTO EMP_01 (EMP_NAME, DEPT_TITLE)
VALUES ('심청이', '마케팅팀');

-- EMP_ID 컬럼에 PRIMARY KEY 제약조건이 걸려있기 때문에 에러 발생 (중복불가)
INSERT INTO EMP_01 (EMP_ID, EMP_NAME, DEPT_TITLE)
VALUES (700, '심청이', '마케팅팀');

SELECT * FROM EMP_01;

-- 3) 서브 쿼리 사용
-- 사용하기 전 데이터 전부 삭제
DELETE FROM EMP_01;

-- EMPLOYEE 테이블에서 직원의 사번, 이름, 부서명, 입사일을 조회해서 EMP_01 테이블에 INSERT 하시오
-- 조인하여 서브 쿼리 작성
SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, E.HIRE_DATE 
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (D.DEPT_ID = E.DEPT_CODE);

-- INSERT INTO 테이블 
INSERT INTO EMP_01 (
   SELECT E.EMP_ID, 
          E.EMP_NAME, 
          D.DEPT_TITLE, 
          E.HIRE_DATE 
   FROM EMPLOYEE E
   JOIN DEPARTMENT D ON (D.DEPT_ID = E.DEPT_CODE)
);

-- 컬럼명을 지정하지 않았을 시 컬럼 순서가 바뀌면, 에러
INSERT INTO EMP_01 (
   SELECT E.EMP_NAME,
          E.EMP_ID,  
          D.DEPT_TITLE, 
          E.HIRE_DATE 
   FROM EMPLOYEE E
   JOIN DEPARTMENT D ON (D.DEPT_ID = E.DEPT_CODE)
);

-- 서브 쿼리문에 조회된 데이터의 컬럼의 개수가 추가하려는 테이블의 컬럼 개수보다 많기 때문에, 에러
INSERT INTO EMP_01 (
   SELECT E.EMP_NAME,
          E.EMP_ID,  
          D.DEPT_TITLE, 
          E.HIRE_DATE,
          E.DEPT_CODE
   FROM EMPLOYEE E
   JOIN DEPARTMENT D ON (D.DEPT_ID = E.DEPT_CODE)
);

DELETE FROM EMP_01;
-- EMPLOYEE 테이블에서 직원들의 사번, 직원명을 조회해서 EMP_01 테이블에 INSERT 하시오
-- 서브쿼리 작성
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE;

-- INSERT INTO 구문에 넣기
INSERT INTO EMP_01 (EMP_ID, EMP_NAME)(
   SELECT EMP_ID, 
          EMP_NAME
   FROM EMPLOYEE
);

SELECT * FROM EMP_01;
DROP TABLE EMP_01;