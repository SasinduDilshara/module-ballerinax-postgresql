// Copyright (c) 2020, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied. See the License for the
// specific language governing permissions and limitations
// under the License.

// import ballerina/sql;
// import ballerina/regex;
import ballerina/test;
// import ballerina/time;

string complexQueryDb = "query_complex_params_db";

type SelectTestAlias record {
    int int_type;
    int long_type;
    float numeric_type;
    string double_precision_type;
    boolean boolean_type;
    string string_type;
};

type ResultSetTestAlias record {
    int INT_TYPE;
    int LONG_TYPE;
    float DOUBLE_PRECISION_TYPE;
    string NUMERIC_TYPE;
    boolean BOOLEAN_TYPE;
    string STRING_TYPE;
    int DT2INT_TYPE;
};

type ResultDates record {
    string DATE_TYPE;
    string TIME_TYPE;
    string TIMESTAMP_TYPE;
    string DATETIME_TYPE;
};

// @test:Config {
//     groups: ["query","query-complex-params"]
// }
// function testGetPrimitiveTypes() {
//     Client dbClient = checkpanic new (host, user, password, complexQueryDb, port);
//     stream<record{}, error> streamData = dbClient->query(
//         "SELECT INT_TYPE, LONG_TYPE, DOUBLE_PRECISION_TYPE, NUMERIC_TYPE"
//         + " BOOLEAN_TYPE, STRING_TYPE from DataTable WHERE ROW_ID = 1");
//     record {|record {} value;|}? data = checkpanic streamData.next();
//     checkpanic streamData.close();
//     record {}? value = data?.value;
//     checkpanic dbClient.close();

//     SelectTestAlias expectedData = {
//         int_type: 1,
//         long_type: 9223372036854774807,
//         numeric_type: 123.34,
//         double_precision_type: "2139095039",
//         boolean_type: true,
//         string_type: "Hello"
//     };
//     test:assertEquals(value, expectedData, "Expected data did not match.");
    
// }

// @test:Config {
//     groups: ["query","query-complex-params"]
// }
// function testToJson() {
//     Client dbClient = checkpanic new (host, user, password, complexQueryDb, port);
//     stream<record{}, error> streamData = dbClient->query(
//         "SELECT INT_TYPE, LONG_TYPE, NUMERIC_TYPE, DOUBLE_PRECISION_TYPE,"
//         + "BOOLEAN_TYPE, STRING_TYPE from DataTable WHERE ROW_ID = 1");
//     record {|record {} value;|}? data = checkpanic streamData.next();
//     checkpanic streamData.close();
//     record {}? value = data?.value;
//     json retVal = checkpanic value.cloneWithType(json);

//     SelectTestAlias expectedData = {
//         int_type: 1,
//         long_type: 9223372036854774807,
//         numeric_type: 123.34,
//         double_precision_type: "13.34",
//         boolean_type: true,
//         string_type: "Hello"
//     };
//     test:assertEquals(retVal, expectedData.cloneWithType(json), "Expected JSON did not match.");

//     checkpanic dbClient.close();
// }

// @test:Config {
//     groups: ["query","query-complex-params"]
// }
// function testToJsonComplexTypes() {
//     Client dbClient = checkpanic new (host, user, password, complexQueryDb, port);
//     stream<record{}, error> streamData = dbClient->query("SELECT BYTEA_TYPE as byteaType from" +
//         " ComplexTypes where ROW_ID = 1");
//     record {|record {} value;|}? data = checkpanic streamData.next();
//     checkpanic streamData.close();
//     record {byte[] byteaType;}? value = <record {byte[] byteaType;}>data?.value;
//     checkpanic dbClient.close();

//     record{byte[] byteaType;}? complexStringType = {
//         byteaType: "77736F322062616C6C6572696E6120626C6F6220746573742E".toBytes()
//     };
//     test:assertEquals(value, complexStringType, "Expected record did not match."); 
// }

@test:Config {
    groups: ["query","query-complex-params"]
}
function testComplexTypesNil() {
    Client dbClient = checkpanic new (host, user, password, complexQueryDb, port);
    stream<record{}, error> streamData = dbClient->query("SELECT BYTEA_TYPE, TEXT_TYPE from " +
        " ComplexTypes where ROW_ID = 2");
    record {|record {} value;|}? data = checkpanic streamData.next();
    checkpanic streamData.close();
    record {}? value = data?.value;
    checkpanic dbClient.close();

    var complexStringType = {
        BYTEA_TYPE: (),
        TEXT_TYPE: ()
    };
    test:assertEquals(value, complexStringType, "Expected record did not match."); 
}

// @test:Config {
//     groups: ["query","query-complex-params"]
// }
// function testDateTime() {
//     Client dbClient = checkpanic new (host, user, password, complexQueryDb, port);
//     string insertQuery = string `Insert into DateTimeTypes (ROW_ID, DATE_TYPE, TIME_TYPE, TIMESTAMP_TYPE, DATETIME_TYPE)
//      values (1,'2017-05-23','14:15:23','2017-01-25 16:33:55','2017-01-25 16:33:55')`;
//     sql:ExecutionResult? result = checkpanic dbClient->execute(insertQuery);
//     stream<record{}, error> queryResult = dbClient->query("SELECT DATE_TYPE, TIME_TYPE, TIMESTAMP_TYPE, DATETIME_TYPE"
//        + " from DateTimeTypes where ROW_ID = 1", ResultDates);
//     record{| record{} value; |}? data =  checkpanic queryResult.next();
//     record{}? value = data?.value;
//     checkpanic dbClient.close();

//     time:Time now = time:currentTime();
//     time:TimeZone systemTimeZone = now.zone;

//     time:Time dateTime = checkpanic time:createTime(2017, 5, 23, 0, 0, 0, 0, systemTimeZone.id);
//     string dateType = checkpanic time:format(dateTime, "yyyy-MM-ddXXX");
//     dateType = regex:replaceAll(dateType, "Z", "+00:00");

//     time:Time timeType = checkpanic time:createTime(2017, 5, 23, 14, 15, 23, 0, "UTC");
//     time:Time newTime = checkpanic time:toTimeZone(timeType, systemTimeZone.id);
//     string timeTypeString = checkpanic time:format(newTime, "HH:mm:ss.SSSXXX");
//     timeTypeString = regex:replaceAll(timeTypeString, "Z", "+00:00");

//     time:Time insertedTimeType = checkpanic time:createTime(2017, 1, 25, 16, 33, 55, 0, "UTC");
//     time:Time insertedOffsetTime = checkpanic time:toTimeZone(insertedTimeType, systemTimeZone.id);
//     string insertedTimeString = checkpanic time:format(insertedOffsetTime, "yyyy-MM-dd'T'HH:mm:ss.SSSXXX");
//     insertedTimeString = regex:replaceAll(insertedTimeString, "Z", "+00:00");

//     ResultDates expected = {
//         DATE_TYPE: dateType,
//         TIME_TYPE: timeTypeString,
//         TIMESTAMP_TYPE: insertedTimeString,
//         DATETIME_TYPE: insertedTimeString
//     };
//     test:assertEquals(value, expected, "Expected record did not match."); 
// }

// @test:Config {
//     groups: ["query","query-complex-params"]
// }
// function testColumnAlias() {
//     Client dbClient = checkpanic new (host, user, password, complexQueryDb, port);
//     stream<record{}, error> queryResult = dbClient->query("SELECT dt1.INT_TYPE, dt1.LONG_TYPE, FORMAT(dt1.FLOAT_TYPE, 2) as FLOAT_TYPE," +
//            "dt1.DOUBLE_TYPE,dt1.BOOLEAN_TYPE, dt1.STRING_TYPE,dt2.INT_TYPE as dt2INT_TYPE from DataTable dt1 " +
//            "left join DataTableRep dt2 on dt1.ROW_ID = dt2.ROW_ID WHERE dt1.ROW_ID = 1;", ResultSetTestAlias);

//     ResultSetTestAlias expectedData = {
//         INT_TYPE: 1,
//         LONG_TYPE: 9223372036854774807,
//         FLOAT_TYPE: "123.34",
//         DOUBLE_TYPE: 2139095039,
//         BOOLEAN_TYPE: true,
//         STRING_TYPE: "Hello",
//         DT2INT_TYPE: 100
//     };
//     int counter = 0; 
//     error? e = queryResult.forEach(function (record{} value) {
//         if (value is ResultSetTestAlias) {
//             test:assertEquals(value, expectedData, "Expected record did not match."); 
//             counter = counter + 1;
//         } else{
//             test:assertFail("Expected data type is ResultSetTestAlias");
//         }
//     });
//     if(e is error) {
//         test:assertFail("Query failed");
//     }
//     test:assertEquals(counter, 1, "Expected only one data row."); 
//     checkpanic dbClient.close();
// }
