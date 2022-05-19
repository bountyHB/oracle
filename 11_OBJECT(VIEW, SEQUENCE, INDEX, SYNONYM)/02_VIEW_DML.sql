/*
   <VIEW를 이용해서 DML 사용>
      뷰를 통해서 데이터를 변경하게 되면 실제 데이터가 담겨있는 테이블에도 변경된 내용이 적용된다.      
*/


-- JOB 테이블을 이용하여 VIEW 생성
CREATE VIEW V_JOB
AS SELECT *
   FROM JOB;

-- VIEW 조회
SELECT JOB_CODE, JOB_NAME
FROM V_JOB;

-- VIEW에 INSERT 실행하여 데이터 추가
INSERT INTO V_JOB VALUES ('J8', '알바');

-- VIEW 조회
SELECT JOB_CODE, JOB_NAME
FROM V_JOB;

-- JOB 테이블 조회 (원본 테이블에도 INSERT가 반영되어 있다)
SELECT *
FROM JOB;

-- VIEW에 UPDATE 실행하여 데이터 수정
UPDATE V_JOB 
SET JOB_NAME = '인턴'
WHERE JOB_CODE = 'J8';

-- VIEW 조회
SELECT JOB_CODE, JOB_NAME
FROM V_JOB;

-- JOB 테이블 조회 (원본 테이블에도 UPDATE가 반영되어 있다)
SELECT *
FROM JOB;

-- VIEW에 DELETE 실행하여 데이터 삭제
DELETE FROM V_JOB 
WHERE JOB_CODE = 'J8';

-- VIEW 조회
SELECT JOB_CODE, JOB_NAME
FROM V_JOB;

-- JOB 테이블 조회 (원본 테이블에도 DELETE가 반영되어 있다)
SELECT *
FROM JOB;


/*
   <DML 구문으로 VIEW 조작이 불가능한 경우>

   1. 뷰 정의에 포함되지 않은 컬럼을 조작하는 경우
	 2. 뷰에 포함되지 않은 컬럼 중에 베이스가 되는 컬럼이 NOT NULL 제약조건이 지정된 경우
	 3. 산술 표현식으로 정의된 경우
	 4. 그룹 함수나 GROUP BY 절을 포함한 경우
	 5. DISTINCT를 포함한 경우
	 6. JOIN을 이용해서 여러 테이블을 연결한 경우
*/


CREATE OR REPLACE VIEW V_JOB
AS SELECT JOB_CODE
   FROM JOB;


-- 뷰에 정의되어 있지 않는 컬럼 JOB_NAME을 조작하는 DML 작성
-- INSERT
INSERT INTO V_JOB VALUES ('J8');
INSERT INTO V_JOB VALUES ('J8','인턴'); -- 없는 컬럼에대한 INSERT는 가능하지 않다.

SELECT * FROM JOB;
SELECT * FROM V_JOB;

-- UPDATE
-- 뷰에 정의되어 있지 않는 컬럼은 수정할 수 없다. 
UPDATE V_JOB 
SET JOB_NAME = '인턴'
WHERE JOB_CODE = 'J8';

-- 정의된 컬럼은 수정 가능하다.
UPDATE V_JOB
SET JOB_CODE = 'J0'
WHERE JOB_CODE = 'J8';

-- DELETE   
-- 뷰에 정의되어 있지 않는 컬럼은 삭제할 수 없다.
DELETE V_JOB
WHERE JOB_NAME = '사원';

-- 정의된 컬럼은 삭제 가능하다.
DELETE V_JOB
WHERE JOB_CODE = 'J0';

SELECT * FROM V_JOB;


-- 2. 뷰에 포함되지 않은 컬럼 중에 베이스가 되는 컬럼이 NOT NULL 제약조건이 지정된 경우
CREATE OR REPLACE VIEW V_JOB
AS SELECT JOB_NAME
   FROM JOB;

-- INSERT
-- PRIMARY KEY 제약조건안에 NOT NULL이 있어서 불가능하다.
INSERT INTO V_JOB VALUES('인턴');

-- UPDATE
UPDATE V_JOB
SET JOB_NAME = '인턴'
WHERE JOB_NAME = '사원';

-- DELETE 
-- FK 제약조건으로 인해 삭제되지 않는다.
DELETE FROM V_JOB
WHERE JOB_NAME = '인턴';

ROLLBACK;

SELECT * FROM JOB;
SELECT * FROM V_JOB;


-- 3. 산술 표현식으로 정의된 경우
-- 사원들의 급여 정보를 조회하는 뷰
CREATE OR REPLACE VIEW V_EMP_SAL
AS SELECT EMP_ID,
          EMP_NAME,
          EMP_NO,
          SALARY,
          SALARY*12 "연봉" -- 연산자가 들어간 경우 별칭 필요. 실제 EMPLOYEE 에는 없는 가상의 컬
   FROM EMPLOYEE; 

-- 테스트를 위해 JOB_CODE의 NOT NULL 제약조건 수정하기
ALTER TABLE EMPLOYEE MODIFY JOB_CODE NULL;      
   
-- INSERT
-- 가상컬럼(연봉)에는 값을 넣을 수 없다.
-- 산술연산으로 정의된 컬럼은 데이터 삽입 불가능
INSERT INTO V_EMP_SAL VALUES('1000', '홍길동', '940325-1111111', 3000000, 36000000); 
-- 산술연산과 무관한 컬럼은 데이터 삽입 가능
INSERT INTO V_EMP_SAL(EMP_ID, EMP_NAME, EMP_NO, SALARY) VALUES('100', '홍길동', '940325-1111111', 3000000);  
   
SELECT * FROM V_EMP_SAL; -- 연봉정보를 담고있는 컬럼이 있다.
SELECT * FROM EMPLOYEE; -- 연봉정보를 담고있는 컬럼이 없다.   
   
-- UPDATE
-- 가상컬럼(연봉)에는 값을 수정할 수 없다.
-- 급여를 가지고 연봉을 계산한 것이기 때문에, 연봉을 수정시 급여가 수정?? --> 말이 안된다.
UPDATE V_EMP_SAL
SET "연봉" = 40000000
WHERE EMP_NAME = '홍길동';

-- 산술연산과 무관한 컬럼의 데이터 변경
-- 정상적으로 변경되었고, 연봉에도 반영되었다.
UPDATE V_EMP_SAL
SET SALARY = 500000
WHERE EMP_NAME = '홍길동';

-- DELETE
-- 삭제가 정상적으로 되었다.
DELETE 
FROM V_EMP_SAL
WHERE "연봉" = 6000000;
   
SELECT * FROM V_EMP_SAL; 
SELECT * FROM EMPLOYEE; 


-- 4. 그룹 함수나 GROUP BY 절을 포함한 경우
-- 부서별 급여의 합계, 급여 평균을 조회하는 뷰 생성
-- 서브쿼리 작성
SELECT DEPT_CODE, SUM(SALARY)"합계", ROUND(AVG(NVL(SALARY,0)))"평균"
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 서브쿼리를 이용한 VIEW 테이블 생성 (함수식은 별칭 필요) 
CREATE OR REPLACE VIEW V_EMP_SAL
AS SELECT DEPT_CODE, 
          SUM(SALARY)"합계", 
          ROUND(AVG(NVL(SALARY,0)))"평균"
   FROM EMPLOYEE
   GROUP BY DEPT_CODE;

SELECT * FROM V_EMP_SAL;

-- INSERT
-- 가상 컬럼 에러가 발생
INSERT INTO V_EMP_SAL VALUES ('D0', 8000000, 4000000);
-- NOT NULL 제약조건과 FK 제약조건이 걸려서 참조하고 있는 테이블(DEPARTMENT)에 있는 값만 가질 수 있다.
INSERT INTO V_EMP_SAL(DEPT_CODE) VALUES ('D0');

-- UPDATE
-- 합계를 수정하는 것은 원본 데이터에 이상한 영향을 주기 때문에 불가.
UPDATE V_EMP_SAL
SET "합계" = 8000000
WHERE DEPT_CODE = 'D1';

-- 동일한 문제로 GROUPING 한 결과를 수정할 수는 없음.
UPDATE V_EMP_SAL
SET DEPT_CODE = 'D3'
WHERE DEPT_CODE = 'D1';
 
-- DELETE
-- 역시 불가하다
DELETE 
FROM V_EMP_SAL
WHERE DEPT_CODE = 'D1';


-- 5. DISTINCT를 포함한 경우
-- JOB_CODE 컬럼에서 중복되는 값을 제외하고 하나만 보여준다
-- DISTINCT를 이용한 VIEW 테이블 생성
CREATE VIEW V_EMP_JOB
AS SELECT DISTINCT JOB_CODE
   FROM EMPLOYEE;

-- 역시 조작된 결과를 보여주는 테이블에서는 모두 허용하지 않는다.
-- INSERT
INSERT INTO V_EMP_JOB VALUES('J7');

-- UPDATE
UPDATE V_EMP_JOB 
SET JOB_CODE = 'J6'
WHERE JOB_CODE = 'J7';

-- DELETE
DELETE
FROM V_EMP_JOB
WHERE JOB_CODE = 'J7';

SELECT * FROM V_EMP_JOB;
SELECT * FROM EMPLOYEE WHERE JOB_CODE = 'J7';


-- 6. JOIN을 이용해서 여러 테이블을 연결한 경우
-- 직원들의 사번, 직원명, 부서명을 조회하는 뷰를 생성
-- JOIN 구문
SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE 
FROM EMPLOYEE E 
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID);

-- JOIN된 VIEW 테이블 생성
CREATE OR REPLACE VIEW V_EMP
AS SELECT E.EMP_ID, E.EMP_NAME, E.EMP_NO, D.DEPT_TITLE
   FROM EMPLOYEE E 
   JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID);
   
-- INSERT 
-- JOIN 되어 있는 테이블에서는 조작이 불가능하다.
INSERT INTO V_EMP VALUES ('100', '김삿갓', '990101-1111111', '마케팅부');
-- JOIN 기준 테이블에는 정상적으로 삽입이 적용되었다.
INSERT INTO V_EMP(EMP_ID, EMP_NAME, EMP_NO) VALUES ('100', '김삿갓', '990101-1111111');

SELECT * FROM V_EMP; -- INNER 조인이라 보이지 않음 
SELECT * FROM EMPLOYEE; -- 김삿갓이 추가된 것을 확인할 수 있다.

-- UPDATE
-- 마찬가지로 JOIN된 테이블의 부서를 변경할 수는 없다.
UPDATE V_EMP
SET DEPT_TITLE = '마케팅부'
WHERE EMP_ID = '200';

-- 정상적으로 변경이 적용되었다.
UPDATE V_EMP
SET EMP_NAME = '서동일'
WHERE EMP_ID = '200';

-- DELETE
-- JOIN된 테이블의 데이터는 지워지지 않고,
-- 기준이 된 테이블에 있는 총무부의 사원들만 지원진다. 
DELETE
FROM V_EMP
WHERE DEPT_TITLE = '총무부';

-- 정상적으로 삭제가 적용되었다.
DELETE
FROM V_EMP
WHERE EMP_ID = '200';

SELECT * FROM V_EMP;  
SELECT * FROM EMPLOYEE; 

ROLLBACK;