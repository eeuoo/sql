
-- 부서ID를 입력하면 부서명을 반환하는 스토어드 함수를 작성하시오.        

select * from departments;

desc departments;

CREATE OR REPLACE FUNCTION dpt_id_to_name(dpt_id IN number) 
RETURN varchar2

IS
    v_ret varchar2(30) := '' ;
      
BEGIN
	
    select department_name into v_ret from Departments where department_id = dpt_id;

    return v_ret;

END;


select dpt_id_to_name(20) from dual;
