
select addr, group_concat(name) from Student group by addr ;

select addr, if (addr = '강원', '*', '') , group_concat(name) from Student group by addr ;

select group_concat(name) from temp_sub;

create temporary table temp_sub(
	id smallint unsigned not null auto_increment primary key,
    name varchar(31) not null);

insert into temp_sub(name) select name from Subject order by name;


select sub.name as sub_name, stu.gender as stu_name, count(*) as count
 	 from Enroll e inner join Student stu on e.student = stu.id
						 inner join Subject sub on e.subject = sub.id
	where stu.addr = '서울'
    group by sub.id, stu.gender ;
	
    


