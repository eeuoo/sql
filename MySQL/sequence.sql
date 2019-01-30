SELECT * 
  FROM USER_SEQUENCES 
 WHERE SEQUENCE_NAME = UPPER('employees_seq');
 
create sequence test_seq
 start with 1
 increment BY 1
 maxvalue 10000;
 
select test_seq.currval from dual; 

create table T (id number, name varchar2(30));

insert into T(id, name) values(test_seq.nextval, '김이수');

select * from T;



