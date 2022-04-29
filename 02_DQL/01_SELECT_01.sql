/* 

    <SELECT>
         SELECT   컬럼 [, 컬럼, ...]
         FROM     테이블명;
        
        - 테이블에서 데이터를 조회할 때 사용하는 SQL 문이다.
        - SELECT를 통해서 조회된 결과를 RESULT SET이라고 한다.
        - 조회하고자 하는 컬럼은 반드시 FROM 절에 기술한 테이블에 존재하는 컬럼이어야 한다.
        - 모든 컬럼을 조회할 경우 컬럼명 대신 * 기호 사용할 수 있다. 
        
*/
-- *는 와일드 카드 : 모든이라는 뜻


-- 현재 계정이 소유한 테이블의 목록 조회
SELECT
   *
FROM
   TABS; 


-- TABLE_NAME 에 있는 행만 보고싶을때
SELECT
   TABLE_NAME
FROM
   TABS;
  
  
-- 테이블의 컬럼 정보 확인
DESC EMPLOYEE;
 
 
-- EMPLOYEE 테이블에서 전체 사원의 모든 컬럼의 정보 조회
-- 하나씩 입력할 수 있음
SELECT
   EMP_ID,
   EMP_NAME,
   EMP_NO
FROM
   EMPLOYEE;
  
  
-- * 와일드 카드이용
SELECT
   *
FROM
   EMPLOYEE;
 
 
-- EMPLOYEE 테이블에서 전체 사원들의 사번, 이름, 급여만 조회
SELECT
   EMP_ID,
   EMP_NAME,
   SALARY
FROM
   EMPLOYEE;
 
 
-- 아래와 같이 쿼리는 대소문자를 가리지 않지만 관례상 대문자로 작성한다.
SELECT
   EMP_ID,
   EMP_NAME,
   SALARY
FROM
   EMPLOYEE;
  
-----------------------실습문제--------------------------
  
--1. JOB 테이블의 모든 컬럼 정보 조회
SELECT
   *
FROM
   JOB;
  
  
--2. JOB 테이블의 직급명 컬럼만 조회
SELECT
   JOB_NAME
FROM
   JOB;

--3. DEPARTMENT 테이블의 모든 컬럼 정보 조회
SELECT
   *
FROM
   DEPARTMENT;

--4. EMPLOYEE 테이블의 사원명, 이메일, 전화번호, 입사일(HIRE_DATE) 정보 조회
SELECT
   EMP_NAME,
   EMAIL,
   PHONE,
   HIRE_DATE
FROM
   EMPLOYEE;

---------------------------------------------------------------
/*
    <컬럼의 산술 연산>
       SELECT 절에 컬럼면 입력 부분에서 산술 연산자를 사용하여 결과를 조회할 수 있다.
*/

-- EMPLOYEE 테이블에서 직원명, 직원의 연봉 (연봉 = 급여 * 12)
SELECT
   EMP_NAME,
   SALARY * 12
FROM
   EMPLOYEE;

-- EMPLOYEE 테이블에서 직원명, 급여, 연봉, 보너스가 포함된 연봉(급여 + 보너스 * 급여)
-- 산술 연산 중 NULL 값이 존재할 경우 산술 연산한 결과값은 무조건 NULL이다.
SELECT
   EMP_NAME,
   SALARY,
   SALARY * 12, 
--                    SALARY + (BONUS * SALARY)
   SALARY + ( NVL(BONUS, 0) * SALARY )
FROM
   EMPLOYEE;
    

-- SYSDATE는 현재 날짜를 출력한다.
SELECT
   SYSDATE
FROM
   DUAL;
    

-- EMPLOYEE 테이블에서 직원명, 입사일, 근무일수
-- DATE 타입도 연산이 가능하다.
SELECT
   EMP_NAME,
   HIRE_DATE,
   SYSDATE - HIRE_DATE
FROM
   EMPLOYEE;
    

-- CEIL 함수를 이용해서 올림
SELECT
   EMP_NAME,
   HIRE_DATE,
   CEIL(SYSDATE - HIRE_DATE) -- 매개값으로 전달되는 수를 올림하는 함수
FROM
   EMPLOYEE;

/*
<<<<<<< HEAD
    <컬럼 별칭>
       [표현법]
         컬럼 AS 별칭 / 컬럼 AS "별칭 / 컬럼 별칭 / 컬럼 "별칭"
           
        - 산술연산을 하게 되면 컬럼명이 지저분해진다. 이 때 컬럼명에 별칭을 부여해서 깔끔하게 보여줄 수 있다.
        - 별칭을 지정할 때 띄어쓰기 혹은 특수문자가 별칭에 포함될 경우에는 반드시 큰 따옴표로 감싸준다.
=======
         <컬럼 별칭>
            [표현법]
            컬럼 AS 별칭 / 컬럼 AS "별칭 / 컬럼 별칭 / 컬럼 "별칭"
                 
            - 산술연산을 하게 되면 컬럼명이 지저분해진다. 이 때 컬럼명에 별칭을 부여해서 깔끔하게 보여줄 수 있다.
            - 별칭을 지정할 때 띄어쓰기 혹은 특수문자가 별칭에 포함될 경우에는 반드시 큰 따옴표로 감싸준다.
>>>>>>> 51bb40abcd13762149554a7068046a5a9e2a55ef
*/

-- EMPLOYEE 테이블에서 직원명, 연봉, 보너스가 포함된 연봉(급여 + 보너스 * 급여)
SELECT
   EMP_NAME                            AS 직원명,
   SALARY * 12                         AS "연봉",
   SALARY + ( NVL(BONUS, 0) * SALARY ) "보너스가 포함된 연봉"
FROM
   EMPLOYEE;
    
    
/*
<<<<<<< HEAD
      <리터럴>
         SELECT 절에 리터럴을 사용하면 테이블에 존재하는 데이터처럼 조회가 가능하다.
         즉, 리터럴은 RESULT SET의 모든 행에 반복적으로 출력된다.
=======
            <리터럴>
              SELECT 절에 리터럴을 사용하면 테이블에 존재하는 데이터처럼 조회가 가능하다.
              즉, 리터럴은 RESULT SET의 모든 행에 반복적으로 출력된다.
>>>>>>> 51bb40abcd13762149554a7068046a5a9e2a55ef
            
*/

SELECT
   '안녕'
FROM
   DUAL;

SELECT
   EMP_NAME,
   '안녕하세용'
FROM
   EMPLOYEE;
    
    
-- EMPLOYEE 테이블에서 사번, 직원명, 급여, 단위(원) 조회
SELECT
   EMP_ID,
   EMP_NAME,
   SALARY,
   '원' AS "단위(원)"
FROM
   EMPLOYEE;
    
    
<<<<<<< HEAD
/*
      <DISTINCT>
        컬럼에 포함된 중복 값을 한 번씩만 표시하고자 할 때 사용한다. 
        SELECT 절에 한 번만 기술할 수 있다.
        컬럼이 여러 개이면 컬럼 값들이 모두 동일해야 중복 값으로 판단되어 중복이 제거된다.
 */
=======
    /*
            <DISTINCT>
              컬럼에 포함된 중복 값을 한 번씩만 표시하고자 할 때 사용한다. 
              SELECT 절에 한 번만 기술할 수 있다.
              컬럼이 여러 개이면 컬럼 값들이 모두 동일해야 중복 값으로 판단되어 중복이 제거된다.
   */
>>>>>>> 51bb40abcd13762149554a7068046a5a9e2a55ef
    
    
--  EMPLOYEE 테이블에서 직급 코드(중복제거) 조회
SELECT DISTINCT
   JOB_CODE
FROM
   EMPLOYEE
ORDER BY
   JOB_CODE;
                 
                 
-- EMPLOYEE 테이블에서 부서 코드(중복제거) 조회
SELECT DISTINCT
   DEPT_CODE
FROM
   EMPLOYEE
ORDER BY
   DEPT_CODE DESC; -- 내림차순     


-- DISTINCT는 SELECT 절에 한 번만 기술할 수 있다.
SELECT DISTINCT
   JOB_CODE,
   DEPT_CODE
FROM
   EMPLOYEE
ORDER BY
   JOB_CODE;
   
   
<<<<<<< HEAD
/*
      <WHERE>
         SELECT   컬럼 [, 컬럼, ...]
         FROM     테이블명
         WHERE    조건식;
            
       <비교 연산자>
         > ,  < , >= , <=   : 대소 비교
         =                  : 같다
         != , ^= , <>       : 같지 않다
=======
   /*
            <WHERE>
              SELECT   컬럼 [, 컬럼, ...]
              FROM     테이블명
              WHERE    조건식;
            
            <비교 연산자>
              > ,  < , >= , <=   :  대소 비교
              =                  : 같다
              != , ^= , <>        : 같지 않다
>>>>>>> 51bb40abcd13762149554a7068046a5a9e2a55ef
*/


-- EMPLOYEE 테이블에서 부서 코드가  D9과 일치하는 사원들의 모든 컬럼 조회
SELECT
   *
FROM
   EMPLOYEE; -- DEPT_CODE


SELECT
   *
FROM
   EMPLOYEE
WHERE
   DEPT_CODE = 'D9';


-- EMPLOYEE 테이블에서 부서 코드가  D9과 일치하는 사원들의 직원명, 부서 코드, 급여
SELECT
   *
FROM
   EMPLOYEE; -- EMP_NAME, DEPT_CODE, SALARY


SELECT
   EMP_NAME,
   DEPT_CODE,
   SALARY
FROM
   EMPLOYEE
WHERE
   DEPT_CODE = 'D9';
   
   
-- EMPLOYEE 테이블에서 부서 코드가  D9과 일치하지 않는 사원들의 사번, 직원명, 부서 코드
SELECT
   *
FROM
   EMPLOYEE; --EMP_ID, EMP_NAME, DEPT_CODE


SELECT
   EMP_ID,
   EMP_NAME,
   DEPT_CODE
FROM
   EMPLOYEE
-- WHERE DEPT_CODE != 'D9';
-- WHERE DEPT_CODE ^= 'D9';
WHERE
   DEPT_CODE <> 'D9';
   
   
-- EMPLOYEE 테이블에서 급여가 400만원 이상인 직원들의 직원명, 부서 코드, 급여 조회
SELECT
   *
FROM
   EMPLOYEE; -- EMP_NAME, DEPT_CODE, SALARY 


SELECT
   EMP_NAME  AS "직원명",
   DEPT_CODE AS "부서 코드",
   SALARY    AS "급여"
FROM
   EMPLOYEE
WHERE
   SALARY >= 4000000;


-- EMPLOYEE 테이블에서 재직 중인 직원들의 사번, 이름, 입사일 조회
SELECT
   *
FROM
   EMPLOYEE; -- EMP_ID, EMP_NAME,  HIRE_DATE, ENT_YN


SELECT
   EMP_ID    AS "사번",
   EMP_NAME  AS "이름",
   HIRE_DATE AS "입사일"
FROM
   EMPLOYEE
WHERE
   ENT_YN = 'N';
--WHERE NET_NATE != NULL; 은 불가. NULL은 비교 연산자를 사용해서 사용 불가하다.
--NULL은 IS NULL 이라는 연산자만 사용 가능하다.
   
   
--EMPLOYEE 테이블에서 연봉이 5000만원 이상인 직원들의 직원명, 급여, 연봉, 입사일 조회
SELECT
   *
FROM
   EMPLOYEE; -- EMP_NAME,  SALARY, SALARY * 12 AS "연봉", HIRE_DATE


SELECT
   EMP_NAME    AS "직원명",
   SALARY      AS "급여",
   SALARY * 12 AS "연봉",
   HIRE_DATE   AS "입사일"
FROM
   EMPLOYEE
WHERE
   SALARY * 12 >= 50000000;


---------------------------------------------------------------------------------------------------------

   /*
<<<<<<< HEAD
      <ORDER BY>
          SELECT       컬럼 [, 컬럼, ...]
          FROM         테이블명
          WHERE        조건식
          ORDER BY     컬럼 | 별칭 | 컬럼 순번   [ASC | DESC]   [NULLS FIRST | NULLS LAST];

         - ASC          : 오름차순 정렬 (ASC, DESC 생략 시 기본값)
         - DESC         : 내림차순 정렬
         - NULL FIRST   : 정렬하고자 하는 컬럼 값에 NULL이 있는 경우 NULL 값을 맨 앞으로 정렬한다. 
         - NULL LAST    : 정렬하고자 하는 컬럼 값에 NULL이 있는 경우 NULL 값을 맨 뒤로 정렬한다. 
            
      <SELECT문이 실행(해석) 되는 순서>   
         1. FROM 절
         2. WHERE 절
         3. SELECT 절
         4. ORDER BY 절
=======
            <ORDER BY>
               SELECT       컬럼 [, 컬럼, ...]
               FROM         테이블명
               WHERE        조건식
               ORDER BY     컬럼 | 별칭 | 컬럼 순번   [ASC | DESC]   [NULLS FIRST | NULLS LAST];

               - ASC  : 오름차순 정렬 (ASC, DESC 생략 시 기본값)
               - DESC : 내림차순 정렬
               - NULL FIRST   : 정렬하고자 하는 컬럼 값에 NULL이 있는 경우 NULL 값을 맨 앞으로 정렬한다. 
               - NULL LAST    : 정렬하고자 하는 컬럼 값에 NULL이 있는 경우 NULL 값을 맨 뒤로 정렬한다. 
            
           <SELECT문이 실행(해석) 되는 순서>   
               1. FROM 절
               2. WHERE 절
               3. SELECT 절
               4. ORDER BY 절
>>>>>>> 51bb40abcd13762149554a7068046a5a9e2a55ef
         
*/


-- EMPLOYEE 테이블에서 BONUS로 오름차순 정렬
SELECT
   *
FROM
   EMPLOYEE
ORDER BY
   BONUS;
ORDER BY BONUS ASC; -- 오름차순 정렬은 기본적으로 NULLS LAST
ORDER BY BONUS NULLS FIRST;
ORDER BY BONUS ASC NULLS FIRST;


-- EMPLOYEE 테이블에서 BONUS로 내림차순 정렬 (단, BONUS 값이 일치할 경우에는 SALARY 가지고 오름차순 정렬)
SELECT * 
FROM EMPLOYEE
--ORDER BY BONUS DESC; -- 내림차순 정렬은 기본적으로 NULLS FIRST
--ORDER BY BONUS DESC NULLS LAST;
ORDER BY BONUS DESC NULLS LAST,
SALARY;  -- 정렬 기준 여러 개를 제시할 수 있다.


-- EMPLOYEE 테이블에서 연봉별 내림차순으로 정렬된 직원들의 직원명, 연봉 조회
SELECT
   EMP_NAME    AS "직원명",
   SALARY * 12 AS "연봉"
FROM
   EMPLOYEE
--ORDER BY SALARY * 12 DESC;
--ORDER BY "연봉" DESC;
ORDER BY
   1 DESC;
