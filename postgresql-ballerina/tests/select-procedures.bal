import ballerina/sql;
import ballerina/test;
// // import ballerina/io;
// // import ballerina/time;

@test:Config {
    groups: ["procedures"],
    dependsOn: [testCallWithStringTypes]
}
function testCallWithStringTypesInParams() {
    Client dbClient = checkpanic new (host, user, password, proceduresDb, port);
    string varcharType = "test1";
    string charmaxType = "test2";
    string charType = "c";
    string charactermaxType = "test3";
    string characterType = "d";
    string nvarcharmaxType = "test4";

    var ret = checkpanic dbClient->call(`{call InsertStringData(3, ${varcharType}, ${charmaxType}, ${charType},
                            ${charactermaxType}, ${characterType}, ${nvarcharmaxType})}`);

    string sqlQuery = "SELECT varchar_type, charmax_type, char_type, charactermax_type, character_type," +
                   "nvarcharmax_type from StringTypes where id = 2";

    StringDataForCall expectedDataRow = {
        varchar_type: "test1",
        charmax_type: "test2",
        char_type: "c",
        charactermax_type: "test3",
        character_type: "d",
        nvarcharmax_type: "test4"
    };
    test:assertEquals(queryMySQLClient(dbClient, sqlQuery), expectedDataRow, "Call procedure insert and query did not match.");
}

@test:Config {
    groups: ["procedures"],
    dependsOn: [testCallWithStringTypesInParams]
}
function testCallWithStringTypesReturnsData() {
    Client dbClient = checkpanic new (host, user, password, proceduresDb, port);
    sql:ProcedureCallResult ret = checkpanic dbClient->call("{call SelectStringData()}", [StringDataForCall]);
    stream<record{}, sql:Error>? qResult = ret.queryResult;
    if (qResult is ()) {
        test:assertFail("Empty result set returned.");
    } else {
        record {|record {} value;|}? data = checkpanic qResult.next();
        record {}? value = data?.value;
        StringDataForCall expectedDataRow = {
            varchar_type: "test0",
            charmax_type: "test1",
            char_type: "a",
            charactermax_type: "test2",
            character_type: "b",
            nvarcharmax_type: "test3"
        };        
        test:assertEquals(value, expectedDataRow, "Call procedure insert and query did not match.");
        checkpanic qResult.close();
        checkpanic ret.close();
        
    }
    checkpanic dbClient.close();
}

@test:Config {
    groups: ["procedures"],
    dependsOn: [testCallWithStringTypesReturnsData]
}
function testCallWithStringTypesReturnsDataMultiple() {
    Client dbClient = checkpanic new (host, user, password, proceduresDb, port);
    sql:ProcedureCallResult ret = checkpanic dbClient->call("{call SelectStringDataMultiple()}", [StringDataForCall, StringDataSingle]);

    stream<record{}, sql:Error>? qResult = ret.queryResult;
    if (qResult is ()) {
        test:assertFail("First result set is empty.");
    } else {
        record {|record {} value;|}? data = checkpanic qResult.next();
        checkpanic qResult.close();
        record {}? result1 = data?.value;
        StringDataForCall expectedDataRow = {
            varchar_type: "test0",
            charmax_type: "test1",
            char_type: "a",
            charactermax_type: "test2",
            character_type: "b",
            nvarcharmax_type: "test3"
        };        
        test:assertEquals(result1, expectedDataRow, "Call procedure first select did not match.");
    }

    var nextResult = checkpanic ret.getNextQueryResult();
    if (!nextResult) {
        test:assertFail("Only 1 result set returned!.");
    }

    qResult = ret.queryResult;
    if (qResult is ()) {
        test:assertFail("Second result set is empty.");
    } else {
        record {|record {} value;|}? data = checkpanic qResult.next();
        record {}? result2 = data?.value;
        StringDataSingle resultSet2 = {
            varchar_type: "test0"
        };
        test:assertEquals(result2, resultSet2, "Call procedure second select did not match.");
        checkpanic qResult.close();
        checkpanic ret.close();
    }
    checkpanic dbClient.close();
}



