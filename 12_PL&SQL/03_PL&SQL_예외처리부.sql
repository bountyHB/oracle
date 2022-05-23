/*
   3. 예외처리부 : PL/SQL 문에서 발생한 예외를 처리하는 영역이다.
      DECLARE
          ...
      BEGIN
          ...
      EXCEPTION
        WHEN 예외명 1 THEN 예외 처리 구문 1;
        WHEN 예외명 2 THEN 예외 처리 구문 2;
        ...
        WHEN OTHERS THEN 예외 처리 구문;
      END
      
      
      * 오라클에서 미리 정의되어 있는 예외
      
         NO_DATA_FOUND 
         : SELECT 문의 수행 결과가 한 행도 없을 경우에 발생한다.
         
         TOO_MANY_ROWS 
         : 한 행이 리턴되어야 하는데 SELECT 문에서 여러 개의 행을 반환할때 발생한다.
         
         ZERO_DIVIDE   
         : 숫자를 0으로 나눌 때 발생한다.
         
         DUP_VAL_ON_INDEX 
         : UNIQUE 제약조건을 가진 컬럼에 중복된 데이터가 INSERT 될 때 발생한다.
*/


-- 사용자가 입력한 수로 나눗셈 연산 결과를 출력 
-- 0을 입력시 DIVISOR IS EQUAL TO ZERO 에러가 발생한다.
DECLARE
   RESULT NUMBER;
BEGIN
   RESULT := 10 / &숫자;
   
   DBMS_OUTPUT.PUT_LINE('결과 : ' || RESULT);
END;
/

-- 예외처리 코드 (ZERO_DIVIDE)
DECLARE
   RESULT NUMBER;
BEGIN
   RESULT := 10 / &숫자;
   
   DBMS_OUTPUT.PUT_LINE('결과 : ' || RESULT);
EXCEPTION
   WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('0으로 나눌 수 없습니다.');
END;
/

-- UNIQUE 제약조건 위배 시 (DUP_VAL_ON_INDEX)
BEGIN
   UPDATE EMPLOYEE
   SET EMP_ID = 200
   WHERE EMP_NAME = '&이름';
EXCEPTION   
   WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('이미 존재하는 사번입니다.');
   WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('오류가 발생했습니다.');
END;
/

-- 너무 많은 행이 조회가 되었을 때 (TOO_MANY_ROWS) 
-- 데이터가 발견되지 않았을 때 (NO_DATA_FOUND)
DECLARE
   EID EMPLOYEE.EMP_ID%TYPE;
   MID EMPLOYEE.MANAGER_ID%TYPE;
BEGIN
   SELECT EMP_ID, MANAGER_ID
   INTO EID, MID
   FROM EMPLOYEE
   WHERE MANAGER_ID = '&사수사번';

   DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
   DBMS_OUTPUT.PUT_LINE('사수 사번 : ' || MID);
EXCEPTION
   WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('너무 많은 행이 조회되었습니다.'); -- 200번 입력시
   WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('데이터가 존재하지 않습니다.'); -- 300번 입력시
   WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('오류가 발생했습니다.');
END;
/