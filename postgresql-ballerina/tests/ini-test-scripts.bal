import ballerina/io;
import ballerina/sql;

public function initTestScripts() {
    _ = createDatabases();
    _ = connectionInitDb();
    _ = initPool();
    _ = localTransactionInitDb();
    _ = basicExcuteInitDB();
    _ = executeParamsInitDB();
    _ = batchExcuteInitDB();
    _ = simpleQueryInitDB();
    _ = complexQueryInitDB();
    _ = proceduresInitDB(); 
}

public function createDatabases() {
    
        _ = createQuery(`DROP DATABASE IF EXISTS CONNECT_DB`);
        _ = createQuery(`CREATE DATABASE CONNECT_DB`);
        _ = createQuery(`DROP DATABASE IF EXISTS EXECUTE_DB`);
        _ = createQuery(`CREATE DATABASE EXECUTE_DB`);
        _ = createQuery(`DROP DATABASE IF EXISTS LOCAL_TRANSACTION`);
        _ = createQuery(`CREATE DATABASE LOCAL_TRANSACTION`);
        _ = createQuery(`DROP DATABASE IF EXISTS POOL_DB_1`);
        _ = createQuery(`CREATE DATABASE POOL_DB_1`);
        _ = createQuery(`DROP DATABASE IF EXISTS POOL_DB_2`);
        _ = createQuery(`CREATE DATABASE POOL_DB_2`);
        _ = createQuery(`DROP DATABASE IF EXISTS EXECUTE_PARAMS_DB`);
        _ = createQuery(`CREATE DATABASE EXECUTE_PARAMS_DB`);
        _ = createQuery(`DROP DATABASE IF EXISTS BATCH_EXECUTE_DB`);
        _ = createQuery(`CREATE DATABASE BATCH_EXECUTE_DB`);
        _ = createQuery(`DROP DATABASE IF EXISTS QUERY_SIMPLE_PARAMS_DB`);
        _ = createQuery(`CREATE DATABASE QUERY_SIMPLE_PARAMS_DB`);
        _ = createQuery(`DROP DATABASE IF EXISTS QUERY_COMPLEX_PARAMS_DB`);
        _ = createQuery(`CREATE DATABASE QUERY_COMPLEX_PARAMS_DB`);
        _ = createQuery(`DROP DATABASE IF EXISTS PROCEDURES_DB`);
        _ = createQuery(`CREATE DATABASE PROCEDURES_DB`);
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