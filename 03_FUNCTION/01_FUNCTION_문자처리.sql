/*
   <문자 관련 함수>
   
   1) LENGTH / LENGTHB
      LENGTH('문자값')  : 글자 수 반환
      LENGTHB('문자값') : 글자의 바이트 수 반환
      
      한글 한 글자               -> 3 BYTE
      영문자, 숫자, 특수문자 한 글자 -> 1 BYTE
*/


SELECT LENGTH ('오라클'),
       LENGTHB('오라클')
FROM DUAL;


SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME),
       EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;


/*
   2) INSTR : 지정한 위치부터 지정한 숫자 번째로 나타나는 문자의 시작 위치를 반환
      INSTR('문자값', '문자값' [, POSITION, OCCURRENCE])
*/


SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;        --3
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL;     --3  / 왼쪽에서 부터 순차적으로 찾는다.
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL;    --10 / 오른쪽에서 부터 역순으로 찾는다.
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL;  --9  / 왼쪽에서 부터 순차적으로 2번째로 등장하는 자리값을 찾는다.
SELECT INSTR('AABAACAABBAA', 'B', 1, -1) FROM DUAL; --음수 사용 불가
SELECT INSTR('AABAACAABBAA', 'B', -1, 3) FROM DUAL; --3  / 오른쪽에서 부터 순차적으로 3번째로 등장하는 자리값을 찾는다.


-- 골뱅이 위치
SELECT EMAIL AS "이메일", INSTR(EMAIL, '@') AS "@위치"
FROM EMPLOYEE;


/*
   3) LPAD / RPAD : 문자값에 임의의 문자값을 덧붙여 N 길이의 문자값을 반환
      LPAD / RPAD ('문자값', 최종적으로 반환할 문자의 길이(바이트)[, 덧붙이고자 하는 문자])
*/


-- 문자값 왼쪽을 AB로 반복하여 지정한 길이수만큼 채워준다. -ABABAHello 출력
SELECT LPAD('Hello', 10, 'AB') 
FROM DUAL;

-- 문자를 지정해 주지 않으면 공백으로 채워진다.
SELECT LPAD('Hello', 10)
FROM DUAL;

-- 문자값 오른쪽을 AB로 반복하여 지정한 길이수만큼 채워준다. -HelloABABA 출력
SELECT RPAD('Hello', 10, 'AB') 
FROM DUAL;

-- 20만큼의 길이 중 EMAIL 값은 오른쪽으로 정렬하고 공백을 왼쪽으로 채운다.
SELECT LPAD(EMAIL, 20)
FROM EMPLOYEE;

SELECT LPAD(EMAIL, 10)
FROM EMPLOYEE;

SELECT LPAD(EMAIL, 3)
FROM EMPLOYEE;


--20만큼의 길이 중 EMAIL 값은 왼쪽으로 정렬하고 #을 오른쪽으로 채운다.
SELECT RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;


-- 220429-3******를 출력
SELECT RPAD('220429-3', 14, '*')
FROM DUAL;

/*
   4) LTRIM / RTRIM : 문자값의 지정한 문자를 제거한 나머지를 반환
      LTRIM / RTRIM('문자값'[, 제거하고자 하는 문자값])
*/


--LTRIM
SELECT LTRIM('   HB') FROM DUAL;
SELECT LTRIM('000123456', '0') FROM DUAL; -- 123456 출력
SELECT LTRIM('123123HB', '123') FROM DUAL; -- HB 출력 
SELECT LTRIM('123123HB123', '123') FROM DUAL; -- HB123 출력 / 왼쪽의 값만 제거 된다.


--RTRIM
SELECT RTRIM('HB   ') FROM DUAL; 
SELECT RTRIM('HB   ', ' ') FROM DUAL;
SELECT RTRIM('0012300456000', '0') FROM DUAL; --0012300456 출력


--LTRIM과 RTRIM을 중첩해서 사용할 수 있다.
SELECT LTRIM (RTRIM('0012300456000', '0'), '0') FROM DUAL; --12300456


/*
   5) TRIM
      TRIM([[LEADING | TRAILING | BOTH] '제거하고자 하는 문자값' FROM] '문자값')

      문자값 앞/ 뒤/ 양쪽에 있는 지정한 문자를 제거한 나머지를 반환한다.
      - 지정한 문자가 없으면 공백을 제거한다.
      - 문자만 가능, 문자열은 불가.
*/


-- 기본적으로 양쪽에 있는 공백 문자를 제거한다.
SELECT TRIM('    HB    ') FROM DUAL;
SELECT TRIM(' ' FROM '    HB    ') FROM DUAL;

-- BOTH를 생략해도 기본적으로 들어있다.
SELECT TRIM('Z' FROM 'ZZZHBZZZ') FROM DUAL;          -- HB
SELECT TRIM(BOTH 'Z' FROM 'ZZZHBZZZ') FROM DUAL;     -- HB
SELECT TRIM(LEADING 'Z' FROM 'ZZZHBZZZ') FROM DUAL;  -- HBZZZ
SELECT TRIM(TRAILING 'Z' FROM 'ZZZHBZZZ') FROM DUAL; -- ZZZHB


/*
   6) SUBSTR : 문자값에서 지정한 위치부터 지정한 개수의 문자열을 잘라내어 반환
      SUBSTR('문자값', POSISTION [, LENGTH])
*/


SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;     -- THEMONEY 출력 -- 7번째 문자부터 출력
SELECT SUBSTR('SHOWMETHEMONEY', 7, 3) FROM DUAL;  -- THE 출력      -- 7번째 문자부터 문자 3개 출력 
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL; -- THE 출력      -- 역순으로 8번째 문자부터 문자 3개 출력
SELECT SUBSTR('쇼 미 더 머니', 3, 7) FROM DUAL;      -- 미 더 머니     -- 공백 포함으로 카운트


-- EMPLOYEE 테이블에서 주민등록번호에 성별을 나타내는 부분만 잘라서 조회하기 (직원명, 성별 코드)
SELECT EMP_NAME AS "직원명",
       SUBSTR (EMP_NO, 8, 1) AS "성별 코드" 
       
FROM EMPLOYEE;


-- EMPLOYEE 테이블에서 여자 사원의 직원명, 성별 코드 조회
SELECT EMP_NAME AS "직원명",
       SUBSTR (EMP_NO, 8, 1) AS "성별 코드" 
FROM EMPLOYEE
WHERE SUBSTR (EMP_NO, 8, 1) = '2';

-- EMPLOYEE 테이블에서 남자 사원의 직원명, 성별 조회
SELECT EMP_NAME AS "직원명",
       '남자' AS "성별" 
FROM EMPLOYEE
WHERE SUBSTR (EMP_NO, 8, 1) = '1';


-- EMPLOYEE 테이블에서 주민등록번호 첫 번째 자리부터 성별까지 추출한 결과값의 오른쪽에 * 문자를 채워서 14 글자를 출력
-- ex) 221212-1******
SELECT RPAD (SUBSTR('991212-122222', 1, 8), 14, '*')
FROM DUAL;

SELECT EMP_NAME AS "직원명",
       RPAD (SUBSTR(EMP_NO, 1, 8), 14, '*') AS "주민등록번호"
FROM EMPLOYEE
WHERE SUBSTR (EMP_NO, 8, 1) = '1' OR SUBSTR (EMP_NO, 8, 1) = '2' ;


-- EMPLOYEE 테이블에서 직원명, 이메일, 아이디(이메일에서 @ 앞의 문자 값만 출력)를 조회
SELECT INSTR('boun@gmail.com', '@')
FROM DUAL;

SELECT SUBSTR('boun@gmail.com', 1, INSTR('boun@gmail.com', '@') -1)
FROM DUAL;

SELECT EMP_NAME, 
       EMAIL, 
       SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') -1) AS "아이디"
--       LPAD(EMAIL, INSTR(EMAIL, '@') -1) AS "아이디"       
FROM EMPLOYEE;


/*
   7) LOWER / UPPER / INITCAP : 문자값을 소문자 / 대문자 / 첫 글자만 대문자로 변환하여 반환
      LOWER / UPPER / INITCAP ('문자값')
*/


SELECT 'wElcOme tO My wORld' FROM DUAL;
SELECT LOWER ('wElcOme tO My wORld') FROM DUAL; -- 소문자로 변경
SELECT UPPER ('wElcOme tO My wORld') FROM DUAL; -- 대문자로 변경 
SELECT INITCAP ('wElcOme tO My wORld') FROM DUAL; -- 단어 앞 글자마다 대문자로 변경


/*
   8) CONCAT : 문자값 두 개를 하나로 합친 후 반환 
      CONCAT('문자값', '문자값')

*/


SELECT CONCAT('가나다라', 'ABCD') FROM DUAL;
SELECT '가나다라' || 'ABCD' FROM DUAL; -- 연결 연산자와 동일한 결과를 출력한다.

SELECT CONCAT('가나다라', 'ABCD', 'EFG') FROM DUAL; -- 에러발생 (CONCAT은 두 개의 문자값만 전달받을 수 있다.)
SELECT '가나다라' || 'ABCD' || 'EFG' FROM DUAL; 

SELECT CONCAT(EMP_ID, EMP_NAME)
FROM EMPLOYEE;

SELECT EMP_ID || EMP_NAME || EMP_NO
FROM EMPLOYEE;


/*
   9) REPLACE : 문자값에서 특정문자를 지정한 문자로 바꾼 후 반환
      REPLACE ('문자값', '변경하려고 하는 문자값', '변경할 문자값')
*/


SELECT REPLACE ('서울시 강남구 역삼동', '역삼동', '삼성동') FROM DUAL;

-- EMPLOYEE 테이블에서 이메일의 kh.or.kr을 gmail.com 변경해서 조회
SELECT REPLACE ('BOUNT@NAVER.COM', 'NAVER.COM', 'GMAIL.COM') FROM DUAL;
SELECT REPLACE (EMAIL, 'kh.or.kr', 'gmail.com') FROM EMPLOYEE;

SELECT EMP_NAME,
       REPLACE (EMAIL, 'kh.or.kr', 'gmail.com') 
FROM EMPLOYEE;

