-- SELECT 와 FROM
-- SELECT 는 데이터 베이스 내에 버관되어 있는 데이터를 조회 할 때 사용
-- SELECT 는 FROM 에서 명시한 테이블에서 조회 할 열을 지정 할 수 있음
-- SELECT [조회 할 열], [조회 할 열] FROM tablename;
SELECT * FROM EMP;	-- (*) 모든 열을 의미하며 FROM 다음에 오는 것이 TABLE 이름이고 SQL 수행문은 ;으로 끝난다

-- 특정 column 만 선택해서 조회
SELECT EMPNO, ENAME, DEPTNO FROM EMP;

-- 사원번호와 부서번호만 나오도록 SQL 작성 (EMPNO, DEPNO)
SELECT EMPNO, DEPTNO FROM EMP;

-- 한눈에 보기 좋게 별칭 부여 하기
SELECT ENAME, SAL, COMM, SAL * 12 + COMM
	FROM EMP;
	
SELECT ENAME 이름, SAL AS "급여", COMM AS "성과급", SAL * 12 "연봉"
	FROM EMP;
	
-- 중복 제거하는 DISTINCT, 데이터를 조회 할 때 중복되는 행이 여러개일때, 중복된 행을 한개씩만 선택
SELECT DISTINCT DEPTNO
FROM EMP
ORDER BY DEPTNO DESC;	-- ASC 오름차순 DESC 내림차순

-- COLUMN 값을 계산하는 연산자 (+, -, *, /)
SELECT ENAME "이름", SAL "연봉", SAL * 12 "연급여", SAL * 12 + COMM "총 연봉"
	FROM EMP;
	
-- 연습문제 : 직책(JOB) 을 중복 제거하고 출력하기
SELECT DISTINCT JOB FROM EMP;

-- WHERE 절 (조건문)
-- 데이터 조회 할 때 사용자 원하는 조건에 맞는 데이터만 조회 할 때 사용
SELECT * FROM EMP	-- 먼저 TABLE 이 선택되고, COLUMN 정하고 ROW 를 제한 해서 보여줌
WHERE DEPTNO = 10;

-- 사원번호가 7369인 사원의 모든 정보를 출력
SELECT * FROM EMP
	WHERE EMPNO = 7369;	-- 데이터베이스에서 비교는 = (같다)라는 의미로 사용 된다 (대입이 아님)

-- 급여가 2500 초과인 사원번호, 이름, 직책, 급여 출력
SELECT EMPNO, ENAME, JOB, SAL
	FROM EMP
	WHERE SAL > 2500;
	
-- WHERE 문에 기본 연산자 사용
SELECT * FROM EMP
	WHERE SAL * 12 = 36000;
	
-- 성과급이 500 초과
SELECT * FROM EMP
	WHERE COMM > 500;

-- 입사일이 81년 1월 1일 이전 사람의 모든 정보 출력하기
SELECT * FROM EMP
WHERE HIREDATE < '01/JAN/1990';

SELECT * FROM EMP
	-- WHERE DEPTNO <> 30;
	-- WHERE deptno != 30;
	WHERE DEPTNO ^= 30;

SELECT * FROM EMP
	WHERE SAL >= 3000 AND DEPTNO = 20;

SELECT * FROM EMP
	WHERE SAL >= 3000 OR DEPTNO = 20;
SELECT * FROM EMP
	WHERE SAL >= 3000 AND DEPTNO = 20 AND HIREDATE < '01/JAN/1990';
SELECT * FROM EMP
	WHERE SAL >= 3000 AND (DEPTNO = 20 OR HIREDATE < '01/JAN/1982');
	
-- 급여가 2500 이고 직책이 MANAGER 인 사원의 모든 정보 출력
SELECT * FROM EMP
	WHERE SAL >= 2500 AND JOB = 'MANAGER';

