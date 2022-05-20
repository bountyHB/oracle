/*
   <INDEX>
      INDEX는 오라클에서 제공하는 객체로 SQL 명령문의 처리 속도를 향상시키기 위해서 행들의 위치 정보를 가지고 있다.
*/


-- ROWID로 데이터의 주소 확인
SELECT ROWID, -- 데이터의 주소
       EMP_ID, 
       EMP_NAME
FROM EMPLOYEE;

-- 계획 설명으로 검색 구조 확인 
SELECT *
FROM EMPLOYEE
WHERE EMP_ID = 202;

-- 계획 설명으로 확인하면,
-- OPTIONS에서 FULL SCAN으로 총 COST 5의 자원을 사용했다.
SELECT *
FROM TB_STUDENT
WHERE STUDENT_NAME = '황효종';

-- PK로 검색하면, 자동으로 인덱스가 만들어져서 STUDENT_NO의 위치값을 찾아 검색하게 된다.
-- 계획 설명으로 확인하면, 
-- OPTIONS에서 UNIQUE SCAN, BY INDEX ROWID를 이용하여 COST 2로 훨씬 작은 자원을 사용했다.
SELECT *
FROM TB_STUDENT
WHERE STUDENT_NO = 'A511332';


/*
   <INDEX 생성>
      고유 인덱스(UNIQUE INDEX)
      : 중복되는 값이 있는 컬럼을 지정하면 에러가 발생한다.
   
      비고유 인덱스(NONUNIQUE INDEX)
      : 중복 값이 있는 컬럼에도 생성이 가능하다. (WHERE 절에 빈번하게 사용되는 컬럼을 지정)
      
      결합 인덱스 (COMPOSITE INDEX)
      : 두 개 이상의 컬럼을 하나의 인덱스로 생성이 가능하고 순서의 의해 성능의 차이가 날 수 있다.
      
      함수 기반 인덱스(FUNCTION-BASED INDEX)

*/


-- 고유 인덱스(UNIQUE INDEX) 이용
-- 이미 이름 컬럼에 중복된 값이 있기 때문에, 오류가 난다.
CREATE UNIQUE INDEX IDX_STUDENT_NAME
ON TB_STUDENT(STUDENT_NAME);

-- 비고유 인덱스(NONUNIQUE INDEX)를 이용
-- 이름 컬럼에 중복된 값이 있어도 생성이 가능하다.
CREATE INDEX IDX_STUDENT_NAME
ON TB_STUDENT(STUDENT_NAME);

-- 생성 후 INDEX를 이용하여 조회
-- 계획 설명을 확인해보면,
-- OPTIONS에서 UNIQUE SCAN, BY INDEX ROWID를 이용하여 COST 2로 훨씬 작은 자원을 사용했다.
SELECT *
FROM TB_STUDENT
WHERE STUDENT_NAME = '황효종';

-- 결합 인덱스 (COMPOSITE INDEX) 이용
-- 계획 설명을 확인해보면,
-- OPTIONS에서 FULL SCAN으로 총 COST 8의 자원을 사용했다.
SELECT *
FROM TB_GRADE
WHERE STUDENT_NO = 'A617031' AND CLASS_NO = 'C2272800';

-- 결합 인덱스 (COMPOSITE INDEX) 생성
CREATE INDEX IDX_STUDENT_CLASS_NO 
ON TB_GRADE(STUDENT_NO, CLASS_NO);

-- 생성 후 INDEX를 이용하여 조회
-- 계획 설명을 확인해보면,
-- OPTIONS에서 RANGE SCAN, BY INDEX ROWID를 이용하여  총 COST 2의 자원을 사용했다.
SELECT *
FROM TB_GRADE
WHERE STUDENT_NO = 'A617031' AND CLASS_NO = 'C2272800';

-- INDEX 삭제
DROP INDEX IDX_STUDENT_NAME;