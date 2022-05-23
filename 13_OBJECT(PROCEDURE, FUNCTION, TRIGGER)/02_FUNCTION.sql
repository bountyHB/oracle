/*
   <FUNCTION>
   프로시저와는 다르게 OUT 변수를 사용하지 않아도 실행 결과를 되돌려 받을 수 있다. (RETURN)
   
      [표현법]
      CREATE [OR REPLACE] FUNCTION 함수명
      ( 
         매개변수 1 타입,
         매개변수 2 타입,
         ... 
      )
      RETURN 데이터 타입
      IS [AS]
         선언부
      BEGIN
         실행부
    
         RETURN 반환값;
      [EXCEPTION
         예외 처리부]
      END [함수명];
      /
      
      [실행 방법]
      EXECUTE (또는 EXEC) 함수명[(매개값1, 매개값2, ...)];
*/


-- 사번을 입력받아 해당 사원의 보너스를 포함하는 연봉을 계산하고 리턴하는 함수 생성
CREATE FUNCTION BONUS_CALC
(
   V_EMP_ID EMPLOYEE.EMP_ID%TYPE
)
RETURN NUMBER
IS 
   SALARY EMPLOYEE.SALARY%TYPE;
   BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
   SELECT SALARY, NVL(BONUS,0)
   INTO SALARY, BONUS
   FROM EMPLOYEE
   WHERE EMP_ID = V_EMP_ID;
   
   RETURN (SALARY + (SALARY * BONUS)) * 12;
END;
/

-- 함수를 호출하면, 리턴 값이 조회된다.
SELECT BONUS_CALC('200') FROM DUAL;

-- 바인드 변수 생성
VAR VAR_BONUS_CALC NUMBER;

-- 바인드 변수를 대입
EXEC :VAR_BONUS_CALC := BONUS_CALC('200'); 

-- EMPLOYEE 테이블에서 전체 사원의 사번, 직원명, 급여, 보너스를 포함한 연봉을 조회 (BONUS_CALC 함수 사용)
SELECT EMP_ID, EMP_NAME, SALARY, BONUS, BONUS_CALC(EMP_ID)
FROM EMPLOYEE;
