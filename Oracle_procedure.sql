create or replace procedure sp_dept_emp_list(p_dept_id number)

is

begin

   for rec in ( select (first_name || ' ' || last_name) emp_name 
	  from Employees where department_id = p_dept_id )
      
loop
      dbms_output.put_line( 'Employee Name: ' || rec.emp_name );
      end loop;
end;


SET SERVEROUTPUT ON ; 
EXEC sp_dept_emp_list(80);


