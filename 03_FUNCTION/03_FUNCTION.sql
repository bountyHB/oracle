/*
   <그룹 함수>
      대량의 데이터들로 집계나 통계 같은 작업을 처리해야 하는 경우 사용되는 함수들이다.
      모든 그룹 함수는 NULL 값을 자동으로 제외하고 값이 있는 것들만 계산을 한다.
      
   1) SUM : 제시된 컬럼 값들의 합계를 반환
      SUM(NUMBER 타입의 컬럼) 
*/


--EMPLOYEE 테이블에서 전사원의 총 급여의 합계를 조회
SELECT TO_CHAR(SUM(SALARY),'FML99,999,999') AS "총 급여"
FROM EMPLOYEE;


--EMPLOYEE 테이블에서 남자사원의 총 급여의 합계를 조회
SELECT TO_CHAR(SUM(SALARY),'FML99,999,999') AS "남자사원의 총 급여합"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1)=1;

--EMPLOYEE 테이블에서 여자사원의 총 급여의 합계를 조회
SELECT TO_CHAR(SUM(SALARY),'FML99,999,999') AS "여자사원의 총 급여합"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1)=2;


--EMPLOYEE 테이블에서 전사원의 총 연봉의 합계를 조회
SELECT TO_CHAR(SUM(SALARY*12),'FML99,999,999,999') AS "총 연봉의 합계"
FROM EMPLOYEE;


--EMPLOYEE 테이블에서 부서 코드가 D5인 사원들의 총 연봉의 합계를 조회
SELECT TO_CHAR(SUM(SALARY*12),'FML999,999,999') AS "합계"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';


SELECT *
FROM EMPLOYEE;


/*
   2) AVG : 제시된 컬럼 값들의 평균값을 반환
      AVG(NUMBER 타입의 컬럼)
      
      => 모든 그룹 함수는 NULL 값을 자동으로 제외하기 때문에 AVG 함수를 사용할 때는 NVL 함수와 함께 사용하는 것을 권장
*/


-- EMPLOYEE 테이블에서 전 사원의 급여 평균을 조회

SELECT AVG(SALARY)
FROM EMPLOYEE;

SELECT AVG(NVL(SALARY,0))
FROM EMPLOYEE;

SELECT ROUND(AVG(NVL(SALARY,0)))
FROM EMPLOYEE;

SELECT TO_CHAR(ROUND(AVG(NVL(SALARY,0))),'FML9,999,999') AS "급여 평균"
FROM EMPLOYEE;


/*
   3) MIN / MAX
      MIN / MAX(모든 타입의 컬럼)
      
      MIN : 제시된 컬럼 값들 중에 가장 작은 값을 반환 
      MAX : 제시된 컬럼 값들 중에 가장 큰 값을 반환 
*/


SELECT *
FROM EMPLOYEE;

SELECT (EMP_NAME),
       (EMAIL),
       (SALARY),
       (HIRE_DATE)
FROM EMPLOYEE;


-- 각각의 컬에서 가장 작은 값들
SELECT MIN(EMP_NAME),
       MIN(EMAIL),
       MIN(SALARY),
       MIN(HIRE_DATE)
FROM EMPLOYEE;
 
 
-- 각각의 컬럼에서 가장 큰 값들
SELECT MAX(EMP_NAME),럼
       MAX(EMAIL),
       MAX(SALARY),
       MAX(HIRE_DATE)
FROM EMPLOYEE;


/*
   4) COUNT : 컬럼 또는 행의 개수를 반환
      COUNT(* |[DISTINCT] 컬럼명)
      
      COUNT(*) : 조회 결과에서 모든 행의 개수를 반환
      COUNT(컬럼명) : 제시된 컬럼 값이 NULL이 아닌 행의 개수를 반환
      COUNT(DISTINCT 컬럼명) : 제시된 컬럼 값의 NULL 이 아닌 값과, 중복된 값을 제거한 행의 개수를 반환
*/


-- EMPLOYEE 테이블에서 전체 사원의 수를 조회
SELECT COUNT(*)
FROM EMPLOYEE;


-- EMPLOYEE 테이블에서 남자 사원의 수를 조회
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = '1';


-- EMPLOYEE 테이블에서 보너스를 받는 사원의 수를 조회
SELECT COUNT(BONUS)
FROM EMPLOYEE;

SELECT COUNT(*)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;


--EMPLOYEE 테이블에서 퇴사한 직원의 수를 조회
SELECT COUNT(*)
FROM EMPLOYEE
WHERE ENT_DATE IS NULL;

SELECT COUNT(*)-COUNT(ENT_DATE)
FROM EMPLOYEE;


--EMPLOYEE 테이블에서 부서가 배치된 사원의 수를 조회
SELECT COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL;

SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;


--EMPLOYEE 테이블에서 현재 사원들이 속해있는 부서의 수를 조회
SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;


--EMPLOYEE 테이블에서 현재 사원들이 분포되어 있는 직급의 수를 조회
SELECT COUNT(DISTINCT JOB_CODE)
FROM EMPLOYEE;
