CREATE DATABASE IF NOT EXISTS EXECUTE_PARAMS_DB;

USE EXECUTE_PARAMS_DB;

DROP TABLE IF EXISTS DataTable;

CREATE TABLE IF NOT EXISTS DataTable(
  row_id       INTEGER,
  int_type     INTEGER,
  long_type    BIGINT,
  float_type   FLOAT,
  double_type  DOUBLE PRECISION,
  boolean_type BOOLEAN,
  string_type  VARCHAR(50),
  decimal_type DECIMAL(20, 2),
  PRIMARY KEY (row_id)
);

INSERT INTO DataTable (row_id, int_type, long_type, float_type, double_type, boolean_type, string_type, decimal_type)
  VALUES(1, 1, 9223372036854774807, 123.34, 2139095039, TRUE, 'Hello', 23.45);

INSERT INTO DataTable (row_id) VALUES (2);

INSERT INTO DataTable (row_id, int_type, long_type, float_type, double_type, boolean_type, string_type, decimal_type)
  VALUES(3, 1, 9372036854774807, 124.34, 29095039, false, '1', 25.45);

DROP TABLE IF EXISTS ComplexTypes;

CREATE TABLE IF NOT EXISTS ComplexTypes(
  row_id         INTEGER NOT NULL,
  bytea_type     BYTEA,
  text_type       TEXT,
  PRIMARY KEY (row_id)
);

INSERT INTO ComplexTypes (row_id, bytea_type, text_type) VALUES
  (1, '77736F322062616C6C6572696E6120626C6F6220746573742E', 'very long text');

INSERT INTO ComplexTypes (row_id, bytea_type, text_type) VALUES
  (2, '77736F322062616C6C6572696E6120626C6F6220746573742E', 'very long text');

INSERT INTO ComplexTypes (row_id, bytea_type, text_type) VALUES
  (3, null, null);

DROP TABLE IF EXISTS NumericTypes;

CREATE TABLE NumericTypes (
   id SERIAL,
   int_type INT ,
   bigint_type BIGINT,
   smallint_type SMALLINT ,
   decimal_type DECIMAL(10,3) ,
   numeric_type NUMERIC(10,3) ,
   float_type FLOAT ,
   real_type REAL ,
   serial_type SERIAL,
   smallserial_type SMALLSERIAL,
   bigserial_type BIGSERIAL,
   PRIMARY KEY (id)
);

INSERT INTO NumericTypes (id, int_type, bigint_type, smallint_type, decimal_type, numeric_type,
    float_type, real_type, serial_type, smallserial_type, bigserial_type) VALUES (1, -2147483648, -9223372036854774808, -32768, -81288607.2323, -81288607.2323, -123.456, -23444.2323, 1,
    1, 1);

INSERT INTO NumericTypes (id, int_type, bigint_type, smallint_type, decimal_type, numeric_type,
    float_type, real_type, serial_type, smallserial_type, bigserial_type) VALUES (2, 2147483647, 9223372036854775807, 32767, 8388607.2321, 8388607.2321, 123.456, 23444.2323, 2147483647, 32767,
    9223372036854775807);

DROP TABLE IF EXISTS StringTypes;

CREATE TABLE StringTypes (
   id SERIAL,
   char_type CHAR(15),
   varchar_type VARCHAR,
   text_type TEXT ,
   name_type NAME,
   PRIMARY KEY (id)
);

INSERT INTO StringTypes (id, char_type, varchar_type, text_type, name_type) VALUES (1, 'This is a char', 'This is a varchar', 'This is a text', 'This is a name');

INSERT INTO StringTypes (id, char_type, varchar_type, text_type, name_type) VALUES (2, 'This is a char', 'This is a varchar', 'This is a text', 'This is a name');

DROP TABLE IF EXISTS DateTimeTypes;

CREATE TABLE IF NOT EXISTS DateTimeTypes(
  row_id         INTEGER NOT NULL,
  date_type      DATE,
  time_type      TIME,
  timetz_type      TIMETZ,
  timestamp_type TIMESTAMP,
  timestamptz_type TIMESTAMPTZ,
  PRIMARY KEY (row_id)
);

INSERT INTO DateTimeTypes (row_id, date_type, time_type, timetz_type, timestamp_type, timestamptz_type) VALUES
  (1,'2017-02-03', '11:35:45', '04:05:06.789-8', '2017-02-03 11:53:00', '2004-10-19 10:23:54+02');

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