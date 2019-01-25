-- 과목별 담당 교수명
select s.* , p.name as 'prof name'
	from Subject s inner join Prof p on s.prof = p.id ;
    
-- 과목별 학생 수
select e.subject, max(s.name) as '과목', count(*) as '학생수'
	from Enroll e inner join Subject s on e.subject = s.id
    group by subject ;
    
-- 과목별 학생 목록
select e.student, s.name, s.birth, sub.name
	from Enroll e inner join Student s on e.student = s.id
						 inner join Subject sub on e.subject = sub.id
    where sub.name = '건축학 개론 ' ;
    
-- 특정 과목을 듣는 서울 거주 학생 목록
select sub.name, stu.id, stu.name, stu.addr
	from Enroll e inner join Subject sub on e.subject = sub.id
						 inner join Student stu on e.student = stu.id
	where sub.name = '소비자 심리' and stu.addr = '서울' ;
    
-- 특정 과목을 수강 중인 지역별 학생 수
select sub.name, stu.addr, count(*)
	from Enroll e inner join Subject sub on e.subject = sub.id
						 inner join Student stu on e.student = stu.id
		 group by sub.id, stu.addr ;
    
select * from Club c right outer join Student s on c.leader = s.id ; 

-- 서울 거주 학생들의 과목별 성별 통계
select max(sub.name) as '과목명', (case stu.gender when 0 then '여' else '남' end) as '성별', count(*) as '인원'
	from Enroll e inner join Subject sub on e.subject = sub.id
						inner join Student stu on e.student = stu.id
		where stu.addr = '서울' 
        group by sub.id, stu.gender
        order by 1, 2;  -- order by sub.name, stu.gender desc

-- group by sub.id 시 중복되는 과목 합쳐서 계산하는 법
select sub_name, gender, sum(student_count) from (
	select min(sub.name) as sub_name , (case stu.gender when 0 then '여' else '남' end) as gender, count(*) as student_count
		from Enroll e inner join Subject sub on e.subject = sub.id
						inner join Student stu on e.student = stu.id
			where stu.addr = '서울' 
			group by sub.id, stu.gender  
            order by sub.name) ss
            group by sub_name, gender;
            
            
            