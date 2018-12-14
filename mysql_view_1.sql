create view v_enroll_subject as
	select e.* , s.name, s.prof
		from Enroll e inner join Subject s on e.subject = s.id;
        
desc v_enroll_subject ;

select * from v_enroll_subject ;

select current_user();

select * from information_schema.views
	where table_schema = 'joodb';
	
create view v_grade_enroll as
	select g.*, e.subject, e.student
		from Grade g inner join Enroll e on g.enroll = e.id ;
