create table Test (
	ts   timestamp,
	tsz  timestamp with time zone,
	ts0  timestamp(0)
);

insert into Test(ts, tsz, ts0)
 values(SYSDATE, SYSDATE, SYSDATE);


select sysdate, CURRENT_TIMESTAMP from dual;

select to_char(sysdate, 'YYYY-mm-dd hh:mi:ss') from dual;

select to_char(CURRENT_TIMESTAMP, 'YYYY-mm-dd hh:mi:ss') from dual;

select to_char(CURRENT_TIMESTAMP, 'WW W DDD RM DY AM TZD') from dual;

-- Julian Day (율리우스 적일, BC4713년 1월 1일부터의 일수)
select to_char(tsz, 'J'), to_char(tsz, 'YY-MM-DD HH24:MI:SS') from Test;

select * from Test;

select ts, tsz, ts0, lengthb(ts), lengthb(tsz),
       lengthb(ts0) from Test;
       
       
select lpad('abc', 5, '0') from dual;

select replace('abc', 'bc' ,'x') from dual;

select power(2, 3), sqrt(2) from dual;

select manager_id, NVL(manager_id, 0) from employees;

select uid from dual;

select decode(2, 1, 'one', 2, 'two', 10, 'ten', 'none')
from dual;
 
select case 2 when 1 then 'one'
              when 2 then 'two'
              when 10 then 'ten'
             else 'none' end from dual;
             

select to_date('2018-12-12', 'yyyy-mm-dd') from dual;


select salary, count(*) cnt from employees group by salary order by 2 desc;

select stats_mode(salary) from Employees;

select employee_id, first_name, salary,
	  rank() over(order by salary desc) Ranking
  from Employees;
  
select employee_id, first_name, salary,
	  dense_rank() over(order by salary desc)
  from Employees;
  
select employee_id, first_name, department_id, salary, 
      rank() over(partition by department_id order by salary desc)Ranking
  from Employees;
