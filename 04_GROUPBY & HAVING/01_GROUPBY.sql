/*
   <GROUP BY>
      그룹 기준을 제시할 수 있는 구문이다.
      여러 개의 값들을 하나의 그룹으로 묶어서 처리할 목적으로 사용한다.

*/


SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;


-- 각 부서별 그룹으로 묶어서 부서별 총합을 구한 결과를 조회
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE NULLS FIRST;


-- EMPLOYEE 테이블에서 전체 사원의 수를 조회
SELECT COUNT(*)
FROM EMPLOYEE;


-- EMPLOYEE 테이블에서 각 부서별 사원의 수를 조회
SELECT NVL(DEPT_CODE,'부서 없음'), COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE NULLS FIRST;


-- EMPLOYEE 테이블에서 부서별 급여의 합계를 조회 (부서별 내림차순)
SELECT NVL(DEPT_CODE,'부서 없음') AS "부서별", 
       TO_CHAR(SUM(SALARY),'L99,999,999') AS "급여의 합"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE DESC;


-- EMPLOYEE 테이블에서 직급별 사원의 수를 조회 (직급별 내림차순 정렬)
SELECT JOB_CODE AS "직급별", 
       COUNT(*) AS "사원의 수"
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE DESC;

-- EMPLOYEE 테이블에서 직급별 보너스를 받는 사원의 수를 조회 (직급별 오름차순 정렬)
SELECT JOB_CODE AS "직급별", 
       COUNT(BONUS) AS "보너스 사원" 
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE DESC;


-- EMPLOYEE 테이블에서 부서별 보너스를 받는 사원의 수를 조회 (부서별 오름차순 정렬)
SELECT NVL(DEPT_CODE, '부서 없음') AS "부서별", 
       COUNT(BONUS) AS "보너스 사원"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE DESC;


-- EMPLOYEE 테이블에서 직급별 급여의 평균을 조회
SELECT JOB_CODE AS "직급별", 
       TO_CHAR(ROUND(AVG(SALARY)),'L9,999,999') AS "평균 급여"
FROM EMPLOYEE
GROUP BY JOB_CODE;


-- EMPLOYEE 테이블에서 부서별 사원의 수, 보너스를 받는 사원의 수, 급여의 합, 평균 급여, 최고 급여, 최저 급여를 조회(부서별 내림차순)
SELECT NVL(DEPT_CODE, '부서 없음') AS "부서", 
       COUNT(*) AS "사원의 수", 
       COUNT(BONUS) AS "보너스 사원", 
       TO_CHAR(SUM(SALARY),'L999,999,999') AS "급여의 합", 
       TO_CHAR(ROUND(NVL(AVG(SALARY),0)),'L9,999,999') AS "평균 급여", 
       TO_CHAR(MAX(SALARY),'L9,999,999') AS "최고 급여", 
       TO_CHAR(MIN(SALARY),'L9,999,999') AS "최저 급여"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE DESC NULLS LAST;


-- EMPLOYEE 테이블에서 성별 별 사원의 수를 조회
SELECT DECODE(SUBSTR(EMP_NO,8,1), '1', '남자', '2', '여자') AS "성별",
       COUNT(*) AS "사원 수"
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1); -- 컬럼, 계산식, 함수 호출 구문이 올 수 있다.
--GROUP BY "성별 코드"; -- 컬럼 순번, 별칭은 사용할 수 없다.


-- EMPLOYEE 테이블에서 부서코드와 직급 코드가 같은 사원의 직원 수, 급여의 합을 조회
-- DEPT_CODE 와 JOB_CODE가 동일한 값들 끼리 그룹이 된다.
SELECT NVL(DEPT_CODE,'부서 없음') AS "부서 코드",
       JOB_CODE AS "직급 코드",
       COUNT(*) AS "직원 수",
       TO_CHAR(SUM(SALARY),'L999,999,999') AS "급여의 합"
       
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE -- 여러 컬럼을 제시해서 그룹 기준을 지정할 수 있다.
ORDER BY DEPT_CODE, JOB_CODE;


