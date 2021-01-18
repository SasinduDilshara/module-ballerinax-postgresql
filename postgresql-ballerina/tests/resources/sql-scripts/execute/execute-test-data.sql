CREATE DATABASE IF NOT EXISTS EXECUTE_DB;

USE EXECUTE_DB;

DROP TABLE IF EXISTS NumericTypes;

CREATE TABLE NumericTypes (
   id SERIAL,
   smallint_type SMALLINT,
   int_type INT,
   bigint_type BIGINT,
   decimal_type DECIMAL,
   numeric_type NUMERIC,
   real_type REAL,
   double_type DOUBLE PRECISION,
   PRIMARY KEY (id)
);

INSERT INTO NumericTypes (int_type) VALUES (10);

DROP TABLE IF EXISTS StringTypes;

CREATE TABLE StringTypes (
   id INT,
   varchar_type CHARACTER VARYING(255),
   charmax_type CHARACTER(10),
   char_type CHARACTER,
   text_type text,
   name_type name,
   PRIMARY KEY (id)
);
