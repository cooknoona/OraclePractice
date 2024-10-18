/* 서브쿼리 : 다른 SQL 쿼리문 내에 포함되는 쿼리문을 말함
 * 주로 데이터를 필터링 하거나 데이터 집계에 사용
 * 서브쿼리는 SELECT, INSERT, UPDATE, DELETE문에 모두 사용 가능
 * 단일행 서브쿼리(단 하나의 행으로 결과가 반환)와 다중행 서브 쿼리(여러행의 결과가 반환)가 있음 */

-- 특정한 사원이 소속된 부서의 이름을 출력
SELECT dname AS "부서이름"
FROM DEPT
WHERE deptno = (
	SELECT DEPTNO
	FROM EMP
	WHERE ename = 'KING'
);

--등가 조인을 사용해서 구현
SELECT DNAME
FROM EMP e
JOIN DEPT d
ON e.DEPTNO = d.DEPTNO
WHERE e.ename = 'KING'

-- 서브쿼리로 'JONES'의 급여보다 높은 급여를 받는 사원 정보 출력
SELECT * FROM EMP
WHERE SAL > (
	SELECT SAL
	FROM EMP
	WHERE ENAME = 'JONES'
);

-- 자체 조인(SELF)로 풀기
SELECT e1.empno
FROM EMP e1
JOIN EMP e2
ON e1.sal > e2.sal
WHERE e2.ename = 'JONES';

-- 서브쿼리는 연산자와 같은 비교 또는 조회 대상의 오른쪽에 놓이며 괄호()로 묶어서 표현
-- 특정한 경우를 제외하고는 ORDER BY를 사용 할 수 없다
-- 서브쿼리의 SELECT 에 명시한 열은 메인 쿼리 비교 대상과 같은 자료형과 같은 개수로 지정해야 한다

-- 문제 : EMP 테이블의 사원 정보 중에서 사원 이름이 ALLEN인 사원의 추가 수당보다 많은 사원 정보 출력
SELECT * FROM EMP
WHERE ENAME = 'ALLEN'	-- ALLEN 의 COMM 확인 하기 위한 쿼리

SELECT * FROM EMP
WHERE COMM > (
	SELECT COMM
	FROM EMP
	WHERE ENAME = 'ALLEN'
);

-- 문제 : JAMES 보다 먼저 입사한 사원들의 정보 출력
SELECT * FROM EMP
WHERE ENAME = 'JAMES';	-- JAMES 의 HIREDATE 정보 출력

SELECT * FROM EMP
WHERE HIREDATE > (
	SELECT HIREDATE
	FROM EMP
	WHERE ENAME = 'JAMES'
);

--문제 : 20번 부서에 속한 사원 중 전체 사원의 평균 급여 보다 높은 급여를 받는 사원 정보와 소속 부서 조회
SELECT e.empno, e.ename, e.sal, d.deptno, d.dname, d.loc
FROM EMP e
JOIN DEPT d
ON e.DEPTNO = d.DEPTNO
WHERE e.DEPTNO = 20 
AND e.sal > (
	SELECT AVG(SAL)
	FROM EMP
);

-- 실행 결과가 여러개인 다중행 서브쿼리
-- IN : 메인 쿼리의 데이터가 서브쿼리의 결과 중 하나라도 일치 데이터가 있다면 TRUE
-- 각 부서별로 가장 높은 급여를 받는 사람
SELECT * FROM EMP
WHERE SAL IN (
	SELECT MAX(SAL)
	FROM EMP
	GROUP BY DEPTNO
);

-- ANY, SOME : 메인 쿼리의 조건식을 만족하는 서브쿼리의 결과가 하나 이상이면 TRUE
-- SALESMAN 의 직업을 가진 사원들중 최소 급여자보다 많은 급여를 받는 사원들
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > ANY (
	SELECT SAL
	FROM EMP
	WHERE JOB = 'SALESMAN'
);

-- SALEMAN 의 직업을 가진 사원들과 같은 급여를 받는 사원들
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL = ANY (
	SELECT SAL
	FROM EMP
	WHERE JOB = 'SALESMAN'
);

-- 30번 부서 사원들의 급여 보다 적은 급여를 받는 사원 정보 출력
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
FROM EMP
WHERE SAL < (
	SELECT MIN(SAL)
	FROM EMP
	WHERE DEPTNO = 30
);

-- ALL : 메인 쿼리의 조건식을 서브쿼리의 결과 모두가 만족하면 TRUE
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
FROM EMP
WHERE SAL < ALL (
	SELECT SAL
	FROM EMP
	WHERE DEPTNO = 30
);

-- 직책이 'MANAGER' 인 사원 보다 많은 급여를 받는 사원의 사원번호, 이름, 급여, 부서이름 출력
SELECT e.EMPNO, e.ENAME, e.SAL, d.DNAME
FROM EMP e
JOIN DEPT d ON e.DEPTNO = d.DEPTNO
WHERE SAL > ALL (
	SELECT SAL
	FROM EMP
	WHERE d.DNAME = 'MANAGER'
);


-- EXISTS : 서브쿼리의 결과가 존재하면 TRUE
SELECT * FROM EMP
WHERE EXISTS (
	SELECT dname
	FROM DEPT
	WHERE DEPTNO = 10
);

-- 다중열 쿼리 : 서브 쿼리의 결과가 두 개 이상의 컬럼으로 반환되어 메인 쿼리에 전달하는 쿼리
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE (DEPTNO, SAL) IN (
	SELECT DEPTNO, SAL
	FROM EMP
	WHERE DEPTNO = 30
);

SELECT * FROM EMP
WHERE (DEPTNO, SAL) IN (
	SELECT DEPTNO, MAX(SAL)
	FROM EMP
	GROUP BY DEPTNO
);

-- FROM 에 사용하는 서브 쿼리 : 인라인뷰라고 하기도 함
SELECT e10.EMPNO, e10.ENAME, e10.DEPTNO, d.DNAME, d.LOC
FROM (
	SELECT * FROM EMP
	WHERE DEPTNO = 10) e10
JOIN DEPT d
ON e10.DEPTNO = d.DEPTNO;

-- 먼저 정렬하고 해당 갯수만 가져오기 : 급여가 많은 5명에 대한 정보 보여줘
SELECT ROWNUM, ENAME, SAL
FROM EMP
WHERE ROWNUM <= 5;

-- SELECT 에 사용하는 서브쿼리 : 단일행 서브쿼리를 스칼라 서브쿼리라고 한다
-- SELECT 에 명시하는 서브쿼리는 반드시 하나의 결과만 반환하도록 작성해야 한다
SELECT EMPNO, ENAME, JOB, SAL,
	(
		SELECT GRADE
		FROM SALGRADE
		WHERE e.SAL BETWEEN LOSAL AND HISAL
	) AS "급여 등급",
	DEPTNO AS "부서 번호",
	(
		SELECT DNAME
		FROM DEPT d
		WHERE e.DEPTNO = d.DEPTNO
	) AS "부서이름"
FROM EMP e
ORDER BY "급여 등급";

-- 조인문으로 변경하기
SELECT SELECT e.EMPNO, e.ENAME, e.JOB, e.SAL, s.GRADE AS "급여등급", d.DEPTNO, DNAME
FROM EMP e
JOIN SALGRADE s 
ON e.SAL BETWEEN s.LOSAL AND s.HISAL
JOIN DEPT d
ON e.DEPTNO = d.DEPTNO
ORDER BY "급여등급"
ㄴ
SELECT EMPNO, ENAME,
        CASE WHEN DEPTNO = (SELECT DEPTNO
                            FROM DEPT
                            WHERE LOC = 'NEW YORK')
            THEN '본사'
            ELSE '분점'
        END AS 소속
FROM EMP
ORDER BY 소속 DESC;

/* 전체 사원 중 ALLEN과 같은 직책(JOB)인 사원들의 사원 정보, 부서 정보를 다음과 같이 출력하는 SQL문을 작성하세요. */
SELECT e.*, d.*
FROM EMP e
JOIN DEPT d
ON e.DEPTNO = d.DEPTNO
WHERE JOB = (
	SELECT JOB
	FROM EMP
	WHERE ENAME = 'ALLEN'
)

/* 전체 사원의 평균 급여(SAL)보다 높은 급여를 받는 사원들의 사원 정보, 부서 정보,
 * 급여 등급 정보를 출력하는 SQL문을 작성하세요
 * (단 출력할 때 급여가 많은 순으로 정렬하되 급여가 같을 경우에는 사원 번호를 기준으로 오름차순으로 정렬하세요).*/
SELECT E.EMPNO, E.ENAME, D.DNAME, E.HIREDATE, D.LOC, E.SAL, S.GRADE
  	FROM EMP E, DEPT D, SALGRADE S
 	WHERE E.DEPTNO = D.DEPTNO
   	AND E.SAL BETWEEN S.LOSAL AND S.HISAL
   	AND SAL > (
   		SELECT AVG(SAL)
        FROM EMP
)
ORDER BY E.SAL DESC, E.EMPNO;

/* 10번 부서에 근무하는 사원 중 30번 부서에는 존재하지 않는 직책을 가진 사원들의 사원 정보,
 *  부서 정보를 다음과 같이 출력하는 SQL문을 작성하세요. */
SELECT E.EMPNO, E.ENAME, E.JOB, E.DEPTNO, D.DNAME, D.LOC
  	FROM EMP E, DEPT D
 	WHERE E.DEPTNO = D.DEPTNO
   	AND E.DEPTNO = 10
   	AND JOB NOT IN (
   		SELECT DISTINCT JOB
		FROM EMP
		WHERE DEPTNO = 30
);
	
/* 직책이 SALESMAN인 사람들의 최고 급여보다 높은 급여를 받는 사원들의 사원 정보,
 *  급여 등급 정보를 다음과 같이 출력하는 SQL문을 작성하세요
 * (단 서브쿼리를 활용할 때 다중행 함수를 사용하는 방법과 사용하지 않는 방법을 통해 사원 번호를 기준으로 오름차순으로 정렬하세요) */
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
  	FROM EMP E, SALGRADE S
 	WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
   	AND SAL > (
   		SELECT MAX(SAL)
        FROM EMP
        WHERE JOB = 'SALESMAN'
)
ORDER BY E.EMPNO;