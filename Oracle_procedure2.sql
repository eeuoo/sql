create procedure sp_emp_list2(p_dept_id number, p_cur OUT SYS_REFCURSOR)
is
begin
    OPEN p_cur for
        select * from Employees where department_id = p_dept_id;
end;
/


var cur REFCURSOR
exec sp_emp_list2(50, :cur);
print cur;
