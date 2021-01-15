import ballerina/io;
import ballerina/sql;

public function initTestScripts(){
    _ = createDatabases();
    _ = connectionInitDb();
    _ = initPool();
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