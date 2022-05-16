/*
   <INSERT ALL>
      
      1) 서브 쿼리의 결과를 INSERT
      INSERT ALL
      INTO 테이블명1[(컬럼, 컬럼, ...)] VALUES(값, 값, ...)
      INTO 테이블명2[(컬럼, 컬럼, 컬럼, ...)] VALUES(값, 값, 값, ...)
      서브 쿼리;
      
      2) 서브 쿼리의 결과를 조건을 만족하는 테이블에 INSERT
      INSERT ALL
      WHEN 조건1 THEN INTO 테이블명1[(컬럼, 컬럼, ...)] VALUES(값, 값, ...)
      WHEN 조건2 THEN INTO 테이블명2[(컬럼, 컬럼, ...)] VALUES(값, 값, ...)
      서브 쿼리;
   
*/


-- 1) 서브 쿼리의 결과를 INSERT
-- 테이블 생성
CREATE TABLE EMP_DEPT
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
   FROM EMPLOYEE
   WHERE 1 = 0;

CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
   FROM EMPLOYEE
   WHERE 1 = 0;

-- EMP_DEPT 테이블에는 EMPLOYEE 테이블의 부서 코드가 D1인 직원들의 사번, 직원명, 부서 코드, 입사일을 삽입하고
-- EMP_MANAGER 테이블에는 EMPLOYEE 테이블의 부서 코드가 D1인 직원들의 사번, 직원명, 관리자 사번을 조회하여 삽입한다.

-- (1) EMP_DEPT 테이블에는 EMPLOYEE 테이블의 부서 코드가 D1인 직원들의 사번, 직원명, 부서 코드, 입사일을 삽입
INSERT ALL
INTO EMP_DEPT VALUES (EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)(
   SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
   FROM EMPLOYEE
   WHERE DEPT_CODE = 'D1'
);

-- (2) EMP_MANAGER 테이블에는 EMPLOYEE 테이블의 부서 코드가 D1인 직원들의 사번, 직원명, 관리자 사번을 조회하여 삽입
INSERT ALL 
INTO EMP_MANAGER VALUES (EMP_ID, EMP_NAME, MANAGER_ID)(
   SELECT EMP_ID, EMP_NAME, MANAGER_ID
   FROM EMPLOYEE
   WHERE DEPT_CODE = 'D1'
);

-- (3) 합쳐서 작성
INSERT ALL
INTO EMP_DEPT VALUES (EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
INTO EMP_MANAGER VALUES (EMP_ID, EMP_NAME, MANAGER_ID)(
   SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
   FROM EMPLOYEE
   WHERE DEPT_CODE = 'D1'
);

SELECT * FROM EMP_DEPT;
SELECT * FROM EMP_MANAGER;

DROP TABLE EMP_DEPT;
DROP TABLE EMP_MANAGER;


-- 2) 서브 쿼리의 결과를 조건을 만족하는 테이블에 INSERT
-- 테이블 생성
CREATE TABLE EMP_OLD
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
   FROM EMPLOYEE
   WHERE 1 = 0;

CREATE TABLE EMP_NEW
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
   FROM EMPLOYEE
   WHERE 1 = 0;

-- EMPLOYEE 테이블에서 입사일 기준으로 2000년 1월 1일 이전에 입사한 사원의 정보는 EMP_OLD 테이블에 삽입하고
-- 2000년 1월 1일 이후에 입사한 사원의 정보는 EMP_NEW 테이블에 삽입한다.

-- (1) EMPLOYEE 테이블에서 입사일 기준으로 2000년 1월 1일 이전에 입사한 사원의 정보는 EMP_OLD 테이블에 삽입
INSERT ALL 
INTO EMP_OLD VALUES (EMP_ID, EMP_NAME, HIRE_DATE, SALARY)(
   SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
   FROM EMPLOYEE
   WHERE HIRE_DATE < '2000/01/01'
);

-- (2) 2000년 1월 1일 이후에 입사한 사원의 정보는 EMP_NEW 테이블에 삽입
INSERT ALL 
INTO EMP_NEW VALUES (EMP_ID, EMP_NAME, HIRE_DATE, SALARY)(
   SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
   FROM EMPLOYEE
   WHERE HIRE_DATE > '2000/01/01'
);

-- (3) 표현법 2를 이용한 작성
INSERT ALL 
WHEN HIRE_DATE < '2000/01/01' THEN
   INTO EMP_OLD VALUES (EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
WHEN HIRE_DATE > '2000/01/01' THEN
   INTO EMP_NEW VALUES (EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE;

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

DROP TABLE EMP_OLD;
DROP TABLE EMP_NEW;