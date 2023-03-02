CREATE TABLE PRODUCT (
	ID VARCHAR2(200),
	NAME VARCHAR2(200),
	CONTENT VARCHAR2(200),
	PRICE NUMBER(38,0),
	COMPANY VARCHAR2(200),
	IMG VARCHAR2(200)
)

-- 한줄 복사: 컨트롤 + 알트 + 화살표 아래

-- 한줄 삭제: 컨트롤 + D

-- 저장할 대상: 엔티티(회원정보, 게시판, 상품정보), 엔티티간의 관계: 회원이 상품을 주문하다(주문정보)
-- 엔티티 + 관계 ==> 테이블로 만들자.!!!

CREATE TABLE ORDERLIST (
	NO VARCHAR2(100),
	MEMBER_ID VARCHAR2(100),
	PRODUCT_ID VARCHAR2(100),
	TOTAL_COUNT VARCHAR2(100)
)

CREATE TABLE "HR"."BBS2" 
(	"NO" VARCHAR2(100), 
	"TITLE" VARCHAR2(100), 
	"CONTENT" VARCHAR2(100), 
	"WRITER" VARCHAR2(100), 
	 CONSTRAINT "BBS_PK22" PRIMARY KEY ("NO"),
	 CONSTRAINT "FK_MEMBER22" FOREIGN KEY ("WRITER")
	  REFERENCES "HR"."MEMBER" ("ID")
)

CREATE TABLE "HR"."BBS3" 
(	"NO" VARCHAR2(100), 
	"TITLE" VARCHAR2(100), 
	"CONTENT" VARCHAR2(100), 
	"WRITER" VARCHAR2(100)
)

-- PK 제약조건 추가
ALTER TABLE "HR".BBS3 
ADD CONSTRAINT "BBS3_PK" 
PRIMARY KEY ("NO");

-- FK 제약조건 추가
ALTER TABLE "HR".BBS3 
ADD CONSTRAINT "BBS3_FK" 
FOREIGN KEY ("WRITER") REFERENCES HR."MEMBER"(ID);

-- 확인문제 1-(1) SQL TABLE을 만들때 PRIMARY KEY 설정
CREATE TABLE "HR"."DEPART2" 
(	"ID" VARCHAR2(100), 
	"NAME" VARCHAR2(100), 
	"INSTRUCTOR" VARCHAR2(100),
	 CONSTRAINT "DEPART2_PK" PRIMARY KEY ("ID")
)

-- 확인문제 2-(1) SQL TABLE을 만들고 제약조건 주가
CREATE TABLE "HR"."STUDENT2"
(	"ID" VARCHAR2(100), 
	"NAME" VARCHAR2(100), 
	"TEL" VARCHAR2(100),
	"DEPART_ID" VARCHAR2(100)
)

ALTER TABLE "HR".STUDENT2  
ADD CONSTRAINT "STUDENT2_PK" 
PRIMARY KEY ("ID");

ALTER TABLE "HR".STUDENT2  
ADD CONSTRAINT "STUDENT2_FK" 
FOREIGN KEY ("DEPART_ID") REFERENCES "HR"."DEPART2" ("ID")

-- 테이블 복사
CREATE TABLE MEMBER22
AS SELECT * FROM MEMBER

INSERT INTO MEMBER22 VALUES ('AAA','BBB','CCC','DDD',SYSDATE ,'ICE', 'STAR')

INSERT INTO BBS3 VALUES (BBS_ID_SEQ.NEXTVAL,'HAPPY','HAPPY DAY2','ICE');

CREATE SEQUENCE PD_ID_SEQ
INCREMENT BY 1
START WITH 1

CREATE TABLE PRODUCT2 (
	ID NUMBER(38,0),
	NAME VARCHAR2(100)
)

INSERT INTO PRODUCT2 VALUES (PD_ID_SEQ.NEXTVAL, 'SHOES')

SELECT * FROM PRODUCT2

-- 확인문제
-- ORDERLIST3 만들기 // ID(NUMBER), TITLE, PRICE(NUMBER)
CREATE TABLE ORDERLIST3 (
	ID NUMBER(38,0),
	TITLE VARCHAR2(100),
	PRICE NUMBER(38,0)
)
	
-- SEQUENCE 만들기 // 이름: OR_SEQ, START값: 1, INCREMENT값: 1
CREATE SEQUENCE OR_SEQ
INCREMENT BY 1
START WITH 1

-- ROW값 3개 이상 넣어보고 확인해보세요.
INSERT INTO ORDERLIST3 VALUES (OR_SEQ.NEXTVAL,'A',2000)

INSERT INTO ORDERLIST3 VALUES (OR_SEQ.NEXTVAL,'8',3000)

INSERT INTO ORDERLIST3 VALUES (OR_SEQ.NEXTVAL,'C',7000)

SELECT * FROM ORDERLIST3

SELECT * FROM ORDERLIST3 ORDER BY ID DESC -- 내림차순


CREATE TABLE DEPT
(
	DEPTNO NUMBER(2),
	DNAME VARCHAR2(14 BYTE),
	LOC VARCHAR2(13 BYTE)
)

CREATE TABLE EMP
(
	EMPNO NUMBER(4),
	ENAME VARCHAR2(10 BYTE),
	JOB VARCHAR2(9 BYTE),
	MGR NUMBER(4),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2)
)

CREATE TABLE SALGRADE
(
	GRADE NUMBER,
	LOSAL NUMBER,
	HISAL NUMBER
)

ALTER TABLE DEPT ADD (
CONSTRAINT PK_DEPT
PRIMARY KEY
(DEPTNO));

ALTER TABLE EMP ADD (
CONSTRAINT PK_EMP
PRIMARY KEY
(EMPNO));

ALTER TABLE EMP ADD (
CONSTRAINT FK_DEPTNO
FOREIGN KEY (DEPTNO)
REFERENCES DEPT (DEPTNO));

SELECT * FROM EMP -- SELECTION

SELECT DEPTNO FROM EMP -- PROJECTION

SELECT DISTINCT DEPTNO FROM EMP -- DISTINCT

SELECT ENAME, SAL * 12 AS YEARSAL FROM EMP

SELECT * FROM EMP ORDER BY SAL DESC 

SELECT * FROM EMP WHERE DEPTNO = 30 ORDER BY EMPNO DESC 

SELECT * FROM EMP WHERE NOT DEPTNO = 30 ORDER BY EMPNO DESC 

SELECT * FROM EMP WHERE DEPTNO = 30 AND JOB = 'SALESMAN'

SELECT * FROM EMP WHERE DEPTNO = 30 OR JOB = 'SALESMAN'

SELECT * FROM EMP WHERE SAL >= 3000

SELECT * FROM EMP WHERE SAL != 3000

SELECT * FROM EMP WHERE JOB IN ('SALESMAN', 'MANAGER') ORDER BY JOB 

SELECT * FROM EMP WHERE JOB NOT IN ('SALESMAN', 'MANAGER') ORDER BY JOB 

SELECT * FROM EMP WHERE SAL BETWEEN 2000 AND 3000 ORDER BY EMPNO

SELECT * FROM EMP WHERE SAL NOT BETWEEN 2000 AND 3000 ORDER BY EMPNO

SELECT * FROM EMP WHERE ENAME LIKE '_L%'

SELECT * FROM EMP WHERE ENAME NOT LIKE '_L%'

SELECT * FROM EMP WHERE COMM IS NULL 

SELECT * FROM EMP WHERE COMM IS NOT NULL 

CREATE TABLE DEPT_TEMP2 AS SELECT * FROM DEPT

SELECT * FROM DEPT_TEMP2

UPDATE DEPT_TEMP2 SET LOC = 'SEOUL'

UPDATE DEPT_TEMP2 SET DNAME = 'DATABASE', LOC = 'BUSAN' WHERE DEPTNO = 40

DELETE FROM DEPT_TEMP2 WHERE DNAME = 'SALES'

-- SELECT, UPDATE, DELETE 정리문제

--price로 내림차순 정렬하여 전체컬럼 검색
SELECT * FROM PRODUCT ORDER BY PRICE DESC

--company로 오름차순 정렬하여 제품의 이름, 내용, 가격 검색
SELECT NAME, CONTENT, PRICE FROM PRODUCT ORDER BY COMPANY

--company의 목록을 검색(중복제거)
SELECT DISTINCT COMPANY FROM PRODUCT

--각 신발을 5개씩 주문했을 때의 가격을 price5라고 항목명을 지정하여 출력
SELECT ID, NAME, CONTENT, PRICE*5 AS PRICE5, COMPANY, IMG FROM PRODUCT

--price가 5000인 제품명과 회사명
SELECT NAME, COMPANY FROM PRODUCT WHERE PRICE = 5000

--price가 3000와 6000사이인 제품명과 가격, 회사명 검색
SELECT NAME, PRICE, COMPANY FROM PRODUCT WHERE PRICE BETWEEN 3000 AND 6000

--회사명이 c100이 아닌 회사명과 제품명
SELECT COMPANY, NAME FROM PRODUCT WHERE COMPANY ='c100'

--회사명이 c100, c200인 제품명과 가격
SELECT NAME, PRICE FROM PRODUCT WHERE COMPANY ='c100' OR COMPANY ='c200'

--제품명에 4로 끝나는 제품의 전체 정보 검색
SELECT * FROM PRODUCT WHERE NAME LIKE '%4'

--제품내용에 food를 포함하는 제품의 전체 정보 검색
SELECT * FROM PRODUCT WHERE CONTENT LIKE '%food%'

--price가 5000원인 제품의 content를 품절로 수정
UPDATE PRODUCT SET CONTENT = '품절' WHERE PRICE = 5000

--id가 100, 102번 제품의 img를 o.png로, price를 10000으로 수정
UPDATE PRODUCT SET IMG = 'o.png', PRICE = 10000 WHERE ID = '100' OR ID = '102'

--회사명이 c100인 경우 모든 정보 삭제
DELETE FROM PRODUCT WHERE COMPANY = 'c100'

--테이블의 모든 정보 삭제
DELETE FROM PRODUCT

--테이블 삭제
DROP TABLE PRODUCT


