/*
   <숫자 처리 함수>
   
   1) ABS : 절대값을 반환
      ABS(NUMBER)
*/


SELECT ABS(10.9) FROM DUAL; -- 10.9
SELECT ABS(-10.9) FROM DUAL; -- 10.9


/*
   2) MOD : 몫으로 나눈 나머지를 반환
      MOD(NUMBER, NUMBER)
*/


SELECT MOD(10,3) FROM DUAL; -- 1
SELECT MOD(-10,3) FROM DUAL; -- -1
SELECT MOD(10.9,3) FROM DUAL; -- 1.9 (SQL에서 NUMBER는 실수와 정수를 모두 표현한다)


/*
   3) ROUND : 위치를 지정해서 반올림 해준다.
              기본적으로는 소수점 첫째 자리를 기준으로 한다.
              
      ROUND(NUMBER[, POSITION])
      
      POSITION : 기본적으로 0, 양수(소수점 기준으로 오른쪽) 음수(소수점 기준으로 왼쪽)
*/


SELECT ROUND(123.456) FROM DUAL; -- 123
SELECT ROUND(-10.65) FROM DUAL; -- -11
SELECT ROUND(-10.65 , 0) FROM DUAL; -- -11
SELECT ROUND(123.456, 1) FROM DUAL; -- 123.5
SELECT ROUND(123.456, 2) FROM DUAL; -- 123.46
SELECT ROUND(123.456, -1) FROM DUAL; -- 120 
SELECT ROUND(123.456, -2) FROM DUAL; -- 100


/*
   4) CEIL : 소수점을 기준으로 무조건 올림
      CEIL(NUMBER)

*/


SELECT CEIL(123.456) FROM DUAL;


/*
   5) FLOOR : 소수점을 기준으로 무조건 내림
      FLOOR(NUMBER)
*/


SELECT FLOOR(123.456) FROM DUAL; -- 123
SELECT FLOOR(456.789) FROM DUAL; -- 456


/*
   6. TRUNC : 위치를 지정해서 버림해 준다.
              기본적으로는 소수점 첫째 자리를 기준으로 한다.

      TRUNC(NUMBER[, POSITION])
*/


SELECT TRUNC(123.456) FROM DUAL; -- 123
SELECT TRUNC(456.789) FROM DUAL; -- 456
SELECT TRUNC(456.789, 0) FROM DUAL; -- 456
SELECT TRUNC(456.789, 1) FROM DUAL; -- 456.7
SELECT TRUNC(456.789, -1) FROM DUAL; -- 450


/*
   <날짜 처리 함수>
   
   1) SYSDATE : 시스템의 현재 날짜를 반환
*/


SELECT SYSDATE FROM DUAL; -지정한 포맷으로 출력된다

-- 날짜 포맷 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH:MI:SS';
-- 기본 포맷으로 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD'; 


/*
   2) MONTH_BETWEEN : 날짜 사이의 개월수를 반환
      MONTH_BETWEEN(DATE, DATE)
*/


SELECT MONTHS_BETWEEN(SYSDATE, '20210525') FROM DUAL; -- 11.2595 소수점 형태로 출력된다.
SELECT FLOOR(MONTHS_BETWEEN(SYSDATE, '20210525')) FROM DUAL; -- 11


--EMPLOYEE 테이블에서 직원명, 입사일, 근무개월수 조회
SELECT * FROM EMPLOYEE;

SELECT EMP_NAME AS "직원명", 
       HIRE_DATE AS "입사일", 
       FLOOR (MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) AS "근무개월수"
FROM EMPLOYEE;


/*
   3) ADD_MONTHS : 입력받은 날짜에 숫자만큼의 개월 수를 더한 날짜를 반환 
      ADD_MONTHS(DATE, NUMBER)
*/


SELECT ADD_MONTHS(SYSDATE, 12) FROM DUAL;

--EMPLOYEE 테이블에서 직원명, 입사일, 입사 후 6개월이 된 날짜를 조회
SELECT EMP_NAME AS "직원명", 
       HIRE_DATE AS "입사일", 
       ADD_MONTHS(HIRE_DATE, 6) AS "입사 후 6개월"
FROM EMPLOYEE;


/*
   4) NEXT_DAY : 기준 날짜에서 가장 가까운 요일의 날짜를 리턴
      NEXT_DAY (DATE, 요일(문자, 숫자))
*/


-- 현재 날짜에서 가장 가까운 일요일 조회
SELECT SYSDATE, NEXT_DAY(SYSDATE, '일요일') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '일') FROM DUAL; -- 줄여서도 사용 가능
-- 1: 일요일, 2: 월요일, ... , 7: 토요일
SELECT SYSDATE, NEXT_DAY(SYSDATE, 1) FROM DUAL; -- 숫자로도 사용 가능
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'SUNDAY') FROM DUAL; -- ERROR. 현재 시스템 언어가 한국어이기 때문


--시스템 언어를 변경.
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;


/*
   5) LAST_DAY : 입력받은 월의 마지막 날짜를 반환
      LAST_DAY(DATE)
*/


SELECT LAST_DAY(SYSDATE) FROM DUAL;
SELECT LAST_DAY('20.09.30') FROM DUAL;
SELECT LAST_DAY('20/09/30') FROM DUAL;


--EMPLOYEE 테이블에서 직원명, 입사일, 입사월의 마지막 날짜 조회
SELECT EMP_NAME AS "직원명", 
       HIRE_DATE AS "입사일",
       LAST_DAY(HIRE_DATE) AS "입사월의 마지막 날짜"
FROM EMPLOYEE;


/*
   6) EXTRACT : 특정 날짜의 년도, 월, 일의 정보를 추출
      EXTRACT(YEAR|MONTH|DAY FROM DATE)
*/


-- EMPLOYEE 테이블에서 직원명, 입사년도, 입사월, 입사일 조회
SELECT EMP_NAME AS "직원명",
--       HIRE_DATE,
       EXTRACT(YEAR FROM HIRE_DATE) AS "입사년도",
       EXTRACT(MONTH FROM HIRE_DATE) AS "입사월",
       EXTRACT(DAY FROM HIRE_DATE) AS "입사일"
FROM EMPLOYEE
-- ORDER BY 뒤에는 컬럼, 별칭, 컬럼순번이 올 수 있다.
--ORDER BY EXTRACT(YEAR FROM HIRE_DATE);
--ORDER BY "입사년도" DESC,"입사월";
ORDER BY 2, 3, 4;

/*
   <형 변환 함수>
   
   1) TO_CHAR : 날짜 또는 숫자 데이터를 문자 타입으로 반환
      TO_CHAR(날짜|숫자[, 포맷])
*/


-- 숫자 -> 문자
SELECT TO_CHAR(1234) FROM DUAL;
SELECT TO_CHAR(1234, '999999')FROM DUAL; -- 6칸의 공간을 확보, 오른쪽 정렬, 빈칸은 공백으로 채운다.
SELECT TO_CHAR(1234, '000000')FROM DUAL; -- 6칸의 공간을 확보, 오른쪽 정렬, 빈칸은 0으로 채운다.
SELECT TO_CHAR(1234, 'L999999')FROM DUAL; -- ￦1234 출력. 현재 설정된 지역의 화폐 단위를 보여준다.
SELECT TO_CHAR(1234, 'L999,999')FROM DUAL; -- ￦1,234 출력. 자리수 구분


--EMPLOYEE 테이블에서 직원명, 급여 조회
SELECT * FROM EMPLOYEE;

SELECT EMP_NAME AS "직원명",
       TO_CHAR(SALARY, 'L99,999,999') AS "급여"
FROM EMPLOYEE;


-- 날짜 -> 문자
SELECT SYSDATE FROM DUAL; -- 22/05/02
SELECT TO_CHAR(SYSDATE) FROM DUAL; -- 22/05/02
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL; -- 오전 11:05:30
SELECT TO_CHAR(SYSDATE, 'DAY') FROM DUAL; -- 월요일
SELECT TO_CHAR(SYSDATE, 'MONTH') FROM DUAL; -- 5월
SELECT TO_CHAR(SYSDATE, 'MON') FROM DUAL; --5월
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD(DY)') FROM DUAL; --2022-5-2(월)


--EMPLOYEE 테이블에서 직원명, 입사일(2022-05-02)
SELECT EMP_NAME AS "직원명",
       TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') AS "입사일"
--     한글은 유효하지 않은 포맷 문자이기 때문에 큰 따옴표 필요
--     TO_CHAR(HIRE_DATE, 'YYYY"년"MM"월"DD"일"') AS "입사일" 
FROM EMPLOYEE
ORDER BY "입사일";


-- 날짜 포맷 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH:MI:SS';
ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD'; 


-- 연도 포맷 문자
-- YY는 무조건 현재 세기를 반영하고, RR은 50 미만이면 현재 세기를 반영, 50 이상이면 이전 세기를 반영한다.
SELECT TO_CHAR(SYSDATE, 'YYYY'), -- 2022 
       TO_CHAR(SYSDATE, 'RRRR'), -- 2022
       TO_CHAR(SYSDATE, 'YY'), -- 22
       TO_CHAR(SYSDATE, 'RR'), -- 22
       TO_CHAR(SYSDATE, 'YEAR') -- TWNETY TWENTY-TWO
FROM DUAL;


-- 월에 대한 포맷
SELECT HIRE_DATE, 
       TO_CHAR(HIRE_DATE, 'MM'),  
       TO_CHAR(HIRE_DATE, 'MON'),
       TO_CHAR(HIRE_DATE, 'MONTH'),
       TO_CHAR(HIRE_DATE, 'RM') --로마기호
FROM EMPLOYEE;


-- 요일에 대한 포맷
SELECT HIRE_DATE, 
       TO_CHAR(HIRE_DATE, 'D'), -- 2, 1주를 기준으로 며칠째
       TO_CHAR(HIRE_DATE, 'DD'), -- 02, 1달을 기준으로 며칠째
       TO_CHAR(HIRE_DATE, 'DDD'), -- 122, 1년을 기준으로 며칠째
       TO_CHAR(HIRE_DATE, 'DY'), -- 월
       TO_CHAR(HIRE_DATE, 'DAY') -- 월요일
FROM EMPLOYEE;


-- EMPLOYEE 테이블에서 직원명, 입사일(2022-05-02(화)) 조회
SELECT EMP_NAME AS "직원명", 
       TO_CHAR(HIRE_DATE, 'YYYY-MM-DD(DY)') AS "입사일"
FROM EMPLOYEE;


-- EMPLOYEE 테이블에서 직원명, 입사일(2022년 05월 02일 (화요일)) 조회
SELECT EMP_NAME AS "직원명", 
       TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일"(DAY)') AS "입사일"
FROM EMPLOYEE;


/*
   2) TO_DATE : 숫자 또는 문자 데이터를 날짜 포맷으로 반환
      TO_DATE(숫자|문자 [, 포맷])
*/


-- 숫자 -> 날짜
SELECT TO_DATE(20200930) FROM DUAL; --20/09/30
SELECT TO_DATE(20200930122215) FROM DUAL; -- 2020-09-30 12:22:15 -- 아래의 날짜 포맷 변경 후 사용 가능


-- 문자 -> 날짜
SELECT TO_DATE('20200930') FROM DUAL; --20/09/30
SELECT TO_DATE('20200930 122215') FROM DUAL; -- 기본 포맷과 다르면 에러가 남
SELECT TO_DATE('20200930 122215', 'YYYYMMDD HH24MISS') FROM DUAL; -- 별도의 포맷을 지정하지 않으면 만들어진 포맷으로 출력한다

-- YY와 RR 비교
-- YY는 무조건 현재 세기를 반영하고, RR은 50미만이면 현재 세기를 반영, 50 이상이면 이전 세기를 반영한다.
-- ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH:MI:SS'; 상태
SELECT TO_DATE('220502', 'YYMMDD') FROM DUAL; -- 2022-05-02 12:00:00 -- 기본으로 지정된 포맷으로 출력 
SELECT TO_DATE('980502', 'YYMMDD') FROM DUAL; -- 2098-05-02 12:00:00

SELECT TO_DATE('220502', 'RRMMDD') FROM DUAL; -- 2022-05-02 12:00:00
SELECT TO_DATE('980502', 'RRMMDD') FROM DUAL; -- 1998-05-02 12:00:00


--EMPLOYEE 테이블에서 1998년 1월 1일 이후에 입사한 사원의 사번, 직원명, 입사일 조회
SELECT EMP_ID,
       EMP_NAME,
       HIRE_DATE
FROM EMPLOYEE
--WHERE HIRE_DATE > TO_DATE('980101', 'RRMMDD')
--WHERE HIRE_DATE > TO_DATE('19980101', 'YYYYMMDD')
--WHERE HIRE_DATE > TO_DATE('19980101', 'RRRRMMDD')
WHERE HIRE_DATE > '19980101'
ORDER BY HIRE_DATE;


-- 날짜 포맷 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH:MI:SS';
ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD'; 


/*
   3) TO_NUMBER : 문자 데이터를 숫자 타입으로 반환
      TO_NUMBER('문자값'[, 포맷])  
*/


SELECT TO_NUMBER('012345678') FROM DUAL; -- 12345678 -- 0이 생략되어서 나옴

SELECT '123' + '456' FROM DUAL; -- 579 -- 자동으로 숫자 타입으로 형 변환 뒤 연산처리를 한다.
SELECT '123' + '456A' FROM DUAL; -- Error.
SELECT '10,000,000' + '500,000' FROM DUAL; -- Error. 
SELECT TO_NUMBER('10,000,000') FROM DUAL; -- Error

SELECT TO_NUMBER('10,000,000', '99,999,999') FROM DUAL; -- 10000000 -- 포맷을 참고해서 숫자로 바꿔준다.
SELECT TO_NUMBER('500,000', '999,999') FROM DUAL; -- 500000
SELECT TO_NUMBER('10,000,000', '99,999,999') + TO_NUMBER('500,000', '999,999') FROM DUAL; -- 10500000

SELECT *
FROM EMPLOYEE
WHERE EMP_ID >= 210; -- CHAR 타입이지만 자동 형 변환이 일어남

-- 날짜 포맷 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH:MI:SS';
ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD'; 


/*
   <NULL 처리 함수>
   
   1) NVL : 값1이 NULL이 아니면 값1을 반환하고 값1이 NULL이면 값2를 반환한다.
      NVL(값1, 값2)
   
   2) NVL2 : 값1이 NULL이 아니면 값2를 반환하고 값이 NULL이면 값3을 반환한다.
      NVL2(값1, 값2, 값3)
   
   3) NULLIF : 두 개의 값이 동일하면 NULL을 반환하고, 두 개의값이 동일하지 않으면 값1을 반환
      NULLIF(값1, 값2)    
*/


-- EMPLOYEE 테이블에서 직원명, 보너스, 보너스가 포함된 연봉 조회
SELECT EMP_NAME AS "직원명",
       NVL(BONUS, 0) AS "보너스",
--     (SALARY + (SALARY * BONUS)) * 12 AS "보너스가 포함된 연봉"       
       (SALARY + (SALARY * NVL(BONUS, 0))) * 12 AS "보너스가 포함된 연봉"       
FROM EMPLOYEE;


-- EMPLOYEE 테이블에서 직원명, 부서코드 조회
SELECT EMP_NAME AS "직원명",
       NVL(DEPT_CODE, '부서없음') AS "부서코드"
FROM EMPLOYEE
ORDER BY DEPT_CODE DESC;


-- EMPLOYEE 테이블에서 보너스를 0.1로 동결하여 사원명, 보너스율, 동결된 보너스율, 보너스가 적용된 연봉 조회
SELECT EMP_NAME AS "사원명",
       NVL(BONUS, 0) AS "보너스율",
       NVL2(BONUS, 0.1, 0) AS "동결된 보너스율",
       (SALARY + (SALARY * NVL2(BONUS, 0.1, 0))) * 12 AS "보너스가 적용된 연봉"
FROM EMPLOYEE;


SELECT NULLIF('123', '123') FROM DUAL; -- NULL -- 동일하면 NULL값을 준다.
SELECT NULLIF('123', '456') FROM DUAL; -- 123 -- 동일하지 않으면 첫번째 값을 준다.

SELECT NULLIF(123, 123) FROM DUAL; -- NULL
SELECT NULLIF(123, 456) FROM DUAL; -- 123


/*
   <선택함수>값
   1) DECODE : 값이 조건과 일치하는지 보고, 일치하는 조건이 있으면 조건에 해당하는 결과값을 반환
      DECODE(값, 조건1, 결과값1, 조건2, 결과값, ..., 결과값 N)
*/


-- EMPLOYEE 테이블에서 사번, 직원명, 주민번호, 성별(남자, 여자) 조회
SELECT EMP_ID AS "사번",
       EMP_NAME AS "직원명",
       EMP_NO AS "주민번호",
--       SUBSTR(EMP_NO, 8, 1) AS "성별코드"
       DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남자', 2, '여자', '잘못된 주민번호 입니다.') AS "성별"
FROM EMPLOYEE;

SELECT * FROM EMPLOYEE;


-- EMPLOYEE 테이블에서 직원명, 직급 코드, 기존 급여, 인상된 급여를 조회
-- 직급 코드가 J7인 직원은 급여를 10% 인상
-- 직급 코드가 J6인 직원은 급여를 15% 인상
-- 직급 코드가 J5인 직원은 급여를 20% 인상
-- 그 외의 직급인 직원은 급여를 5% 인상
SELECT EMP_NAME AS "직원명",
       JOB_CODE AS "직급 코드",
       SALARY AS "기존 급여",
       DECODE(JOB_CODE, 'J7', SALARY*1.1, 'J6', SALARY*1.15, 'J5', SALARY*1.2, SALARY*1.05) AS "인상된 급여"
FROM EMPLOYEE
ORDER BY JOB_CODE DESC;


/*
   2) CASE : 값이 조건과 일치하는지 보고, 일치하는 조건이 있으면 조건에 해당하는 결과값을 반환
      CASE WHEN 조건식1 THEN 결과값1
           WHEN 조건식2 THEN 결과값2
           ...
           ELSE 결과
      END
*/


-- EMPLOYEE 테이블에서 사번, 직원명, 주민번호, 성별(남자, 여자) 조회
SELECT EMP_ID AS "사번", 
       EMP_NAME AS "직원명", 
       EMP_NO AS "주민번호", 
       CASE WHEN SUBSTR(EMP_NO,8,1) = '1' THEN '남자'
            WHEN SUBSTR(EMP_NO,8,1) = '2' THEN '여자'
            ELSE '잘못된 주민번호 입니다.'
       END AS "성별"
FROM EMPLOYEE;


-- EMPLOYEE 테이블에서 직원명, 급여, 듭여 등급(1 ~ 4 등급) 조회
-- SALARY 값이 500만원 초과일 경우 1등급
-- SALARY 값이 500만원 이하 350만원 초과일 경우 2등급
-- SALARY 값이 350만원 이하 200만원 초과일 경우 3등급
-- 그 외의 경우 4등급
SELECT EMP_NAME AS "직원명", 
       TO_CHAR(SALARY,'FM9,999,999') AS "급여", 
       CASE WHEN SALARY>5000000 THEN '1등급'
            WHEN SALARY>3500000 THEN '2등급'
            WHEN SALARY>2000000 THEN '3등급'
            ELSE '4등급'
       END AS "급여 등급"
FROM EMPLOYEE
ORDER BY 2 DESC;

