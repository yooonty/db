create database IF NOT EXISTS rental;
use rental;
alter database rental default character set utf8mb4;

set foreign_key_checks = 0;  -- 외래키 체크하지 않는 것으로 설정
drop table IF EXISTS 고객 cascade;  -- 기존 고객 테이블 제거
drop table IF EXISTS 대리점 cascade;  -- 기존 대리점 테이블 제거
drop table IF EXISTS 직원 cascade;  -- 기존 직원 테이블 제거  
drop table IF EXISTS 제품모델 cascade;  -- 기존 제품모델 테이블 제거 
drop table IF EXISTS 렌탈정보 cascade;  -- 기존 렌탈정보 테이블 제거
set foreign_key_checks = 1;  -- 외래키 체크하는 것으로 설정

/*
  고객 테이블 생성
*/
create table 고객(
	cid char(4) NOT NULL, 
	고객이름 varchar(20) NOT NULL, 
	고객주소 varchar(20), 
	고객연락처 varchar(20) NOT NULL,
	primary key (cid));
    
/*
  대리점 테이블 생성
*/
create table 대리점(
	bid char(4) NOT NULL, 
	대리점이름 varchar(20) NOT NULL, 
	대리점주소 varchar(20), 
	대리점전화번호 varchar(20) NOT NULL,
	primary key (bid));
    
/*
  직원 테이블 생성
*/
create table 직원(
	eid char(4) NOT NULL, 
	직원이름 varchar(20) NOT NULL, 
	직원주소 varchar(20), 
	직원연락처 varchar(20) NOT NULL,
    bid char(4),
    FOREIGN KEY (bid) REFERENCES 대리점 (bid) on delete cascade,
	primary key (eid));
    
/*
  제품모델 테이블 생성
*/
create table 제품모델(
	bid char(4) NOT NULL,
	모델번호 char(4) NOT NULL,
	종류 char(10) NOT NULL,
	출시연도 int,
	소비전력 int,
    구입날짜 date,
    cid char(4),
    렌탈예정일 date,
    반납예정일 date,
	FOREIGN KEY (bid) REFERENCES 대리점 (bid) on delete cascade,
	FOREIGN KEY (cid) REFERENCES 고객 (cid) on delete cascade,
	primary key (bid, 모델번호)
);

/*
  렌탈정보 테이블 생성
*/
create table 렌탈정보(
	cid char(4) NOT NULL,
	bid char(4) NOT NULL,
	모델번호 char(4) NOT NULL,
	렌탈일 date NOT NULL,
	반납일 date NOT NULL,
    반납연체일수 int,
	FOREIGN KEY (cid) REFERENCES 고객 (cid) on delete cascade,
    FOREIGN KEY (bid, 모델번호) REFERENCES 제품모델 (bid, 모델번호) on delete cascade,
	primary key (cid, bid, 모델번호, 렌탈일),
    check (반납연체일수>=0)
);

/*
  고객 테이블에 샘플 레코드 삽입
*/
insert into 고객 
values('C001', 'PDN', '강동구 암사동','010-3304-6302');
insert into 고객 
values('C002', 'KYS', '경기도 의왕시 삼동', '010-7323-3789');
insert into 고객
values('C003', 'YDJ', '관악구 신림동', '010-2628-7436');
insert into 고객 
values('C004', 'KSM', '강동구 명일동', '010-2299-7827');
insert into 고객 
values('C005', 'PJH', '마포구 강인동', '010-3157-2501');
insert into 고객
values('C006', 'HBC', '노원구 상계동', '010-2936-5427');
insert into 고객
values('C007', 'KCY', '강동구 천호동', '010-7119-6732');
insert into 고객
values('C008', 'PYS', '중랑구 상봉동', '010-2523-9738');
insert into 고객
values('C009', 'KHJ', '강남구 대치동', '010-2255-8247');
insert into 고객 
values('C010', 'KDH', '강동구 명일동', '010-4516-9281');

/*
  대리점 테이블에 샘플 레코드 삽입
*/
insert into 대리점
values('B001', '홍익대리점', '마포구 상수동', '02-320-1114');
insert into 대리점
values('B002', '성균관대리점', '종로구 혜화동', '02-760-0114');
insert into 대리점
values('B003', '한양대리점', '성동구 왕십리동', '02-2220-0114');

/*
  직원 테이블에 샘플 레코드 삽입
*/
insert into 직원
values('E001', 'KMS', '광진구 자양동', '010-9502-1342', 'B001');
insert into 직원
values('E002', 'YKD', '강동구 상일동', '010-3422-1886', 'B001');
insert into 직원
values('E003', 'KHD', '마포구 서교동', '010-9872-8531', 'B002');
insert into 직원
values('E004', 'MKH', '마포구 상암동', '010-5261-2332', 'B002');
insert into 직원
values('E005', 'PSC', '성북구 안암동', '010-0934-1869', 'B003');
insert into 직원
values('E006', 'YSS', '강남구 개포동', '010-9515-8534', 'B003');

/*
  제품모델 테이블에 샘플 레코드 삽입
*/
insert into 제품모델
values('B001', 'M001', '세탁기', 2019, 1400, '21/10/16', 'C001', '2021/11/12', '2021/11/18');
insert into 제품모델
values('B001', 'M002', '냉장고', 2021, 1200, '20/10/10', 'C001', '2021/11/12', '2021/11/24');
insert into 제품모델
values('B001', 'M003', '오븐', 2020, 1700, '20/01/26', 'C002', '2021/11/13', '2021/11/20');
insert into 제품모델
values('B002', 'M004', '세탁기', 2019, 1900, '19/10/19', 'C003', '2021/11/13', '2021/11/25');
insert into 제품모델
values('B002', 'M005', '오븐', 2019, 1000, '20/11/11', 'C003', '2021/11/14', '2021/11/24');
insert into 제품모델
values('B002', 'M006', '건조기', 2021, 1300, '18/07/16', 'C005', '2021/11/14', '2021/11/27');
insert into 제품모델
values('B002', 'M007', '세탁기', 2018, 1600, '21/01/14', 'C007', '2021/11/14', '2021/11/22');
insert into 제품모델
values('B003', 'M008', '건조기', 2019, 900, '20/04/22', 'C007', '2021/11/15', '2021/11/28');
insert into 제품모델
values('B003', 'M009', '오븐', 2021, 1100, '20/10/17', 'C008', '2021/11/16', '2021/11/28');

/*
  렌탈정보 테이블에 샘플 레코드 삽입
*/
insert into 렌탈정보
values('C009', 'B001', 'M001', '2021/08/16', '2021/08/28', 0);
insert into 렌탈정보
values('C002', 'B001', 'M002', '2021/09/11', '2021/09/22', 2);
insert into 렌탈정보
values('C001', 'B002', 'M004', '2021/09/16', '2021/09/28', 0);
insert into 렌탈정보
values('C005', 'B002', 'M004', '2021/10/06', '2021/10/18', 8);
insert into 렌탈정보
values('C009', 'B002', 'M006', '2021/10/10', '2021/10/18', 0);
insert into 렌탈정보
values('C003', 'B002', 'M006', '2021/10/12', '2021/10/18', 0);
insert into 렌탈정보
values('C002', 'B002', 'M006', '2021/10/16', '2021/10/24', 1);
insert into 렌탈정보
values('C008', 'B003', 'M008', '2021/10/20', '2021/10/28', 2);
insert into 렌탈정보
values('C004', 'B003', 'M008', '2021/10/25', '2021/11/02', 0);
insert into 렌탈정보
values('C003', 'B003', 'M009', '2021/10/25', '2021/11/03', 3);

/* 1번 */
select * from 고객;
select * from 대리점;
select * from 직원;
select * from 제품모델;
select * from 렌탈정보;

/* 2번 */
select count(*) as "대리점 수"
from 대리점;

/* 3번 */
select eid, 직원이름, 직원주소
from 직원
where bid='B001';

/* 4번 */
select 소비전력, 출시연도
from 제품모델
where 소비전력 >= 1300
order by 소비전력 desc, 출시연도 asc;

/* 5번 */
select 대리점이름, 대리점주소
from 대리점
where bid = (select bid from 제품모델 where 구입날짜 = (select min(구입날짜) from 제품모델));

/* 6번 */
select 고객이름
from 고객
where cid in (select cid from 렌탈정보 where bid='B003');

/* 7번 */
select 고객.고객이름, 대리점.대리점이름
from 고객, 대리점, 제품모델
where 제품모델.반납예정일-제품모델.렌탈예정일 < 10 and 제품모델.cid=고객.cid and 제품모델.bid=대리점.bid;

/* 8번 */
select 대리점.대리점이름
from 대리점, 제품모델
where 대리점.bid=제품모델.bid
group by 제품모델.bid having sum(출시연도=2019) >= 2;

/* 9번 */
select count(*) as "K로 이름이 시작하는 고객들이 렌탈한 총 제품 수"
from 렌탈정보
where cid in (select cid from 고객 where 고객이름 like 'K%');

/* 10번 */
select 고객.고객이름
from 고객, 렌탈정보
where 렌탈정보.cid in (select 렌탈정보.cid from 렌탈정보 where 모델번호='M006') and 렌탈정보.모델번호='M001' and 고객.cid=렌탈정보.cid;

/* 11번 */
select cid, sum(반납연체일수) as "반납연체일수 합"
from 렌탈정보
group by cid;

/* 12번 */
select 고객이름
from 고객
where NOT EXISTS (select * from 렌탈정보 where 렌탈정보.cid=고객.cid);

/* 13번 */
select 고객.고객이름, 제품모델.모델번호, 대리점.대리점주소
from 고객, 제품모델, 대리점
where 제품모델.렌탈예정일 > '2021/11/13' and 제품모델.반납예정일 < '2021/11/26' and 제품모델.cid=고객.cid and 제품모델.bid=대리점.bid;

/* 15번 */
select 고객.고객이름, 고객.고객주소
from 고객, 렌탈정보, 대리점
where 렌탈정보.반납일 < '2021/09/30' and 대리점.대리점주소 like '종로구%' and 대리점.bid=렌탈정보.bid and 고객.cid=렌탈정보.cid;

/* 16번 */
update 제품모델
set 반납예정일 = 반납예정일 +1
where cid = 'C001';
select * from 제품모델;

/* 17번 */
delete
from 직원
where bid = 'B001' and 직원주소 like '마포구%';
select * from 직원;

/* 18번 */
drop view IF EXISTS M008렌탈고객;
create view M008렌탈고객(고객이름, 고객연락처)
as select 고객.고객이름, 고객.고객연락처
   from 고객, 렌탈정보
   where 렌탈정보.모델번호='M008' and 고객.cid=렌탈정보.cid
with check option;
select * from M008렌탈고객;

