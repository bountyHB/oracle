/*
   <HAVING>
      그룹에 대한 조건을 제시할 때 사용하는 구문이다.
      
   <SELECT 구문의 실행 순서>
      5. SELECT : 가져올 컬럼
      1: FROM : 가져올 테이블
      2. WHERE : 특정 조건
      3. GROUP BY : 그룹 기준 제시
      4. HAVING : 그룹에 대한 조건
      6. ORDER BY : 정렬 (실행 순서가 뒤에 있기 때문에 컬럼명, 컬럼순서, 별칭으로 불러올 수 있다)
*/


--EMPLOYEE 테이블에서 부서별로 급여가 300만원 이상인 직원의 이름을 조회 
SELECT DEPT_CODE, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3000000
ORDER BY DEPT_CODE;


--EMPLOYEE 테이블에서 부서별로 급여가 300만원 이상인 직원의 평균을 조회 
SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
WHERE SALARY >= 3000000
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;


-- EMPLOYEE 테이블에서 평균 급여가 300만원 이상인 부서를 조회
SELECT NVL(DEPT_CODE,'부서 없음') AS "부서명", 
       TO_CHAR(ROUND(NVL(AVG(SALARY),0)),'L999,999,999') AS "평균급여"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING ROUND(NVL(AVG(SALARY),0)) >= 3000000
ORDER BY DEPT_CODE;


-- EMPLOYEE 테이블에서 직급별 총 급여의 합이 10,000,0000 이상인 직급들만 조회
SELECT JOB_CODE AS "직급", 
       TO_CHAR(SUM(SALARY),'FML999,999,999') AS "총 급여의 합"
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000
ORDER BY JOB_CODE;


-- EMPLOYEE 테이블에서 부서별 보너스를 받는 사원이 없는 부서만 조회
SELECT NVL(DEPT_CODE,'부서없음') AS "부서" 
--       COUNT(BONUS) AS "보너스 없는 부서"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0
ORDER BY DEPT_CODE;

-- 내 잘못된 식
SELECT NVL(DEPT_CODE,'부서없음'), 
       BONUS
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING BONUS IS NOT NULLS
ORDER BY DEPT_CODE;

