-- $ psql -d isolation_exp -f 1-init_tables.sql
DROP TABLE IF EXISTS stocks;
DROP TABLE IF EXISTS sumtable ;
DROP TABLE IF EXISTS execution ;

CREATE TABLE stocks (
	s_id SERIAL PRIMARY KEY,
  w_id INTEGER,
  i_id INTEGER,
  s_qty INTEGER CHECK(s_qty > 0)
);

CREATE TABLE sumtable(
	addition INTEGER
);

CREATE TABLE execution(
	execution VARCHAR(50)
);
