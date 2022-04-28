/*
      <연결 연산자>
            여러 컬럼 값들을 하나의 컬럼인 것처럼 연결하거나, 컬럼과 리터럴을 연결할 수 있는 연산자이다.
*/


-- EMPLOYEE 테이블에서 사번, 직원명, 급여를 연결해서 조회
SELECT EMP_ID || EMP_NAME || SALARY AS "사번 직원명 급여"
FROM EMPLOYEE;


--EMPLOYEE 테이블에서 직원명, 급여를 리터럴과 연결해서 조회
SELECT EMP_NAME || '의 월급은 ' || SALARY || '원 입니다.' AS "급여 정보"
FROM EMPLOYEE;

/*
      <논리 연산자>
            AND (~이면서, 그리고)
            OR    (~이거나, 또는)
*/


--EMPLOYEE 테이블에서 부서 코드가  D6이면서 급여가 300만원 이상인 직원들의 사번, 직원명, 부서 코드, 급여 조회
SELECT   EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' AND SALARY >= 3000000;


--EMPLOYEE 테이블에서 부서 코드가  D5이거나 급여가 500만원 이상인 직원들의 사번, 직원명, 부서코드, 급여 조회
SELECT   EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY >= 5000000;


--EMPLOYEE 테이블에서 급여가  350만원 이상 600만원 이하를 받는  직원들의 사번, 직원명, 부서코드, 급여 조회
SELECT   EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE   SALARY >= 3500000  AND SALARY <= 6000000
ORDER BY SALARY;

/*
         <BETWEEN AND>
              WHERE 컬럼 BETWEEN 하한값 AND 상한값
               
               WHERE 절에서 사용되는 연산자로 범위에 대한 조건을 제시할 때 사용한다.
               컬럼의 값이 하한값 이상이고, 상한값 이하인 경우 검색 대상이된다.
*/


--EMPLOYEE 테이블에서 급여가  350만원 이상 600만원 이하를 받는  직원들의 사번, 직원명, 부서코드, 급여 조회
SELECT   EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE   SALARY BETWEEN 3500000  AND 6000000
ORDER BY SALARY;


-- EMPLOYEE 테이블에서 급여가  350만원 이상 600만원 이하가 아닌  직원들의 사번, 직원명, 부서코드, 급여 조회
SELECT   EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--WHERE NOT SALARY BETWEEN 3500000  AND 6000000
WHERE  SALARY NOT BETWEEN 3500000  AND 6000000 -- NOT 연산자는 컬럼면 앞 또는 BETWWEN 앞에 사용 가능
ORDER BY SALARY;


-- EMPLOYEE 테이블에서 입사일 '90/01/01' ~ '01/01/01'인 사원의 모든 컬럼 조회
SELECT   *
FROM EMPLOYEE
WHERE   HIRE_DATE BETWEEN  '90/01/01' AND '01/01/01'
ORDER BY HIRE_DATE DESC;


-- EMPLOYEE 테이블에서 입사일 '90/01/01' ~ '01/01/01'이 아닌 사원의 모든 컬럼 조회
SELECT   *
FROM EMPLOYEE
WHERE   HIRE_DATE NOT BETWEEN  '90/01/01' AND '01/01/01'
ORDER BY HIRE_DATE DESC;


/*
         <IN>
            WHERE 컬럼 IN (값, 값, ..., 값) 

           컬럼의 값이 값 목록 중에 일치하는 값이 있을 때 검색 대상이 된다.
*/


--EMPLOYEE  테이블에서 부서 코드가 'D5', 'D6', 'D8' 인 부서원들의 직원명, 부서 코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--WHERE DEPT_CODE  = 'D5' OR DEPT_CODE  = 'D6' OR DEPT_CODE  = 'D8';
--WHERE DEPT_CODE BETWEEN 'D5' AND 'D8'
WHERE DEPT_CODE IN ('D5', 'D6', 'D8') 
ORDER BY DEPT_CODE;
