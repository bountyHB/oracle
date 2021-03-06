/*
   3. CROSS JOIN
      조인되는 모든 테이블의 각 행들이 서로서로 모두 매핑된 데이터가 검색된다.
      두 테이블의 행들이 모두 곱해진 조합이 출력 -> 방대한 데이터 출력 -> 과부하의 위험
*/


-- ANSI 구문
SELECT E.EMP_NAME, D.DEPT_TITLE
FROM EMPLOYEE E
CROSS JOIN DEPARTMENT D -- 23 * 9 = 207행 조회
ORDER BY DEPT_TITLE;

-- 오라클 구문
SELECT *
FROM EMPLOYEE, DEPARTMENT;


/*
   4. NON EQUAL JOIN
      조인 조건에 등호(=) 를 사용하지 않는 조인을 NON EQUAL JOIN이라고 한다.
      > < >= <= BETWEEN AND, IS NULL, IS NOT NULL, IN, NOT IN 사용.
      USING 구문은 사용 불가하다.
*/


-- EMPLOYEE 테이블과 SAL_GRADE 테이블을 비등가 조인하여 직원명, 급여, 급여 등급 조회


-- ANSI 구문
-- 급여가 조건을 만족하지 않으면 조회되지 않음
SELECT E.EMP_NAME, E.SALARY, S.SAL_LEVEL
FROM EMPLOYEE E
JOIN SAL_GRADE S ON (E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL);

-- LEFT JOIN으로 조건을 만족하지 않는 사람도 조회할 수 있음
SELECT E.EMP_NAME, E.SALARY, S.SAL_LEVEL
FROM EMPLOYEE E
LEFT JOIN SAL_GRADE S ON (E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL);

-- 등가 JOIN
SELECT E.EMP_NAME, E.SALARY, S.SAL_LEVEL
FROM EMPLOYEE E
JOIN SAL_GRADE S ON (E.SALARY >=  S.MIN_SAL AND E.SALARY <= S.MAX_SAL);


-- 오라클 구문
SELECT E.EMP_NAME, E.SALARY, S.SAL_LEVEL
FROM EMPLOYEE E, SAL_GRADE S
WHERE E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL;


/*
   5. SELF JOIN
      동일한 테이블을 조인하는 경우에 사용한다.
*/


-- EMPLOYEE 테이블을 SELF JOIN 하여 사번, 직원명, 부서 코드, 사수 사번, 사수명을 조회
SELECT EMP_ID, EMP_NAME, MANAGER_ID
FROM EMPLOYEE;


-- ANSI 구문
SELECT E.EMP_ID "사번", 
       E.EMP_NAME "사원명", 
       E.DEPT_CODE "부서 코드", 
       M.EMP_ID "사수 사번", 
       M.EMP_NAME "사수명"
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);


-- 오라클 구문
SELECT E.EMP_ID "사번", 
       E.EMP_NAME "사원명", 
       E.DEPT_CODE "부서 코드", 
       M.EMP_ID "사수 사번", 
       M.EMP_NAME "사수명"
FROM EMPLOYEE E, EMPLOYEE M 
WHERE E.MANAGER_ID = M.EMP_ID(+);


/*
   6. 다중 JOIN
      여러 개의 테이블을 조인하는 경우에 사용한다.
*/

-- EMPLOYEE, DEPARTMENT, LOCATION 테이블을 다중 JOIN 하여 사번, 직원명, 부서명, 지역명을 조회

SELECT *
FROM EMPLOYEE;
-- DEPT_CODE = DEPT_ID
SELECT *
FROM DEPARTMENT;
-- LOCATION_ID = LOCAL_CODE
SELECT *
FROM LOCATION;


-- ANSI 구문 (순서가 중요)
SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, L.LOCAL_NAME
FROM EMPLOYEE E 
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
WHERE L.LOCAL_NAME= 'ASIA1';


-- DEPT_TITLE 과 LOCAL_NAME이 NULL인 사원까지 조회 (다중 JOIN)
SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, L.LOCAL_NAME
FROM EMPLOYEE E 
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE);


-- 오라클 구문 (순서가 중요하지 않음)
SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, L.LOCAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
WHERE (E.DEPT_CODE = D.DEPT_ID) AND (D.LOCATION_ID = L.LOCAL_CODE) AND  L.LOCAL_NAME= 'ASIA1';
