# postgres-isolation-levels

CS5432 Experiment between different isolation levels in Postgres

## Expirement

### Setup

- Machine: M1 Pro Macbook 16GB

```
$ psql -f 0-init_db.sql
$ psql -d isolation_exp -f 1-init_tables.sql
$ psql -d isolation_exp -f 2-init_procs.sql
$ psql -d isolation_exp -f 4-update-sqty.sql
```

Seed:

```
$ psql -d isolation_exp -f 3-seed-stocks10000.sql
```

### Config

axis to vary:

- r: # of rows (5k and 20k)
- level: isolation level (serialisable / repeatable read and read committed)
- n: number of rows to sum over (100, 1000)
- c: # of concurrent processos (5, 50)

what to log:

- execution time
- inconsistencies (sumtable != 10000000)
- pg stat (xact_commit,xact_rollback,conflicts,deadlocks)

### Results

Results and output can be found in `results/`

For example: `5k-s-100-5.output`
