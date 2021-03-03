import ballerina/io;
import ballerina/sql;

public function initTestScripts() {
    _ = createDatabases();
    // _ = connectionInitDb();
    // _ = initPool();
    // _ = localTransactionInitDb();
    // _ = basicExcuteInitDB();
    // _ = executeParamsInitDB();
    // _ = batchExcuteInitDB();
    // _ = simpleQueryInitDB();
    // _ = complexQueryInitDB();
    // _ = proceduresInitDB(); 
    _ = networkInitDB(); 
    _ = geometricInitDB(); 
    _ = uuidInitDB(); 
    _ = tsInitDB();
    _ = jsonInitDB(); 
    _ = dateTimeInitDB();
    _ = rangeInitDB(); 
    _ = bitStringInitDB();
    _ = pglsnInitDB(); 
    _ = moneyInitDB();
    _ = objectidentifierInitDB();
}

public function createDatabases() {
    
        // _ = createQuery(`DROP DATABASE IF EXISTS CONNECT_DB`);
        // _ = createQuery(`CREATE DATABASE CONNECT_DB`);
        // _ = createQuery(`DROP DATABASE IF EXISTS EXECUTE_DB`);
        // _ = createQuery(`CREATE DATABASE EXECUTE_DB`);
        // _ = createQuery(`DROP DATABASE IF EXISTS LOCAL_TRANSACTION`);
        // _ = createQuery(`CREATE DATABASE LOCAL_TRANSACTION`);
        // _ = createQuery(`DROP DATABASE IF EXISTS POOL_DB_1`);
        // _ = createQuery(`CREATE DATABASE POOL_DB_1`);
        // _ = createQuery(`DROP DATABASE IF EXISTS POOL_DB_2`);
        // _ = createQuery(`CREATE DATABASE POOL_DB_2`);
        // _ = createQuery(`DROP DATABASE IF EXISTS EXECUTE_PARAMS_DB`);
        // _ = createQuery(`CREATE DATABASE EXECUTE_PARAMS_DB`);
        // _ = createQuery(`DROP DATABASE IF EXISTS BATCH_EXECUTE_DB`);
        // _ = createQuery(`CREATE DATABASE BATCH_EXECUTE_DB`);
        // _ = createQuery(`DROP DATABASE IF EXISTS QUERY_SIMPLE_PARAMS_DB`);
        // _ = createQuery(`CREATE DATABASE QUERY_SIMPLE_PARAMS_DB`);
        // _ = createQuery(`DROP DATABASE IF EXISTS QUERY_COMPLEX_PARAMS_DB`);
        // _ = createQuery(`CREATE DATABASE QUERY_COMPLEX_PARAMS_DB`);
        // _ = createQuery(`DROP DATABASE IF EXISTS PROCEDURES_DB`);
        // _ = createQuery(`CREATE DATABASE PROCEDURES_DB`);
        _ = createQuery(`DROP DATABASE IF EXISTS NETWORK_DB`);
        _ = createQuery(`CREATE DATABASE NETWORK_DB`);
        _ = createQuery(`DROP DATABASE IF EXISTS GEOMETRIC_DB`);
        _ = createQuery(`CREATE DATABASE GEOMETRIC_DB`);
        _ = createQuery(`DROP DATABASE IF EXISTS UUID_DB`);
        _ = createQuery(`CREATE DATABASE UUID_DB`);
        _ = createQuery(`DROP DATABASE IF EXISTS TS_DB`);
        _ = createQuery(`CREATE DATABASE TS_DB`);
        _ = createQuery(`DROP DATABASE IF EXISTS JSON_DB`);
        _ = createQuery(`CREATE DATABASE JSON_DB`);
        _ = createQuery(`DROP DATABASE IF EXISTS DATETIME_DB`);
        _ = createQuery(`CREATE DATABASE DATETIME_DB`);
        _ = createQuery(`DROP DATABASE IF EXISTS RANGE_DB`);
        _ = createQuery(`CREATE DATABASE RANGE_DB`);
        _ = createQuery(`DROP DATABASE IF EXISTS BITSTRING_DB`);
        _ = createQuery(`CREATE DATABASE BITSTRING_DB`);
        _ = createQuery(`DROP DATABASE IF EXISTS PGLSN_DB`);
        _ = createQuery(`CREATE DATABASE PGLSN_DB`);
        _ = createQuery(`DROP DATABASE IF EXISTS MONEY_DB`);
        _ = createQuery(`CREATE DATABASE MONEY_DB`);
        _ = createQuery(`DROP DATABASE IF EXISTS OBJECTIDENTIFIER_DB`);
        _ = createQuery(`CREATE DATABASE OBJECTIDENTIFIER_DB`);
    }

public function connectionInitDb() {
        sql:ParameterizedQuery q2 = `
            DROP TABLE IF EXISTS Customers;

            CREATE TABLE Customers(
                    customerId SERIAL,
                    firstName  VARCHAR(300),
                    lastName  VARCHAR(300),
                    registrationID INTEGER,
                    creditLimit DOUBLE PRECISION,
                    country  VARCHAR(300),
                    PRIMARY KEY (customerId)
            );

            INSERT INTO Customers (firstName,lastName,registrationID,creditLimit,country)
                            VALUES ('Peter', 'Stuart', 1, 5000.75, 'USA');

            DROP DATABASE IF EXISTS SSL_CONNECT_DB;
            CREATE DATABASE SSL_CONNECT_DB;
        
        `;
        _ = executeQuery("connect_db", q2);
}

function initPool() {
    sql:ParameterizedQuery q2 = `
            DROP TABLE IF EXISTS Customers;

            CREATE TABLE IF NOT EXISTS Customers(
            customerId SERIAL,
            firstName  VARCHAR(300),
            lastName  VARCHAR(300),
            registrationID INTEGER,
            creditLimit DOUBLE PRECISION,
            country  VARCHAR(300),
            PRIMARY KEY (customerId)
            );

            INSERT INTO Customers (firstName,lastName,registrationID,creditLimit,country)
            VALUES ('Peter', 'Stuart', 1, 5000.75, 'USA');

            INSERT INTO Customers (firstName,lastName,registrationID,creditLimit,country)
            VALUES ('Dan', 'Brown', 2, 10000, 'UK');
    
    `;
    _ = executeQuery("pool_db_1", q2);

    

    sql:ParameterizedQuery q3 = `
            DROP TABLE IF EXISTS Customers;

            CREATE TABLE IF NOT EXISTS Customers(
            customerId SERIAL,
            firstName  VARCHAR(300),
            lastName  VARCHAR(300),
            registrationID INTEGER,
            creditLimit DOUBLE PRECISION,
            country  VARCHAR(300),
            PRIMARY KEY (customerId)
            );

            INSERT INTO Customers (firstName,lastName,registrationID,creditLimit,country)
            VALUES ('Peter', 'Stuart', 1, 5000.75, 'USA');

            INSERT INTO Customers (firstName,lastName,registrationID,creditLimit,country)
            VALUES ('Dan', 'Brown', 2, 10000, 'UK');
        
        `;

    _ = executeQuery("pool_db_2", q3);
}

public function localTransactionInitDb() {
    sql:ParameterizedQuery q5 = `
            DROP TABLE IF EXISTS Customers;
            CREATE TABLE Customers(
                    customerId SERIAL,
                    firstName  VARCHAR(300),
                    lastName  VARCHAR(300),
                    registrationID INTEGER,
                    creditLimit DOUBLE PRECISION,
                    country  VARCHAR(300),
                    PRIMARY KEY (customerId)
            );
        
        `;

    _ = executeQuery("local_transaction", q5);
        
}

public function basicExcuteInitDB() {

    sql:ParameterizedQuery q5 = `
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

            INSERT INTO StringTypes (id, varchar_type) VALUES (1, 'test data');

            DROP TABLE IF EXISTS BooleanTypes;

            CREATE TABLE BooleanTypes (
                id SERIAL,
                boolean_type boolean,
                PRIMARY KEY (id)
            );

            INSERT INTO BooleanTypes (boolean_type) VALUES (true);

            DROP TABLE IF EXISTS DateTimeTypes;

            CREATE TABLE DateTimeTypes (
                id SERIAL,
                date_type DATE,
                time_type TIME,
                timetz_type TIMETZ,
                timestamp_type TIMESTAMP,
                timestamptz_type TIMESTAMPTZ,
                PRIMARY KEY (id)
            );

            INSERT INTO DateTimeTypes (date_type) VALUES ('1999-01-08');
            
        `;

    _ = executeQuery("execute_db", q5);

}

public function executeParamsInitDB() {
    sql:ParameterizedQuery query = `
    
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
    VALUES(1, 1, 9223372036854774807, 123.34, 2139095039, true, 'Hello', 23.45);

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
        float_type, real_type, serial_type, smallserial_type, bigserial_type) VALUES (1, -2147483648, -9223372036854774808, -32768, -812823, -812823 ,-123.456, -234.23, 1,
        1, 1);

    INSERT INTO NumericTypes (id, int_type, bigint_type, smallint_type, decimal_type, numeric_type,
        float_type, real_type, serial_type, smallserial_type, bigserial_type) VALUES (2, 2147483647, 9223372036854775807, 32767, 83.2, 87.1, 123.456, 24.3, 2147483647, 32767,
        9223372036854775807);

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

    `;
    _ = executeQuery("execute_params_db", query);
}

public function batchExcuteInitDB() {

    sql:ParameterizedQuery q5 = `
        DROP TABLE IF EXISTS DataTable;

        CREATE TABLE DataTable(
        id SERIAL,
        int_type     INTEGER UNIQUE,
        long_type    BIGINT,
        float_type   FLOAT,
        PRIMARY KEY (id)
        );

        INSERT INTO DataTable (int_type, long_type, float_type)
        VALUES(1, 9223372036854774807, 123.34);


        INSERT INTO DataTable (int_type, long_type, float_type)
        VALUES(2, 9372036854774807, 124.34);
                `;

    _ = executeQuery("batch_execute_db", q5);

}

public function simpleQueryInitDB() {

    sql:ParameterizedQuery q5 = `
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
        VALUES(3, 1, 9372036854774807, 124.45, 29095039, false, '1', 25.45);

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
        (2, null, null);

        DROP TABLE IF EXISTS NumericTypes;

        CREATE TABLE NumericTypes (
        id SERIAL,
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
            double_type, real_type) VALUES (1, 2147483647, 9223372036854774807, 32767, 8388607, 1234.567, 1234.567,
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
        timestamp_type TIMESTAMP,
        timestamptz_type  TIMESTAMPTZ,
        PRIMARY KEY (row_id)
        );

        INSERT INTO DateTimeTypes (row_id, date_type, time_type, timetz_type, timestamp_type, timestamptz_type) VALUES
        (1,'2017-02-03', '11:35:45', '11:35:45+3','2017-02-03 11:53:00', '2017-02-03 11:53:00+2');


                `;

    _ = executeQuery("query_simple_params_db", q5);

}

public function complexQueryInitDB() {
    sql:ParameterizedQuery query = 
    `
        DROP TABLE IF EXISTS DataTable;

        CREATE TABLE IF NOT EXISTS DataTable(
        ROW_ID       INTEGER,
        INT_TYPE     INTEGER,
        LONG_TYPE    BIGINT,
        DOUBLE_PRECISION_TYPE    DOUBLE PRECISION,
        NUMERIC_TYPE  NUMERIC,
        BOOLEAN_TYPE BOOLEAN,
        STRING_TYPE  VARCHAR(50),
        DECIMAL_TYPE DECIMAL(20, 2),
        PRIMARY KEY (ROW_ID)
        );

        INSERT INTO DataTable (ROW_ID, INT_TYPE, LONG_TYPE, DOUBLE_PRECISION_TYPE , NUMERIC_TYPE, BOOLEAN_TYPE, STRING_TYPE, DECIMAL_TYPE)
        VALUES(1, 1, 9223372036854774807, 123.34, 2139095039, TRUE, 'Hello', 23.45);

        INSERT INTO DataTable (ROW_ID) VALUES (2);

        DROP TABLE IF EXISTS DataTableRep;

        CREATE TABLE IF NOT EXISTS DataTableRep(
        ROW_ID       INTEGER,
        INT_TYPE     INTEGER,
        PRIMARY KEY (ROW_ID)
        );

        INSERT INTO DataTableRep (ROW_ID, INT_TYPE) VALUES (1, 100);

        INSERT INTO DataTableRep (ROW_ID, INT_TYPE) VALUES (2, 200);

        DROP TABLE IF EXISTS FloatTable;

        CREATE TABLE IF NOT EXISTS FloatTable(
        ROW_ID       INTEGER,
        DOUBLE_PRECISION_TYPE    DOUBLE PRECISION,
        REAL_TYPE  REAL,
        NUMERIC_TYPE NUMERIC(10,2),
        DECIMAL_TYPE  DECIMAL(10,2),
        PRIMARY KEY (ROW_ID)
        );

        INSERT INTO FloatTable (ROW_ID, DOUBLE_PRECISION_TYPE , REAL_TYPE, NUMERIC_TYPE, DECIMAL_TYPE) VALUES
        (1, 238999.34, 238999.34, 238999.34, 238999.34);

        DROP TABLE IF EXISTS ComplexTypes;

        CREATE TABLE IF NOT EXISTS ComplexTypes(
        ROW_ID         INTEGER NOT NULL,
        BYTEA_TYPE      BYTEA,
        TEXT_TYPE      TEXT,
        PRIMARY KEY (ROW_ID)
        );

        INSERT INTO ComplexTypes (ROW_ID, BYTEA_TYPE, TEXT_TYPE) VALUES
        (1, '77736F322062616C6C6572696E6120626C6F6220746573742E', 'very long text');

        INSERT INTO ComplexTypes (ROW_ID, BYTEA_TYPE, TEXT_TYPE) VALUES
        (2, null, null);

        DROP TABLE IF EXISTS DateTimeTypes;

        CREATE TABLE IF NOT EXISTS DateTimeTypes(
        ROW_ID         INTEGER NOT NULL,
        DATE_TYPE      DATE,
        TIME_TYPE      TIME,
        TIMETZ_TYPE      TIMETZ,
        TIMESTAMP_TYPE timestamp,
        TIMESTAMPTZ_TYPE timestamptz,
        PRIMARY KEY (ROW_ID)
        );

        DROP TABLE IF EXISTS DataTypeTableNillable;

        CREATE TABLE IF NOT EXISTS DataTypeTableNillable(
        ROW_ID       INTEGER,
        INT_TYPE     INTEGER,
        LONG_TYPE    BIGINT,
        DOUBLE_PRECISION_TYPE   DOUBLE PRECISION,
        REAL_TYPE    REAL,
        BOOLEAN_TYPE BOOLEAN,
        STRING_TYPE  VARCHAR(50),
        NUMERIC_TYPE NUMERIC(10,3),
        DECIMAL_TYPE DECIMAL(10,3),
        SMALLINT_TYPE SMALLINT,
        BYTEA_TYPE  BYTEA,
        DATE_TYPE      DATE,
        TIME_TYPE      TIME,
        TIMETZ_TYPE      TIMETZ,
        TIMESTAMP_TYPE TIMESTAMP,
        TIMESTAMPTZ_TYPE TIMESTAMPTZ,
        PRIMARY KEY (ROW_ID)
        );
        DROP TABLE IF EXISTS DataTypeTableNillableBinary;

        CREATE TABLE IF NOT EXISTS DataTypeTableNillableBinary(
        ROW_ID       INTEGER,
        BYTEA_TYPE    BYTEA,
        PRIMARY KEY (ROW_ID)
        );

        INSERT INTO DataTypeTableNillable (ROW_ID, INT_TYPE, LONG_TYPE, DOUBLE_PRECISION_TYPE , REAL_TYPE, BOOLEAN_TYPE, STRING_TYPE,
        NUMERIC_TYPE, DECIMAL_TYPE, SMALLINT_TYPE, BYTEA_TYPE, DATE_TYPE, TIME_TYPE,
        TIMETZ_TYPE, TIMESTAMP_TYPE, TIMESTAMPTZ_TYPE) VALUES
        (1, 10, 9223372036854774807, 2139095039, 1234.567, TRUE, 'Hello',1234.567, 1234.567, 5555,
        '77736F322062616C6C6572696E612062696E61727920746573742E', '2017-02-03', '11:35:45', '11:35:45+3',
        '2017-02-03 11:53:00', '2017-02-03 11:53:00+3');

        INSERT INTO DataTypeTableNillable (ROW_ID, INT_TYPE, LONG_TYPE, DOUBLE_PRECISION_TYPE , REAL_TYPE, BOOLEAN_TYPE, STRING_TYPE,
        NUMERIC_TYPE, DECIMAL_TYPE, SMALLINT_TYPE, BYTEA_TYPE, DATE_TYPE, TIME_TYPE,
        TIMETZ_TYPE, TIMESTAMP_TYPE, TIMESTAMPTZ_TYPE) VALUES
        (2, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

        INSERT INTO DataTypeTableNillableBinary (ROW_ID, BYTEA_TYPE) VALUES
        (3, '77736F322062616C6C6572696E6120626C6F6220746573742E');

        INSERT INTO DataTypeTableNillableBinary (ROW_ID, BYTEA_TYPE) VALUES (4, null);

        DROP TABLE IF EXISTS Person;

        CREATE TABLE IF NOT EXISTS Person(
        ID       INTEGER,
        AGE      INTEGER,
        SALARY   DOUBLE PRECISION,
        NAME  VARCHAR(50),
        PRIMARY KEY (ID)
        );

        INSERT INTO Person (ID, AGE, SALARY, NAME) VALUES (1, 25, 400.25, 'John');

        INSERT INTO Person (ID, AGE, SALARY, NAME) VALUES (2, 35, 600.25, 'Anne');

        INSERT INTO Person (ID, AGE, SALARY, NAME) VALUES (3, 45, 600.25, 'Mary');

        INSERT INTO Person (ID, AGE, SALARY, NAME) VALUES (10, 22, 100.25, 'Peter');

    `;

    _ = executeQuery("query_complex_params_db", query);
}

public function proceduresInitDB() {
    sql:ParameterizedQuery query = 
    `
    
    `;

    _ = executeQuery("procedures_db", query);
}

public function networkInitDB() {

    string networkDatabaseName = "network_db";
    string networkTableName = "NetworkTypes";
    sql:ParameterizedQuery networkTableCreateQuery = 
`
    DROP TABLE IF EXISTS NetworkTypes;
    CREATE TABLE IF NOT EXISTS NetworkTypes(
        row_id SERIAL,
        inet_type inet,
        cidr_type cidr,
        macaddr_type macaddr,
        macaddr8_type macaddr8,
        PRIMARY KEY(row_id)
    );

    `;

    sql:ParameterizedQuery networkTableInsertQuery = 
    `
        INSERT INTO NetworkTypes(
            inet_type,
            cidr_type,
            macaddr_type,
            macaddr8_type
            ) 
        VALUES (
            '192.168.0.1/24',
            '::ffff:1.2.3.0/120',
            '08:00:2b:01:02:03',
            '08-00-2b-01-02-03-04-05'
            );

    `;
    _ = executeQuery("network_db", networkTableCreateQuery);
    _ = executeQuery("network_db", networkTableInsertQuery);
}

function geometricInitDB() {
    sql:ParameterizedQuery geometricTableCreateQuery = 
`
    DROP TABLE IF EXISTS GeometricTypes;
    CREATE TABLE IF NOT EXISTS GeometricTypes(
        row_id SERIAL,
        point_type POINT,
        line_type LINE,
        lseg_type LSEG,
        path_type PATH,
        circle_type CIRCLE,
        box_type BOX,
        polygon_type POLYGON,
        PRIMARY KEY(row_id)
    );

    `;

    sql:ParameterizedQuery geometricTableInsertQuery = 
    `
        INSERT INTO GeometricTypes(
            point_type,
            line_type,
            lseg_type,
            box_type,
            path_type,
            polygon_type,
            circle_type
            ) 
        VALUES (
            '(1,2)',
            '{1,2,3}',
            '((1,1),(2,2))',
            '((1,1),(2,2))',
            '[(1,1),(2,2)]',
            '((1,1),(2,2))',
            '<1,1,1>'
            );

    `;
    _ = executeQuery("geometric_db", geometricTableCreateQuery);
    _ = executeQuery("geometric_db", geometricTableInsertQuery);
}

public function uuidInitDB() {
        sql:ParameterizedQuery uuidTableCreateQuery = 
`
    DROP TABLE IF EXISTS UuidTypes;
    CREATE TABLE IF NOT EXISTS UuidTypes(
        row_id SERIAL,
        uuid_type UUID,
        PRIMARY KEY(row_id)
    );

    `;

    sql:ParameterizedQuery uuidTableInsertQuery = 
    `
        INSERT INTO UuidTypes(
            uuid_type
            ) 
        VALUES (
            'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11'
            );

    `;
    _ = executeQuery("uuid_db", uuidTableCreateQuery);
    _ = executeQuery("uuid_db", uuidTableInsertQuery);
}

public function tsInitDB() {
        sql:ParameterizedQuery tsTableCreateQuery = 
`
    DROP TABLE IF EXISTS TextSearchTypes;
    CREATE TABLE IF NOT EXISTS TextSearchTypes(
        row_id SERIAL,
        tsvector_type TSVECTOR,
        tsquery_type TSQUERY,
        PRIMARY KEY(row_id)
    );

    `;

    sql:ParameterizedQuery tsTableInsertQuery = 
    `
        INSERT INTO TextSearchTypes(
            tsvector_type,
            tsquery_type
            ) 
        VALUES (
            'a fat cat sat on a mat and ate a fat rat',
            'fat & rat'
            );

    `;
    _ = executeQuery("ts_db", tsTableCreateQuery);
    _ = executeQuery("ts_db", tsTableInsertQuery);
}
public function jsonInitDB() {
    sql:ParameterizedQuery jsonTableCreateQuery = 
`
    DROP TABLE IF EXISTS JsonTypes;
    CREATE TABLE IF NOT EXISTS JsonTypes(
        row_id SERIAL,
        json_type JSON,
        jsonb_type JSONB,
        jsonpath_type JSONPATH,
        PRIMARY KEY(row_id)
    );

    `;

    sql:ParameterizedQuery jsonTableInsertQuery = 
    `
        INSERT INTO JsonTypes(
            json_type,
            jsonb_type,
            jsonpath_type
            ) 
        VALUES (
            '{"key": "value"}',
            '{"key": "value"}',
            '$.\"floor\"[*].\"apt\"[*]?(@.\"area\" > 40 && @.\"area\" < 90)?(@.\"rooms\" > 1)'
            );

    `;
    _ = executeQuery("json_db", jsonTableCreateQuery);
    _ = executeQuery("json_db", jsonTableInsertQuery);

}

public function dateTimeInitDB() {
    sql:ParameterizedQuery datetimeTableCreateQuery = 
`
    DROP TABLE IF EXISTS DateTimeTypes;
    CREATE TABLE IF NOT EXISTS DateTimeTypes(
        row_id SERIAL,
        time_type TIME,
        timetz_type TIMETZ,
        timestamp_type TIMESTAMP,
        timestamptz_type TIMESTAMPTZ,
        date_type DATE,
        interval_type INTERVAL,
        PRIMARY KEY(row_id)
    );

    `;

    sql:ParameterizedQuery datetimeTableInsertQuery = 
    `
        INSERT INTO DateTimeTypes(
            time_type,
            timetz_type,
            timestamp_type,
            timestamptz_type,
            date_type,
            interval_type
            ) 
        VALUES (
            '04:05:06',
            '2003-04-12 04:05:06 America/New_York',
            '1999-01-08 04:05:06',
            '2004-10-19 10:23:54+02',
            '1999-01-08',
            'P1Y2M3DT4H5M6S'
            );

    `;
    _ = executeQuery("datetime_db", datetimeTableCreateQuery);
    _ = executeQuery("datetime_db", datetimeTableInsertQuery);
}

public function rangeInitDB() {
    sql:ParameterizedQuery rangeTableCreateQuery = 
`
    DROP TABLE IF EXISTS RangeTypes;
    CREATE TABLE IF NOT EXISTS RangeTypes(
        row_id SERIAL,
        int4range_type INT4RANGE,
        int8range_type INT8RANGE,
        numrange_type NUMRANGE,
        tsrange_type TSRANGE,
        tstzrange_type TSTZRANGE,
        daterange_type DATERANGE,
        PRIMARY KEY(row_id)
    );

    `;

    sql:ParameterizedQuery rangeTableInsertQuery = 
    `
        INSERT INTO RangeTypes(
            int4range_type,
            int8range_type,
            numrange_type,
            tsrange_type,
            tstzrange_type,
            daterange_type
            ) 
        VALUES (
            '(2,50)', 
            '(10,100)','(0,24)', 
            '(2010-01-01 14:30, 2010-01-01 15:30)', 
            '(2010-01-01 14:30, 2010-01-01 15:30)', 
            '(2010-01-01 14:30, 2010-01-03 )'
            );

    `;
    _ = executeQuery("range_db", rangeTableCreateQuery);
    _ = executeQuery("range_db", rangeTableInsertQuery);
}

public function bitStringInitDB() {
    sql:ParameterizedQuery rangeTableCreateQuery = 
`
    DROP TABLE IF EXISTS BitTypes;
    CREATE TABLE IF NOT EXISTS BitTypes(
        row_id SERIAL,
        bitstring_type BIT(10),
        varbitstring_type BIT VARYING(10),
        bit_type BIT,
        PRIMARY KEY(row_id)
    );

    `;

    sql:ParameterizedQuery rangeTableInsertQuery = 
    `
        INSERT INTO BitTypes(
            bitstring_type,
            varbitstring_type,
            bit_type
            ) 
        VALUES (
            '1110000111', 
            '1101', 
            '1'
            );

    `;
    _ = executeQuery("bitstring_db", rangeTableCreateQuery);
    _ = executeQuery("bitstring_db", rangeTableInsertQuery);
}

public function pglsnInitDB() {
        sql:ParameterizedQuery pglsnTableCreateQuery = 
`
    DROP TABLE IF EXISTS PGLSNTypes;
    CREATE TABLE IF NOT EXISTS PGLSNTypes(
        row_id SERIAL,
        pglsn_type PG_LSN,
        PRIMARY KEY(row_id)
    );

    `;

    sql:ParameterizedQuery pglsnTableInsertQuery = 
    `
        INSERT INTO PGLSNTypes(
            pglsn_type
            ) 
        VALUES (
            '16/B374D848'
            );

    `;
    _ = executeQuery("pglsn_db", pglsnTableCreateQuery);
    _ = executeQuery("pglsn_db", pglsnTableInsertQuery);
}

public function moneyInitDB() {

    sql:ParameterizedQuery moneyTableInitQuery = 
    `
    set lc_monetary to "en_US.utf8"
    `;

    sql:ParameterizedQuery moneyTableCreateQuery = 
`
    DROP TABLE IF EXISTS MoneyTypes;
    CREATE TABLE IF NOT EXISTS MoneyTypes(
        row_id SERIAL,
        money_type MONEY,
        PRIMARY KEY(row_id)
    );

    `;

    sql:ParameterizedQuery moneyTableInsertQuery = 
    `
        INSERT INTO MoneyTypes(
            money_type
            ) 
        VALUES (
            '124.56'::money
            );

    `;
    _ = executeQuery("money_db", moneyTableInitQuery);
    _ = executeQuery("money_db", moneyTableCreateQuery);
    _ = executeQuery("money_db", moneyTableInsertQuery);
}

public function objectidentifierInitDB() {

    sql:ParameterizedQuery objectidentifierTableCreateQuery = 
`
    DROP TABLE IF EXISTS objectidentifiertypes;
    CREATE TABLE IF NOT EXISTS objectIdentifiertypes(
        row_id SERIAL,
        oid_type OID,
        regclass_type REGCLASS,
        regconfig_type REGCONFIG,
        regdictionary_type REGDICTIONARY,
        regnamespace_type REGNAMESPACE,
        regoper_type REGOPER,
        regoperator_type REGOPERATOR,
        regproc_type REGPROC,
        regprocedure_type REGPROCEDURE,
        regrole_type REGROLE,
        regtype_type REGTYPE,
        PRIMARY KEY(row_id)
    );

    `;

    sql:ParameterizedQuery objectidentifierTableInsertQuery = 
    `
        INSERT INTO objectidentIfiertypes(
            oid_type
            ) 
        VALUES (
            '12'
            );

    `;
    _ = executeQuery("objectidentifier_db", objectidentifierTableCreateQuery);
    _ = executeQuery("objectidentifier_db", objectidentifierTableInsertQuery);
}

public function createQuery(sql:ParameterizedQuery query) {

    Client|sql:Error postgresClient = new(username="postgres",password="postgres");

    if(postgresClient is sql:Error) {
        io:println("Client init failed\n",postgresClient);
    }
    else{
        sql:ExecutionResult|sql:Error result__;
        sql:Error? e__;

        result__ = postgresClient->execute(query);
        if(result__ is sql:Error) {
            io:println("Init Database drop failed\n",result__);
        }
        else{
            io:println("Init Database drop passed\n",result__);
        }
        e__ = postgresClient.close();

        if(e__ is sql:Error) {
            io:println("Client close1 fail\n",e__);
        }
        else{
            io:println("Client close 1 pass");
        }
    }

}

public function executeQuery(string database, sql:ParameterizedQuery query) {

    Client|sql:Error postgresClient = new(username="postgres",password="postgres", database = database);

    if(postgresClient is sql:Error) {
        io:println("Client init failed\n",postgresClient);
    }
    else{
        sql:ExecutionResult|sql:Error result__;
        sql:Error? e__;

        result__ = postgresClient->execute(query);
        if(result__ is sql:Error) {
            io:println("Init Execute drop failed\n",result__);
        }
        else{
            io:println("Init Execute drop passed\n",result__);
        }
        e__ = postgresClient.close();

        if(e__ is sql:Error) {
            io:println("Client close1 fail\n",e__);
        }
        else{
            io:println("Client close 1 pass");
        }
    }

}