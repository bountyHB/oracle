/*
      2. 다중행 서브 쿼리 : 서브 쿼리 조회 결과 값의 행의 수가 여러행, 열의 수가 하나 일 때
                        (=, >, <, >=, <=) 를 사용할 수 없다.
      IN / NOT IN : 여러 개의 결과값 중에서 한 개라도 일치하는 값이 있거나 없다면 TRUE를 리턴한다.
      
      ANY : 여러 개의 값들 중에서 한 개라도 일치하면 TRUE, IN 과 다른 점은 비교 연산자를 함께 사용한다는 점이다.
            SALARY = ANY (...)
            : SALARY가 ANY 값의 목록중에서 하나라도 같은 값이 있으면 TRUE 
            : IN과 같은 결과
            
            SALARY != ANY (...)
            : SALARY가 ANY 값의 목록중에서 하나라도 같은 값이 없으면 TRUE
            : NOT IN과 같은 결과
            
            SALARY > ANY (...)
            : SALARY가 ANY 값의 목록중에서 하나라도 크다면 TRUE
            : 최소값 보다 크면 TRUE 리턴
            
            SALARY < ANY (...)
            : SALARY가 ANY 값의 목록중에서 하나라도 작으면 TRUE
            : 최대값 보다 작으면 TRUE 리턴
            
      ALL : 여러 개의 값들 중에서 모두와 일치하면 TRUE, IN 과 다른 점은 비교 연산자를 함께 사용한다는 점이다.
            SALARY = ALL (...)  : 불가능
            SALARY != ALL (...) : 불가능
            SALARY > ALL (...) : 최대값 보다 크다면 TRUE 리턴
            SALARY < ALL (...) : 최소값 보다 작으면 TRUE 리턴
*/


-- 1) 각 부서별 최고 급여를 받는 직원의 직원명, 직급 코드, 부서 코드, 급여를 조회
-- 부서별 최고급여 조회
SELECT MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 위의 급여를 받는 사원들을 조회 
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN (2890000, 3660000, 8000000, 3760000);

-- 위의 쿼리문을 합쳐서 하나의 쿼리문으로 작성
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN (
      SELECT MAX(SALARY)
      FROM EMPLOYEE
      GROUP BY DEPT_CODE
);


-- 2) 사원들의 사번, 이름, 부서 코드, 구분(사수/사원) 조회
-- 사수에 해당하는 사번을 조회 (201, 204, 100, 200, 211, 207, 214)
SELECT *
FROM EMPLOYEE;

SELECT DISTINCT MANAGER_ID
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL;

-- 사번이 위와 같은 직원들의 사번, 이름, 부서 코드, 구분(사수) 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, '사수' AS "구분"
FROM EMPLOYEE
WHERE EMP_ID IN (201, 204, 100, 200, 211, 207, 214);

-- 위의 쿼리문을 합쳐서 하나의 쿼리문으로 작성
SELECT EMP_ID, EMP_NAME, DEPT_CODE, '사수' AS "구분"
FROM EMPLOYEE
WHERE EMP_ID IN (
      SELECT DISTINCT MANAGER_ID
      FROM EMPLOYEE
      WHERE MANAGER_ID IS NOT NULL
);

-- 일반 사원에 해당하는 정보를 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, '사원' AS "구분"
FROM EMPLOYEE
WHERE EMP_ID NOT IN (
      SELECT DISTINCT MANAGER_ID
      FROM EMPLOYEE
      WHERE MANAGER_ID IS NOT NULL
);

-- 위의 결과들을 하나의 결과로 확인 (UNION)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, '사수' AS "구분"
FROM EMPLOYEE
WHERE EMP_ID IN (
      SELECT DISTINCT MANAGER_ID
      FROM EMPLOYEE
      WHERE MANAGER_ID IS NOT NULL
)

UNION

SELECT EMP_ID, EMP_NAME, DEPT_CODE, '사원' AS "구분"
FROM EMPLOYEE
WHERE EMP_ID NOT IN (
      SELECT DISTINCT MANAGER_ID
      FROM EMPLOYEE
      WHERE MANAGER_ID IS NOT NULL
)
ORDER BY EMP_ID;

-- SELECT 절에 서브 쿼리를 사용해서 위와 동일한 결과를 조회
SELECT EMP_ID, 
       EMP_NAME, 
       DEPT_CODE,
       CASE WHEN EMP_ID IN (
               SELECT DISTINCT MANAGER_ID
               FROM EMPLOYEE
               WHERE MANAGER_ID IS NOT NULL
            )
            THEN '사수'
            ELSE '사원'
       END AS "구분"
FROM EMPLOYEE;


-- 3) 대리 직급임에도 과장 직급들의 최소 급여보다 많이 받는 직원의 사번, 이름, 직급 코드, 급여를 조회
--    (사원 J7 -> 대리 J6 -> 과장 J5 -> 차장 J4 -> 부장 J3)
-- ANY 사용 (SALARY가 하나의 값이라도 만족시키면 됨)
-- 과장 직급들의 최소 급여를 조회
select *
from job;

SELECT MIN(SALARY)
FROM EMPLOYEE
WHERE JOB_CODE = 'J5';

-- 직급이 대리인 직원들의 사번, 이름, 직급 코드, 급여를 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J6';

-- 직급이 대리인 직원들의 사번, 이름, 직급 코드, 급여에 조건을 넣어 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J6' AND SALARY > ANY (
      SELECT SALARY
      FROM EMPLOYEE
      WHERE JOB_CODE = 'J5'
);


-- 4) 과장 직급임에도 차장 직급들의 최대 급여보다 많이 받는 직원의 사번, 이름, 직급 코드, 급여를 조회
--    (사원 J7 -> 대리 J6 -> 과장 J5 -> 차장 J4 -> 부장 J3)
-- ALL 사용 (SALARY가 모든 값을 만족시켜야 함)
-- 차장 직급들의 급여를 조회 (과장 J5) (2200000)
SELECT E.SALARY
FROM EMPLOYEE E 
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE J.JOB_NAME = '차장';

-- 직급이 과장인 직원들의 사번, 이름, 직급 코드, 급여를 조회
SELECT E.EMP_ID, E.EMP_NAME, E.JOB_CODE, E.SALARY
FROM EMPLOYEE E 
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE J.JOB_NAME = '과장';

-- 직급이 과장인 직원들의 사번, 이름, 직급 코드, 급여에 조건을 넣어 조회
SELECT E.EMP_ID, E.EMP_NAME, E.JOB_CODE, E.SALARY
FROM EMPLOYEE E 
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE J.JOB_NAME = '과장' AND E.SALARY > ALL (
      SELECT E.SALARY
      FROM EMPLOYEE E 
      JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
      WHERE J.JOB_NAME = '차장'
);
