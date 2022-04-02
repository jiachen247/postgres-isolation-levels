#!/bin/bash

psql -f 0-init_db.sql
psql -d isolation_exp -f 1-init_tables.sql
psql -d isolation_exp -f 2-init_procs.sql
psql -d isolation_exp -f 3-seed-stocks5k.sql > /dev/null
psql -d isolation_exp -f 4-update-sqty.sql
psql -d isolation_exp -f 5-set-isolation-level.sql
psql -d isolation_exp -f 6-exp.sql

# run processes and store pids in array
for i in {1..50} 
do
  src=$((1 + $RANDOM % 100))
  dest=$((1 + $RANDOM % 100))
  psql -d isolation_exp -c "call transferQty(${src}, ${dest});" &
  pids[${i}]=$!;
  psql -d isolation_exp -c "call sumTransaction(100);" &
  spids[${i}]=$!;
done

# wait for all pids
for pid in ${pids[*]}; do
  wait $pid
done

for pid in ${spids[*]}; do
  wait $pid
done

echo "Gather Results"

echo "SELECT AVG(execution) FROM execution;" | psql -d isolation_exp
echo "SELECT AVG(addition) FROM sumtable;" | psql -d isolation_exp
# echo "SELECT * from pg_tables;" | psql -d isolation_exp
# psql -d isolation_exp    
# select * FROM stocks WHERE s_qty <> 10000;