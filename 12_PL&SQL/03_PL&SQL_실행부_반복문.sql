/*
   2) 반복문

   1) BASIC LOOP
      LOOP
      반복적으로 실행시킬 구문

        [반복문을 빠져나갈 조건문 작성]
        1) IF 조건식 THEN EXIT; END IF; 
        2) EIXT WHEN 조건식;
      END LOOP;
*/


-- 1 ~ 5까지 순차적으로 1씩 증가하는 값을 출력 (IF THEN EXIT)
DECLARE
   NUM NUMBER := 1;   
BEGIN
   LOOP
      NUM := NUM + 1;
      DBMS_OUTPUT.PUT_LINE(NUM);
   
      IF NUM > 5 THEN
         EXIT;
      END IF;
   END LOOP;
END;
/

-- 1 ~ 5까지 순차적으로 1씩 증가하는 값을 출력 (EXIT WHEN)
DECLARE
   NUM NUMBER := 1;   
BEGIN
   LOOP
      NUM := NUM + 1;
      DBMS_OUTPUT.PUT_LINE(NUM);
   
      EXIT WHEN NUM >= 5;
   END LOOP;
END;
/


/*
   2) WHILE LOOP
      WHILE 조건식
      LOOP
        반복적으로 실행할 구문;
      END LOOP;
*/


-- 1 ~ 5까지 순차적으로 1씩 증가하는 값을 출력
DECLARE
   NUM NUMBER := 1;
BEGIN
   WHILE NUM < 5
   LOOP
      NUM := NUM + 1;
      DBMS_OUTPUT.PUT_LINE(NUM);
   END LOOP;
END;
/

-- 구구단 출력 (2 ~ 9단) (이중 FOR문)
DECLARE
   DAN NUMBER := 2;
   SU NUMBER;
   RESULT NUMBER;
BEGIN
   WHILE DAN <= 9
   LOOP 
      SU := 1;
      WHILE SU <= 9
         LOOP
         RESULT := DAN * SU;
         DBMS_OUTPUT.PUT_LINE(DAN || 'X' || SU || '=' ||RESULT);
         SU := SU + 1;
      END LOOP;
      DBMS_OUTPUT.PUT_LINE('');
      DAN := DAN + 1;
   END LOOP;
END;
/


/*
   3) FOR LOOP (반복 횟수를 알고 있을때)
      FOR 변수 IN [REVERSE] 초기값..최종값
      LOOP
        반복적으로 실행할 구문;
      END LOOP;
*/


-- 1 ~ 5까지 순차적으로 1씩 증가하는 값을 출력 (FOR LOOP)
BEGIN
   FOR NUM IN 1..5 -- 횟수 지정
   LOOP
      DBMS_OUTPUT.PUT_LINE(NUM);
   END LOOP;
END;
/

-- 5 ~ 1까지 순차적으로 1씩 증가하는 값을 출력 (FOR LOOP)
BEGIN
   FOR NUM IN REVERSE 1..5
   LOOP
      DBMS_OUTPUT.PUT_LINE(NUM);
   END LOOP;
END;
/


-- 구구단 출력 (2 ~ 9단) 단, 짝수단만 출력한다.
-- 내 방법
BEGIN
   FOR NUM1 IN 2..9
   LOOP
      FOR NUM2 IN 1..9
      LOOP
         IF (MOD(NUM1, 2) = 0) THEN
            DBMS_OUTPUT.PUT_LINE(NUM1 || 'X' || NUM2 || '=' || NUM1 * NUM2);
         END IF;
      END LOOP;
   END LOOP;
END;
/

-- 선생님 방법
BEGIN
   FOR DAN IN 2..9
   LOOP
      IF (MOD(DAN, 2) = 0) THEN
         FOR SU IN 1..9
         LOOP
            DBMS_OUTPUT.PUT_LINE(DAN || 'X' || SU || '=' || DAN * SU);
         END LOOP;
            DBMS_OUTPUT.PUT_LINE('');
      END IF;
   END LOOP;
END;
/

-- 반복문을 이용한 데이터 삽입
DROP TABLE TEST;

CREATE TABLE TEST (
   NUM NUMBER,
   CREATE_DATE DATE
);

SELECT * FROM TEST;

-- PL/SQL도 DML, TCL을 사용할 수 있다.
-- TEST 테이블에 10개의 행을 INSERT 하는 PL/SQL 작성 (BASIC LOOP) + (DML)
BEGIN
   FOR NUM IN 1..10
   LOOP
      INSERT INTO TEST VALUES(NUM, SYSDATE);
   END LOOP;
END;
/

SELECT * FROM TEST;

ROLLBACK;

-- NUM 값이 짝수이면 COMMIT, 홀수이면 ROLLBACK (BASIC LOOP) + (TCL)
BEGIN
   FOR NUM IN 1..10
   LOOP
      INSERT INTO TEST VALUES(NUM, SYSDATE);
      
      IF (MOD(NUM,2) = 0) THEN
         COMMIT;
      ELSE
         ROLLBACK;
      END IF;
   END LOOP;
END;
/

SELECT * FROM TEST;

-- ROLLBACK 해도 COMMIT을 했기 때문에 지워지지 않는다.
-- 데이터만 지우고 싶을때는 DELETE 또는 TRUNCATE로 지울 수 있다.
TRUNCATE TABLE TEST;
SELECT * FROM TEST;

