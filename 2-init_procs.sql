-- $ psql -d isolation_exp -f INit_procs.sql
-- 1000 is configurable (number of iterations)
--- sqty INit to 10000
CREATE OR REPLACE PROCEDURE updateTransaction()
LANGUAGE plpgsql    
AS $$
BEGIN
FOR i IN 1..1000
  LOOP
    UPDATE stocks SET s_qty=s_qty-2 WHERE mod(s_id,2)=0;
    UPDATE stocks SET s_qty=s_qty+2 WHERE mod(s_id,2)=1;
    COMMIT;
  END LOOP;
END;$$;

CREATE OR REPLACE FUNCTION testsum (INT) RETURNS TEXT AS
$$
DECLARE
r RECORD;
p TEXT;
e TEXT;
query TEXT := 'SELECT SUM(s_qty) FROM stocks WHERE s_id<='||$1;
ap NUMERIC := 0;
ae NUMERIC := 0;
BEGIN
	FOR r IN EXECUTE 'EXPLAIN ANALYZE ' || query
	LOOP
		IF  r::TEXT LIKE '%PlannINg%'
		THEN 
		p := REGEXP_REPLACE( r::TEXT, '.*PlannINg (?:T|t)ime: (.*) ms.*', '\1');
		END IF;
		IF r::TEXT LIKE '%Execution%'
		THEN 
		e := REGEXP_REPLACE( r::TEXT, '.*Execution (?:T|t)ime: (.*) ms.*', '\1');
		END IF;
	END LOOP;
	ap := ap + (p::NUMERIC - ap) / 1;
	ae := ae + (e::NUMERIC - ae) / 1;
RETURN ROUND(ap, 2) || ' : ' || ROUND(ae, 2) ;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE sumTransaction(n INTEGER)
LANGUAGE 'plpgsql'    
AS $$
BEGIN
FOR i IN 1..100
LOOP
INSERT INTO sumtable SELECT SUM(s_qty) FROM stocks WHERE s_id<=n;
INSERT INTO execution SELECT testsum(n);
END LOOP;
END;$$;

-- n is the param
CREATE OR REPLACE PROCEDURE exp1()
LANGUAGE 'plpgsql'    
AS $$
BEGIN
CALL updateTransaction();
CALL sumTransaction(10);
END;$$;

CREATE or REPLACE PROCEDURE exp2()
LANGUAGE 'plpgsql'    
AS $$
BEGIN
CALL sumTransaction(10);
CALL updateTransaction();
END;$$;
