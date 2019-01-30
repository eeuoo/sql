
-- Club table
create table Club (
	id smallint unsigned not null auto_increment primary key,
    name varchar(31) not null,
    createdate timestamp not null default current_timestamp,
    leader int(11) unsigned, 
    constraint foreign key fk_leader_student(leader) references Student(id)
    on delete set null
    );
    
insert into Club(name, leader) values('요트부', 100);  
insert into Club(name, leader) values('미술부', 200);  
insert into Club(name, leader) values('테니스부', 300);

select * from Enroll;

select c.name , s.name as 'student name' from Club c inner join Student s on c.leader = s.id ;  



-- Prof table
create table Prof (
	  id smallint unsigned not null auto_increment primary key,
      name varchar(31) not null,
      likecnt int not null default 0,
      createdate timestamp not null default current_timestamp
       );

select s.* , p.name as 'prof name' from Subject s inner join Prof p on s.prof = p.id;  

insert into Prof(name, likecnt) select name, ceil(rand() * 100) from Student order by rand() limit 100 ;

select * from Prof ;


  
-- Subject table    
 create table Subject (
	id int unsigned not null auto_increment primary key,
    createdate timestamp not null default current_timestamp,
    prof smallint unsigned, 
    constraint foreign key fk_prof(prof) references Prof(id)
    on delete set null
    );   

select * from Subject ;    
    
insert into Subject(prof, name) values( 66, '수학') ; 
insert into Subject(prof, name) values( 44, '영어') ; 
insert into Subject(prof, name) values( 50, '도덕') ; 
insert into Subject(prof, name) values( 1, '역사') ; 
insert into Subject(prof, name) values( 2, '체육') ; 
insert into Subject(prof, name) values( 95, '국어') ; 
insert into Subject(prof, name) values( 12, '가정') ; 
insert into Subject(prof, name) values( 25, '기술') ;
insert into Subject(prof, name) values(30, '화학') ;  
insert into Subject(prof, name) values( 88, '사회') ; 

select id from Subject order by rand();



 -- Enroll table   
 create table Enroll (
	id smallint unsigned not null auto_increment primary key,
    createdate timestamp not null default current_timestamp,
    subject int unsigned, 
    student int(11) unsigned
    );

alter table Enroll add constraint  fk_student foreign key ( student ) references Student(id) on delete cascade;
alter table Enroll add constraint  foreign key fk_subject(subject) references Subject(id) on delete cascade;


-- insert into Enroll(subject, student) values (select id from Subject order by rand() , select id from Student order by rand()) ;

insert into Enroll(student, subject)  stu.id, (select id from Subject order by rand() limit 1)  
             from Student stu order by rand() on duplicate key update student = student ;

insert into Enroll(student, subject)  (select id from Student ) s, 1  ;

update  Enroll  set subject =  (select id from Subject order by rand() limit 1)  ;

insert into Enroll(subject)  (select id from Subject order by rand() limit 1) on duplicate update ;

insert into Enroll (student, subject) stu.id , (select id from Subject order by rand() limit 1) from Student stu on duplicate key update student = student;


select subject, count(*) from Enroll group by subject ;

select subject, student, count(*) from Enroll group by subject, student having count(*) > 1 ;


################################ 응 급 ########################################
insert into Enroll(student, subject)
 select id, (select id from Subject order by rand() limit 1) sid from Student order by id;

insert into Enroll(student, subject)
 select id, (select id from Subject order by rand() limit 1) sid from Student order by rand() limit 500
 on duplicate key update student = student;
 
insert into Enroll(student, subject)
 select id, (select id from Subject order by rand() limit 1) sid from Student order by rand() limit 500
 on duplicate key update student = student;
#############################################################################



-- 정상
select student, count(*) from Enroll group by student;
select count(student) from Enroll;
select count(*) from (select student, count(*) from Enroll group by student) s ;

-- --> Error Code: 1248. Every derived table must have its own alias


-- 오류
select student, count(*) from Enroll;  


-- update Enroll set subject = 3 where subject = 1 and id <> 0 limit 100; 
-- insert into Enroll(subject, student) select ( a.id , b.id) from Subject a, Student b ;


truncate table Enroll; 

select * from Enroll ;

select subject, count(*) from Subject group by subject ;

-- alter table Enroll add index fk_student_idx(student asc);


    
ALTER TABLE `joodb`.`Enroll` 
ADD INDEX `fk_student_idx` (`student` ASC);
;
ALTER TABLE `joodb`.`Enroll` 
ADD CONSTRAINT `fk_student`
  FOREIGN KEY (`student`)
  REFERENCES `joodb`.`Student` (`id`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE;
  

-- table 검증
desc Club;
desc Prof;
desc Subject;
desc Enroll;
desc Student;
    
show create table Student;
    
show create table Enroll;
    

Enroll CREATE TABLE `Enroll` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `createdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `subject` int(10) unsigned NOT NULL,
  `student` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk` (`student`,`subject`),
  CONSTRAINT `fk_student` FOREIGN KEY (`student`) REFERENCES `Student` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2046 DEFAULT CHARSET=utf8

Student	CREATE TABLE `Student` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `addr` varchar(30) NOT NULL,
  `birth` varchar(8) NOT NULL,
  `tel` varchar(15) NOT NULL,
  `email` varchar(31) NOT NULL,
  `regdt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `gender` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8


