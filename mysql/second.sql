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
	primary key (sno)
);

/*
  course 테이블 생성
*/
create table course(
	cno char(8),
	cname varchar(30) not null,
	credit int,
	profname varchar(20),
	dept varchar(20),
      primary key (cno)
);

/*
  enroll 테이블 생성
*/
create table enroll(
	sno char(15),
	cno char(8),
	lettergrade char(2),
	midterm int,
	final int,
	FOREIGN KEY (sno) REFERENCES student (sno) on delete cascade,
	FOREIGN KEY (cno) REFERENCES course (cno) on delete cascade,
    	primary key (sno, cno)
);

/*
  student 테이블에 샘플 레코드 삽입
*/
select * from student;
insert into student 
values('A111111', '유재석', 4,'컴퓨터');
insert into student 
values('B222222', '김종국', 3, '전자전기');
insert into student 
values('C333333', '이광수', 4, '기계공학');
insert into student 
values('D444444', '하동훈', 2, '산업디자인');
insert into student 
values('E555555', '송지효', 2, '산업공학');
select * from student;

/*
  course 테이블에 샘플 레코드 삽입
*/
select * from course;
insert into course 
values('M111', '자료구조', 1, '김민재', '컴퓨터');
insert into course 
values('M222', '프로그래밍', 3, '손흥민', '컴퓨터');
insert into course 
values('M333', '데이터베이스', 2, '황희찬', '컴퓨터');
select * from course;

/*
  enroll 테이블에 샘플 레코드 삽입
*/
select * from enroll;
insert into enroll 
values('A111111', 'M111', 'A', 80 ,100);
insert into enroll 
values('B222222', 'M222', 'B', 70, 85);
insert into enroll 
values('C333333', 'M333', 'A', 90, 95);
insert into enroll 
values('D444444', 'M333', 'B', 85, 75);
select * from enroll;

select * from student;
select * from course;
select * from enroll;
select sno, sname from student where dept = '컴퓨터' and grade = 4;
select distinct cno as "수강 중인 모든 과목번호" from enroll;
select sno, sname from student where sname like '김%';
select sno, cno from enroll where midterm >= 80 order by sno asc, cno desc;
select sname from student where grade is not null;
select count(*) as "학생수" from student where dept = '컴퓨터';
select count(*) as "과목수" from course;
