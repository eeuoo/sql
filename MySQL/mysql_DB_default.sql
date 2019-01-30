create table Test(
	id tinyint unsigned not null auto_increment,
    name char(5) not null ,
    primary key(id)  ) ;
    
    
desc Test ;

desc Test2;

show create table Test ;

show processlist ;
show variables like '%session%' ;

select * from Test ;

insert into Test(name) select name from Student where id < 2 ;

delete from Test where id > 1 ;

alter Test add column 'ttt'  varchar(3)  null after 'nn';

insert into Test(name) values('김일수') ;

ALTER DATABASE joodb DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;