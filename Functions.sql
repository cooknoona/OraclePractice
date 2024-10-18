-- TRUNC : 버림을 한 결과를 반환하는 함수, 자릿수 지정 가능
SELECT TRUNC(1234.5678)	"TRUNK",	-- 소수점 첫째자리에 버림해서 결과를 반환
	TRUNC(1234.5678, 0) AS "TRUNC_0", 
	TRUNC(1234.5678, 1) AS TRUNC_1,
	TRUNC(1234.5678, 2) AS TRUNC_2, 
	TRUNC(1234.5678, -1) AS TRUNC_MINUS1, 
	TRUNC(1234.5678, -2) AS TRUNC_MINUS2
FROM dual;

-- MOD : 나누기 한 후 나머지를 출력하는 함수
SELECT MOD(21, 5) FROM dual;
-- CEIL : 소수점 이하를 올림
SELECT CEIL(12.345) FROM dual;
-- FLOOR : 소수점 이하를 날림
SELECT FLOOR(12.999) FROM dual;
-- POWER : 제곱근 값을 구하는 함수
SELECT POWER(3, 4) FROM dual;	-- 3 * 3 * 3 * 3
-- DUAL : SYS(관리자) 계정에서 제공하는 테이블, 테이블 참조 없이 실행해보기 위해 FROM 문에 사용하는 더미 테이블
SELECT 20*30 FROM dual;

-- 문자 함수 : 문자 데이터로부터 특정 결과를 얻고자 할 때
SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME)
	FROM EMP;
-- UPPER 함수로 문자열 비교하기
SELECT * FROM EMP
	WHERE UPPER(ENAME) LIKE UPPER('%james%');
	
-- 문자열 길이를 구하는 LENGTH 함수, LENGTHB 함수
-- LENGTH : 문자열 길이를 반환
-- LENGTHB : 문자열의 바이트를 반환
SELECT LENGTH(ENAME), LENGTHB(ENAME)	-- 영어는 한 바이트를 차지하기 때문에 길이와 바이트 수가 동일
	FROM EMP;

SELECT LENGTH('하니'), LENGTHB('하니') FROM dual; -- 오라클 XE 에서 한글은 3바이트를 차지

-- 직책이름의 길이가 6글자 이상이고, COMM에 있는 사원의 모든 정보 출력
SELECT * FROM EMP
	WHERE LENGTH(JOB) >= 6 AND COMM IS NOT NULL AND COMM != 0;

-- SUBSTR / SUBSTRB : 시작 위치로 부터 선택 개수만큼의 문자를 반환하는 함수, 인덱스는 1부터 시작
SELECT JOB, SUBSTR(JOB, 1, 2), SUBSTR(JOB, 3, 2), SUBSTR(JOB, 5) FROM EMP;

-- SUBSTR 함수와 다른 함수 함께 사용
SELECT JOB,
	SUBSTR(JOB, -LENGTH(JOB)),
	SUBSTR(JOB, -LENGTH(JOB), 2),
	SUBSTR(JOB, -3)
	FROM EMP;

-- INSTR : 문자열 데이터 안에 특정 문자나 문자열이 어디에 포함되어 있는지를 알고자 할 때 사용
SELECT INSTR('HELLO, ORACLE', 'L') AS INSTR_1,	-- 'L' 문자의 위치 찾기
	INSTR('HELLO, ORACLE', 'L', 5) AS INSTR_2,	-- 5번째 위치에서 'L' 문자의 위치 찾기
	INSTR('HELLO, ORACLE', 'L', 2, 2) AS INSTR_3	-- 두번째 위치에서 시작해서 두번째 나타나는 문자위치
	FROM dual;

-- 특정 문자가 포함된 행 찾기
SELECT * FROM EMP
	WHERE INSTR(ENAME, 'S') > 0;	-- 'S' 가 포함된 행 출력
	
SELECT * FROM EMP
	WHERE ENAME LIKE '%S%';

-- REPLACE : 특정 문자열 데이터에 포함된 문자를 다른 문자로 대체 할 때 사용
SELECT '010-5006-4146' AS "변경이전",
	REPLACE('010-5006-4146', '-', '/') AS "변경 이후 1",
	REPLACE('010-5006-4146', '-') AS "변경 이후 2"	-- 대체 할 문자를 지정하지 않으면 삭제처리
FROM dual;

-- LPAD / RPAD : 기준 공간 칸수를 지정하고 빈칸 만큼을 특정 문자로 채우는 함수
SELECT LPAD('ORACLE', 10, '+')
FROM dual;

SELECT RPAD('ORACLE', 10, '+')
FROM dual;

SELECT RPAD('921016-', 14, '*') AS RPAD_JUMIN,
	RPAD('010-5006-', 13, '*') AS RPAD_PHONE
FROM dual;

-- 두 문자열을 합치는 concat 함수
SELECT CONCAT(EMPNO, ENAME) AS "사원정보",
	CONCAT(EMPNO, CONCAT(' : ', ENAME)) AS "사원정보 : "
	FROM EMP
	WHERE ENAME = 'JAMES';

-- TRIM / LTRIM / RTRIM : 문자열 데이터 내에서 특정 문자를 지우기 위해 사용, 문자를 지정하지 않으면 공백 제거
SELECT '[' || TRIM(' _ORACLE_ ') || ']' AS TRIM,
	'[' || LTRIM(' _ORACLE_ ')	|| ']' AS LTRIM,	-- 왼쪽 공백 제거
	'[' || RTRIM(' _ORACLE_ ')	|| ']' AS RTRIM		-- 오른쪽 공백 제거
FROM dual;
	
-- 날짜 데이터를 다루는 함수
-- 날짜 데이터 + 숫자 : 가능, 날짜에서 숫자 만큼의 이 후 날짜
-- 날짜 데이터 - 숫자 : 가능, 날짜에서 숫자 만큼의 이 전 날짜
-- 날짜 데이터 - 날짜 데이터 : 가능, 두 날짜간의 일수 차이
-- 날짜 데이터 + 날짜 데이터 : 연산 불가능
-- SYSDATE : 운영체제로 부터 시간을 가져오는 함수
SELECT SYSDATE FROM dual;

SELECT SYSDATE AS "현재시간",
	SYSDATE - 1 AS "어제",
	SYSDATE + 1 AS "내일"
FROM dual;

-- 몇 개월 이후 날짜를 구하는 ADD_MONTH 함수 : 특정 날짜에 지정한 개월 수 이후 날짜 데이터를 반환
SELECT SYSDATE,
	ADD_MONTHS(SYSDATE, 3) AS "3개월 이후 데이터"
	FROM dual;

-- 입사 10주년이 되는 사원들의 데이터 출력하기
SELECT EMPNO, ENAME, HIREDATE AS "입사일", ADD_MONTHS(HIREDATE, 120) AS "입사 10주년"
FROM EMP;

-- 두 날짜의 개월 수 차이를 구하는 MONTHS_BETWEEN 함수
SELECT EMPNO, ENAME, HIREDATE,
	MONTHS_BETWEEN(SYSDATE, HIREDATE) AS "재직 기간",
	TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS "재직 기간2"
FROM EMP;

-- 돌아오는 요일(NEXT_DAY), 달의 마지막 날짜(LAST_DAY)
SELECT SYSDATE,
	NEXT_DAY(SYSDATE, 'MONDAY'),
	LAST_DAY(SYSDATE)
FROM dual;

SELECT LAST_DAY('24/AUG/28') FROM dual;

-- 날짜 정보 추출 함수 : EXTRACT
SELECT EXTRACT(YEAR FROM TO_DATE('24-OCT-16', 'DD-MON-RR')) FROM dual;

SELECT * FROM EMP
	WHERE EXTRACT (MONTH FROM HIREDATE) = 12;

-- 자료형을 변환하는 형 변환 함수
SELECT EMPNO, ENAME, EMPNO + '500'	-- 오라클의 기본 형변환
	FROM EMP
WHERE ENAME = 'FORD';

-- 날짜, 숫자를 문자로 변환하는 TO_CHAR 함수 : 자바의 SimpleDateFormat 유사
SELECT SYSDATE AS "기본시간포맷", TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') AS "현재날짜"
FROM dual;

SELECT SYSDATE,
    TO_CHAR(SYSDATE, 'CC') AS 세기,
    TO_CHAR(SYSDATE, 'YY') AS 연도,
    TO_CHAR(SYSDATE, 'YYYY/MM/DD PM HH:MI:SS ') AS "년/월/일 시:분:초",
    TO_CHAR(SYSDATE, 'Q') AS 쿼터,
    TO_CHAR(SYSDATE, 'DD') AS 일,
    TO_CHAR(SYSDATE, 'DDD') AS 경과일,
    TO_CHAR(SYSDATE, 'HH') AS "12시간제",
    TO_CHAR(SYSDATE, 'HH12') AS "12시간제",
    TO_CHAR(SYSDATE, 'HH24') AS "24시간제",
    TO_CHAR(SYSDATE, 'W') AS 몇주차
FROM dual;

SELECT SYSDATE,
     TO_CHAR(SYSDATE, 'MM') AS MM,
     TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = KOREAN' ) AS MON_KOR,
     TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = JAPANESE') AS MON_JPN,
     TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = ENGLISH' ) AS MON_ENG,
     TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = KOREAN' ) AS MONTH_KOR,
     TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = JAPANESE') AS MONTH_JPN,
     TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = ENGLISH' ) AS MONTH_ENG
FROM dual;

-- 숫자 데이터 형식을 지정하여 출력하기
SELECT SAL,
	TO_CHAR(SAL, '$999,999') AS SAL_$,	-- 9는 숫자의 한 자리를 의미하고 빈 자리를 채우지 않는다
	TO_CHAR(SAL, 'L999,999') AS SAL_L,	-- 지역 화폐 단위 출력
	TO_CHAR(SAL, '999,999.00') AS SAL_1,	-- 0은 빈자리를 0으로 채운다
	TO_CHAR(SAL, '000,999,999.00')	AS SAL_2
FROM EMP;

-- TO_NUMBER : 숫자 타입의 문자열을 숫자 데이터로 변환해주는 함수
SELECT 1300 - '1500', '1300' + '1500'
FROM dual;

-- TO_DATE : 문자열로 명시된 날짜로 변환 하는 함수
SELECT TO_DATE('20/JAN/24', 'YY/MM/DD') AS "날짜타입1",
	TO_DATE('20/JAN/2020', 'DD/MM/YYYY') AS "날짜타입2" 
FROM dual;

-- 1981년 7월 1일 이후 입사한 사원 정보 출력하기
SELECT * FROM EMP WHERE HIREDATE > TO_DATE('01/JUL/1981');

-- NULL 처리 함수 : 특정 열의 행에 데이터가 없는 경우 데이터값이 NULL이 된다 (NULL은 값이 없음)
-- NULL : 값이 할당되지 않았기 때문에 공백이나 0과는 다른 의미, 연산(계산, 비교 등등)이 존재
-- NVL(Null Value Logic)(검사 할 데이터 또는 열, 앞의 데이터가 NULL인 경우 대체 할 값)
SELECT EMPNO, ENAME, SAL, COMM, SAL+COMM,
	NVL(COMM, 0),
	SAL * 12 + NVL(COMM, 0) AS "연봉"
FROM EMP;

-- NVL2(검사할 데이터, 데이터가 NULL이 아닐 때 반환 되는 값, 데이터가 NULL 일 때 반환되는 값)
SELECT EMPNO, ENAME, COMM,
	NVL2(COMM, 'O', 'X') AS "보너스여부",
	NVL2(COMM, SAL * 12 + COMM, SAL * 12) AS "연봉"
FROM EMP;

-- NULLIF : 두 값을 비교하여 동일하면 NULL, 동일하지 않으면 첫번째 값을 반환한다
SELECT NULLIF (10, 10), NULLIF ('A', 'B')
FROM dual;

-- DECODE : 주어진 데이터 값이 조건 값과 일치하는 값을 출력하고 일치하는 값이 없으면 기본값 출력
SELECT EMPNO, ENAME, JOB, SAL,
	DECODE(JOB, 
		'MANAGER', SAL * 1.1,
		'SALEMAN', SAL * 1.05,
		'ANALYST', SAL,
		SAL*1.03) AS "연봉인상"
FROM EMP;

-- CASE : SQL의 표준 함수, 일반적으로 SELECT절에서 많이 사용된다
SELECT EMPNO, ENAME, JOB, SAL,
	CASE JOB
		WHEN 'MANAGER' THEN SAL * 1.1
		WHEN 'SALEMANE' THEN SAL * 1.05
		WHEN 'ANALYST' THEN SAL
		ELSE SAL * 1.03
	END AS "연봉인상"
FROM EMP;

-- 열 값에 따라서 출력이 달라지는 CASE 문 : 기준 데이터를 지정하지 않고 사용하는 방법
SELECT EMPNO, ENAME, COMM,
	CASE
		WHEN COMM IS NULL THEN '해당 사항 없음'
		WHEN COMM = 0 THEN '수당 없음'
		WHEN COMM > 0 THEN '수당 : ' || COMM
	END AS "수당 정보"
FROM EMP;


SELECT empno, ename, TRUNC(sal, -2)
FROM emp;
ORDER BY empno, ename, sal ASC;

SELECT * FROM emp
WHERE EXTRACT (MONTH FROM HIREDATE) = 9;

SELECT empno, ename, hiredate, ADD_MONTHS(hiredate, 12 * 40)
	FROM emp;

SELECT * FROM emp
	WHERE MONTHs_BETWEEN(SYSDATE, hiredate) / 12 >= 38;

SELECT * FROM EMP
	WHERE ENAME LIKE '%S';

SELECT empno, RPAD(SUBSTR(empno, 1, 2), 4, '*') AS MASKING_EMPNO,
	ename, RPAD(SUBSTR(ename, 1, 1), LENGTH(ename), '*') AS MASKING_ENAME
FROM emp
WHERE LENGTH(ename) = 5;

SELECT empno, ename, sal,
	TRUNC(sal / 21.5, 2) AS DAY_PAY,	-- 소수점 3번째 자리에서 자르고 2번째 자리 까지만 출력
	ROUND(sal / 21.5 / 8, 1) AS TIME_PAY	-- 하루 8시간을 나누고 소수점 1번째 자리 까지만 출력
FROM emp;

-- 입사일 기준으로 3개월이 지난 첫 월요일
SELECT empno, ename, hiredate,
	TO_CHAR(NEXT_DAY(ADD_MONTHS(hiredate, 3), 'Monday'),'YYYY-MM-DD') AS R_JOB,
	NVL(TO_CHAR(comm), 'N/A') AS COMM
FROM emp;

SELECT empno, ename, mgr,
	CASE
		WHEN mgr IS NULL THEN '0000' 
		WHEN SUBSTR(TO_CHAR(mgr), 1, 2) = '75' THEN '5555'
		WHEN SUBSTR(TO_CHAR(mgr), 1, 2) = '76' THEN '6666'
		WHEN SUBSTR(TO_CHAR(mgr), 1, 2) = '77' THEN '7777'
		WHEN SUBSTR(TO_CHAR(mgr), 1, 2) = '78' THEN '8888'
		ELSE TO_CHAR(mgr)
	END AS CHG_MGR
FROM emp;


	
