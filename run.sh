#!/bin/bash
echo "\n\n=========================================\n\n"
psql -f 0-init_db.sql
psql -d isolation_exp -f 1-init_tables.sql
psql -d isolation_exp -f 2-init_procs.sql
psql -d isolation_exp -f 3-seed-stocks25k.sql > /dev/null
psql -d isolation_exp -f 4-update-sqty.sql

# run processes and store pids in array
for i in {1..50} 
do
  psql -d isolation_exp -c "call swapTransaction(1000, 'repeatable read');" &
  spids[${i}]=$!;
  psql -d isolation_exp -c "call sumTransaction(100);" &
  pids[${i}]=$!;
done

# wait for all pids
for pid in ${pids[*]}; do
  wait $pid
done

for pid in ${spids[*]}; do
  wait $pid
done

echo "Gather Results for 25k-rr-100-50.output"
echo "SELECT AVG(execution_time), STDDEV(execution_time) FROM execution;" | psql -d isolation_exp
echo "SELECT STDDEV(addition) FROM sumtable;" | psql -d isolation_exp
echo "SELECT xact_commit,xact_rollback,conflicts,deadlocks FROM pg_catalog.pg_stat_database where datname='isolation_exp';" | psql -d isolation_exp