-- $ psql -d isolation_exp -f INit_procs.sql
-- transfer 20 from src to dest
CREATE OR REPLACE PROCEDURE transferQty(src INT, dest INT)
LANGUAGE plpgsql    
AS $$
BEGIN
	FOR i IN 1..100
  LOOP
		UPDATE stocks SET s_qty=s_qty - 1 WHERE s_id = src;
		UPDATE stocks SET s_qty=s_qty + 1 WHERE s_id = dest;
	END LOOP;
	COMMIT;
END;$$;

CREATE OR REPLACE FUNCTION testsum (INT) RETURNS REAL AS
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
		-- IF  r::TEXT LIKE '%Planning%'
		-- THEN 
		-- p := REGEXP_REPLACE( r::TEXT, '.*Planning (?:T|t)ime: (.*) ms.*', '\1');
		-- END IF;
		IF r::TEXT LIKE '%Execution%'
		THEN
		e := REGEXP_REPLACE( r::TEXT, '.*Execution (?:T|t)ime: (.*) ms.*', '\1');
		END IF;
	END LOOP;
	ap := ap + (p::NUMERIC - ap) / 1;
	ae := ae + (e::NUMERIC - ae) / 1;
-- RETURN ROUND(ap, 2) || ' : ' || ROUND(ae, 2) ;
-- Return only execution time
	RETURN ae;
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
