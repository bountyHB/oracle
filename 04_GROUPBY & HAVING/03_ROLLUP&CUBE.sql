/*
   <집계 함수>
      그룹별 산출한 결과 값의 중간 집계를 계산하는 함수
      
      ROLLUP : 컬럼 1을 가지고 중간 집계를 내는 함수
      ROLLUP(컬럼1, 컬럼2, ...)
      
      CUBE : 전달되는 모든 컬럼을 가지고 중간 집계를 내는 함수
      CUBE(컬럼1, 컬럼2, ...)  
*/


-- EMPLOYEE 테이블에서 직급별 급여의 합계를 조회
-- 그룹된 합계들의 총 합계를 구해줌
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
--GROUP BY ROLLUP(JOB_CODE)
GROUP BY CUBE(JOB_CODE)
ORDER BY JOB_CODE;


-- EMPLOYEE 테이블에서 직급 코드와 부서 코드가 같은 사원들의 급여의 합계를 조회
SELECT JOB_CODE AS "직급 코드", 
       DEPT_CODE AS "부서 코드", 
       SUM(SALARY) AS "급여 합계"
FROM EMPLOYEE
-- ROLLUP(컬럼1, 컬럼2, ...) -> 컬럼 1을 가지고 중간 집계를 내는 함수
-- GROUP BY ROLLUP(JOB_CODE, DEPT_CODE)
-- CUBE(컬럼1, 컬럼2, ...) -> 전달되는 모든 컬럼을 가지고 중간 집계를 내는 함수
GROUP BY CUBE(JOB_CODE, DEPT_CODE)
ORDER BY JOB_CODE, DEPT_CODE;

