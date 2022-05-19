/*
   <VIEW 옵션>
   
   1. OR REPLACE
      기존에 동일한 뷰가 있을 경우 덮어쓰고, 존재하지 않으면 뷰를 새로 생성한다.
*/


CREATE OR REPLACE VIEW V_EMP_01
AS SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
   FROM EMPLOYEE;
   
SELECT * FROM V_EMP_01;
SELECT * FROM USER_VIEWS;
   
   
/*
   2. NOFORCE / FORCE

   1) NOFORCE
   : 서브 쿼리에 기술된 테이블이 존재해야만 뷰가 생성된다. (기본값)
   
   2) FORCE 
   : 서브 쿼리에 기술된 테이블이 존재하지 않아도 뷰가 생성된다.

*/

-- NOFORCE
-- VIEW가 생성되지 않음   
CREATE /* NOFORCE */ VIEW V_EMP_02
AS SELECT *
   FROM TEST_TABLE;
   
-- FORCE   
-- VIEW가 생성됨
CREATE FORCE VIEW V_EMP_02
AS SELECT *
   FROM TEST_TABLE;

-- VIEW가 생성된 것을 확인할 수 있다.
SELECT * FROM USER_VIEWS;

-- 그러나 조회에서는 에러가 난다.
SELECT * FROM V_EMP_02;

-- 존재하지 않던 테이블을 생성 
CREATE TABLE TEST_TABLE(
   TCODE NUMBER,
   TNAME VARCHAR2(20)
);

-- 조회가 가능해진다.
SELECT * FROM V_EMP_02;

-- => 테이블을 만들기 전에 VIEW 를 먼저 만들고자 할때 사용한다.


/*
   3. WITH CHECK OPTION
      서브 쿼리에 기술된 조건에 부합하지 않는 값으로 수정하는 경우 오류를 발생시킨다.
*/


-- SALARY가 3000000원 이상인 직원들을 조회하는 VIEW 생성
CREATE VIEW V_EMP_03
AS SELECT *
   FROM EMPLOYEE
   WHERE SALARY >= 3000000;

-- 선동일 사장님의 급여를 200만원으로 변경 
-- 서브 쿼리의 조건에 부합하지 않아도 변경이 가능하다.
UPDATE V_EMP_03
SET SALARY = 2000000
WHERE EMP_NAME = '선동일';

-- 업데이트되어 조건을 벗어난 선동일 사장님이 조회되지 않는다.
SELECT * FROM V_EMP_03;
SELECT * FROM EMPLOYEE;

ROLLBACK;

-- SALARY가 3000000원 이상인 직원들을 조회하는 VIEW 생성 (WITH CHECK OPTION 추가)
CREATE OR REPLACE VIEW V_EMP_03
AS SELECT *
   FROM EMPLOYEE
   WHERE SALARY >= 3000000
WITH CHECK OPTION;

-- WITH CHECK OPTION이 들어간것을 확인할 수 있다.
SELECT * FROM USER_VIEWS;

-- 선동일 사장님의 급여를 200만원으로 변경 
-- 서브 쿼리의 조건에 부합하지 않아 변경이 불가능하다.
UPDATE V_EMP_03
SET SALARY = 2000000
WHERE EMP_NAME = '선동일';

-- 선동일 사장님의 급여를 400만원으로 변경 
-- 서브 쿼리의 조건에 부합하기 때문에 변경이 가능하다.
UPDATE V_EMP_03
SET SALARY = 4000000
WHERE EMP_NAME = '선동일';

-- 조회로 확인
SELECT * FROM V_EMP_03;

ROLLBACK;


/*
   4. WITH READ ONLY
      뷰에 대해 조회만 가능하다. (DML 수행 불가)
*/


CREATE VIEW V_DEPT
AS SELECT *
   FROM DEPARTMENT
WITH READ ONLY;

-- 아래의 DML 모두 불가하다.
-- INSERT
INSERT INTO V_DEPT VALUES ('D0', '해외영업5부', 'L2');

-- UPDATE
UPDATE V_DEPT
SET LOCATION_ID = 'L2'
WHERE DEPT_ID = 'D9';

-- DELETE
DELETE
FROM V_DEPT;


/*
   <VIEW 삭제>
   DROP VIEW 뷰명;
*/
  
   
-- DROP으로 VIEW 삭제
DROP VIEW V_DEPT;
DROP VIEW V_EMP;
DROP VIEW V_EMP_01;
DROP VIEW V_EMP_02;
DROP VIEW V_EMP_03;
DROP VIEW V_EMP_JOB;
DROP VIEW V_EMP_SAL;
DROP VIEW V_EMPLOYEE;
DROP VIEW V_JOB;

-- 삭제된 VIEW 확인
SELECT * FROM USER_VIEWS;
