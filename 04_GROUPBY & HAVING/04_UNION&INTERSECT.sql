/*
   <집합 연산자>
      여러 개의 쿼리문을 하나의 쿼리문으로 만드는 연산자이다.
      
      1) UNION
         두 쿼리문을 수행한 결과값을 하나로 합쳐서 추출한다. (중복되는 행은 제거)
      2) UNION ALL
         두 쿼리문을 수행한 결과값을 하나로 합쳐서 추출한다. (중복되는 행은 제거하지 않음)
      3) INTERSECT
         두 쿼리문을 수행한 결과값에서 중복된 결과값만 추출한다. (교집합)
      4) MINUS
         선행 쿼리문의 결과값에서 후행 쿼리문의 결과값을 뺀 나머지 결과값만 추출한다. (차집합)
*/


-- EMPLOYEE 테이블에서 부서 코드가 D5인 사원들의 사번, 직원명, 부서코드, 급여를 조회 (6명 조회)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';


-- EMPLOYEE 테이블에서 급여가 300만원 초과인 사원들의 사번, 직원명, 부서코드, 급여를 조회 (8명 조회)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;


-- 1) UNION 
-- EMPLOYEE 테이블에서 부서 코드가 D5인 사원 또는 급여가 300만원 초과인 사원들의 사번, 직원명, 부서코드, 급여를 조회 (12명 조회)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'

UNION

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- 위 쿼리문 대신에 WHERE 절에 OR 연산자를 사용해서 처리 가능
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY > 3000000;


-- 2) UNION ALL
-- EMPLOYEE 테이블에서 부서 코드가 D5인 사원 또는 급여가 300만원 초과인 사원들의 사번, 직원명, 부서코드, 급여를 조회 (14명 조회)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'

UNION ALL

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;


-- 3) INTERSECT
-- EMPLOYEE 테이블에서 부서 코드가 D5이면서 급여가 300만원 초과인 사원들의 사번, 직원명, 부서코드, 급여를 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'

INTERSECT

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- 위 쿼리문 대신에 WHERE 절에 AND 연산자를 사용해서 처리 가능
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEㅋ
WHERE DEPT_CODE = 'D5' AND SALARY > 3000000;


-- 4) MINUS
-- EMPLOYEE 테이블에서 부서 코드가 D5인 사원들 중에 급여가 300만원 초과인 사원들을 제외해서 사번, 직원명, 부서코드, 급여를 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'

MINUS

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- 위 쿼리문 대신에 WHERE 절에 AND 연산자를 사용해서 처리 가능
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY <= 3000000;


