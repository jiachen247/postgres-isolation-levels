-- SET SESSION CHARACTERISTICS AS TRANSACTION ISOLATION LEVEL serializable;
-- SET SESSION CHARACTERISTICS AS TRANSACTION ISOLATION LEVEL repeatable read;
SET SESSION CHARACTERISTICS AS TRANSACTION ISOLATION LEVEL read committed;
-- SHOW default_transaction_isolation;


-- ALTER DATABASE isolation_exp SET DEFAULT_TRANSACTION_ISOLATION TO 'serializable';
-- ALTER DATABASE isolation_exp SET DEFAULT_TRANSACTION_ISOLATION TO 'repeatable read';
ALTER DATABASE isolation_exp SET DEFAULT_TRANSACTION_ISOLATION TO 'read committed';