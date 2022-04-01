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

Inputs:

- \# of rows (5k and 25k)
- isolation level
  - serialisable
  - repeatable read
  - read committed)
- n: number of rows to sum over (10, 100)

Ouputs:

- average over execution table
- average over sum table
- wall clock time for each exp

## Expriment 1:

- rows: 5k
- isolation: serialisable

## N=10, update --> sum

- wall clock: 24.59 real
- execution: 0.01895999938249588
- sumtable: 100000

## N=10, sum --> update

- wall clock: 23.61 real
- execution: 0.011449999995529652
- sumtable: 100000

## N=100, update --> sum

- wall clock: 23.80 real
- execution: 0.07684999868273736
- sumtable: 100000

## N=100, sum --> update

- wall clock: 23.45 real
- execution: 0.03404000084847212
- sumtable: 100000

## Expriment 2:

- rows: 5k
- isolation: repeatable read

## N=10, update --> sum

- wall clock: 19.58 real
- execution: 0.01329000025987625
- sumtable: 100000

## N=10, sum --> update

- wall clock: 22.37 real
- execution: 0.011920000007376075
- sumtable: 100000

## N=100, update --> sum

- wall clock: 23.34 real
- execution: 0.07342999927699566
- sumtable: 100000

## N=100, sum --> update

- wall clock: 23.39 real
- execution: 0.03412000004202127
- sumtable: 100000

## Expriment 3:

- rows: 5k
- isolation: read commited

## N=10, update --> sum

- wall clock: 29.27 real
- execution: 0.01456000017002225
- sumtable: 100000

## N=10, sum --> update

- wall clock: 22.99 real
- execution: 0.011319999964907766
- sumtable: 100000

## N=100, update --> sum

- wall clock: 22.85 real
- execution: 0.06609999924898148
- sumtable: 100000

## N=100, sum --> update

- wall clock: 23.65 real
- execution: 0.035440000593662264
- sumtable: 100000
