/*
   <SUBQUERY>
      하나의 SQL 문 안에 포함된 또 다른 SQL 문을 말한다.
      메인 쿼리를 보조하는 역할을 하는 쿼리문이다.
*/

-- 서브 쿼리 예시 1) 
-- 1. 노옹철 사원과 같은 부서원들을 조회
-- 1) 노옹철 사원의 부서 코드 조회 (D9)
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철';

-- 2) 부서 코드가 노옹철 사원의 부서 코드와 동일한 사원들을 조회
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- 위의 2단계를 하나의 쿼리로 작성
SELECT * -- 메인 쿼리
FROM EMPLOYEE
WHERE DEPT_CODE = (
      SELECT DEPT_CODE -- 서브 쿼리
      FROM EMPLOYEE
      WHERE EMP_NAME = '노옹철'
);
-- > 서브 쿼리가 메인 쿼리보다 먼저 실행된다.

-- 2. 전 직원의 평균 급여보다 더 많은 급여를 받고 있는 직원들의 사번, 직원명, 직급 코드, 급여를 조회
-- 1) 전 직원의 평균 급여를 조회 (3047662.60869565217391304347826086956522)
SELECT AVG(NVL(SALARY,0))
FROM EMPLOYEE;

-- 2) 급여가 1)의 조회결과 이상인 직원들의 사번, 직원명, 직급 코드, 급여를 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (3047662.60869565217391304347826086956522);

-- 위의 2단계를 하나의 쿼리로 작성
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (
      SELECT AVG(NVL(SALARY,0))
      FROM EMPLOYEE
);

/*
   <서브 쿼리 구분>
      서브 쿼리는 서브 쿼리를 수행한 결과값에 따라서 분류할 수 있다.
      
      1. 단일행 서브 쿼리      : 서브 쿼리 조회 결과 값의 행의 수가 하나, 열의 수가 하나 일 때
      2. 다중행 서브 쿼리      : 서브 쿼리 조회 결과 값의 행의 수가 여러행, 열의 수가 하나 일 때
      3. 다중열 서브 쿼리      : 서브 쿼리 조회 결과 값의 행이 하나, 열의 수가 여러개 일 때  
      4. 다중행 다중열 서브 쿼리 : 서브 쿼리 조회 결과 값의 행의 수가 여러행, 열의 수가 여러개 일 때
      
      * 서브 쿼리의 분류에 따라 서브 쿼리 앞에 붙는 연산자가 달라진다.
*/


-- 1. 단일행 서브 쿼리


-- 1) 전 직원의 평균 급여보다 급여를 적게 받는 직원들의 사번, 직원명, 직급 코드, 급여를 조회
-- 전 직원의 평균 급여
SELECT AVG(NVL(SALARY,0))
FROM EMPLOYEE;

-- 위 쿼리를 서브 쿼리로 사용하는 메인 쿼리 작성
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE 
WHERE SALARY < (
      SELECT AVG(NVL(SALARY,0))
      FROM EMPLOYEE
);


-- 2) 최저 급여를 받는 직원의 사번, 직원명, 직급 코드, 급여, 입사일 조회
-- 최저 급여를 조회
SELECT MIN(SALARY)
FROM EMPLOYEE;

-- 위 쿼리를 서브 쿼리로 사용하는 메인 쿼리 작성
SELECT EMP_ID, EMP_NAME, JOB_CODE, HIRE_DATE
FROM EMPLOYEE 
WHERE SALARY = (
      SELECT MIN(SALARY)
      FROM EMPLOYEE
);


-- 3) 노옹철 사원의 급여보다 더 많이 받는 사원의 사번, 직원명, 부서명, 직급 코드, 급여를 조회
-- 노옹철 사원의 급여
SELECT SALARY
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철';

-- 메인 쿼리 작성
SELECT EMP_ID, EMP_NAME, JOB_CODE, DEPT_TITLE, HIRE_DATE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID);

-- 위 쿼리를 서브 쿼리로 사용하는 메인 쿼리 작성
-- ANSI 구문
SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, E.JOB_CODE, E.HIRE_DATE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE E.SALARY > (
      SELECT SALARY
      FROM EMPLOYEE
      WHERE EMP_NAME = '노옹철'
);

-- 오라클 구문
SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, E.JOB_CODE, E.HIRE_DATE
FROM EMPLOYEE E, DEPARTMENT D
WHERE (E.DEPT_CODE = D.DEPT_ID) AND E.SALARY > (
      SELECT SALARY
      FROM EMPLOYEE
      WHERE EMP_NAME = '노옹철'
);


-- 4) 부서별 급여의 합이 가장 큰 부서의 부서 코드, 급여의 합을 조회
-- 각 부서별 급여의 합 중에 가장 큰 값
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 메인 쿼리를 작성
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 위 쿼리를 서브 쿼리로 사용하는 메인 쿼리 작성
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (
      SELECT MAX(SUM(SALARY))
      FROM EMPLOYEE
      GROUP BY DEPT_CODE
);

