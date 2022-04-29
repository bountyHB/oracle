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
         OR  (~이거나, 또는)
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

/*
   <LIKE>
      WHERE 컬럼 LIKE '특정 패턴'
            
      컬럼 값이 지정된 특정 패턴을 만족할 경우 검색 대상이 된다.
      특정 패턴에는 %, _ 를 와일드카드로 사용할 수 있다.
      
      % : 0 글자 이상
      ex)컬럼 LIKE '문자%'  -> 컬럼 값 중에 '문자'로 시작하는 모든 행을 조회한다.
         컬럼 LIKE '%문자'  -> 컬럼 값 중에 '문자'로 끝나는 모든 행을 조회한다.
         컬럼 LIKE '%문자%' -> 컬럼 값 중에 '문자'가 포함되어 있는 모든 행을 조회한다.

      _ : 1 글자 이상
      ex)컬럼 LIKE '_문자'  -> 컬럼 값 중에 '문자' 앞에 무조건 한 글자가 오는 모든 행을 조회한다.
         컬럼 LIKE '__문자' -> 컬럼 값 중에 '문자' 앞에 무조건 두 글자가 오는 모든 행을 조회한다.
*/


-- EMPLOYEE 테이블에서 성이 전 씨인 사원의 직원명, 급여, 입사일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';


-- EMPLOYEE 테이블에서 이름 중에 '하'가 포함된 사원들의 직원명, 주민번호, 부서 코드 조회
SELECT EMP_NAME, EMP_NO, DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';


-- EMPLOYEE 테이블에서 김씨 성이 아닌 사원들의 사번, 직원명, 입사일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME NOT LIKE '김%';


-- EMPLOYEE 테이블에서 전화번호 4번째 자리가 9로 시작하는 사원들의 사번, 직원명, 전화번호, 이메일 조회
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';


-- EMPLOYEE 테이블에서 이메일 중 _ 앞 글자가 3자리인 이메일 주소를 가진 사원들의 사번, 직원명, 이메일 조회
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___$_%' ESCAPE '$'; -- ESCAPE 문자는 임의의 문자로 지정 가능

/*
   <IS NULL>
      WHERE 컬럼 IS NULL
      
      컬럼 값에 NULL이 있을 경우 검색 대상이 된다.

*/

-- EMPLOYEE 테이블에서 보너스를 받지 않는 사원의 사번, 직원명, 급여
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
--WHERE BONUS = NULL; -- NULL은 비교연산자로 비교할 수 없다.
WHERE BONUS IS NULL; 


-- EMPLOYEE 테이블에서 관리자(사수)가 없는 사원의 이름, 부서 코드 조회
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL; 


-- EMPLOYEE 테이블에서 관리자도 없고 부서도 배치 받지 않은 사원의 이름, 부서코드 조회
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL ; 


-- EMPLOYEE 테이블에서 부서 배치를 받진 않았지만 보너스를 받는 사원의 직원명, 부서 코드, 보너스 조회
SELECT EMP_NAME, DEPT_CODE, BONUS
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;


/*
   <연산자 우선순위>
      
*/


-- EMPLOYEE 테이블에서 직급 코드가 J2 또는 J7 직급인 사원들 중 급여가 200만원 이상인 사원들의 모든 컬럼을 조회

--1. AND가 먼저 실행되기 때문에 J7 AND 2000000 먼저 출력, 그 후 OR 의 조건인 J7의 모든 직원이 출력된다.
SELECT *
FROM EMPLOYEE
WHERE JOB_CODE = 'J7' OR JOB_CODE = 'J2' AND SALARY >= 2000000; 

--2. 괄호로 묶은 연산이 우선 실행된다.
SELECT *
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J2') AND SALARY >= 2000000;

--3. 또는 IN을 사용할 수 있다.
SELECT *
FROM EMPLOYEE
WHERE JOB_CODE IN ('J7','J2') AND SALARY >= 2000000;
