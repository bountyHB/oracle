/*
   <인라인 뷰>
      FROM 절에 서브 쿼리를 제시하고, 서브 쿼리를 수행한 결과를 테이블 대신에 사용한다.
*/

-- 1. 인라인 뷰를 활용한 TOP-N 분석
-- 전 직원 중에 급여가 가장 높은 상위 5명의 순위, 이름, 급여를 조회
-- * ROWNUM : 오라클에서 제공하는 컬럼, 조회된 순서대로 1부터 순번을 부여

SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC;
-- 이미 순번이 정해진 다음에 정렬이 되었다.
-- FROM -> SELECT (순번이 정해진다) -> ORDER BY

-- SELECT ROWNUM, A.* -- 별칭의 모든 값을 가져온다
SELECT ROWNUM, A.EMP_NAME, A.SALARY -- 별칭으로 값을 가져온다
FROM (
      SELECT *
      FROM EMPLOYEE
      ORDER BY SALARY DESC
) A -- 별칭 지정
WHERE ROWNUM <= 5;


-- 2. 인라인 뷰를 활용한 TOP-N 분석 (GROUP BY)
-- 부서별 평균 급여가 높은 3개의 부서의 부서 코드, 평균 급여를 조회
SELECT *
FROM EMPLOYEE;

SELECT DEPT_CODE, ROUND(AVG(NVL(SALARY,0))) "평균급여"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY "평균급여" DESC;

-- 내 방법 (에러남)
SELECT ROWNUM, NVL(DEPT_CODE,'부서없음'), ROUND(AVG(NVL(SALARY,0)))
FROM (
      SELECT NVL(DEPT_CODE,'부서없음'), 
             ROUND(AVG(NVL(SALARY,0)))
      FROM EMPLOYEE
      GROUP BY DEPT_CODE
      ORDER BY "평균급여" DESC
)
WHERE ROWNUM <= 3;

-- 쌤
-- 별칭을 사용하지 않으면, 컬럼명이 아니라 함수 실행이라고 인식을 한다.
-- 함수사용하는 구문이나 연산식이 컬럼에 들어가면 반드시 별칭을 붙여야 에러가 나지 않는다.
SELECT ROWNUM AS "순위", 부서코드, ROUND(평균급여)
FROM (
      SELECT NVL(DEPT_CODE,'부서없음') AS "부서코드", 
             AVG(NVL(SALARY,0)) "평균급여"
      FROM EMPLOYEE
      GROUP BY DEPT_CODE
      ORDER BY "평균급여" DESC
)
WHERE ROWNUM <= 3;


-- 3. WITH를 이용한 방법
WITH TOPN_SAL AS (
      SELECT NVL(DEPT_CODE,'부서없음') AS "부서코드", 
             AVG(NVL(SALARY,0)) "평균급여"
      FROM EMPLOYEE
      GROUP BY DEPT_CODE
      ORDER BY "평균급여" DESC
)
SELECT ROWNUM, 부서코드, ROUND(평균급여)
FROM TOPN_SAL
WHERE ROWNUM <= 3;