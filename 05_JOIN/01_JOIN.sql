/*
   <JOIN>
      두 개 이상의 테이블에서 데이터를 조회하고자 할 때 사용하는 구문이다.

   1. INNER JOIN : 연결시키는 컬럼의 값이 일치하는 행들만 하나의 행으로 조회한다.
                   (일치하는 값이 없는 행은 조회 x)
   
      1) 오라클 전용 구문
          SELECT 컬럼, ..., 컬럼
          FROM   테이블1, 테이블2
          WHERE  테이블1.컬럼명 = 테이블2.컬럼명;
         
          - FROM 절에 조인하려는 테이블들을 콤마로 구분하여 나열한다.
          - WHERE 절에 매칭 시킬 컬럼명에 대한 조건을 제시한다.
         
      2) ANSI 표준 구문
          SELECT         컬럼, ..., 컬럼
          FROM           테이블1
          [INNER] JOIN   테이블2 ON (테이블1.컬럼명 = 테이블2.컬럼명);
  
          - FROM 절에서 기준이 되는 테이블을 기술한다.
          - JOIN 절에서 조인하려는 테이블을 기술 후에 매칭 시킬 컬럼에 대한 조건을 제시한다.
          - 연결에 사용하려는 컬럼명이 같은 경우 USING(컬럼명) 구문을 사용한다.
*/


-- 부서명
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

SELECT *
FROM EMPLOYEE
INNER JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE
INNER JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

----------------------------------------
-- 사원들의 사번, 직원명, 부서 코드, 부서명을 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- 사원들의 사번, 직원명, 직급 코드, 직급명을 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE;

SELECT JOB_CODE, JOB_NAME
FROM JOB;


-- 오라클 구문
-- 1-1) 연결할 두 컬럼명이 다른 경우
-- EMPLOYEE 테이블과 DEPARTMENT 테이블을 조인하여 사번, 직원명, 부서 코드, 부서명을 조회
-- 조건을 만족하지 않는 행은 조회되지 않는다. (DEPT_CODE가 NULL인 사원, DEPT_ID가 D3, D4, D7인 사원)
SELECT EMP_ID, EMP_NAME, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;

-- 1-2) 연결할 두 컬럼명이 같은 경우
-- EMPLOYEE 테이블과 JOB 테이블을 조인하여 사번, 직원명, 직급 코드, 직급명을 조회
-- 방법 1) 테이블명을 이용하는 방법
SELECT EMP_ID, EMP_NAME, JOB.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- 방법 2) 테이블 별칭을 이용하는 방법
SELECT E.EMP_ID, 
       E.EMP_NAME, 
       J.JOB_CODE, 
       J.JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;


-- ANSI 구문
-- 2-1) 연결할 두 컬럼명이 다른 경우
-- EMPLOYEE 테이블과 JOB 테이블을 조인하여 사번, 직원명, 부서 코드, 부서명을 조회

SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_CODE, D.DEPT_TITLE
FROM EMPLOYEE E 
JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID);


-- 2-2) 연결할 두 컬럼명이 같은 경우
-- EMPLOYEE 테이블과 JOB 테이블을 조인하여 사번, 직원명, 직급 코드, 직급명을 조회
-- 방법 1) 테이블명을 이용하는 방법
SELECT EMPLOYEE.EMP_ID, 
       EMPLOYEE.EMP_NAME, 
       JOB.JOB_CODE, 
       JOB.JOB_NAME
FROM EMPLOYEE
JOIN JOB ON (EMPLOYEE.JOB_CODE = JOB.JOB_CODE);


-- 방법 2) 테이블 별칭을 이용하는 방법
SELECT E.EMP_ID, E.EMP_NAME, J.JOB_CODE, J.JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);


-- 방법 3) USING 구문을 이용하는 방법
-- 별도로 별칭을 명시하지 않아도 하나의 같은 컬럼이라고 인식한다.
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE);


-- 방법 4) NATURAL JOIN을 이용하는 방법 (참고만)
-- USING과 똑같이 출력
-- 동일한 이름의 컬럼이 자동으로 조인되는데, 동일한 이름의 컬럼이 여러개면 모두 조인되어버린다.
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB;


-- EMPLOYEE 테이블과 JOB 테이블을 조인해서 직급이 대리인 사원의 사번, 직원명, 직급명, 급여를 조회
-- 1) 오라클 구문
SELECT E.EMP_ID, E.EMP_NAME, J.JOB_NAME, E.SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE AND J.JOB_NAME = '대리';


-- 2) ANSI 구문
SELECT E.EMP_ID, E.EMP_NAME, J.JOB_NAME, E.SALARY
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE J.JOB_NAME = '대리';
   
----------------------------------------실습문제----------------------------------------
-- 1. DEPARTMENT 테이블과 LOCATION 테이블을 조인하여 부서 코드, 부서명, 지역 코드, 지역명을 조회 
-- 오라클 구문
SELECT D.DEPT_ID AS "부서코드", 
       D.DEPT_TITLE AS "부서명", 
       L.LOCAL_CODE AS "지역코드", 
       L.LOCAL_NAME AS "지역명"
FROM DEPARTMENT D, LOCATION L
WHERE D.LOCATION_ID = L.LOCAL_CODE;

-- ANSI 구문
SELECT D.DEPT_ID AS "부서코드", 
       D.DEPT_TITLE AS "부서명", 
       L.LOCAL_CODE AS "지역코드", 
       L.LOCAL_NAME AS "지역명"
FROM DEPARTMENT D
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE);


-- 2. EMPLOYEE 테이블과 DEPARTMENT 테이블을 조인해서 보너스를 받는 사원들의 사번, 직원명, 부서명, 보너스를 조회
-- 오라클 구문
SELECT E.EMP_ID AS "사번", 
       E.EMP_NAME AS "직원명", 
       D.DEPT_TITLE AS "부서명", 
       NVL(E.BONUS,0) AS "보너스"
FROM EMPLOYEE E, DEPARTMENT D
WHERE (E.DEPT_CODE = D.DEPT_ID) AND (E.BONUS IS NOT NULL);

-- ANSI 구문
SELECT E.EMP_ID AS "사번", 
       E.EMP_NAME AS "직원명", 
       D.DEPT_TITLE AS "부서명", 
       NVL(E.BONUS,0) AS "보너스"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
--WHERE (E.BONUS IS NOT NULL);
WHERE NVL(BONUS, 0) > 0;

-- 3. EMPLOYEE 테이블과 DEPARTMENT 테이블을 조인해서 인사관리부가 아닌 사원들의 직원명, 부서명, 급여를 조회
-- 오라클 구문
SELECT E.EMP_NAME AS "직원명", 
       D.DEPT_TITLE AS "부서명", 
       TO_CHAR(E.SALARY,'L99,999,999') AS "급여"
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID AND (D.DEPT_TITLE != '인사관리부');

-- ANSI 구문
SELECT E.EMP_NAME AS "직원명", 
       D.DEPT_TITLE AS "부서명", 
       TO_CHAR(E.SALARY,'L99,999,999') AS "급여"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE (D.DEPT_TITLE != '인사관리부');


-- 4. EMPLOYEE 테이블과 DEPARTMENT 테이블, JOB테이블을 조인해서 사원들의 사번, 직원명, 부서명, 직급명을 조회
-- 오라클 구문
SELECT E.EMP_ID AS "사번", 
       E.EMP_NAME AS "직원명", 
       D.DEPT_TITLE AS "부서명", 
       J.JOB_NAME AS "직급명"
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE (E.DEPT_CODE = D.DEPT_ID) AND(E.JOB_CODE = J.JOB_CODE);

-- ANSI 구문
SELECT E.EMP_ID AS "사번", 
       E.EMP_NAME AS "직원명", 
       D.DEPT_TITLE AS "부서명", 
       J.JOB_NAME AS "직급명"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);
