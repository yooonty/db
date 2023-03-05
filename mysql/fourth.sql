/*
  데이터베이스 생성 및 지정
*/
create database IF NOT EXISTS university;
use university;

set foreign_key_checks = 0;   -- 외래키 체크하지 않는 것으로 설정
drop table IF EXISTS student cascade;   -- 기존 student 테이블 제거  
drop table IF EXISTS course cascade;   -- 기존 course 테이블 제거  
drop table IF EXISTS enroll cascade;   -- 기존 enroll 테이블 제거  
set foreign_key_checks = 1;   -- 외래키 체크하는 것으로 설정


/*
  student 테이블 생성
*/
create table student (
	sno char(7) NOT NULL, 
	sname varchar(20) NOT NULL, 
	grade int DEFAULT 1, 
	dept varchar(20),
	primary key (sno));

/*
  insert 실습
*/
select * from student;
insert into student 
values('A890309', 'Lee Jinbeom', 4,'computer');
insert into student 
values('A890515', 'Kim Taekyu', 3, 'electrical');
insert into student 
values('A890801', 'Lee Kyoungsoo', 4, 'mechanical');
insert into student 
values('A910628', 'Kim Hokyoung', 2, 'design');
insert into student 
values('B070805', 'Kim Hyunki', 2, 'industrial');
select * from student;

/*
  update 실습
*/
update student
set sname = 'Kim Hoyoung'
where sno = 'A910628';
update student
set dept = 'construction'
where sno = 'B070805';
select * from student;

/*
  delete 실습
*/
delete
from student
where sno = 'A890801';
delete
from student
where sno = 'B070805';
select * from student;

/*
  view 실습
*/
drop view IF EXISTS second_grade_student;
create view second_grade_student
as select sno,sname
   from student
   where grade = 2
with check option;
select * from second_grade_student;
   