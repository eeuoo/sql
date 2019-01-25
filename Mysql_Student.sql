create table Student (
	id tinyint unsigned not null auto_increment,
	name varchar(32) not null ,
	addr varchar(30) not null ,
	birth varchar(8) not null,
	tel varchar(15) not null,
	email varchar(31) not null,
	regdt timestamp,
	primary key(id)  
    ) ;
    
desc Student ;

insert into Student(name, addr, birth, tel, email) 
               	values('이햇살', '경상남도', '930223', '010-2222-3333', 'sunny@sunny.com') ;
                
insert into Student(name, addr, birth, tel, email)                 
				values('최바다', '강원도', '940906', '010-4444-5555', 'sea@sea.com') ;

insert into Student(name, addr, birth, tel, email) 
				values('이강산', '서울시', '950502', '010-8888-9999', 'river@river.com') ;
                
                
create table t_student like Student ;                

truncate t_student ;

select * from Student ;

select * from t_student ; 

insert into t_student select * from Student ;

alter table t_student drop  column email ;

show index from Student ;

show table status;

select tel from Student group by tel having count(*) > 1 ;

select s.* from (select name, addr, email from Student where tel like '010-2222%') s
				where s.email like 'sunny%' ; 
                
                
select *  from (select * from Student where like addr = '강원') order by birth limit 10, 5 ;

-- 강원 지역 학생 중 어린 순서로 11번째부터 5명 추출
select * from Student where addr = '강원' order by birth desc limit 10, 5 ;

-- 지역별 학생수 
select addr, count(*) as cnt from Student group by addr  order by cnt desc ;

-- 지역별 학생수가 160명 이상인 지역들만 추출
select addr, count(*) as cnt from Student group by addr  order by cnt desc;

alter table Student drop column gender ;
alter table Student add column gender bit not null default 0 ;

update Student set gender = 1  where id < 501 ;

update Student set gender = (case when name like '%혜%' or name like '%희%' then 0 else 1 end) where id > 0 ;
update Student set gender = 1
      where not (name like '%혜%' or name like '%희%' )  
      and id > 0 ;
update Student set gender = mod(id, 2);

select gender, count(*) from Student group by gender ;

