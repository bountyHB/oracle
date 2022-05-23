/*
   <PROCEDURE> 
   PL&SQL 문을 저장하는 객체이다.
   특정 로직을 처리하기만 하고 결과값을 반환하지 않는다.
   
      [표현법]
      CREATE [OR REPLACE] PROCEDURE 프로시저명
      (
         매개변수 1 [IN|OUT] 데이터 타입 [:= DEFAULT 값],
         매개변수 2 [IN|OUT] 데이터 타입 [:= DEFAULT 값],
         ...
      )
      IS [AS]
         선언부
      BEGIN
         실행부
      [EXCEPTION
         예외 처리부]
      END [프로시저명];
      /
         
      [실행 방법]
      EXECUTE (또는 EXEC) 프로시저명[(매개값1, 매개값2, ...)];
*/


-- 테스트용 테이블 생성
CREATE TABLE EMP_COPY
AS SELECT *
   FROM EMPLOYEE;
   
SELECT * FROM EMP_COPY;

-- EMP_COPY 데이터를 모두 삭제하는 프로시저 생성
CREATE PROCEDURE DEL_ALL_EMP
IS 
BEGIN
   DELETE FROM EMP_COPY;
   COMMIT; -- PCL
END;
/

-- DEL_ALL_EMP 프로시저 호출
EXECUTE DEL_ALL_EMP;

-- 프로시저를 관리하는 데이터 딕셔너리
SELECT * FROM USER_SOURCE;

-- 프로시저 삭제
DROP PROCEDURE DEL_ALL_EMP;
DROP TABLE EMP_COPY;


/*
   1. 매개변수가 있는 프로시저
*/


-- 사번을 입력 받아서 해당하는 사번의 사원을 삭제하는 프로시저 생성
CREATE PROCEDURE DEL_EMP_ID (
   P_EMP_ID EMPLOYEE.EMP_ID%TYPE
)
IS
BEGIN
   DELETE FROM EMPLOYEE
   WHERE EMP_ID = P_EMP_ID;
END DEL_EMP_ID;
/

SELECT * FROM EMPLOYEE;

-- 프로시저 실행 (매개 변수로 매개 값을 전달해야 한다.)
EXEC DEL_EMP_ID; -- 매개 값을 전달하지 않아 에러 발생 
EXEC DEL_EMP_ID('200');  

-- 사용자가 입력한 값도 전달이 가능하다.
EXEC DEL_EMP_ID('&사번');  

SELECT * FROM EMPLOYEE; -- 200 번 사원 지워진 것 확인

ROLLBACK;


/*
   2. IN/OUT 매개변수가 있는 프로시저
*/


-- 사번을 입력 받아서 해당하는 사원의 정보를 전달하는 프로시저 생성
CREATE PROCEDURE SELECT_EMP_ID(
   P_EMP_ID IN EMPLOYEE.EMP_ID%TYPE,
   P_EMP_NAME OUT EMPLOYEE.EMP_NAME%TYPE,
   P_SALARY OUT EMPLOYEE.SALARY%TYPE,
   P_BONUS OUT EMPLOYEE.BONUS%TYPE
)
IS
BEGIN
   SELECT EMP_NAME, SALARY, BONUS
   INTO P_EMP_NAME, P_SALARY, P_BONUS
   FROM EMPLOYEE
   WHERE EMP_ID = P_EMP_ID;
END;
/

-- * 바인드 변수 (VARIAVLE 또는 VAR)
-- DBMS에 변수선언 하는것. 한번씩 다 실행 시켜야 함.
VARIABLE VAR_EMP_NAME VARCHAR2(30);
VARIABLE VAR_SALARY NUMBER;
VAR VAR_BONUS NUMBER;

-- 실행하면서 변수의 주소값을 넘겨준다.
EXEC SELECT_EMP_ID('205', :VAR_EMP_NAME, :VAR_SALARY, :VAR_BONUS); 

-- 바인드 변수의 값을 출력하기 위해서 PRINT 명령을 사용한다.
PRINT VAR_EMP_NAME;
PRINT VAR_SALARY;
PRINT VAR_BONUS;

-- PL&SQL 블럭에서 사용되는 바인드 변수의 값을 자동으로 출력한다. (값의 변화가 생겼을 시)
SET AUTOPRINT ON;
EXEC SELECT_EMP_ID('&사번', :VAR_EMP_NAME, :VAR_SALARY, :VAR_BONUS);
