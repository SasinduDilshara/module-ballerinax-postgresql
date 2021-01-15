DROP DATABASE IF EXISTS CONNECT_DB;

CREATE DATABASE CONNET_DB;

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


