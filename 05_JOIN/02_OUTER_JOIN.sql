/*
   2. OUTER JOIN
      두 테이블 간의 JOIN 시 일치하지 않는 행도 포함시켜서 조회할 때 사용하는 구문이다.
      반드시 시준이 되는 테이블(컬럼)을 지정해야 한다. (LEFT, RIGHT, FULL, (+))
*/


-- OUTER JOIN과 비교할 INNER JOIN을 조회
-- EMPLOYEE 테이블과 DEPARTMENT 테이블을 조인해서 사원들의 사원명, 부서명, 부서아이디, 급여, 연봉 조회
-- DEPT_CODE가 NULL인 사원 2명은 조회가 되지 않아서 21명의 사원만 조회됨
SELECT E.EMP_NAME,
       D.DEPT_TITLE,
       D.DEPT_ID,
       E.SALARY,
       E.SALARY * 12
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID);


/*
   1) LEFT [OUTER] JOIN
      두 테이블 중 왼편에 기술된 테이블의 컬럼을 기준으로 JOIN을 진행한다.      
*/


-- ANSI 구문
-- 왼쪽 테이블인 EMPLOYEE 기준으로 조회
-- DEPT_TITLE이 NULL값이었던 두 사원도 포함되어 총 23명이 조회가 됨.
SELECT E.EMP_NAME,
       D.DEPT_TITLE,
       D.DEPT_ID,
       E.SALARY,
       E.SALARY * 12
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
ORDER BY DEPT_TITLE DESC;


-- 오라클 구문
-- DATA가 없는데 표시되어야 하는 DEPARTMENT가 있는 컬럼에다가 (+) 표시, 테이블 기준으로 조인하는 ANSI 구문과 반대된다.
-- NULL 값이 포함된 DEPARTMENT 컬럼 기준으로 조회
SELECT E.EMP_NAME,
       D.DEPT_TITLE,
       D.DEPT_ID,
       E.SALARY,
       E.SALARY * 12
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID (+) 
ORDER BY DEPT_TITLE DESC;


/*
   2) RIGHT [OUTER] JOIN
      두 테이블 중 오른편에 기술된 테이블의 컬럼을 기준으로 JOIN을 진행한다.
*/


-- ANSI 구문
-- 오른쪽의 테이블인 DEPARTMENT 기준으로 조회되기 때문에, 왼쪽 기준으로 출력되지 않았던 D3, D4, D7 번까지 조회된다.
SELECT E.EMP_NAME,
       D.DEPT_TITLE,
       D.DEPT_ID,
       E.SALARY,
       E.SALARY * 12
FROM EMPLOYEE E
RIGHT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
ORDER BY DEPT_ID;


-- 오라클 구문
-- NULL 값이 포함된 EMPLOYEE 컬럼 기준으로 조회
SELECT E.EMP_NAME,
       D.DEPT_TITLE,
       D.DEPT_ID,
       E.SALARY,
       E.SALARY * 12
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE(+) = D.DEPT_ID 
ORDER BY DEPT_ID;

/*
   3) FULL [OUTER] JOIN
      두 테이블이 가진 모든 행을 조회할 수 있다. (단, 오라클 구문은 지원하지 않는다.)
*/


-- ANSI 구문
-- EMPLOYEE 기준으로 NULL 값이 포함된 데이터와 DEPARTMENT 기준으로 NULL 값이 포함된 데이터를 모두 조회
SELECT E.EMP_NAME,
       D.DEPT_TITLE,
       D.DEPT_ID,
       E.SALARY,
       E.SALARY * 12
FROM EMPLOYEE E
FULL JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
ORDER BY DEPT_ID;
