/*
   <PL/SQL>
      오라클에 내장되어 있는 절차적 언어로 SQL 문장 내에서 변수를 정의, 조건 처리(IF),
      반복 처리(LOOP, WHILE, FOR)등을 지원한다.
*/


-- 출력 기능 활성화
SET SERVEROUTPUT ON;

-- HELLO WORLD 출력
BEGIN
   DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');   
END;
/


/*
   1. 선언부
      변수 및 상수를 선언하는 영역이다. (선언과 동시에 초기화도 가능)
      일반 타입, 레퍼런스 타입, ROW 타입 변수로 선언해서 사용할 수 있다.
      
      1) 일반 타입 변수 선언 및 초기화
      
      2) 레퍼런스 타입 변수 선언 및 초기화
         : 테이블의 컬럼에 데이터 타입을 참조한다.
      
      3) ROW 타입 변수 선언 및 초기화
         : 하나의 테이블의 모든 행을 한꺼번에 저장할 수 있는 변수를 선언할 수 있다.
*/


-- 1) 일반 타입 변수 선언 및 초기화

DECLARE
   EID NUMBER; -- 변수 생성
   ENAME VARCHAR2(15) := '김삿갓'; -- 생성과 동시에 초기화 
   PI CONSTANT NUMBER := 3.14; -- 상수는 선언과 동시에 초기화를 해야한다
BEGIN
   EID := 300; -- 변수 초기화
--   PI := 3.15; -- 상수는 초기화후 변경하려하면 에러가 발생한다
   
   DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
   DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
   DBMS_OUTPUT.PUT_LINE('PI : ' || PI);

END;
/


-- 2) 레퍼런스 타입 변수 선언 및 초기화
DECLARE 
   EID EMPLOYEE.EMP_ID%TYPE;-- EMP_ID의 타입을 참고하겠다 (VARCHAR2(3))
   ENAME EMPLOYEE.EMP_NAME%TYPE;
   SAL EMPLOYEE.SALARY%TYPE;
BEGIN
   -- 노옹철 사원의 사번, 직원명, 급여 정보를 EID, ENAME, SAL 변수에 대입 후 출력한다.
   SELECT EMP_ID, EMP_NAME, SALARY
   INTO EID, ENAME, SAL
   FROM EMPLOYEE
   WHERE EMP_NAME = '노옹철';
--   WHERE EMP_NAME = '&직원명'; -- 정보를 받은 후, 입력 받은 값으로 정부를 출력한다
   
   DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
   DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
   DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
   
END;
/


------------------- 실습 문제 -------------------
/*
   레퍼런스 타입 변수로 EID, ENAME, JCODE, DTITLE, SAL를 선언하고 
   각 변수의 자료형은 EMPLOYEE 테이블의 EMP_ID, EMP_NAME, JOB_CODE, SALARY 컬럼과 
   DEPARTMENT 테이블의 DEPT_TITLE 컬럼의 자료형을 참조한다.
   사용자가 입력한 사번과 일치하는 사원을 조회(사번, 직원명, 직급 코드, 부서명, 급여) 한 후 조회 결과를 각 변수에 
   대입하여 출력한다.
*/
-- 서브쿼리
SELECT E.EMP_ID, E.EMP_NAME, E.JOB_CODE, D.DEPT_TITLE, E.SALARY
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (D.DEPT_ID = E.DEPT_CODE);

-- PL
DECLARE 
   EID EMPLOYEE.EMP_ID%TYPE;
   ENAME EMPLOYEE.EMP_NAME%TYPE;
   JCODE EMPLOYEE.JOB_CODE%TYPE;
   DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
   SAL EMPLOYEE.SALARY%TYPE;
BEGIN
   -- 노옹철 사원의 사번, 직원명, 급여 정보를 EID, ENAME, SAL 변수에 대입 후 출력한다.
   SELECT E.EMP_ID, E.EMP_NAME, E.JOB_CODE, D.DEPT_TITLE, E.SALARY
   INTO EID, ENAME, JCODE, DTITLE, SAL
   FROM EMPLOYEE E
   JOIN DEPARTMENT D ON (D.DEPT_ID = E.DEPT_CODE)
   WHERE EMP_ID = '&사번'; -- 정보를 받은 후, 입력 받은 값으로 정부를 출력한다
   
   DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
   DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
   DBMS_OUTPUT.PUT_LINE('직급 코드 : ' || JCODE);
   DBMS_OUTPUT.PUT_LINE('부서 : ' || DTITLE);
   DBMS_OUTPUT.PUT_LINE('급여 : ' || SAL);
   
END;
/


-- 3. ROW 타입 변수 선언 및 초기화
DECLARE
   EMP EMPLOYEE%ROWTYPE; -- EMPLOYEE 테이블의 모든 행을 참조

BEGIN
   SELECT *
   INTO EMP
   FROM EMPLOYEE
   WHERE EMP_NAME = '&직원명';

   DBMS_OUTPUT.PUT_LINE('사번 : ' || EMP.EMP_ID);
   DBMS_OUTPUT.PUT_LINE('이름 : ' || EMP.EMP_NAME);
   DBMS_OUTPUT.PUT_LINE('주민 번호 : ' || EMP.EMP_NO);
   DBMS_OUTPUT.PUT_LINE('이메일 : ' || EMP.EMAIL);
   DBMS_OUTPUT.PUT_LINE('전화 번호 : ' || EMP.PHONE);
   DBMS_OUTPUT.PUT_LINE('부서 코드 : ' || EMP.DEPT_CODE);
   DBMS_OUTPUT.PUT_LINE('직급 코드 : ' || EMP.JOB_CODE);
   DBMS_OUTPUT.PUT_LINE('급여 : ' || TO_CHAR(EMP.SALARY,'FML99,999,999'));
   DBMS_OUTPUT.PUT_LINE('입사일 : ' || TO_CHAR(EMP.HIRE_DATE,'YYYY"년" MM"월" DD"일"'));
END;
/
