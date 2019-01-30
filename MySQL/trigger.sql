/* 부서테이블에 직원수 컬럼을 추가하고, 초기값(현재 부서의 직원수)을 셋팅한 후,
   직원의 입사 및 퇴사시 직원수 컬럼을 조정하는 트리거를 작성하시오. */


alter table departments add emp_cnt number default 0 not null ; 

select * from departments ;

update departments d set emp_cnt =
(select count(*) from employees where department_id = d.department_id);


select * from employees;


insert ;

desc employees;



CREATE OR REPLACE TRIGGER update_emp_dept
    after insert 
    ON employees FOR EACH ROW
	--when (new.department_id is not null)
    
begin
	update departments dpt set emp_cnt = emp_cnt + 1 
    where :new.department_id = dpt.department_id ;
end;


CREATE OR REPLACE TRIGGER delete_emp_dept
    after delete 
    ON employees FOR EACH ROW
    --when (old.department_id is not null)
	
begin
	update departments dpt set emp_cnt = emp_cnt - 1 
    where :old.department_id = dpt.department_id ;
end;




