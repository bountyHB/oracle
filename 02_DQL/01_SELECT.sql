/* 

    <SELECT>
      SELECT 컬럼 [, 컬럼, ...]
        FROM 테이블명;
        
        - 테이블에서 데이터를 조회할 때 사용하는 SQL 문이다.
        - SELECT를 통해서 조회된 결과를 RESULT SET이라고 한다.
        - 조회하고자 하는 컬럼은 반드시 FROM 절에 기술한 테이블에 존재하는 컬럼이어야 한다.
        - 모든 컬럼을 조회할 경우 컬럼명 대신 * 기호 사용할 수 있다. 
        
*/
-- *는 와일드 카드 : 모든이라는 뜻
-- 현재 계정이 소유한 테이블의 목록 조회
SELECT * FROM TABS; 

-- TABLE_NAME 에 있는 행만 보고싶을때
SELECT TABLE_NAME 
  FROM TABS;
  
-- 테이블의 컬럼 정보 확인
DESC EMPLOYEE;
 
-- EMPLOYEE 테이블에서 전체 사원의 모든 컬럼의 정보 조회
-- 하나씩 입력할 수 있음
SELECT EMP_ID, EMP_NAME, EMP_NO
  FROM EMPLOYEE;
  
-- * 와일드 카드이용
SELECT *
  FROM EMPLOYEE;
 
-- EMPLOYEE 테이블에서 전체 사원들의 사번, 이름, 급여만 조회
SELECT EMP_ID, EMP_NAME, SALARY
  FROM EMPLOYEE;
 
-- 아래와 같이 쿼리는 대소문자를 가리지 않지만 관례상 대문자로 작성한다.
select emp_id, emp_name, salary
  from employee;
  
-----실습문제-----
  
--1. JOB 테이블의 모든 컬럼 정보 조회
SELECT * 
 FROM JOB;
  
--2. JOB 테이블의 직급명 컬럼만 조회
SELECT JOB_NAME
 FROM JOB;

--3. DEPARTMENT 테이블의 모든 컬럼 정보 조회
SELECT *
 FROM DEPARTMENT;

  
--4. EMPLOYEE 테이블의 사원명, 이메일, 전화번호, 입사일(HIRE_DATE) 정보 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
 FROM EMPLOYEE;

----------------