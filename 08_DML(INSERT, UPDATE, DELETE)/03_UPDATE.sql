/*
   <UPDATE>
      테이블에 기록된 데이터를 수정하는 구문이다.
     
      UPDATE 테이블명
      SET 컬럼명 = 변경하려는 값,
      컬럼명 = 변경하려는 값, 
      ...
      [WHERE 조건];
*/


-- 테이블 생성
CREATE TABLE DEPT_COPY
AS SELECT *
   FROM DEPARTMENT;

CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
   FROM EMPLOYEE;

SELECT * FROM DEPT_COPY;
SELECT * FROM EMP_SALARY;

-- DEPT_COPY 테이블에서 DEPT_ID가 D9인 부서명을 전략기획팀으로 수정
UPDATE DEPT_COPY
SET DEPT_TITLE = '전략기획팀'
WHERE DEPT_ID = 'D9';

-- EMP_SALARY 테이블에서 노옹철 사원의 급여를 1000000원으로 변경
UPDATE EMP_SALARY
SET SALARY = '1000000'
WHERE EMP_NAME = '노옹철';

SELECT *
FROM EMP_SALARY
WHERE EMP_NAME = '노옹철';

-- EMP_SALARY 테이블에서 선동일 사장의 급여를  7000000원으로, 보너스를 0.2로 변경
UPDATE EMP_SALARY
SET SALARY = '7000000', 
    BONUS = 0.2
WHERE EMP_NAME = '선동일';

SELECT *
FROM EMP_SALARY
WHERE EMP_NAME = '선동일';

-- 모든 사원의 급여를 기존 급여에서 10프로 인상한 금액으로 변경
UPDATE EMP_SALARY
SET SALARY = SALARY * 1.1;

-- 커밋을 하지 않았기 때문에 수정한 모든 값이 되돌아오게 된다.
ROLLBACK; 

-- UPDATE 시 변경할 값은 해당 컬럼에 대한 제약 조건에 위배되면 안된다.
-- EMP_SALARY 테이블에 사번이 200인 사원의 사번을 NULL로 변경
UPDATE EMP_SALARY수
SET EMP_ID = NULL
WHERE EMP_ID = 200;

-- EMPLOYEE 테이블에 노옹철 사원의 부서코드를 D0로 변경
-- 부모테이블에는 D0라는 값이 없기때문에 에러 
UPDATE EMPLOYEE
SET DEPT_CODE = 'D0'
WHERE EMP_NAME = '노옹철';

-- 방명수 사원의 급여와 보너스를 유재식 사원과 동일하게 변경
-- 유재식 사원의 급여와 보너스 조회
SELECT SALARY, BONUS
FROM EMP_SALARY
WHERE EMP_NAME = '유재식';

-- 1) 단일행 서브 쿼리를 이용하는 방법
UPDATE EMP_SALARY
SET (SALARY) = (
   SELECT SALARY
   FROM EMP_SALARY
   WHERE EMP_NAME = '유재식'
)
WHERE EMP_NAME = '방명수';

UPDATE EMP_SALARY
SET (BONUS) = (
   SELECT BONUS
   FROM EMP_SALARY
   WHERE EMP_NAME = '유재식'
)
WHERE EMP_NAME = '방명수';

-- 2) 다중열 서브 쿼리를 이용해서 SALARY, BONUS 컬럼을 한 번에 변경
UPDATE EMP_SALARY
SET (SALARY, BONUS) = (
   SELECT SALARY, BONUS
   FROM EMP_SALARY
   WHERE EMP_NAME = '유재식'
)
WHERE EMP_NAME = '방명수';

-- 확인
SELECT * 
FROM EMP_SALARY 
WHERE EMP_NAME = '방명수';

SELECT * 
FROM EMP_SALARY 
WHERE EMP_NAME = '유재식';


------------------------------- 실습 문제 -------------------------------
-- EMP_SALARY 테이블에서 노옹철, 전형돈, 정중하, 하동운 사원들의 급여와 보너스를 유재식 사원과 동일하게 변경
-- 유재식사원의 급여와 보너스 확인
SELECT SALARY, BONUS
FROM EMP_SALARY
WHERE EMP_NAME = '유재식';

-- 서브쿼리를 사용하여 넣기 (SET에 연결)
UPDATE EMP_SALARY
SET (SALARY, BONUS) = (
   SELECT SALARY, BONUS
   FROM EMP_SALARY
   WHERE EMP_NAME = '유재식'
)
WHERE EMP_NAME = '노옹철' OR EMP_NAME = '전형돈' 
      OR EMP_NAME = '정중하' OR EMP_NAME = '하동운';

-- 확인
SELECT *
FROM EMP_SALARY
WHERE EMP_NAME = '노옹철' OR EMP_NAME = '전형돈' 
      OR EMP_NAME = '정중하' OR EMP_NAME = '하동운';
      
-- EMP_SALARY 테이블에서 아시아 지역에 근무하는 직원들의 보너스를 0.3으로 변경
-- EMP_SALARY, DEPT_COPY, LOCATION 조인
-- 조인 구문을 이용한 서브 쿼리만들기 (WHERE에 연결)
SELECT *
FROM EMP_SALARY S
JOIN DEPT_COPY D ON (S.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (L.LOCAL_CODE = D.LOCATION_ID)
WHERE L.LOCAL_NAME LIKE 'ASIA%';

-- 내꺼
UPDATE EMP_SALARY
SET (BONUS = 0.3) = (
   SELECT BONUS S
   FROM EMP_SALARY S
   JOIN DEPT_COPY D ON (S.DEPT_CODE = D.DEPT_ID)
   JOIN LOCATION L ON (L.LOCAL_CODE = D.LOCATION_ID)
   WHERE L.LOCAL_NAME LIKE 'ASIA%'
);

-- 선생님
UPDATE EMP_SALARY
SET BONUS = 0.3
WHERE EMP_ID IN (
   SELECT EMP_ID
   FROM EMP_SALARY S
   JOIN DEPT_COPY D ON (S.DEPT_CODE = D.DEPT_ID)
   JOIN LOCATION L ON (L.LOCAL_CODE = D.LOCATION_ID)
   WHERE L.LOCAL_NAME LIKE 'ASIA%'
);


DROP TABLE DEPT_COPY;
DROP TABLE EMP_SALARY;