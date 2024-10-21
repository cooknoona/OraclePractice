/* DDL(Data Definition Langauge) : 데이터베이스에 데이터를 보관하기 위해,
 * 제공되는 생성, 변경, 삭제 관련 기능을 수행
 * CREATE : 새로운 데이터베이스를 개체(Entity) 를 생성 - TABLE, VIEW, INDEX
 * ALTER : 기존 데이터베이스의 개체(Entity) 를 수정
 * DROP : 데이터베이스 개체(Entity) 를 삭제
 * TRUNCATE : 모든 데이터를 삭제하지만 테이블 구조는 담겨 둠
 * TABLE? : 데이터베이스의 기본 데이터 저장 단위인 테이블은 사용자가 접근 가능한
 * 데이터를 보유하며 레코드(행) 와 컬럼(열) 으로 구성 된다 
 * 테이블과 테이블의 관계를 표현하는데 외래키 (Foreign Key)를 사용 */

CREATE TABLE EMP_DDL(
	EMPNO NUMBER(4),	-- NUMERICAL DATA TYPE, 4자리로 선언, 최대 크기로 38자리까지 숫자 지정
	ENAME VARCHAR2(10), -- 가변문자 데이터 타입, 4000Byte, 실제 입력된 크기 만큼 차지
	JOB VARCHAR2(9),
	MGR NUMBER(4),
	HIREDATE DATE,	-- 날짜와 시간을 지정하는 날짜형 데이터 타입
	SAL NUMBER(7, 2),	-- 전체범위가 7자리에 소수점 이하가 2자리
	COMM NUMBER(7, 2),
	DEPTNO NUMBER(2)
);

SELECT * FROM EMP_DDL;

-- 기존 테이블의 열 구조와 데이터를 복사하여 새 테이블 생성하기
CREATE TABLE DEPT_DDL
	AS SELECT * FROM DEPT;
	
SELECT * FROM DEPT_DDL;

CREATE TABLE EMP_ALTER
	AS SELECT * FROM EMP;
	
SELECT * FROM EMP_ALTER;

-- 열 이름을 추가하는 add
ALTER TABLE EMP_ALTER
	ADD HP VARCHAR2(20);

-- 열 이름을 변경하는 rename
ALTER TABLE EMP_ALTER
	RENAME COLUMN HP TO TEL;

-- 열의 자료형을 변경하는 Modify
-- 자료형 변경 시 데이터가 이미 존재하는 경우 크기를 크게 하는 경우는 문제가 되지 않으나
-- 크기를 줄이는 경우 저장되어 있는 데이터 크기에 따라 변경되지 않을 수 있음
ALTER TABLE EMP_ALTER
	MODIFY EMPNO NUMBER(5);

-- 특정 열을 삭제하는 DROP
ALTER TABLE EMP_ALTER
	DROP COLUMN TEL;

SELECT * FROM EMP_ALTER;

RENAME EMP_ALTER TO EMP_RENAME;
SELECT * FROM EMP_RENAME;

-- 테이블의 데이터를 삭제하는 TRUNCATE : 테이블의 모든 데이터 삭제, 테이블 구조에 영향 주지 않음
-- ddl 명령어 이기 때문에 ROLLBACK 불가
DELETE FROM EMP_RENAME;
ROLLBACK;

TRUNCATE TABLE EMP_RENAME;
DROP TABLE EMP_RENAME;
