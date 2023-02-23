-- 테이블명 + 항목명 + 항목이 들어가는 데이터타입

CREATE TABLE product2 ( 
	no varchar2(100),
	name varchar2(100),
	content varchar2(100),
	price number
)

CREATE TABLE "HR"."MEMBER3" 
   (	"ID" VARCHAR2(100), 
	"PW" VARCHAR2(100), 
	"NAME" VARCHAR2(100), 
	"TEL" VARCHAR2(100)
   )
   
CREATE TABLE "HR"."HOBBY2" 
   (	"HOBBYID" NUMBER(38,0), 
	"CONTENT" VARCHAR2(100), 
	"LOCATION" VARCHAR2(100)
   )
   
INSERT INTO HOBBY  VALUES (100,'run','seoul')

INSERT INTO HOBBY  VALUES (200,'book','busan')
   
INSERT INTO "member" VALUES ('park','1234','park','011')

INSERT INTO "member" VALUES ('apple','1111','apple','011')

INSERT INTO "member" VALUES ('ice','2222','ice','012')

INSERT INTO "member" VALUES ('melon','3333','melon','013')

SELECT * FROM HOBBY

SELECT CONTENT FROM HOBBY

SELECT LOCATION, CONTENT FROM HOBBY

SELECT * FROM "member" --모든컬럼

SELECT id FROM "member"

SELECT id, pw FROM "member"