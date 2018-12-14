
-- 과목명을 주면, 해당 과목의 수강 학생수를 반환하는 함수를 만드시오.

DELIMITER $$

CREATE Function sub_cnt (subject_n varchar(31)) 

 RETURNS smallint
 
BEGIN

	RETURN (select count(*) from Enroll where subject = (select id from Subject where name = subject_n) ) ;
    
END $$
DELIMITER ;

    