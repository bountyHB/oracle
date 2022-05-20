/*
   2. 실행부
      BEGIN으로 시작, 제어문, 반복문, 함수 정의 등 로직을 기술하는 영역이다.


   1) 단일 IF 문
      IF 조건식 THEN
         실행 문장
      END IF;
*/

-- 출력 기능 활성화
SET SERVEROUTPUT ON;

SELECT * FROM EMPLOYEE;
-- 사번을 입력받은 후 해당 사원의 사번, 이름, 급여, 보너스를 출력
-- 단, 보너스를 받지 않는 사원은 보너스 출력 전에 '보너스를 지급받지 않는 사원입니다.'라는 문구를 출력한다.

SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE EMP_ID = 200;

DECLARE
   EID EMPLOYEE.EMP_ID%TYPE;
   ENAME EMPLOYEE.EMP_NAME%TYPE;
   SALARY EMPLOYEE.SALARY%TYPE;
   BONUS EMPLOYEE.BONUS%TYPE;

BEGIN
   SELECT EMP_ID, EMP_NAME, SALARY, BONUS
   INTO EID, ENAME, SALARY, BONUS
   FROM EMPLOYEE
   WHERE EMP_ID = &사번;

   DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
   DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
   DBMS_OUTPUT.PUT_LINE('급여 : ' || TO_CHAR(SALARY,'FML99,999,999'));
   
   IF (BONUS IS NULL) THEN
   DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.');
   END IF;
   DBMS_OUTPUT.PUT_LINE('보너스 : ' || BONUS);
END;
/


/*
   2) IF ~ ELSE 구문
      IF 조건식 THEN
         실행 문장
      ELSE 
         실행 문장
      END IF;
*/


-- 위의 PL/SQL 구문을 IF ELSE 구문으로 바꾸어 작성
DECLARE
   EID EMPLOYEE.EMP_ID%TYPE;
   ENAME EMPLOYEE.EMP_NAME%TYPE;
   SALARY EMPLOYEE.SALARY%TYPE;
   BONUS EMPLOYEE.BONUS%TYPE;

BEGIN
   SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
   INTO EID, ENAME, SALARY, BONUS
   FROM EMPLOYEE
   WHERE EMP_ID = &사번;

   DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
   DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
   DBMS_OUTPUT.PUT_LINE('급여 : ' || TO_CHAR(SALARY,'FML99,999,999'));
   
--   IF (BONUS IS NULL) THEN
   IF (BONUS = 0) THEN
   DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.');
   ELSE
   DBMS_OUTPUT.PUT_LINE('보너스율: ' || BONUS * 100 || '%');
   END IF;
   
END;
/


-- 사번을 입력받아 해당 사원의 사번, 이름, 부서명, 국가 코드를 조회한 후 출력한다.
-- 단, 국가 코드가 KO 이면 국태임 그 외는 해외팀으로 출력한다.

SELECT * FROM EMPLOYEE; -- E.DEPT_CODE = D.DEPT_ID
SELECT * FROM DEPARTMENT; -- D.LOCATION_ID = L.LOCAL_CODE
SELECT * FROM LOCATION; -- L.NATIONAL_CODE = N.NATIONAL_CODE

SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, L.NATIONAL_CODE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE);

DECLARE
   EID EMPLOYEE.EMP_ID%TYPE; 
   ENAME EMPLOYEE.EMP_NAME%TYPE;
   DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
   NCODE LOCATION.NATIONAL_CODE%TYPE;
 
BEGIN
   SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, L.NATIONAL_CODE
   INTO EID, ENAME, DTITLE, NCODE
   FROM EMPLOYEE E
   JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
   JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
   WHERE EMP_ID = '&사번';
  
   DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
   DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
   DBMS_OUTPUT.PUT_LINE('부서명 : ' || DTITLE);


   IF (NCODE = 'KO') THEN
   DBMS_OUTPUT.PUT_LINE('국가코드 : ' || NCODE);
   DBMS_OUTPUT.PUT_LINE('국내팀');
   
   ELSE 
   DBMS_OUTPUT.PUT_LINE('국가코드 : ' || NCODE);
   DBMS_OUTPUT.PUT_LINE('해외팀');
   END IF;
   
END;
/


/*
   3) IF ~ ELSIF ~ ELSE 구문
      IF 조건식 THEN
         실행 문장
      ELSIF 조건식 THEN
         실행 문장
         ...
      ELSE
         실행 문장
      END IF;
*/


-- 사용자에게 점수를 입력받아서 SCORE 변수에 저장한 후 학점은 입력된 점수에 따라 GRADE 변수에 저장한다.
-- 90점 이상은 'A' 학점
-- 80점 이상은 'B' 학점
-- 70점 이상은 'C' 학점
-- 60점 이상은 'D' 학점
-- 60점 미만은 'F' 학점
-- 출력은 '당신의 점수는 95점이고, 학점은 A학점입니다.'와 같이 출력한다.

DECLARE
   SCORE NUMBER;
   GRADE CHAR(1);

BEGIN
   SCORE := '&점수';

   IF(SCORE>= 100 OR SCORE <0) THEN
      DBMS_OUTPUT.PUT_LINE('점수를 잘못 입력하였습니다.');
      RETURN;
   ELSIF (SCORE>= 90) THEN
      GRADE := 'A';
   ELSIF (SCORE>= 80) THEN
      GRADE := 'B';
   ELSIF (SCORE>= 70) THEN
      GRADE := 'C';
   ELSIF (SCORE>= 60) THEN
      GRADE := 'D';
   ELSE 
      GRADE := 'F';
   END IF;

   DBMS_OUTPUT.PUT_LINE('당신의 점수는' ||SCORE||'점이고, 학점은 ' ||GRADE||'학점 입니다.');

END;
/


-- 사용자에게 입력받은 사번과 일치하는 사원의 급여 조회 후 출력
-- 500만원 이상이면 '고급' 
-- 300만원 이상이면 '중급' 
-- 300만원 미만이면 '초급' 
-- 출력은 '해당 사원의 급여 등급은 고급입니다.' 

SELECT EMP_ID, SALARY
FROM EMPLOYEE;

DECLARE
   EID EMPLOYEE.EMP_ID%TYPE;
   SAL EMPLOYEE.SALARY%TYPE; 
   GRADE VARCHAR2(10);

BEGIN

   SELECT EMP_ID, SALARY
   INTO EID, SAL
   FROM EMPLOYEE
   WHERE EMP_ID = '&사번';

   IF (SAL>=5000000) THEN
      GRADE := '고급';
   ELSIF (SAL>=3000000) THEN
      GRADE := '중급';
   ELSE 
      GRADE := '초급';
   END IF;

   DBMS_OUTPUT.PUT_LINE('해당 사원의 급여 등급은 ' ||GRADE|| '입니다.');

END;
/


-- 입력 값을 변수에 담아, 다른 테이블에서 변수를 이용하여 조회.
DECLARE
   SAL EMPLOYEE.SALARY%TYPE;
   GRADE SAL_GRADE.SAL_LEVEL%TYPE;

BEGIN
-- 앞에서 사번 입력 받은걸 SAL 변수에 담고
   SELECT SALARY
   INTO SAL
   FROM EMPLOYEE
   WHERE EMP_ID = '&사번';
-- 두번째 절에서 변수 샐러리를 이용해서 GRADE 변수에 담았다.
   SELECT SAL_LEVEL
   INTO GRADE
   FROM SAL_GRADE
   WHERE SAL BETWEEN MIN_SAL AND MAX_SAL;
   
   DBMS_OUTPUT.PUT_LINE('SAL : '||SAL);
   DBMS_OUTPUT.PUT_LINE('GRADE : '||GRADE);
   DBMS_OUTPUT.PUT_LINE('해당 사원의 급여 등급은 ' ||GRADE|| '입니다.');

END;
/


/*
   4) CASE 구문
      CASE 비교 대상
         WHEN 비교값 1 THEN 결과값 1
         WHEN 비교값 2 THEN 결과값 2
         ...
         [ELSE 결과값]
      END;
*/


-- 사용자로부터 사번을 입력받은 후에 사원의 모든 컬럼에 데이터를 EMP에 대입하고 DEPT_CODE에 따라 알맞는 부서를 출력한다.
DECLARE
   EMP EMPLOYEE%ROWTYPE;
   DTITLE VARCHAR2(30);
BEGIN
   SELECT *
   INTO EMP
   FROM EMPLOYEE
   WHERE EMP_ID = '&사번';

   DTITLE := CASE EMP.DEPT_CODE
                  WHEN 'D1' THEN '인사관리부'
                  WHEN 'D2' THEN '회계관리부'
                  WHEN 'D3' THEN '마케팅부'
                  WHEN 'D4' THEN '국내영업부'
                  WHEN 'D5' THEN '해외영업1부'
                  WHEN 'D6' THEN '해외영업2부'
                  WHEN 'D7' THEN '해외영업2부'
                  WHEN 'D8' THEN '기술지원부'
                  WHEN 'D9' THEN '총무부'
                  ELSE '부서없음'
             END; 
 
   DBMS_OUTPUT.PUT_LINE('사번 : ' || EMP.EMP_ID);
   DBMS_OUTPUT.PUT_LINE('이름 : ' || EMP.EMP_NAME);
   DBMS_OUTPUT.PUT_LINE('부서 코드 : ' || EMP.DEPT_CODE);
   DBMS_OUTPUT.PUT_LINE('부서명 : ' || DTITLE);

END;
/
