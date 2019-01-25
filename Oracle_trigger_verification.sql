desc employees;
       
select * from departments; --기존 인원 34

insert into employees(employee_id, last_name, email, hire_date, job_id, department_id)
       values(employees_seq.nextval, 'heee', 'hh@gg.com', current_timestamp, 'AD_VP', 80);

select * from departments; -- 증가 인원 +1, 총 인원 35

delete from employees where employee_id = 207 ;

select * from departments; -- 감소 인원 -1, 총 인원 34