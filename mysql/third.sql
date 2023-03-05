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
  course 테이블에 샘플 레코드 삽입
*/
select * from course;
insert into course 
values('M111', 'data strucutre', 1, 'Kim Kyoungmoon', 'computer');
insert into course 
values('M222', 'programming', 3, 'Kang Gitae', 'computer');
insert into course 
values('M333', 'database', 2, 'Kim Hyunsoo', 'computer');
select * from course;

/*
  enroll 테이블에 샘플 레코드 삽입
*/
select * from enroll;
insert into enroll 
values('A890309', 'M111', 'A', 80 ,100);
insert into enroll 
values('A890515', 'M222', 'B', 70, 85);
insert into enroll 
values('A890801', 'M333', 'A', 90, 95);
insert into enroll 
values('A910628', 'M333', 'B', 85, 75);
select * from enroll;

/* 8번 */
select student.sno, student.sname  
from enroll, student 
where enroll.cno='M111' and enroll.sno=student.sno;

/* 9번 */
select student.sname, course.cname 
from student, course, enroll 
where course.profname='Kang Gitae' and enroll.cno=course.cno and enroll.sno=student.sno;

/* 10번 */
select student.sno, student.sname 
from student 
where dept = (select dept from course where profname='Kim Hyunsoo');

/* 11번 */
select student.sno, student.sname 
from student 
where dept not in (select dept from course where profname='Kim Hyunsoo');

/* 12번 */
select student.sname, count(*) as "Number of students" 
from student, course, enroll 
where course.profname='Kim Kyoungmoon' and course.cno=enroll.cno and student.sno=enroll.sno
group by student.sname;