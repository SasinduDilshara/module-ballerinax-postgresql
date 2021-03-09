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

import ballerina/sql;
import ballerina/test;
import ballerina/io;

string batchExecuteDB = "batch_execute_db";

@test:Config {
    groups: ["batch-execute"]
}
function batchInsertIntoDataTable() {
    var data = [
        {row_id: 2, longValue: 9223372036854774807, doubleValue: 123.34},
        {row_id: 3, longValue: 9223372036854774807, doubleValue: 123.34},
        {row_id: 4, longValue: 9223372036854774807, doubleValue: 123.34}
    ];
    sql:ParameterizedQuery[] sqlQueries =
        from var row in data
        select `INSERT INTO NumericTypes (int_type, bigint_type, double_type) VALUES (${row.row_id}, ${row.longValue}, ${row.doubleValue})`;
    validateBatchExecutionResult(batchExecuteQueryPostgreSQLClient(sqlQueries), [1, 1, 1], [2, 3, 4]);
}

@test:Config {
    groups: ["batch-execute"],
    dependsOn: [batchInsertIntoDataTable]
}
function batchInsertIntoDataTable2() {
    int intValue = 5;
    sql:ParameterizedQuery sqlQuery = `INSERT INTO NumericTypes (int_type) VALUES(${intValue})`;
    sql:ParameterizedQuery[] sqlQueries = [sqlQuery];
    validateBatchExecutionResult(batchExecuteQueryPostgreSQLClient(sqlQueries), [1], [5]);
}

@test:Config {
    groups: ["batch-execute"],
    dependsOn: [batchInsertIntoDataTable2]
}
function batchInsertIntoDataTableFailure() {
    var data = [
        {row_id: 6, longValue: 9223372036854774807, doubleValue: 123.34},
        {row_id: 7, longValue: 9223372036854774807, doubleValue: 123.34},
        {row_id: 1, longValue: 9223372036854774807, doubleValue: 123.34},
        {row_id: 8, longValue: 9223372036854774807, doubleValue: 123.34}
    ];
    sql:ParameterizedQuery[] sqlQueries =
        from var row in data
        select `INSERT INTO NumericTypes (row_id, bigint_type, double_type) VALUES (${row.row_id}, ${row.longValue}, ${row.doubleValue})`;
    sql:ExecutionResult[]|error result = trap batchExecuteQueryPostgreSQLClient(sqlQueries);
    test:assertTrue(result is error);
    io:println("Batch execute error\n", result);
    if (result is sql:BatchExecuteError) {
        sql:BatchExecuteErrorDetail errorDetails = result.detail();
        io:println("Batch execute errorDetails.executionResults\n", errorDetails.executionResults);
        test:assertEquals(errorDetails.executionResults.length(), 4);
        test:assertEquals(errorDetails.executionResults[0].affectedRowCount, 1);
        test:assertEquals(errorDetails.executionResults[1].affectedRowCount, 1);
        test:assertEquals(errorDetails.executionResults[2].affectedRowCount, -3);
        test:assertEquals(errorDetails.executionResults[3].affectedRowCount, -3);
    } else {
        test:assertFail("Database Error expected.");
    }
}

@test:Config {
    groups: ["batch-execute"],
    dependsOn: [batchInsertIntoDataTableFailure]
}
function batchInsertIntoCharacterTable() {
    var data = [
        {row_id: 3, charValue: "This is char2", varcharValue: "This is varchar2"},
        {row_id: 4, charValue: "This is char3", varcharValue: "This is varchar3"},
        {row_id: 5, charValue: "This is char4", varcharValue: "This is varchar4"}
    ];
    sql:ParameterizedQuery[] sqlQueries =
        from var row in data
        select `INSERT INTO CharacterTypes (row_id, char_type, varchar_type) VALUES (${row.row_id}, ${row.charValue}, ${row.varcharValue})`;
    validateBatchExecutionResult(batchExecuteQueryPostgreSQLClient(sqlQueries), [1, 1, 1], [3, 4, 5]);
}

@test:Config {
    groups: ["batch-execute"],
    dependsOn: [batchInsertIntoCharacterTable]
}
function batchUpdateCharacterTable() {
    var data = [
        {row_id: 3, varcharValue: "Updated varchar2"},
        {row_id: 4, varcharValue: "Updated varchar3"},
        {row_id: 5, varcharValue: "Updated varchar4"}
    ];
    sql:ParameterizedQuery[] sqlQueries =
        from var row in data
        select `UPDATE CharacterTypes SET varchar_type = ${row.varcharValue}
               WHERE row_id = ${row.row_id}`;
    validateBatchExecutionResult(batchExecuteQueryPostgreSQLClient(sqlQueries), [1, 1, 1], [3, 4, 5]);
}

isolated function validateBatchExecutionResult(sql:ExecutionResult[] results, int[] rowCount, int[] lastId) {
    test:assertEquals(results.length(), rowCount.length());

    int i =0;
    while (i < results.length()) {
        test:assertEquals(results[i].affectedRowCount, rowCount[i]);
        int|string? lastInsertIdVal = results[i].lastInsertId;
        if (lastId[i] == -1) {
            test:assertNotEquals(lastInsertIdVal, ());
        } else if (lastInsertIdVal is int) {
            test:assertTrue(lastInsertIdVal > 1, "Last Insert Id is nil.");
        } else {
            test:assertFail("The last insert id should be an integer.");
        }
        i = i + 1;
    }
}

function batchExecuteQueryPostgreSQLClient(sql:ParameterizedQuery[] sqlQueries) returns sql:ExecutionResult[] {
    Client dbClient = checkpanic new (host, user, password, batchExecuteDB, port);
    sql:ExecutionResult[] result = checkpanic dbClient->batchExecute(sqlQueries);
    checkpanic dbClient.close();
    return result;
}
