-- 다중행 함수 : 여러 행에 대해서 함수가 적용되어 하나의 결과를 나타내는 함수
SELECT sum(sal)
FROM EMP
GROUP BY DEPTNO;

-- SUM : 지정한 데이터 합계 반환
-- COUNT : 지정한 데이터 개수 반환
-- MAX : 지정한 데이터중 최대값 반환
-- MIN : 지정한 데이터중 최소값 반환
-- AVG : 지정한 데이터 평균값 반환
SELECT SUM(DISTINCT SAL), SUM(ALL SAL), SUM(SAL)
FROM EMP;

-- 30번의 사원번호를 가진 직원의 급여, 보너스 합계
SELECT sum(SAL), sum(COMM)
FROM EMP
WHERE DEPTNO = 30;

-- 모든 사원의 급여, 보너스 합계
SELECT sum(SAL), sum(COMM), DEPTNO
FROM EMP
GROUP BY DEPTNO;

-- 각 직책별로 급여와 추가 수당의 합구하기
SELECT JOB, sum(SAL), sum(COMM)
FROM EMP
GROUP BY JOB;

-- MAX 급여 출력 하기 (GROUP BY 활용)
SELECT MAX(SAL), DEPTNO
FROM EMP
GROUP BY DEPTNO;

-- MAX 급여 출력하기 (GROUP BY 없이) UNION ALL 로 각 STATEMENT를 묶어 줄 수 있음
SELECT MAX(SAL)
FROM EMP
WHERE DEPTNO = 10
UNION ALL
SELECT MAX(SAL)
FROM EMP
WHERE DEPTNO = 20
UNION ALL
SELECT MAX(SAL)
FROM EMP
WHERE DEPTNO = 30;

-- 부서 번호가 20인 사원중 입사일이 가장 최근 입사일 출력하기
SELECT MAX(HIREDATE)
FROM EMP
WHERE DEPTNO = 20;

-- 서브쿼리 사용하기 : 각 부서별 최대(MAX) 급여 받는 사원의 (사원번호, 이름, 직책, 부서번호 출력)
SELECT MAX(SAL), DEPTNO
FROM EMP
GROUP BY DEPTNO;

SELECT MAX(SAL)
FROM EMP e2
WHERE e2.DEPTNO = 10;

SELECT EMPNO, ENAME, SAL, JOB, DEPTNO
FROM EMP e
WHERE SAL = (
	SELECT MAX(SAL)
	FROM EMP e2
	WHERE e2.DEPTNO = e.DEPTNO
);

-- HAVING 문
-- GROUP BY 존재 할 때만 사용 할 수 있음
-- WHERE 조건절과 동일하게 동작하지만, 그룹화된 결과 값의 범위를 제한 할 때 사용
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
	HAVING AVG(SAL) >= 2000 
ORDER BY DEPTNO;

-- WHERE, HAVING 을 동시에 사용
SELECT DEPTNO, JOB, AVG(SAL)	--5. 출력 할 열 제한
FROM EMP						--1. 먼저 테이블을 가져 온다
WHERE SAL <= 3000				--2. 급여 기준으로 행을 제한
GROUP BY DEPTNO, JOB			--3. 부서별, 직책별 그룹화
	HAVING AVG(SAL) > 2000		--4. 그룹내에서 행 제한
ORDER BY DEPTNO, JOB;			--6. 그룹별, 직책별 오름차순 정렬

-- HAVING 절을 사용하여 EMP 테이블의 부서별 직책의 평균 급여가 500 이상인
-- 사원들의 부서번호, 직책, 부서별 직책의 평균 급여가 출력
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB 
	HAVING AVG(SAL) >= 500
ORDER BY AVG(SAL) DESC;

-- EMP 테이블을 이용하여 부서번호, 평균 급여, 최고급여, 최저급여, 사원수를 출력,
-- 단, 평균 급여를 출력 할 때는 소수점 제외하고 부서 번호별로 출력
SELECT DEPTNO AS "부서번호",
TRUNC(AVG(SAL)) AS "평균급여",
MAX(SAL) AS "최고급여",
MIN(SAL) AS "최저급여",
COUNT(DEPTNO) AS "사원수"
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;

-- 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원을 출력
SELECT JOB, COUNT(*)
FROM EMP
GROUP BY JOB
	HAVING COUNT(*) >= 3
ORDER BY JOB;

-- 사원들의 입사연도를 기준으로 부서별로 몇명이 입사 했는지 출력
SELECT TO_CHAR(HIREDATE, 'YYYY'), DEPTNO, COUNT(*)
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY'), DEPTNO;

-- 추가 수당을 받는 사원 수와 받지 않는 사원수를 출력 (O, X로 표기)
SELECT COUNT(*), NVL2(COMM, 'O', 'X') 
FROM EMP
GROUP BY NVL2(COMM, 'O', 'X');

-- 각 부서의 입사 연도별 사원 수, 최고 급여, 급여 합, 평균 급여를 출력
SELECT DEPTNO, TO_CHAR(HIREDATE, 'YYYY'), COUNT(*), MAX(SAL), SUM(SAL), TRUNC(AVG(SAL))
FROM EMP
GROUP BY DEPTNO, TO_CHAR(HIREDATE, 'YYYY')
ORDER BY DEPTNO;

-- 그룹화 관련 기타 함수 : ROLLUP, CUBE, GROUPING SETS
SELECT NVL(TO_CHAR(DEPTNO), '전체부서') AS "부서번호",
	NVL(TO_CHAR(JOB), '부서별 직책') AS "직책",
	COUNT(*) AS "사원수",
	MAX(SAL) AS "최대급여",
	MIN(SAL) AS "최소급여",
	ROUND(AVG(SAL)) AS "평균급여"
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY DEPTNO, JOB;


