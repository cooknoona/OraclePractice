/* 데이터 사전이란? : 데이터베이스를 구성하고, 운영하는데 필요한 모든 정보를 저장하는 특수한 테이블을 의미함
 * 데이터 사전에는 데이터베이스 메모리, 성능, 사용자, 권한, 객체 등등의 정보가 포함된다 */

SELECT * FROM DICTIONARY;

SELECT * FROM USER_INDEXES;

-- 인덱스 생성 : 오라클에서는 자동으로 생성해주는 인덱스(PK)외에 사용자가 직접 인덱스를 만들때는
-- CREAT를 사용 해야 한다

CREATE INDEX IDX_EMP_SAL ON EMP(SAL);

-- 인덱스 삭제
DROP INDEX IDX_EMP_SAL;

-- 테이블 뷰 : 가상 테이블로 부르는 뷰(View)는 하나 이상의 테이블을 조회하는 SELECT를 저장한 객체를 의미
-- SELECT * FROM VM_EMP20;
SELECT * FROM (
	SELECT EMPNO, ENAME, JOB, DEPTNO
	FROM EMP
	WHERE DEPTNO = 20
);

CREATE VIEW VW_EMP20
AS (SELECT EMPNO, ENAME, JOB, DEPTNO
	FROM EMP
	WHERE DEPTNO = 20
);

-- 규칙에 따라 순번을 생성하는 시퀀스
-- 시퀀스 : 오라클 데이터베이스에서 특정 규칙에 맞는 연속 숫자를 생성하는 객체
CREATE TABLE DEPT_SEQUENCE
AS SELECT * FROM DEPT
WHERE 1 <> 1;

CREATE SEQUENCE SEQ_DEPT_SEQUENCE
INCREMENT BY 10
START WITH 10
MAXVALUE 90
MINVALUE 0
NOCYCLE
CACHE 2;

SELECT * FROM USER_SEQUENCES;

INSERT INTO DEPT_SEQUENCE
