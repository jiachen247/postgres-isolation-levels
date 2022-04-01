CREATE OR REPLACE PROCEDURE exp1()
LANGUAGE 'plpgsql'    
AS $$
BEGIN
CALL updateTransaction();
CALL sumTransaction(10);
END;$$;

CREATE OR REPLACE PROCEDURE exp2()
LANGUAGE 'plpgsql'    
AS $$
BEGIN
CALL sumTransaction(10);
CALL updateTransaction();
END;$$;

CREATE OR REPLACE PROCEDURE exp3()
LANGUAGE 'plpgsql'    
AS $$
BEGIN
CALL updateTransaction();
CALL sumTransaction(100);
END;$$;

CREATE OR REPLACE PROCEDURE exp4()
LANGUAGE 'plpgsql'    
AS $$
BEGIN
CALL sumTransaction(100);
CALL updateTransaction();
END;$$;
