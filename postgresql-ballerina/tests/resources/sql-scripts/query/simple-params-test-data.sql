CREATE DATABASE IF NOT EXISTS QUERY_SIMPLE_PARAMS_DB;

USE QUERY_SIMPLE_PARAMS_DB;

DROP TABLE IF EXISTS DataTable;

CREATE TABLE IF NOT EXISTS DataTable(
  row_id       INTEGER,
  int_type     INTEGER,
  long_type    BIGINT,
  numeric_type   NUMERIC,
  double_type  DOUBLE PRECISION,
  boolean_type BOOLEAN,
  string_type  VARCHAR(50),
  decimal_type DECIMAL,
  PRIMARY KEY (row_id)
);

INSERT INTO DataTable (row_id, int_type, long_type, numeric_type, double_type, boolean_type, string_type, decimal_type)
  VALUES(1, 1, 9223372036854774807, 123.45, 2139095039, TRUE, 'Hello', 23.45);

INSERT INTO DataTable (row_id) VALUES (2);

INSERT INTO DataTable (row_id, int_type, long_type, numeric_type, double_type, boolean_type, string_type, decimal_type)
  VALUES(3, 1, 9372036854774807, 124.34, 29095039, false, '1', 25.45);

DROP TABLE IF EXISTS ComplexTypes;

CREATE TABLE IF NOT EXISTS ComplexTypes(
  row_id         INTEGER NOT NULL,
  bytea_type     BYTEA,
  text_type       TEXT
  PRIMARY KEY (row_id)
);

INSERT INTO ComplexTypes (row_id, bytea_type, text_type) VALUES
  (1, '77736F322062616C6C6572696E6120626C6F6220746573742E', 'very long text');

INSERT INTO ComplexTypes (row_id, bytea_type, text_type) VALUES
  (2, null, null);

DROP TABLE IF EXISTS NumericTypes;

CREATE TABLE NumericTypes (
   id INT AUTO_INCREMENT,
   int_type INT NOT NULL,
   bigint_type BIGINT NOT NULL,
   smallint_type SMALLINT NOT NULL ,
   decimal_type DECIMAL NOT NULL ,
   numeric_type NUMERIC NOT NULL ,
   double_type DOUBLE PRECISION NOT NULL ,
   real_type REAL NOT NULL ,
   PRIMARY KEY (id)
);

INSERT INTO NumericTypes (id, int_type, bigint_type, smallint_type, decimal_type, numeric_type,
    double_type, real_type) VALUES (1, 2147483647, 9223372036854774807, 32767, 8388607, 1234.567, 1234.567, 1234.567,
    1234.567);

INSERT INTO NumericTypes (id, int_type, bigint_type, smallint_type, decimal_type, numeric_type,
    double_type, real_type) VALUES (2, 2147483647, 9223372036854774807, 32767, 1234, 1234, 1234,
    1234);

DROP TABLE IF EXISTS DateTimeTypes;

CREATE TABLE IF NOT EXISTS DateTimeTypes(
  row_id         INTEGER NOT NULL,
  date_type      DATE,
  time_type      TIME,
  timetz_type      TIMETZ,
  timestamp_type TIMESTAMPTZ,
  timestamptz_type  DATETIME,
  PRIMARY KEY (row_id)
);

INSERT INTO DateTimeTypes (row_id, date_type, time_type, datetime_type, timestamp_type) VALUES
  (1,'2017-02-03', '11:35:45', '11:35:45+3','2017-02-03 11:53:00', '2017-02-03 11:53:00+2');





-- DROP TABLE IF EXISTS ENUMTable;

-- CREATE TABLE ENUMTable (
--     id integer NOT NULL,
--     enum_type ENUM('admin','doctor','housekeeper') DEFAULT NULL,
--     PRIMARY KEY (id)
-- );
-- INSERT INTO ENUMTable(id, enum_type) VALUES (1, 'doctor');

-- DROP TABLE IF EXISTS SetTable;

-- CREATE TABLE SetTable (
--     row_id INTEGER NOT NULL,
--     set_type SET('a', 'b', 'c', 'd')
-- );

-- INSERT INTO SetTable (row_id, set_type) VALUES (1, 'a,d'), (2, 'd,a'), (3, 'a,d,a');

-- DROP TABLE IF EXISTS GEOTable;

-- CREATE TABLE GEOTable(
--     id INTEGER NOT NULL ,
--     geom GEOMETRY
-- );

-- INSERT INTO GEOTable (id, geom) values (1, ST_GeomFromText('POINT(7 52)'));

-- DROP TABLE IF EXISTS JsonTable;

-- CREATE TABLE JsonTable(
--     id INTEGER NOT NULL ,
--     json_type JSON
-- );

-- INSERT INTO JsonTable (id, json_type) values (1, JSON_OBJECT('id', 100, 'name', 'Joe', 'groups', '[2,5]'));