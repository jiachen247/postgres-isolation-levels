#!/bin/bash

psql -f 0-init_db.sql
psql -d isolation_exp -f 1-init_tables.sql
psql -d isolation_exp -f 2-init_procs.sql
psql -d isolation_exp -f 3-seed-stocks25k.sql > /dev/null
psql -d isolation_exp -f 4-update-sqty.sql
psql -d isolation_exp -f 5-set-isolation-level.sql
psql -d isolation_exp -f 6-exp.sql

echo "call exp1();" | time psql -d isolation_exp
echo "SELECT AVG(execution) FROM execution;" | psql -d isolation_exp
echo "SELECT AVG(addition) FROM sumtable;" | psql -d isolation_exp


psql -f 0-init_db.sql
psql -d isolation_exp -f 1-init_tables.sql
psql -d isolation_exp -f 2-init_procs.sql
psql -d isolation_exp -f 3-seed-stocks25k.sql > /dev/null
psql -d isolation_exp -f 4-update-sqty.sql
psql -d isolation_exp -f 5-set-isolation-level.sql
psql -d isolation_exp -f 6-exp.sql

echo "call exp2();" | time psql -d isolation_exp
echo "SELECT AVG(execution) FROM execution;" | psql -d isolation_exp
echo "SELECT AVG(addition) FROM sumtable;" | psql -d isolation_exp

psql -f 0-init_db.sql
psql -d isolation_exp -f 1-init_tables.sql
psql -d isolation_exp -f 2-init_procs.sql
psql -d isolation_exp -f 3-seed-stocks25k.sql > /dev/null
psql -d isolation_exp -f 4-update-sqty.sql
psql -d isolation_exp -f 5-set-isolation-level.sql
psql -d isolation_exp -f 6-exp.sql

echo "call exp3();" | time psql -d isolation_exp
echo "SELECT AVG(execution) FROM execution;" | psql -d isolation_exp
echo "SELECT AVG(addition) FROM sumtable;" | psql -d isolation_exp

psql -f 0-init_db.sql
psql -d isolation_exp -f 1-init_tables.sql
psql -d isolation_exp -f 2-init_procs.sql
psql -d isolation_exp -f 3-seed-stocks25k.sql > /dev/null
psql -d isolation_exp -f 4-update-sqty.sql
psql -d isolation_exp -f 5-set-isolation-level.sql
psql -d isolation_exp -f 6-exp.sql

echo "call exp4();" | time psql -d isolation_exp
echo "SELECT AVG(execution) FROM execution;" | psql -d isolation_exp
echo "SELECT AVG(addition) FROM sumtable;" | psql -d isolation_exp

