CREATE DATABASE IF NOT EXISTS PROCEDURES_DB;

USE PROCEDURES_DB;

DROP TABLE IF EXISTS StringTypes;

CREATE TABLE StringTypes (
       id INT,
       varchar_type VARCHAR(255),
       char_type CHAR,
       text_type TEXT,
       name_type NAME,
       PRIMARY KEY (id)
);

INSERT INTO StringTypes(id, varchar_type, char_type, text_type, name_type)
                    VALUES (1, 'test0', 'a', 'test1', 'test2');

DROP TABLE IF EXISTS NumericTypes;

CREATE TABLE NumericTypes (
       id INT,
       int_type INT,
       bigint_type BIGINT,
       smallint_type SMALLINT,
       decimal_type DECIMAL(10,2),
       numeric_type NUMERIC(10,2),
       double_type DOUBLE PRECISION,
       real_type REAL,
       PRIMARY KEY (id)
);

INSERT INTO NumericTypes (id, int_type, bigint_type, smallint_type, decimal_type, numeric_type,
                          double_type, real_type)
                  VALUES (1, 2147483647, 9223372036854774807, 32767, 1234.56, 1234.56,
                                                                      1234.56, 1234.56);



CREATE PROCEDURE InsertStringData(IN p_id INTEGER,
                                  IN p_varchar_type VARCHAR(255),
                                  IN p_char_type CHAR,
                                  IN p_text_type TEXT,
                                  IN p_name_type NAME))
Begin
INSERT INTO StringTypes(id, p_varchar_type, p_char_type, p_text_type, p_name_type)
VALUES (p_id, p_varchar_type, p_char_type, p_text_type, p_name_type);



CREATE PROCEDURE SelectStringData()
Begin
SELECT p_varchar_type, p_char_type, p_text_type, p_name_type
       FROM StringTypes
where id = 1;



CREATE PROCEDURE SelectStringDataMultiple()
Begin
SELECT p_varchar_type, p_char_type, p_text_type, p_name_type FROM StringTypes where id = 1;
SELECT varchar_type FROM StringTypes where id = 1;



CREATE PROCEDURE SelectStringDataWithOutParams (IN p_id INT, INOUT  p_varchar_type VARCHAR(255),
                                                INOUT  p_char_type CHAR, INOUT  p_text_type TEXT, INOUT  p_name_type NAME)
Begin
SELECT varchar_type INTO p_varchar_type FROM StringTypes where id = p_id;
SELECT char_type INTO p_char_type FROM StringTypes where id = p_id;
SELECT text_type INTO p_text_type FROM StringTypes where id = p_id;
SELECT name_type INTO p_name_type FROM StringTypes where id = p_id;



CREATE PROCEDURE SelectNumericDataWithOutParams (IN p_id INT, INOUT  p_int_type INT, INOUT p_bigint_type BIGINT,
                                                 INOUT  p_smallint_type SMALLINT, INOUT  p_decimal_type DECIMAL(10,2),
                                                 INOUT  p_numeric_type NUMERIC(10,2), INOUT  p_double_type DOUBLE PRECISION, INOUT  p_real_type REAL, INOUT  p_double_type DOUBLE)
Begin
SELECT int_type INTO p_int_type FROM NumericTypes where id = p_id;
SELECT bigint_type INTO p_bigint_type FROM NumericTypes where id = p_id;
SELECT smallint_type INTO p_smallint_type FROM NumericTypes where id = p_id;
SELECT decimal_type INTO p_decimal_type FROM NumericTypes where id = p_id;
SELECT numeric_type INTO p_numeric_type FROM NumericTypes where id = p_id;
SELECT double_type INTO p_double_type FROM NumericTypes where id = p_id;
SELECT real_type INTO p_real_type FROM NumericTypes where id = p_id;

