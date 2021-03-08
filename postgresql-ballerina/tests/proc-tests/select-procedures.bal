// import ballerina/sql;
// import ballerina/test;
// // import ballerina/io;
// // // import ballerina/time;

// string proceduresDatabase = "procedure_db";

// public type StringDataForCall record {
//     string char_type;
//     string varchar_type;
//     string text_type;
//     string name_type;
// };

// @test:Config {
//     groups: ["procedures"]
// }
// function testProcedureQueryWithSingleData() {
//     int row_id = 1;
//     sql:ParameterizedCallQuery callQuery = `
//         select * from singleSelectProcedure(${row_id});
//     `;

//     sql:ProcedureCallResult ret = callSelectProcedure(callQuery, proceduresDatabase, [StringDataForCall]);
//     stream<record{}, sql:Error>? qResult = ret.queryResult;
//     if (qResult is ()) {
//         test:assertFail("Empty result set returned.");
//     } else {
//         record {|record {} value;|}? data = checkpanic qResult.next();
//         record {}? value = data?.value;
//         StringDataForCall expectedDataRow = {
//             char_type: "This is a char1",
//             varchar_type: "This is a varchar1",
//             text_type: "This is a text1",
//             name_type: "This is a name1"
//         };        
//         test:assertEquals(value, expectedDataRow, "Call procedure insert and query did not match.");
//         checkpanic qResult.close();
//         checkpanic ret.close();
        
//     }
// }

// @test:Config {
//     groups: ["procedures"],
//     dependsOn: [testProcedureQueryWithSingleData]
// }
// function testProcedureQueryWithMultipleData() {
//     int row_id = 1;
//     sql:ParameterizedCallQuery callQuery = `
//         select * from multipleSelectProcedure();
//     `;
//     sql:ProcedureCallResult ret = callSelectProcedure(callQuery, proceduresDatabase, [StringDataForCall, StringDataForCall]);

//     stream<record{}, sql:Error>? qResult = ret.queryResult;
//     if (qResult is ()) {
//         test:assertFail("First result set is empty.");
//     } else {
//         record {|record {} value;|}? data = checkpanic qResult.next();
//         record {}? result1 = data?.value;
//         StringDataForCall expectedDataRow = {
//             char_type: "This is a char1",
//             varchar_type: "This is a varchar1",
//             text_type: "This is a text1",
//             name_type: "This is a name1"
//         };        
//         test:assertEquals(result1, expectedDataRow, "Call procedure first select did not match.");
//     }

//     qResult = ret.queryResult;
//     if (qResult is ()) {
//         test:assertFail("Second result set is empty.");
//     } else {
//         record {|record {} value;|}? data = checkpanic qResult.next();
//         record {}? result2 = data?.value;
//         StringDataForCall expectedDataRow2 = {
//             char_type: "This is a char2",
//             varchar_type: "This is a varchar2",
//             text_type: "This is a text2",
//             name_type: "This is a name2"
//         };
        
//         test:assertEquals(result2, expectedDataRow2, "Call procedure second select did not match.");
//         checkpanic qResult.close();
//         checkpanic ret.close();
//     }
// }

// public type StringData record {
//     int row_id;
//     string char_type;
//     string varchar_type;
//     string text_type;
//     string name_type;
// };

// @test:Config {
//     groups: ["procedures"],
//     dependsOn: [testProcedureQueryWithMultipleData]
// }
// function testProcedureQueryWithMultipleSelectData() {
//     int row_id = 1;
//     sql:ParameterizedCallQuery callQuery = `
//         select * from multipleQuerySelectProcedure();
//     `;
//     sql:ProcedureCallResult ret = callSelectProcedure(callQuery, proceduresDatabase, [StringData, StringData]);

//     stream<record{}, sql:Error>? qResult = ret.queryResult;
//     if (qResult is ()) {
//         test:assertFail("First result set is empty.");
//     } else {
//         record {|record {} value;|}? data = checkpanic qResult.next();
//         record {}? result1 = data?.value;
//         StringData expectedDataRow = {
//             row_id: 1,
//             char_type: "This is a char1",
//             varchar_type: "This is a varchar1",
//             text_type: "This is a text1",
//             name_type: "This is a name1"
//         };        
//         test:assertEquals(result1, expectedDataRow, "Call procedure first select did not match.");
//     }

//     if (qResult is ()) {
//         test:assertFail("Second result set is empty.");
//     } else {
//         record {|record {} value;|}? data = checkpanic qResult.next();
//         record {}? result2 = data?.value;
//         StringData expectedDataRow2 = {
//             row_id: 2,
//             char_type: "This is a char2",
//             varchar_type: "This is a varchar2",
//             text_type: "This is a text2",
//             name_type: "This is a name2"
//         };
//         test:assertEquals(result2, expectedDataRow2, "Call procedure second select did not match.");
//         checkpanic qResult.close();
//         checkpanic ret.close();
//     }
// }


// function callSelectProcedure(sql:ParameterizedCallQuery sqlQuery, string database, typedesc<record {}>[] rowTypes = []) returns sql:ProcedureCallResult {
//     Client dbClient = checkpanic new (host, user, password, database, port);
//     sql:ProcedureCallResult result = checkpanic dbClient->call(sqlQuery, rowTypes);
//     checkpanic dbClient.close();
//     return result;
// }