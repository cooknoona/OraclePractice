/* DML (Data Manipulation Language) : INSERT(입력), UPDATE(수정), DELETE(삭제) 
 * 연습용 테이블 생성하기 */
CREATE TABLE DEPT_TEMP
AS SELECT * FROM DEPT;

SELECT * FROM DEPT_TEMP;

-- TABLE 에 데이터를 추가 하는 INSERT

-- 1. INSERT INTO TABLE_NAME(COLUMN_NAME1, COLUMN_NAME2, COLUMN_NAME2) VALUES(VALUE1, VALUE2, VALUE3)
INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC) VALUES(50, 'DATABASE', 'SEOUL');

INSERT INTO DEPT_TEMP VALUES (60, 'BACKEND', 'BUSAN');	-- COLUMN의 순서에 맞게 데이터값이 입력 된다

INSERT INTO DEPT_TEMP(DEPTNO) VALUES(70);	-- COLUMN 하나만 지정해서 나머지는 NULL 값

INSERT INTO DEPT_TEMP VALUES (80, 'FRONTEND', 'INCHEON');

INSERT INTO DEPT_TEMP VALUES (90, NULL, 'INCHEON');
INSERT INTO DEPT_TEMP VALUES (95, ' ', 'INCHEON');

DELETE FROM DEPT_TEMP
WHERE LOC = 'INCHEON';

INSERT INTO DEPT_TEMP VALUES (70, '웹개발', '');

CREATE TABLE EMP_TEMP
AS SELECT * FROM EMP WHERE 1 != 1;

SELECT * FROM EMP_TEMP;

INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (9001, '나영석', 'PD', NULL, TO_DATE('2021/01/02', 'YYYY/MM/DD'), 9900, 1000, 50);

INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (9002, '강호동', 'MC', NULL, TO_DATE('2021/01/01', 'YYYY/MM/DD'), 8000, 1000, 70);

INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (9003, '서장훈', 'MC', NULL, SYSDATE, 9000, 1000, 80);

SELECT * FROM DEPT_TEMP;

SELECT * FROM EMP_TEMP;

INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC) VALUES (80, 'FRONTEND', 'SUWON');
ROLLBACK;

UPDATE DEPT_TEMP
	SET DNAME = 'WEB-PROGRAMME',
		LOC = 'SUWON'
	WHERE DEPTNO = 70;
COMMIT;

DELETE FROM DEPT_TEMP
	WHERE LOC = 'SUWON';
	
DELETE FROM EMP_TEMP
	WHERE ENAME = '서장훈';