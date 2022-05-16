-- 3. 다중열 서브 쿼리
-- 비교하려는 대상을 하나의 쌍으로 묶어서 (하나의 행) 조회
-- 비교 연산자 사용 가능

-- 내 방법
-- 1) 하이유 사원과 같은 부서 코드, 같은 직급 코드에 해당하는 사원들을 조회
-- 하이유 사원의 부서 코드와 직급 코드 조회 (DEPT_CODE = 'D5' AND JOB_CODE = 'J5')
SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '하이유';

-- 
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND JOB_CODE = 'J5';

--
SELECT *
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) IN (
      SELECT DEPT_CODE, JOB_CODE
      FROM EMPLOYEE
      WHERE EMP_NAME = '하이유'
);


-- 선생님 방법
-- 1) 하이유 사원과 같은 부서 코드, 같은 직급 코드에 해당하는 사원들을 조회
-- 하이유 사원의 부서 코드와 직급 코드 조회 (D5, J5)
SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '하이유'

-- 부서 코드가 D5 이면서 직급 코드가 J5 인 사원들 조회
SELECT EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND JOB_CODE = 'J5';

-- 각각 단일행 서브 쿼리로 작성
SELECT EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = (
      SELECT DEPT_CODE
      FROM EMPLOYEE
      WHERE EMP_NAME = '하이유'
)
AND JOB_CODE = [
      SELECT JOB_CODE
      FROM EMPLOYEE
      WHERE EMP_NAME = '하이유'   
);


-- 다중열 서브 쿼리를 사용해서 조회
SELECT EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (('D5','J5'));

--
SELECT EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (
      SELECT DEPT_CODE, JOB_CODE
      FROM EMPLOYEE
      WHERE EMP_NAME = '하이유'
);


-- 2) 박나라 사원과 직급 코드가 일치하면서 같은 사수를 가지고 있는 사원의 사번, 이름, 직급 코드, 사수 사번을 조회
-- 내 방법
-- 박나라 사원 직급 코드와 사수 코드
SELECT JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE EMP_NAME = '박나라';

-- 사원의 사번, 이름, 직급 코드, 사수 사번을 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE;

-- 조건을 넣어 합치기
SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) = (
      SELECT JOB_CODE, MANAGER_ID
      FROM EMPLOYEE
      WHERE EMP_NAME = '박나라'
);

-- 선생님 방법
-- 박나라 사원 직급 코드와 사수의 사번을 조회
SELECT JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE EMP_NAME = '박나라';

-- 박나라 사원과 같은 직급 코드, 같은 사수를 가지고 있는 사원의 사번, 이름, 직급 코드, 사수 사번을 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) IN (
      SELECT JOB_CODE, MANAGER_ID
      FROM EMPLOYEE
      WHERE EMP_NAME = '박나라'
);



























