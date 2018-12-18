-- DROP Procedure IF EXISTS sp_student_cnt ;


DELIMITER $$
CREATE Procedure sp_student_cnt (IN _subject_name varchar(31) ,
															OUT stucnt smallint) 
                                                            
BEGIN

	select count(*)  into  stucnt  from Enroll 
    where subject = (select id from Subject where name = _subject_name)  ;
    
END $$
DELIMITER ;

call sp_student_cnt('국어', @cnt);

select @cnt ;



-- 과목명을 입력받아, 해당과목의 수강 학생수와 과목 평균 점수를 반환하는 프로시저

DROP Procedure IF EXISTS sp_subject_name_cnt_avg ;

DELIMITER $$
CREATE Procedure sp_subject_name_cnt_avg (IN v_subject_name varchar(31) )
-- ,OUT stucnt smallint) 
                                                            
BEGIN

	select count(e.subject),  avg(g.midterm + g.finalterm)
    from Grade g inner join Enroll e on g.enroll = e.id
    where  e.subject = (select id from Subject where name = v_subject_name)  ;
    
END $$
DELIMITER ;

call sp_subject_name_cnt_avg ( '국어' ) ;


select id, name from Student where id < 3
union
select name, id from Student where id < 5;




-- 클럽명을 주면, 해당 클럽의 멤버를 아래와 같이 출력하는 프로시저를 작성하시오.

-- 함수 
DROP function f_level_korean;

DELIMITER $$
CREATE Function f_level_korean(v_level smallint) RETURNS varchar(31)

BEGIN
	RETURN (select case v_level when 0 then '평회원'
										             when 1 then '간부'
										            when 2 then '회장'  end) ;
                                        
END $$
DELIMITER ;


-- 프로시져
DROP Procedure IF EXISTS sp_club_member ;

DELIMITER $$
CREATE Procedure sp_club_member (IN v_club_name varchar(31) )
-- ,OUT stucnt smallint) 
                                                            
BEGIN

	declare v_club_id smallint ; 
    
    select id into v_club_id from Club where name = v_club_name ;
    
	select c.name, s.name, f_level_korean(cm.level) 
    from Clubmember cm inner join Student s on cm.student = s.id 
                                        inner join Club c on cm.club = c.id
    where cm.club = v_club_id  ;
    
END $$
DELIMITER ;

call sp_club_member ( '요트부' ) ;

select * from Clubmember;
