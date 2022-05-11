-- SELECT - BASIC
-- 1. 별칭
SELECT DEPARTMENT_NAME AS "학과 명", CATEGORY AS "계열"
FROM TB_DEPARTMENT;

-- 2. 연결연산자 ||
SELECT DEPARTMENT_NAME || '의 정원은 ' || CAPACITY ||'명 입니다' AS "학과별 정원"
FROM TB_DEPARTMENT;

-- 3. SUBSTR() 글자 추출
SELECT S.STUDENT_NAME
FROM TB_STUDENT S
JOIN TB_DEPARTMENT D ON (S.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE S.ABSENCE_YN = 'Y' AND SUBSTR(S.STUDENT_SSN,8,1)=2 AND S.DEPARTMENT_NO = 001;

-- 4. IN
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN('A513079','A513090','A513091','A513110' ,'A513119');

-- 5. BETWEEN A AND B
SELECT DEPARTMENT_NAME, CATEGORY
FROM TB_DEPARTMENT
WHERE CAPACITY BETWEEN 20 AND 30;

-- 6. IS NULL
SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

-- 7. IS NULL
SELECT *
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

-- 8. IS NOT NULL
SELECT CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

-- 9. DISTINCT 중복제거
SELECT DISTINCT CATEGORY
FROM TB_DEPARTMENT;

-- 10. EXTRACT : 특정 날짜의 년도, 월, 일의 정보를 추출, LIKE % 문자열 조건
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE) = 2002 AND ABSENCE_YN = 'N' AND STUDENT_ADDRESS LIKE ('전주%');

-- SELECT - FUNCTION
-- 1. ORDER BY
SELECT STUDENT_NO AS "학번", STUDENT_NAME AS "이름", ENTRANCE_DATE AS "입학년도"
FROM TB_STUDENT
WHERE DEPARTMENT_NO = 002
ORDER BY "입학년도";

-- 2. LENGTH / NOT LIKE '___'
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
--WHERE LENGTH(PROFESSOR_NAME) != 3 ;
WHERE PROFESSOR_NAME NOT LIKE '___';

-- 3. TRUNC , SYSDATE, MONTH_BETWEEN : 날짜 사이의 개월수를 반환 , 나이 구하기
SELECT PROFESSOR_NAME AS "교수이름", 
       TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE('19'||SUBSTR(PROFESSOR_SSN, 1, 2), 'YYYY'))/12) AS "나이"
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN,8,1) = 1
ORDER BY "나이" DESC;

-- 4. SUBSTR 
SELECT SUBSTR(PROFESSOR_NAME,2,2) AS "이름"
FROM TB_PROFESSOR;

-- 5. MONTH_BETWEEN, TO_DATE, 'RRMMDD'
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE MONTHS_BETWEEN(ENTRANCE_DATE, TO_DATE(SUBSTR(STUDENT_SSN, 1, 6),'RRMMDD'))/12 > 19 
    AND MONTHS_BETWEEN(ENTRANCE_DATE, TO_DATE(SUBSTR(STUDENT_SSN, 1, 6),'RRMMDD'))/12 <= 20; 

-- 6. TO_DATE, TO_CHAR
SELECT TO_CHAR(TO_DATE('2020/12/25'), 'DAY') 
FROM DUAL;

-- 7. TO_CHAR, TO_DATE
SELECT TO_CHAR(TO_DATE('99/10/11','YY/MM/DD'),'YYYY') AS "년", -- 2099년
       TO_CHAR(TO_DATE('49/10/11','YY/MM/DD'),'YYYY') AS "년", -- 2049년
       TO_CHAR(TO_DATE('99/10/11','RR/MM/DD'),'RRRR') AS "년", -- 1999년
       TO_CHAR(TO_DATE('49/10/11','RR/MM/DD'),'RRRR') AS "년" -- 2049년
FROM DUAL;

-- 8. NOT LIKE '%'
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
--WHERE SUBSTR(STUDENT_NO,1,1) != 'A';
WHERE STUDENT_NO NOT LIKE 'A%';

-- 9. ROUND, AVG
SELECT ROUND(AVG(POINT),1) AS "평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

-- 10. COUNT
SELECT DEPARTMENT_NO AS "학과번호", COUNT(*) AS "학생수"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;

-- 11. COUNT , IS NULL
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

-- 12. SUBSTR, ROUND, AVG, GROUP BY
SELECT SUBSTR(TERM_NO,1,4) AS "년도" , 
       ROUND(AVG(POINT),1) AS "년도 별 평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO,1,4);

-- 13. DECODE
SELECT DEPARTMENT_NO 학과코드명, 
       COUNT(DECODE(ABSENCE_YN, 'Y', 1, NULL)) "휴학생 수"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

-- 14. COUNT, HAVING
SELECT STUDENT_NAME AS "동일이름", COUNT(*) AS "동명인 수"
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(*) > 1;

-- 15. ROLLUP , WHERE 과 HAVING 차이 구분하기
SELECT SUBSTR(TERM_NO,1,4) AS "년도", 
       SUBSTR(TERM_NO,5,2) AS "학기", 
       ROUND(AVG(POINT),1) AS "평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO,1,4), SUBSTR(TERM_NO,5,2))
ORDER BY 1;

-- SELECT - OPTIONAL
-- 1. 
SELECT STUDENT_NAME AS "학생 이름",
       STUDENT_ADDRESS AS "주소지"
FROM TB_STUDENT;

-- 2. 
SELECT STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY 2 DESC;

-- 3. LIKE, (), OR
SELECT STUDENT_NAME AS "학생이름", 
       STUDENT_NO AS "학번", 
       STUDENT_ADDRESS AS "거주지 주소"
FROM TB_STUDENT
WHERE (STUDENT_ADDRESS LIKE '강원%' OR  STUDENT_ADDRESS LIKE '경기%') AND STUDENT_NO LIKE '9%'
ORDER BY 1;

-- 4. 
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO = '005'
ORDER BY PROFESSOR_SSN;

SELECT * 
FROM TB_DEPARTMENT;

-- 5. DESC, AND, TO_CHAR
SELECT STUDENT_NO, TO_CHAR(POINT,'99.99')
FROM TB_GRADE
WHERE TERM_NO = '200402' AND CLASS_NO = 'C3118100'
ORDER BY POINT DESC, STUDENT_NO;

-- 6. JOIN
SELECT S.STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT S
JOIN TB_DEPARTMENT D ON (D.DEPARTMENT_NO = S.DEPARTMENT_NO)
ORDER BY S.STUDENT_NAME; 

-- 7. 
SELECT C.CLASS_NAME, D.DEPARTMENT_NAME
FROM TB_CLASS C
JOIN TB_DEPARTMENT D ON (D.DEPARTMENT_NO = C.DEPARTMENT_NO);


-- 8. 3개의 클래스 연결 (.???)
SELECT C.CLASS_NAME, P.PROFESSOR_NAME
FROM TB_CLASS C
JOIN TB_PROFESSOR P ON (C.DEPARTMENT_NO = P.DEPARTMENT_NO)
ORDER BY 2,1;

-- 풀이
SELECT C.CLASS_NAME, P.PROFESSOR_NAME
FROM TB_CLASS C
JOIN TB_CLASS_PROFESSOR CP ON (C.CLASS_NO = CP.CLASS_NO)
JOIN TB_PROFESSOR P ON (CP.PROFESSOR_NO = P.PROFESSOR_NO)
ORDER BY 2,1;

-- 9. 
SELECT C.CLASS_NAME, P.PROFESSOR_NAME
FROM TB_CLASS C
JOIN TB_PROFESSOR P ON (C.DEPARTMENT_NO = P.DEPARTMENT_NO)
JOIN TB_DEPARTMENT D ON (P.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE CATEGORY = '인문사회' 
ORDER BY 2,1;

-- 풀이
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS
JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
JOIN TB_PROFESSOR P USING(PROFESSOR_NO)
JOIN TB_DEPARTMENT D ON (P.DEPARTMENT_NO = D.DEPARTMENT_NO) --> DEPARTMENT를 조인해야 CATEGORY 컬럼을 사용할 수 있다.  
WHERE CATEGORY = '인문사회'
ORDER BY 2, 1;

-- 10. GROUP BY 2개로 묶기
SELECT S.STUDENT_NO, S.STUDENT_NAME, ROUND(AVG(G.POINT),1)
FROM TB_GRADE G
JOIN TB_STUDENT S ON (G.STUDENT_NO = S.STUDENT_NO)
JOIN TB_DEPARTMENT D ON (S.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '음악학과'
GROUP BY S.STUDENT_NO, S.STUDENT_NAME
ORDER BY S.STUDENT_NO;

-- 11. 다른 컬럼값 연결하기 
 
SELECT D.DEPARTMENT_NAME AS "학과이름", 
       S.STUDENT_NAME AS "학생이름", 
       P.PROFESSOR_NAME AS "지도교수이름"
FROM TB_STUDENT S
JOIN TB_DEPARTMENT D ON (D.DEPARTMENT_NO = S.DEPARTMENT_NO)
JOIN TB_PROFESSOR P ON (S.COACH_PROFESSOR_NO = P.PROFESSOR_NO)
WHERE S.STUDENT_NO = 'A313047';

SELECT DEPARTMENT_NAME 학과이름, STUDENT_NAME 학생이름, PROFESSOR_NAME 지도교수이름
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
JOIN TB_PROFESSOR ON(COACH_PROFESSOR_NO = PROFESSOR_NO)
WHERE STUDENT_NO = 'A313047';

-- 12. JOIN
SELECT *
FROM TB_STUDENT S
JOIN TB_GRADE G ON (S.STUDENT_NO = G.STUDENT_NO)
JOIN TB_CLASS C ON (G.CLASS_NO = C.CLASS_NO)
WHERE C.CLASS_NAME = '인간관계론' AND TERM_NO LIKE '2007%';

SELECT *
FROM TB_STUDENT S
JOIN TB_GRADE G ON (S.STUDENT_NO = G.STUDENT_NO)
JOIN TB_CLASS C ON (S.DEPARTMENT_NO = C.DEPARTMENT_NO)
WHERE C.CLASS_NAME = '인간관계론' AND TERM_NO LIKE '2007%';


-- 13. LEFT OUTER JOIN
SELECT *
FROM TB_CLASS C
JOIN TB_CLASS_PROFESSOR CP ON (C.CLASS_NO = CP.CLASS_NO)
JOIN TB_DEPARTMENT D ON (C.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE D.CATEGORY = '예체능';

SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS C
LEFT JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE CATEGORY = '예체능'
  AND PROFESSOR_NO IS NULL
ORDER BY 2, 1;

SELECT *
FROM TB_PROFESSOR;

SELECT *
FROM TB_CLASS_PROFESSOR;

SELECT *
FROM TB_STUDENT;

SELECT *
FROM TB_GRADE;

SELECT *
FROM TB_DEPARTMENT;

SELECT *
FROM TB_CLASS;











