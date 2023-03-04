create database IF NOT EXISTS university;
use university;

drop table IF EXISTS student;
create table student(
    sno CHAR(7) NOT NULL,
    sname VARCHAR(20) NOT NULL,
    grade INT DEFAULT 1,
    dept VARCHAR(20),
    PRIMARY KEY(sno)
);

show tables;
desc student;

alter table student add address VARCHAR(30);
desc student;

alter table student drop column address;
desc student;

drop table student;
show tables;
