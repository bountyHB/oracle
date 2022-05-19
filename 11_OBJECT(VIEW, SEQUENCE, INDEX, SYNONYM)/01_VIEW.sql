/*
   <VIEW>
      SELECT 문을 저장할 수 있는 객체이다. (논리적인 가상 테이블)
      데이터를 저장하고 있지 않으며 테이블에 대한 SQL(Select Query Language)만 저장되어 있어 
      VIEW에 접근할 때 SQL을 수행하고 결과값을 가져온다.  
*/


-- 한국에서 근무하는 사원들의 사번, 직원명, 부서명, 급여, 근무 국가명을 조회
-- E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, E.SALARY, N.NATIONAL_NAME
SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, E.SALARY, N.NATIONAL_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
WHERE N.NATIONAL_NAME = '한국';

-- 일본에서 근무하는 사원들의 사번, 직원명, 부서명, 급여, 근무 국가명을 조회
SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, E.SALARY, N.NATIONAL_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
WHERE N.NATIONAL_NAME = '일본';

-- 관리자 계정으로 CREATE VIEW 권한을 부여한다.
GRANT CREATE VIEW TO KH;

-- VIEW 생성
CREATE VIEW V_EMPLOYEE
AS SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, E.SALARY, N.NATIONAL_NAME
   FROM EMPLOYEE E
   JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
   JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
   JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE);

-- 위에서 생성한 쿼리문이 실행된다.
SELECT * 
FROM V_EMPLOYEE; -- 가상 테이블로 실제 데이터가 담겨있는 것은 아니다.

-- 접속한 계정이 가지고 있는 VIEW의 정보를 조회하는 데이터 딕셔너리이다.
SELECT * FROM USER_VIEWS;
SELECT * FROM USER_TABLES;

-- VIEW 를 이용하여
-- 한국에서 근무하는 사원들의 사번, 직원명, 부서명, 급여, 근무 국가명을 조회
SELECT * 
FROM V_EMPLOYEE
WHERE NATIONAL_NAME = '한국';

-- 일본에서 근무하는 사원들의 사번, 직원명, 부서명, 급여, 근무 국가명을 조회
SELECT * 
FROM V_EMPLOYEE
WHERE NATIONAL_NAME = '일본';

-- 직원들의 사번, 직원명, 성별, 근무년수 조회할 수 있는 뷰를 생성
-- 쿼리문 생성
SELECT EMP_ID, 
       EMP_NAME, 
       DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여') "성별", 
       EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) "근무년수"
FROM EMPLOYEE;

-- VIEW 생성
-- 1) 서브 쿼리에서 별칭을 지정하는 방법
-- 서브 쿼리의 SELECT 절에 함수나 산술연산이 기술되어 있는 경우 반드시 컬럼에 별칭을 지정해야 한다.
CREATE VIEW V_EMP_01
AS SELECT EMP_ID, 
       EMP_NAME, 
       DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여') "성별", 
       EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) "근무년수"
   FROM EMPLOYEE;

-- 2) VIEW 생성 시 모든 컬럼에 별칭을 부여하는 방법
-- OR REPLACE : 똑같은 이름의 VIEW 위에 덮어쓴다.
CREATE OR REPLACE VIEW V_EMP_01 ("사번", "직원명", "성별", "근무년수") -- 모든 컬럼에 별칭을 부여해야 한다.
AS SELECT EMP_ID, 
       EMP_NAME, 
       DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여'), 
       EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
   FROM EMPLOYEE;

SELECT * FROM V_EMP_01;
DROP VIEW V_EMP_01;
