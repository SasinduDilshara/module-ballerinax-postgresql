// Copyright (c) 2020 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/crypto;
import ballerina/java;
import ballerina/sql;
import ballerina/io;

# Represents a PostgreSQL database client.
public client class Client {
    *sql:Client;
    private boolean clientActive = true;

    # Initialize PostgreSQL Client.
    #
    # + host - Hostname of the postgresql server to be connected
    # + user - If the postgresql server is secured, the username to be used to connect to the postgresql server
    # + password - The password of provided username of the database
    # + database - The name fo the database to be connected
    # + port - Port number of the postgresql server to be connected
    # + options - The Database specific JDBC client properties
    # + connectionPool - The `sql:ConnectionPool` object to be used within the jdbc client.
    #                   If there is no connectionPool is provided, the global connection pool will be used and it will
    #                   be shared by other clients which has same properties.
    public function init(string host = "localhost", string? username = (), string? password = (), string? database = (),
        int port = 5432, Options? options = (), sql:ConnectionPool? connectionPool = ()) returns sql:Error? {
        // int port = 3306, Options? options = (), sql:ConnectionPool? connectionPool = ()) returns sql:Error? {
        ClientConfiguration clientConfig = {
            host: host,
            port: port,
            user: username,
            password: password,
            database: database,
            options: options,
            connectionPool: connectionPool
        };
        io:println("initialization method =================================================================================================================");
        return createClient(self, clientConfig, sql:getGlobalConnectionPool());
    }

    # Queries the database with the query provided by the user, and returns the result as stream.
    #
    # + sqlQuery - The query which needs to be executed as `string` or `ParameterizedQuery` when the SQL query has
    #              params to be passed in
    # + rowType - The `typedesc` of the record that should be returned as a result. If this is not provided the default
    #             column names of the query result set be used for the record attributes.
    # + return - Stream of records in the type of `rowType`
    remote function query(@untainted string|sql:ParameterizedQuery sqlQuery, typedesc<record {}>? rowType = ())
    returns @tainted stream <record {}, sql:Error> {
        io:println("query method =================================================================================================================");
        if (self.clientActive) {
            return nativeQuery(self, sqlQuery, rowType);
        } else {
            return sql:generateApplicationErrorStream("PostgreSQL Client is already closed,"
                + "hence further operations are not allowed");
        }
    }

    # Executes the DDL or DML sql queries provided by the user, and returns summary of the execution.
    #
    # + sqlQuery - The DDL or DML query such as INSERT, DELETE, UPDATE, etc as `string` or `ParameterizedQuery`
    #              when the query has params to be passed in
    # + return - Summary of the sql update query as `ExecutionResult` or returns `Error`
    #           if any error occurred when executing the query
    remote function execute(@untainted string|sql:ParameterizedQuery sqlQuery) returns sql:ExecutionResult|sql:Error {
        io:println("execute method =================================================================================================================");
        if (self.clientActive) {
            return nativeExecute(self, sqlQuery);
        } else {
            return sql:ApplicationError("PostgreSQL Client is already closed, hence further operations are not allowed");
        }
    }

    # Executes a batch of parameterized DDL or DML sql query provided by the user,
    # and returns the summary of the execution.
    #
    # + sqlQueries - The DDL or DML query such as INSERT, DELETE, UPDATE, etc as `ParameterizedQuery` with an array
    #                of values passed in
    # + return - Summary of the executed SQL queries as `ExecutionResult[]` which includes details such as
    #            `affectedRowCount` and `lastInsertId`. If one of the commands in the batch fails, this function
    #            will return `BatchExecuteError`, however the JDBC driver may or may not continue to process the
    #            remaining commands in the batch after a failure. The summary of the executed queries in case of error
    #            can be accessed as `(<sql:BatchExecuteError> result).detail()?.executionResults`.
    remote function batchExecute(@untainted sql:ParameterizedQuery[] sqlQueries) returns sql:ExecutionResult[]|sql:Error {
        io:println("batch execute method =================================================================================================================");
        if (sqlQueries.length() == 0) {
            return sql:ApplicationError(" Parameter 'sqlQueries' cannot be empty array");
        }
        if (self.clientActive) {
            return nativeBatchExecute(self, sqlQueries);
        } else {
            return sql:ApplicationError("JDBC Client is already closed, hence further operations are not allowed");
        }
    }

    # Executes a SQL stored procedure and returns the result as stream and execution summary.
    #
    # + sqlQuery - The query to execute the SQL stored procedure
    # + rowTypes - The array of `typedesc` of the records that should be returned as a result. If this is not provided
    #               the default column names of the query result set be used for the record attributes.
    # + return - Summary of the execution is returned in `ProcedureCallResult` or `sql:Error`
    remote function call(@untainted string|sql:ParameterizedCallQuery sqlQuery, typedesc<record {}>[] rowTypes = [])
    returns sql:ProcedureCallResult|sql:Error {
        io:println("call method =================================================================================================================");
        if (self.clientActive) {
            return nativeCall(self, sqlQuery, rowTypes);
        } else {
            return sql:ApplicationError("JDBC Client is already closed, hence further operations are not allowed");
        }
    }

    # Close the SQL client.
    #
    # + return - Possible error during closing the client
    public function close() returns sql:Error? {
        self.clientActive = false;
        io:println("close method =================================================================================================================");
        return close(self);
    }
}

# Provides a set of configurations for the postgresql client to be passed internally within the module.
#
# + host - URL of the database to connect
# + port - Port of the database to connect
# + user - Username for the database connection
# + password - Password for the database connection
# + database - Name of the database
# + options - Mysql datasource `Options` to be configured
# + connectionPool - Properties for the connection pool configuration. Refer `sql:ConnectionPool` for more details

type ClientConfiguration record {|
    string host;
    int port;
    string? user;
    string? password;
    string? database;
    Options? options;
    sql:ConnectionPool? connectionPool;
|};

# PostgreSQL database options.
#
# + ssl - SSL Configuration to be used
# + useXADatasource - Boolean value to enable XADatasource
# + connectTimeoutInSeconds - Timeout to be used when connecting to the postgresql server
# + socketTimeoutInSeconds - Socket timeout during the read/write operations with postgresql server,
#                            0 means no socket timeout

public type Options record {|
  SSLConfig ssl?;
  int connectTimeoutInSeconds?;
  int socketTimeoutInSeconds?;
  int loginTimeoutInSeconds?;
  int rowFetchSize?;
  int dbMetadataCacheFields?;
  int dbMetadataCacheFieldsMiB?;
  int prepareThreshold?;
  int preparedStatementCacheQueries?;
  int preparedStatementCacheSize?;
  int cancelSignalTimeoutInSeconds?;
  boolean tcpKeepAlive?;
|};

public enum SSLMode {
   PREFER,
   REQUIRE,
   DISABLE,
   ALLOW,
   VERIFY_CA = "VERIFY-CA",
   VERIFY_FULL = "VERIFY-FULL"
}
# SSL Configuration to be used when connecting to Postgresql server.
#
# + mode - `SSLMode` to be used during the connection
# + sslkey - Keystore configuration of the client certificates
# + sslrootcert - File name of the SSL root certificate.
#                 Defaults to defaultdir/root.crt
# + sslcert - Provide the full path for the client certificate file.
#             Defaults to /defaultdir/postgresql.crt,
#             where defaultdir is ${user.home}/.postgresql/ in unix        systems and %appdata%/postgresql/ on windows.
 
public type SSLConfig record {|
  SSLMode mode = PREFER;
  crypto:KeyStore sslkey?;
  string sslrootcert?;
  string sslcert?;
|};

function createClient(Client mysqlClient, ClientConfiguration clientConf,
    sql:ConnectionPool globalConnPool) returns sql:Error? = @java:Method {
    'class: "org.ballerinalang.postgresql.NativeImpl"
} external;

function nativeQuery(Client sqlClient, string|sql:ParameterizedQuery sqlQuery, typedesc<record {}>? rowType)
returns stream <record {}, sql:Error> = @java:Method {
    'class: "org.ballerinalang.sql.utils.QueryUtils"
} external;

function nativeExecute(Client sqlClient, string|sql:ParameterizedQuery sqlQuery)
returns sql:ExecutionResult|sql:Error = @java:Method {
    'class: "org.ballerinalang.sql.utils.ExecuteUtils"
} external;

function nativeBatchExecute(Client sqlClient, sql:ParameterizedQuery[] sqlQueries)
returns sql:ExecutionResult[]|sql:Error = @java:Method {
    'class: "org.ballerinalang.sql.utils.ExecuteUtils"
} external;

function nativeCall(Client sqlClient, string|sql:ParameterizedCallQuery sqlQuery, typedesc<record {}>[] rowTypes)
returns sql:ProcedureCallResult|sql:Error = @java:Method {
    'class: "org.ballerinalang.sql.utils.CallUtils"
} external;

function close(Client mysqlClient) returns sql:Error? = @java:Method {
    'class: "org.ballerinalang.postgresql.NativeImpl"
} external;
