import ballerina/io;
import ballerina/sql;

public function initTestScripts(){
    _ = createDatabases();
    _ = connectionInitDb();
    _ = initPool();
    _ = localTransactionInitDb();
    _ = basicExcuteInitDB();
    _ = executeParamsInitDB();
    _ = batchExcuteInitDB();
}

public function createDatabases(){
    
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

function initPool(){
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

public function basicExcuteInitDB(){

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

public function executeParamsInitDB(){
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

public function batchExcuteInitDB(){

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

public function createQuery(sql:ParameterizedQuery query){

    Client|sql:Error postgresClient = new(username="postgres",password="postgres");

    if(postgresClient is sql:Error){
        io:println("Client init failed\n",postgresClient);
    }
    else{
        sql:ExecutionResult|sql:Error result__;
        sql:Error? e__;

        result__ = postgresClient->execute(query);
        if(result__ is sql:Error){
            io:println("Init Database drop failed\n",result__);
        }
        else{
            io:println("Init Database drop passed\n",result__);
        }
        e__ = postgresClient.close();

        if(e__ is sql:Error){
            io:println("Client close1 fail\n",e__);
        }
        else{
            io:println("Client close 1 pass");
        }
    }

}

public function executeQuery(string database, sql:ParameterizedQuery query){

    Client|sql:Error postgresClient = new(username="postgres",password="postgres", database = database);

    if(postgresClient is sql:Error){
        io:println("Client init failed\n",postgresClient);
    }
    else{
        sql:ExecutionResult|sql:Error result__;
        sql:Error? e__;

        result__ = postgresClient->execute(query);
        if(result__ is sql:Error){
            io:println("Init Execute drop failed\n",result__);
        }
        else{
            io:println("Init Execute drop passed\n",result__);
        }
        e__ = postgresClient.close();

        if(e__ is sql:Error){
            io:println("Client close1 fail\n",e__);
        }
        else{
            io:println("Client close 1 pass");
        }
    }

}