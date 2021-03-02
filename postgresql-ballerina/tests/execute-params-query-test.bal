// // Copyright (c) 2020 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
// //
// // WSO2 Inc. licenses this file to you under the Apache License,
// // Version 2.0 (the "License"); you may not use this file except
// // in compliance with the License.
// // You may obtain a copy of the License at
// //
// // http://www.apache.org/licenses/LICENSE-2.0
// //
// // Unless required by applicable law or agreed to in writing,
// // software distributed under the License is distributed on an
// // "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// // KIND, either express or implied.  See the License for the
// // specific language governing permissions and limitations
// // under the License.

// // import ballerina/io;
import ballerina/sql;
import ballerina/test;
// import ballerina/io;
// import ballerina/time;

string executeParamsDb = "execute_params_db";

// @test:Config {
//     groups: ["execute", "execute-params"]
// }
// function insertIntoDataTable() {
//     int rowId = 4;
//     int intType = 1;
//     int longType = 9223372036854774807;
//     float floatType = 123.34;
//     int doubleType = 2139095039;
//     boolean boolType = true;
//     string stringType = "Hello";
//     decimal decimalType = 23.45;

//     sql:ParameterizedQuery sqlQuery =
//       `INSERT INTO DataTable (row_id, int_type, long_type, float_type, double_type, boolean_type, string_type, decimal_type)
//             VALUES(${rowId}, ${intType}, ${longType}, ${floatType}, ${doubleType}, ${boolType}, ${stringType}, ${decimalType})`;
//     validateResult(executeQueryPostgresqlClient(sqlQuery), 1, rowId);
// }

// @test:Config {
//     groups: ["execute", "execute-params"],
//     dependsOn: [insertIntoDataTable]
// }
// function insertIntoDataTable2() {
//     int rowId = 5;
//     sql:ParameterizedQuery sqlQuery = `INSERT INTO DataTable (row_id) VALUES(${rowId})`;
//     validateResult(executeQueryPostgresqlClient(sqlQuery), 1, rowId);
// }

// @test:Config {
//     groups: ["execute", "execute-params"],
//     dependsOn: [insertIntoDataTable2]
// }
// function insertIntoDataTable3() {
//     int rowId = 6;
//     int intType = 1;
//     int longType = 9223372036854774807;
//     float floatType = 123.34;
//     int doubleType = 2139095039;
//     boolean boolType = false;
//     string stringType = "1";
//     decimal decimalType = 23.45;

//     sql:ParameterizedQuery sqlQuery =
//       `INSERT INTO DataTable (row_id, int_type, long_type, float_type, double_type, boolean_type, string_type, decimal_type)
//         VALUES(${rowId}, ${intType}, ${longType}, ${floatType}, ${doubleType}, ${boolType}, ${stringType}, ${decimalType})`;
//     validateResult(executeQueryPostgresqlClient(sqlQuery), 1, rowId);
// }

// @test:Config {
//     groups: ["execute", "execute-params"],
//     dependsOn: [insertIntoDataTable3]
// }
// function insertIntoDataTable4() {
//     sql:IntegerValue rowId = new (7);
//     sql:IntegerValue intType = new (2);
//     sql:BigIntValue longType = new (9372036854774807);
//     sql:FloatValue floatType = new (124.34);
//     sql:DoubleValue doubleType = new (29095039);
//     sql:BooleanValue boolType = new (false);
//     sql:VarcharValue stringType = new ("stringvalue");
//     decimal decimalVal = 25.45;
//     sql:DecimalValue decimalType = new (decimalVal);

//     sql:ParameterizedQuery sqlQuery =
//       `INSERT INTO DataTable (row_id, int_type, long_type, float_type, double_type, boolean_type, string_type, decimal_type)
//         VALUES(${rowId}, ${intType}, ${longType}, ${floatType}, ${doubleType}, ${boolType}, ${stringType}, ${decimalType})`;
//     validateResult(executeQueryPostgresqlClient(sqlQuery), 1, 7);
// }

// @test:Config {
//     groups: ["execute", "execute-params"]
//     // dependsOn: [insertIntoDataTable4]
// }
// // Need to recheck
// function deleteDataTable1() {
//     int rowId = 1;
//     int intType = 1;
//     int longType = 9223372036854774807;
//     float floatType = 123.34;
//     int doubleType = 2139095039;
//     boolean boolType = true;
//     string stringType = "Hello";
//     decimal decimalType = 23.45;

//     sql:ParameterizedQuery sqlQuery =
//             `DELETE FROM DataTable where row_id=${rowId} AND int_type=${intType} AND long_type=${longType}
//               AND double_type=${doubleType} AND boolean_type=${boolType}
//               AND string_type=${stringType} AND decimal_type=${decimalType}`;
//     validateResult(executeQueryPostgresqlClient(sqlQuery), 1, 1);
// }

// @test:Config {
//     groups: ["execute", "execute-params"],
//     dependsOn: [deleteDataTable1]
// }
// // Need to recheck
// function deleteDataTable2() {
//     int rowId = 2;
//     sql:ParameterizedQuery sqlQuery = `DELETE FROM DataTable where row_id = ${rowId}`;
//     validateResult(executeQueryPostgresqlClient(sqlQuery), 1, 1);
// }

// // Need to recheck
// @test:Config {
//     groups: ["execute", "execute-params"],
//     dependsOn: [deleteDataTable2]
// }
// function deleteDataTable3() {
//     sql:IntegerValue rowId = new (3);
//     sql:IntegerValue intType = new (1);
//     sql:BigIntValue longType = new (9372036854774807);
//     sql:FloatValue floatType = new (124.34);
//     sql:DoubleValue doubleType = new (29095039);
//     sql:BooleanValue boolType = new (false);
//     sql:VarcharValue stringType = new ("1");
//     decimal decimalVal = 25.45;
//     sql:DecimalValue decimalType = new (decimalVal);

//     sql:ParameterizedQuery sqlQuery =
//             `DELETE FROM DataTable where row_id=${rowId} AND int_type=${intType} AND long_type=${longType}
//               AND double_type=${doubleType} AND boolean_type=${boolType}
//               AND string_type=${stringType} AND decimal_type=${decimalType}`;
//     validateResult(executeQueryPostgresqlClient(sqlQuery), 1, 1);
// }

// @test:Config {
//     groups: ["execute", "execute-params"],
//     dependsOn: [deleteDataTable3]
// }
// function insertIntoNumericTable() {
//     int rowId = 3;
//     int intType = 2147483647;
//     int longType = 9223372036854774807;
//     int smallIntType = 32767;
//     decimal decimalType = 12;
//     decimal numericType = 1234.567;
//     float floatType = 214.47;
//     float realType = 343.32;
//     int serialType = 2147483647;
//     int smallserialType = 32767;
//     int bigserialType = 9223372036854774807;

//     sql:ParameterizedQuery sqlQuery =
//         `INSERT INTO NumericTypes (id, int_type, bigint_type, smallint_type, decimal_type,
//         numeric_type, float_type, real_type, serial_type, smallserial_type, bigserial_type) VALUES(${rowId},${intType},${longType},${smallIntType},
//         ${decimalType},${numericType},${floatType},${realType},${serialType},${smallserialType},${bigserialType})`;
//     validateResult(executeQueryPostgresqlClient(sqlQuery), 1, rowId);
// }

// @test:Config {
//     groups: ["execute", "execute-params"],
//     dependsOn: [insertIntoNumericTable]
// }
// function insertIntoNumericTable2() {
//     int rowId = 4;
//     var nilType = ();
//     sql:ParameterizedQuery sqlQuery =
//             `INSERT INTO NumericTypes (id, int_type, bigint_type, smallint_type, decimal_type,
//         numeric_type, float_type, real_type) VALUES(${rowId},${nilType},${nilType},${nilType},${nilType},
//             ${nilType},${nilType},${nilType})`;
//     validateResult(executeQueryPostgresqlClient(sqlQuery), 1, rowId);
// }

// @test:Config {
//     groups: ["execute", "execute-params"],
//     dependsOn: [insertIntoNumericTable2]
// }
// function insertIntoNumericTable3() {
//     sql:IntegerValue rowId = new (5);
//     sql:IntegerValue intType = new (2147483647);
//     sql:BigIntValue longType = new (9223372036854774807);
//     sql:SmallIntValue smallIntType = new (32767);
//     decimal decimalValue = 12.37;
//     sql:DecimalValue decimalType = new (decimalValue);
//     sql:NumericValue numericType = new (decimalValue);
//     sql:FloatValue floatType = new (26.347);
//     sql:RealValue realType = new (323.23);

//     sql:ParameterizedQuery sqlQuery =
//         `INSERT INTO NumericTypes (id, int_type, bigint_type, smallint_type, decimal_type,
//         numeric_type, float_type, real_type) VALUES(${rowId},${intType},${longType},${smallIntType},
//         ${decimalType},${numericType},${floatType},${realType})`;
//     validateResult(executeQueryPostgresqlClient(sqlQuery), 1, 5);
    
// }
// // Need to recheck
// @test:Config {
//     groups: ["execute", "execute-params"],
//     dependsOn: [insertIntoNumericTable3]
// }
// function deleteNumericTable() {
//     int rowId = 3;
//     int intType = 2147483647;
//     int longType = 9223372036854774807;
//     int smallIntType = 32767;
//     decimal decimalType = 12;
//     decimal numericType = 1234.567;
//     float floatType = 214.47;
//     float realType = 343.32;
//     int serialType = 2147483647;
//     int smallserialType = 32767;
//     int bigserialType = 9223372036854774807;

//     sql:ParameterizedQuery sqlQuery =
//             `DELETE FROM NumericTypes where id = ${rowId} AND int_type = ${intType} AND bigint_type = ${longType} AND smallint_type = ${smallIntType} AND decimal_type = ${decimalType} AND
//         numeric_type = ${numericType} AND float_type = ${floatType} AND real_type = ${realType} AND serial_type = ${serialType} AND smallserial_type = ${smallserialType} AND bigserial_type = ${bigserialType}`;
//     validateResult(executeQueryPostgresqlClient(sqlQuery), 0);



// }
// // Need to recheck
// @test:Config {
//     groups: ["execute", "execute-params"],
//     dependsOn: [deleteDataTable2]
// }
// function deleteNumericTable2() {
//     sql:IntegerValue rowId = new (5);
//     sql:IntegerValue intType = new (2147483647);
//     sql:BigIntValue longType = new (9223372036854774807);
//     sql:SmallIntValue smallIntType = new (32767);
//     decimal decimalValue = 12.37;
//     sql:DecimalValue decimalType = new (decimalValue);
//     sql:NumericValue numericType = new (decimalValue);
//     sql:FloatValue floatType = new (26.347);
//     sql:RealValue realType = new (323.23);

//     sql:ParameterizedQuery sqlQuery =
//         `DELETE FROM NumericTypes where id = ${rowId} AND int_type = ${intType} AND bigint_type = ${longType} AND smallint_type = ${smallIntType} AND
//          decimal_type = ${decimalType} AND numeric_type = ${numericType} AND float_type = ${floatType} AND real_type = ${realType}`;

//     validateResult(executeQueryPostgresqlClient(sqlQuery), 0);
// }

// @test:Config {
//     groups: ["execute", "execute-params"],
//     dependsOn: [deleteNumericTable2]
// }
// function insertIntoStringTable() {
//     int rowId = 3;
//     string charType = "This is a char";    
//     string varcharType = "This is a varchar";
//     string textType = "This is a text";
//     string nameType = "This is a name";    

//     sql:ParameterizedQuery sqlQuery =
//         `INSERT INTO StringTypes (id, char_type, varchar_type, text_type, name_type) VALUES(${rowId},${charType},${varcharType},
//         ${textType}, ${nameType})`;
//     validateResult(executeQueryPostgresqlClient(sqlQuery), 1, rowId);
// }

// @test:Config {
//     groups: ["execute", "execute-params"],
//     dependsOn: [insertIntoStringTable]
// }
// function insertIntoStringTable2() {
//     int rowId = 4;
//     var nilType = ();
//     sql:ParameterizedQuery sqlQuery =
//             `INSERT INTO StringTypes (id, char_type, varchar_type, text_type, name_type) VALUES(${rowId},${nilType},${nilType},
//         ${nilType}, ${nilType})`;
//     validateResult(executeQueryPostgresqlClient(sqlQuery), 1, rowId);
// }

// @test:Config {
//     groups: ["execute", "execute-params"],
//     dependsOn: [insertIntoStringTable2]
// }
// function insertIntoStringTable3() {
//     sql:IntegerValue rowId = new (5);
//     sql:CharValue charType = new ("This is a char");
//     sql:VarcharValue varcharType = new ("This is a varchar");
//     sql:TextValue textType = new ("This is a text");
//     sql:TextValue nameType = new ("This is a name");

//     sql:ParameterizedQuery sqlQuery =
//         `INSERT INTO StringTypes (id, char_type, varchar_type, text_type, name_type) VALUES(${rowId},${charType},${varcharType},
//         ${textType}, ${nameType})`;
//     validateResult(executeQueryPostgresqlClient(sqlQuery), 1, 5);
    
// }
// // Need to recheck
// @test:Config {
//     groups: ["execute", "execute-params"],
//     dependsOn: [insertIntoStringTable3]
// }
// function deleteStringTable() {
//     int rowId = 3;
//     string charType = "This is a char";    
//     string varcharType = "This is a varchar";
//     string textType = "This is a text";
//     string nameType = "This is a name"; 

//     sql:ParameterizedQuery sqlQuery =
//         `DELETE FROM StringTypes where id = ${rowId} AND char_type = ${charType} AND varchar_type = ${varcharType} 
//         AND text_type = ${textType} AND name_type = ${nameType}`; 
//         validateResult(executeQueryPostgresqlClient(sqlQuery), 1, 3);



// }

// @test:Config {
//     groups: ["execute", "execute-params"],
//     dependsOn: [deleteStringTable]
// }
// function deleteStringTable2() {
//     sql:IntegerValue rowId = new (5);
//     sql:CharValue charType = new ("This is a char");
//     sql:VarcharValue varcharType = new ("This is a varchar");
//     sql:TextValue textType = new ("This is a text");
//     sql:TextValue nameType = new ("This is a name");

//     sql:ParameterizedQuery sqlQuery =
//         `DELETE FROM StringTypes where id = ${rowId} AND char_type = ${charType} AND varchar_type = ${varcharType} 
//         AND text_type = ${textType} AND name_type = ${nameType}`; 
//         validateResult(executeQueryPostgresqlClient(sqlQuery), 1, 3);
// }

// @test:Config {
//     groups: ["execute", "execute-params"],
//     dependsOn: [deleteDataTable3]
// }
// function insertIntoComplexTable() {
//     int rowId = 4;
//     record {}|error? value = queryPostgresqlClient("Select * from ComplexTypes where row_id = 1");
//     byte[] byteaType = <byte[]>getUntaintedData(value, "bytea_type");
//     string textType = "very long text";
//     sql:ParameterizedQuery sqlQuery =
//         `INSERT INTO ComplexTypes (row_id, text_type, bytea_type) VALUES (
//         ${rowId}, ${textType}, ${byteaType})`;
//     validateResult(executeQueryPostgresqlClient(sqlQuery), 1, rowId);
// }

// @test:Config {
//     groups: ["execute", "execute-params"],
//     dependsOn: [insertIntoComplexTable]
// }
// function insertIntoComplexTable2() {
//     io:ReadableByteChannel bytea_channel = getByteaColumnChannel();

//     sql:BinaryValue byteaType = new (bytea_channel);
//     int rowId = 5;

//     sql:ParameterizedQuery sqlQuery =
//         `INSERT INTO ComplexTypes (row_id, bytea_type) VALUES (
//             ${rowId}, ${byteaType})`;
//     validateResult(executeQueryPostgresqlClient(sqlQuery), 1, rowId);
// }

// @test:Config {
//     groups: ["execute", "execute-params"],
//     dependsOn: [insertIntoComplexTable2]
// }
// function insertIntoComplexTable3() {
//     int rowId = 6;
//     var nilType = ();
//     sql:ParameterizedQuery sqlQuery =
//             `INSERT INTO ComplexTypes (row_id, bytea_type, text_type) VALUES (
//             ${rowId}, ${nilType}, ${nilType})`;
//     validateResult(executeQueryPostgresqlClient(sqlQuery), 1, rowId);
// }

// @test:Config {
//     groups: ["execute", "execute-params"],
//     dependsOn: [insertIntoComplexTable3]
// }
// function deleteComplexTable() {
//     record {}|error? value = queryPostgresqlClient("Select * from ComplexTypes where row_id = 1");
//     byte[] bytea_type = <byte[]>getUntaintedData(value, "bytea_type");

//     int rowId = 1;
//     sql:ParameterizedQuery sqlQuery =
//             `DELETE FROM ComplexTypes where row_id = ${rowId} AND bytea_type= ${bytea_type}`;
//     validateResult(executeQueryPostgresqlClient(sqlQuery), 1, 6);
// }

// @test:Config {
//     groups: ["execute", "execute-params"],
//     dependsOn: [deleteComplexTable]
// }
// function deleteComplexTable2() {
//     sql:TextValue textType = new ();
//     sql:BinaryValue byteaType = new ();

//     int rowId = 3;
//     sql:ParameterizedQuery sqlQuery =
//             `DELETE FROM ComplexTypes where row_id = ${rowId} AND bytea_type= ${byteaType} AND text_type=${textType}`;
//     validateResult(executeQueryPostgresqlClient(sqlQuery), 0);
// }

// @test:Config {
//     groups: ["execute", "execute-params"],
//     dependsOn: [insertIntoNumericTable3]
// }
// function insertIntoDateTimeTable() {
//     int rowId = 2;
//     sql:DateValue dateType = new("1997-12-17");
//     sql:TimeValue timeType = new("04:05:06");
//     sql:TimeValue timetzType = new("04:05:06");
//     sql:TimestampValue timestampType = new("2004-10-19 10:23:54");
//     sql:TimestampValue timestamptzType = new("1997-12-17 15:37:16.00");

//     sql:ParameterizedQuery sqlQuery =
//         `INSERT INTO DateTimeTypes (row_id, date_type, time_type, timetz_type, timestamp_type, timestamptz_type)
//         VALUES(${rowId}, ${dateType}, ${timeType}, ${timetzType}, ${timestampType}, ${timestamptzType})`;
//     validateResult(executeQueryPostgresqlClient(sqlQuery), 1, rowId);
// }

// @test:Config {
//     groups: ["execute", "execute-params"],
//     dependsOn: [insertIntoDateTimeTable]
// }
// function insertIntoDateTimeTable2() {
//     int rowId = 3;
//     sql:DateValue dateType = new ();
//     sql:TimeValue timeType = new ();
//     sql:TimeValue timetzType = new ();
//     sql:TimestampValue timestampType = new ();
//     sql:TimestampValue timestamptzType = new ();

//     sql:ParameterizedQuery sqlQuery =
//         `INSERT INTO DateTimeTypes (row_id, date_type, time_type, timetz_type, timestamp_type, timestamptz_type)
//         VALUES(${rowId}, ${dateType}, ${timeType}, ${timetzType}, ${timestampType}, ${timestamptzType})`;
//     validateResult(executeQueryPostgresqlClient(sqlQuery), 1, rowId);
// }

// @test:Config {
//     groups: ["execute", "execute-params"],
//     dependsOn: [insertIntoDateTimeTable2]
// }
// function insertIntoDateTimeTable3() {
//     int rowId = 4;
//     var nilType = ();

//     sql:ParameterizedQuery sqlQuery =
//                 `INSERT INTO DateTimeTypes (row_id, date_type, time_type, timetz_type, timestamp_type, timestamptz_type)
//                 VALUES(${rowId}, ${nilType}, ${nilType}, ${nilType}, ${nilType}, ${nilType})`;
//     validateResult(executeQueryPostgresqlClient(sqlQuery), 1, rowId);
// }

// @test:Config {
//     groups: ["execute", "execute-params"],
//     dependsOn: [insertIntoDateTimeTable3]
// }
// function insertIntoDateTimeTable4() {
//     time:Time|error sampleTimestamp = time:createTime(2017, 3, 28, 23, 42, 45,554, "Asia/Colombo");
//     if(sampleTimestamp is time:Time){
//         int rowId = 5;
//         sql:DateValue dateType = new (sampleTimestamp);
//         sql:TimeValue timeType = new (sampleTimestamp);
//         sql:TimeValue timetzType = new (sampleTimestamp);
//         sql:TimestampValue timestampType = new (sampleTimestamp);
//         sql:TimestampValue timestamptzType = new (sampleTimestamp);

//         sql:ParameterizedQuery sqlQuery =
//             `INSERT INTO DateTimeTypes (row_id, date_type, time_type, timetz_type, timestamp_type, timestamptz_type)
//             VALUES(${rowId}, ${dateType}, ${timeType}, ${timetzType}, ${timestampType}, ${timestamptzType})`;
//         validateResult(executeQueryPostgresqlClient(sqlQuery), 1, rowId);
//     } else {
//         test:assertFail("Invalid Time value generated. ");
//     }

// }

function executeQueryPostgresqlClient(sql:ParameterizedQuery sqlQuery, string database = executeParamsDb) returns sql:ExecutionResult {
    Client dbClient = checkpanic new (host, user, password, database, port);
    sql:ExecutionResult result = checkpanic dbClient->execute(sqlQuery);
    checkpanic dbClient.close();
    return result;
}

isolated function validateResult(sql:ExecutionResult result, int rowCount, int? lastId = ()) {
    test:assertExactEquals(result.affectedRowCount, rowCount, "Affected row count is different.");

    if (lastId is ()) {
        test:assertEquals(result.lastInsertId, (), "Last Insert Id is not nil.");
    } else {
        int|string? lastInsertIdVal = result.lastInsertId;
        if (lastInsertIdVal is int) {
            test:assertTrue(lastInsertIdVal >= 1, "Last Insert Id is nil.");
        } else {
            test:assertFail("The last insert id should be an integer.");
        }
    }

}

// function queryPostgresqlClient(@untainted string|sql:ParameterizedQuery sqlQuery, typedesc<record {}>? resultType = ())
// returns @tainted record {}? {
//     Client dbClient = checkpanic new (host, user, password, executeParamsDb, port);
//     stream<record {}, error> streamData = dbClient->query(sqlQuery, resultType);
//     record {|record {} value;|}? data = checkpanic streamData.next();
//     checkpanic streamData.close();
//     record {}? value = data?.value;
//     checkpanic dbClient.close();
//     return value;
// }