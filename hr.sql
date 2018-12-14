select * from employees;

-- 1) 부서별 직원수
select max(d.department_name), count(e.employee_id) emp_ent
from employees e inner join departments d on e.department_id = d.department_id
group by e.department_id
order by 2 desc;

-- 2) 부서별 평균 급여
select max(d.department_name)dpt_id, round(avg(e.salary), -1) salary_avg
from employees e inner join departments d on e.department_id = d.department_id
group by e.department_id
order by 2 desc;

-- 3) 직책별 평균 급여
select max(j.job_title)job_id, round(avg(e.salary), -1) salary_avg
from employees e inner join jobs j on e.job_id = j.job_id
group by e.job_id
order by 2 desc;


-- 4) 자신의 매니저 보다 더 많은 급여를 받는 사람 목록
select  e.first_name, e.last_name, e.salary, ee.salary
from employees e inner join employees ee on e.manager_id = ee.employee_id
where e.salary > ee.salary;


select sub.* 
from ( select e.employee_id, e.salary, e.manager_id,
                (select salary from employees where employee_id = e.manager_id) mgr_sal
        from employees e) sub
where sub.salary > sub.mgr_sal ;

SELECT E.FIRST_NAME || ' ' ||  E.LAST_NAME emp_name, E.SALARY
FROM EMPLOYEES E
WHERE SALARY > (SELECT EE.SALARY FROM EMPLOYEES EE WHERE E.MANAGER_ID = EE.EMPLOYEE_ID);


-- 5) Job title이 Sales Representative인 직원 중에서, 급여가 9,000 ~ 10,000 인 직원들의 이름과 급여를 출력하시오.
select concat(concat(first_name, ' '), last_name) as emp_name, salary
from employees e inner join jobs j on e.job_id = j.job_id
where job_title = 'Sales Representative' and e.salary between 9000 and 10000;


/* 6) 각 직급별로 급여의 총합을 구하고자 한다. 급여 총합이 가장 높은 직급순으로 급여 총합을 출력하시오.
     (단, 급여총합이 30,000 이상인 직급만 출력할 것)*/
select * from (select job_id, sum(salary) as ss from employees 
 group by job_id
 order by sum(salary)desc)j 
 where j.ss > 30000 ;
 
 
-- 7) 각 도시별 평균 연봉(급여)가 높은순으로 상위 3개 도시만 출력하시오.
select *
from (select city, round(avg(salary)) as avg_salary
        from employees e inner join (departments d  inner join locations l 
            on d.location_id = l.location_id)
    on e.department_id = d.department_id 
group by city order by 2 desc)ss
where rownum < 4;
 
 
/* 8) 직책(Job Title)이 Sales Manager인 사원들의 입사년도와 입사년도(hire_date)별 평균 급여를 출력하시오. 
출력 시 년도를 기준으로 오름차순 정렬하시오. */

select hy.hire_year, avg(hy.salary)
from (select employee_id, to_char(hire_date, 'yyyy') as hire_year, salary
        from employees e inner join jobs j on e.job_id = j.job_id
        where job_title = 'Sales Manager')hy
group by hy.hire_year 
order by 1;


/* 9) 각 도시(city)의 도시명(city)과 평균연봉, 해당 도시의 직원수를 평균연봉이 낮은 차순으로 정렬하시오.
	단, 도시에 근무하는 직원이 10명 이상인 곳은 제외하고 조회하시오. */
select * 
from(select city, round(avg(salary), -1) sal_avg, count(employee_id) as cnt_emp
        from employees e inner join (departments d  inner join locations l 
                                 on d.location_id = l.location_id)
                on e.department_id = d.department_id
        group by city ) c
where c.cnt_emp < 10
order by c.sal_avg;


/* 10) ‘Public  Accountant’의 직책(job_title)으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 출력하시오. 
	(현재 ‘Public Accountant’의 직책(job_title)으로 근무하는 사원은 고려 하지 않는다.) */
select e.employee_id, e.first_name || ' ' || e.last_name
from job_history jh inner join employees e on jh.employee_id = e.employee_id
                    inner join jobs j on jh.job_id = j.job_id
where job_title = 'Public Accountant'
and e.job_id <> j.job_id;


/* 11) 2007년에 입사(hire_date)한 직원들의 사번(employee_id), 이름(first_name), 성(last_name), 
	부서명(department_name)을 조회합니다. 이때, 부서에 배치되지 않은 직원의 경우, ‘<Not Assigned>’로 출력하시오. */

select e.employee_id, first_name, NVL(d.department_name, '<Not Assigned>')
from Employees e full join departments d on e.department_id = d.department_id
where to_char(hire_date, 'yyyy') = '2007' ;

select * from employees where department_id is null;


/* 12) 부서별로 가장 적은 급여를 받고 있는 직원의 이름, 부서이름, 급여를 출력하시오. 
	이름은 last_name만 출력하며, 부서이름으로 오름차순 정렬하고, 
	부서가 같은 경우 이름을 기준 으로 오름차순 정렬하여 출력합니다. */

select emp.last_name, t.*
from employees emp, (select eee.department_name as dpt_name, min(salary) as min_salary
            from(select employee_id, last_name, salary, department_name, e.department_id as dpt
                    from employees e inner join departments d on e.department_id = d.department_id) eee
            group by eee.department_name ) t
where emp.salary = t.min_salary and emp.deparment_id = t.dpt
order by t.dpt_name, emp.last_name ;

SELECT EE.LAST_NAME, T.*
 FROM EMPLOYEES EE,(SELECT D.DEPARTMENT_NAME, MIN(E.SALARY) AS MIN_SALARY
 FROM DEPARTMENTS D, EMPLOYEES E
WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_NAME) T
WHERE EE.SALARY = T.MIN_SALARY
ORDER BY T.DEPARTMENT_NAME, EE.LAST_NAME;

select department_name, ee.employee_id, ee.last_name, ee.salary, min_sal
from ( select e.department_id, min(e.salary) min_sal
        from employees e
        group by e.department_id) sub 
           inner join employees ee
              on sub.department_id = ee.department_id 
              and ee.salary = sub.min_sal
           inner join departments d 
              on d.department_id = ee.department_id
order by 1;


/* 13) EMPLOYEES 테이블에서 급여를 많이 받는 순서대로 조회했을 때
   6번째부터 10 번째까지 5명의 last_name, first_name, salary를 조회하시오. */
select r.employee_id, r.first_name, r.salary 
from (select employee_id, first_name, salary, 
         rank() over( order by salary desc) ranking
         from Employees) r
where r.ranking between 6 and 10;

select subsub.* from
(select rownum rn, sub.*
    from(select e.last_name, e.first_name, e.salary
            from employees e
            order by e.salary desc) sub) subsub
where rn between 6 and 10;

/* 14) ‘Sales’ 부서에 속한 직원의 이름(first_name), 급여(salary), 부서이름(department_name)을 조회하시오. 
	단, 급여는 100번 부서의 평균보다 적게 받는 직원 정보만 출력되어야 한다. */
select e.first_name, e.salary, d.department_name 
from employees e inner join departments d on e.department_id = d.department_id
where d.department_name = 'Sales'
and e.salary < (select round(avg(salary), -1) from employees where department_id = 100);


/* 15) 부서별 입사월별 직원수를 출력하시오. 
	단, 직원수가 5명 이상인 부서만 출력되어야 하며 출력결과는 부서이름 순으로 한다 */
select ee.* from
(select department_name as dpt, to_char(e.hire_date, 'mon') as month, count(*) as cnt
from employees e inner join departments d on e.department_id = d.department_id
group by department_name, to_char(e.hire_date, 'mon') 
order by 1) ee,
(select d.department_name as dpt, count(e.employee_id)
from employees e inner join departments d on e.department_id = d.department_id
group by d.department_name
having count(e.employee_id) >= 5 ) dd
where dd.dpt = ee.dpt;

select max(d.department_name) department_name, to_char(e.hire_date, 'MM') mm, count(*) emp_cnt
  from Employees e inner join Departments d on e.department_id = d.department_id
 where d.department_id in (select department_id from Employees group by department_id having count(*) >= 5)
 group by e.department_id, to_char(e.hire_date, 'MM')
 order by department_name;


select department_name as dpt, to_char(e.hire_date, 'mon') as month, count(*) as cnt
from employees e inner join departments d on e.department_id = d.department_id
group by department_name, to_char(e.hire_date, 'mon') having count(*) >= 5
order by 1;


/* 16) 커미션(commission_pct)을 가장 많이 받은 상위 4명의 부서명(department_name), 
       직원명 (first_name), 급여(salary), 커미션(commission_pct) 정보를 조회하시오. 
	   출력결과는 커미션을 많이 받는 순서로 출력하되 동일한 커미션에 대해서는 급여가 높은 직원이 먼저 출력 되게 한다. */
select * from
(select department_name, first_name, salary, commission_pct 
from employees e full join departments d on e.department_id = d.department_id
where commission_pct is not null
order by commission_pct desc, salary desc )
where rownum <= 4 ;

