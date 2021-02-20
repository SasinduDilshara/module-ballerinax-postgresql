import ballerina/io;
import ballerina/sql;

public function initTestScripts(){
    _ = createDatabases();
    _ = connectionInitDb();
    _ = initPool();
    _ = localTransactionInitDb();
    _ = basicExcuteInitDB();
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