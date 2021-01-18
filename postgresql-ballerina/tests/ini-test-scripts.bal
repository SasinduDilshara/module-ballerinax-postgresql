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
    sql:ExecutionResult|sql:Error result_;
    sql:Error? e_;
    Client|sql:Error postgresClient = new(username="postgres",password="postgres");

    if(postgresClient is sql:Error){
        io:println("Client init failed\n",postgresClient);
    }
    else{

    sql:ParameterizedQuery q1 = `
    
            DROP DATABASE IF EXISTS CONNECT_DB;
            CREATE DATABASE CONNECT_DB;
            DROP DATABASE IF EXISTS POOL_DB_1;
            CREATE DATABASE POOL_DB_1;
            DROP DATABASE IF EXISTS POOL_DB_2;
            CREATE DATABASE POOL_DB_2;
            DROP DATABASE IF EXISTS EXECUTE_DB;
            CREATE DATABASE EXECUTE_DB;
    `;

    result_ = postgresClient->execute(q1);

        if(result_ is sql:Error){
            io:println("Init Database drop failed\n",result_);
        }
        else{
            io:println("Init Database drop passed\n",result_);
        }
        e_ = postgresClient.close();

        if(e_ is sql:Error){
            io:println("Client close1 fail\n",e_);
        }
        else{
            io:println("Client close 1 pass");
        }
        q1 = `
                DROP DATABASE IF EXISTS LOCAL_TRANSACTION;
                CREATE DATABASE LOCAL_TRANSACTION;
        `;

    result_ = postgresClient->execute(q1);

        if(result_ is sql:Error){
            io:println("Init Database drop failed\n",result_);
        }
        else{
            io:println("Init Database drop passed\n",result_);
        }
        e_ = postgresClient.close();

        if(e_ is sql:Error){
            io:println("Client close1 fail\n",e_);
        }
        else{
            io:println("Client close 1 pass");
        }

    }
}

public function connectionInitDb() {
    sql:ExecutionResult|sql:Error result;
    sql:Error? e;

    Client|sql:Error postgresClient2 = new(username="postgres",password="postgres",database = "connect_db");

    if(postgresClient2 is sql:Error){
        io:println("Client init failed\n",postgresClient2);
    }
    else{
        io:println("Client init Succcess");

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

        result = postgresClient2->execute(q2);

        if(result is sql:Error){
            io:println("Table drop failed\n",result);
        }
        else{
            io:println("Table drop passed\n",result);
        }

        e = postgresClient2.close();

        if(e is sql:Error){
            io:println("Client close2 fail\n",e);
        }
        else{
            io:println("Client close 2 pass");
        }

        
    }
}

function initPool(){
    sql:ExecutionResult|sql:Error result3;
    sql:Error? e3;

    Client|sql:Error postgresClient3 = new(username="postgres",password="postgres",database = "pool_db_1");

    if(postgresClient3 is sql:Error){
        io:println("Client init failed\n",postgresClient3);
    }
    else{
        io:println("Client init Succcess");

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

        result3 = postgresClient3->execute(q2);

        if(result3 is sql:Error){
            io:println("Table drop failed\n",result3);
        }
        else{
            io:println("Table drop passed\n",result3);
        }

        e3 = postgresClient3.close();

        if(e3 is sql:Error){
            io:println("Client close2 fail\n",e3);
        }
        else{
            io:println("Client close 2 pass");
        }

        
    }

    Client|sql:Error postgresClient4 = new(username="postgres",password="postgres",database = "pool_db_2");

    if(postgresClient4 is sql:Error){
        io:println("Client init failed\n",postgresClient4);
    }
    else{
        io:println("Client init Succcess");

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

        result3 = postgresClient4->execute(q3);

        if(result3 is sql:Error){
            io:println("Table drop failed\n",result3);
        }
        else{
            io:println("Table drop passed\n",result3);
        }

        e3 = postgresClient4.close();

        if(e3 is sql:Error){
            io:println("Client close2 fail\n",e3);
        }
        else{
            io:println("Client close 2 pass");
        }

    }
}

public function localTransactionInitDb() {
    sql:ExecutionResult|sql:Error result4;
    sql:Error? e5;

    Client|sql:Error postgresClient5 = new(username="postgres",password="postgres",database = "local_transaction");

    if(postgresClient5 is sql:Error){
        io:println("Client init failed\n",postgresClient5);
    }
    else{
        io:println("Client init Succcess");

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

        result4 = postgresClient5->execute(q5);

        if(result4 is sql:Error){
            io:println("Table drop failed\n",result4);
        }
        else{
            io:println("Table drop passed\n",result4);
        }

        e5 = postgresClient5.close();

        if(e5 is sql:Error){
            io:println("Client close2 fail\n",e5);
        }
        else{
            io:println("Client close 2 pass");
        }

        
    }
}

public function basicExcuteInitDB(){

    sql:ExecutionResult|sql:Error result5;
    sql:Error? e6;

    Client|sql:Error postgresClient6 = new(username="postgres",password="postgres",database = "execute_db");

    if(postgresClient6 is sql:Error){
        io:println("Client init failed\n",postgresClient6);
    }
    else{
        io:println("Client init Succcess");

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

        result5 = postgresClient6->execute(q5);

        if(result5 is sql:Error){
            io:println("Table drop failed\n",result5);
        }
        else{
            io:println("Table drop passed\n",result5);
        }

        e6 = postgresClient6.close();

        if(e6 is sql:Error){
            io:println("Client close2 fail\n",e6);
        }
        else{
            io:println("Client close 2 pass");
        }

        
    }

}