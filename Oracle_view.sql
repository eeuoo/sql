CREATE OR REPLACE VIEW v_emp_dept AS
	SELECT e.first_name as first_name, e.salary as salary, 
    NVL(e.commission_pct,0) as commission_pct, 
    d.department_name as department_name
    from employees e inner join departments d on e.department_id = d.department_id
	WITH READ ONLY;
    
    
CREATE OR REPLACE VIEW v_emp_dept_job AS 
select d.department_name, j.job_title, e.first_name, e.hire_date
from employees e inner join departments d on e.department_id = d.department_id
                 inner join jobs j on e.job_id = j.job_id;
            
