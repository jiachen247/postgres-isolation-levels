-- n is the max number of rows to which swap must occur
create or replace procedure updatestocks(n int)
language 'plpgsql'    
as $$
begin
for i in 1..n
loop
update stocks set s_qty=i where s_id=i;
end loop;
end;$$;

-- n is the max number of rows to which swap must occur
create or replace procedure swap(n integer)
language 'plpgsql'    
as $$
DECLARE
num1 integer;
num2 integer;
val1 integer;
val2 integer;
t timestamptz;
etime integer;
begin
t:=clock_timestamp();
for i in 1..100
loop
num1:= floor(random()* (n) + 1);
num2:= floor(random()* (n) + 1);
select s_qty into val1 from stocks where s_id=num1;
select s_qty into val2 from stocks where s_id=num2;
update stocks set s_qty=val2 where s_id=num1;
update stocks set s_qty=val1 where s_id=num2;
	commit;
end loop;
end;$$;

create or replace procedure swapTransaction(n integer, i text)
language 'plpgsql'    
as $$
declare
query TEXT := 'SET SESSION CHARACTERISTICS AS TRANSACTION ISOLATION LEVEL ' ||i;
t timestamptz;
etime integer;
begin
execute query;
for i in 1..100
loop
t:=clock_timestamp();
call swap(i);
etime:= extract (milliseconds FROM (clock_timestamp() - t));
insert into execution values(etime);
end loop;
end;$$;

-- n  is the number of rows
create or replace procedure sumTransaction(n integer)
language 'plpgsql'    
as $$
begin
for i in 1..100
loop
insert into sumtable select sum(s_qty) from stocks where s_id<=n;
end loop;
end;$$;

