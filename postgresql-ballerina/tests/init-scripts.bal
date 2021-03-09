import ballerina/io;
import ballerina/sql;

public function initTestScripts() {
    _ = createExecuteDB();
     _ = createBatchExecuteDB();
    _ = createQueryDB();
    _ = createProcedureDB();
}


public function createExecuteDB() {
    _ = createDatabaseQuery(createExecuteDBQuery);
    _ = executeQuery("execute_db", tableInitDBQuery);
}

public function createBatchExecuteDB() {
    _ = createDatabaseQuery(createBatchExecuteDBQuery);
    _ = executeQuery("batch_execute_db", tableInitDBQuery);
}

public function createQueryDB() {
    _ = createDatabaseQuery(createQueryDBQuery);
    _ = executeQuery("query_db", tableInitDBQuery);
}

public function createProcedureDB() {
    _ = createDatabaseQuery(procedureDBQuery);
    _ = executeQuery("procedure_db", tableInitDBQuery);
    _ = executeQuery("procedure_db", procedureInQuery);
    _ = executeQuery("procedure_db", procedureOutQuery);
    _ = executeQuery("procedure_db", procedureInoutQuery);
    _ = executeQuery("procedure_db", procedureSelectQuery);
}

public function createDatabaseQuery(sql:ParameterizedQuery query) {

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