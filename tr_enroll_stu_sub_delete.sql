
-- 내가 작성한 trigger
DELIMITER //

Create Trigger tr_enroll_stu_sub_delete
before delete on Enroll for each row

BEGIN

delete from Grade where enroll =  (select id from Enroll where student = OLD.student and subject = OLD.subject) ;

update Student set subjects =  subjects - 1 
    where id =  OLD.student ;


END //

DELIMITER ;



-- 같이 해 본 trigger
DELIMITER //

Create Trigger tr_enroll_stu_sub_delete
before delete on Enroll for each row

BEGIN

delete from Grade where enroll =  OLD.id ;

update Student set subjects =  subjects - 1 
    where id =  (select student from Enroll where id = OLD.id) ;


END //

DELIMITER ;