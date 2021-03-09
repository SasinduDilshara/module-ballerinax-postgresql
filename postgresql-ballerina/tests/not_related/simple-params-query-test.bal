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

import ballerina/io;
import ballerina/sql;
import ballerina/test;

string simpleParamsDb = "simple_query_params_db";

@test:Config {
    groups: ["query","query-simple-params"]
}
function querySingleIntParam() {
    int rowId = 1;
    sql:ParameterizedQuery sqlQuery = `SELECT * from NumericTypes WHERE row_id = ${rowId}`;
    validateNumericTableResult(simpleQueryPostgresqlClient(sqlQuery));
}

@test:Config {
    groups: ["query","query-simple-params"]
}
function queryDoubleIntParam() {
    int rowId = 1;
    int intType = 123;
    sql:ParameterizedQuery sqlQuery = `SELECT * from NumericTypes WHERE row_id = ${rowId} AND int_type =  ${intType}`;
    validateNumericTableResult(simpleQueryPostgresqlClient(sqlQuery));
}

@test:Config {
    groups: ["query","query-simple-params"]
}
function queryIntAndLongParam() {
    int rowId = 1;
    int longType = 123456;
    sql:ParameterizedQuery sqlQuery = `SELECT * from NumericTypes WHERE row_id = ${rowId} AND bigint_type = ${longType}`;
    validateNumericTableResult(simpleQueryPostgresqlClient(sqlQuery));
}

@test:Config {
    groups: ["query","query-simple-params"]
}
function queryStringParam() {
    string stringType = "This is a varchar1";
    sql:ParameterizedQuery sqlQuery = `SELECT * from CharacterTypes WHERE varchar_type = ${stringType}`;
    validateCharacterTableResult(simpleQueryPostgresqlClient(sqlQuery));
}

@test:Config {
    groups: ["query","query-simple-params"]
}
function queryIntAndStringParam() {
    string stringType = "This is a varchar1";
    int rowId =1;
    sql:ParameterizedQuery sqlQuery = `SELECT * from NumericTypes WHERE varchar_type = ${stringType} AND row_id = ${rowId}`;
    validateNumericTableResult(simpleQueryPostgresqlClient(sqlQuery));
}

@test:Config {
    groups: ["query","query-simple-params"]
}
function queryDoubleParam() {
    float doubleType = 234.567;
    sql:ParameterizedQuery sqlQuery = `SELECT * from NumericTypes WHERE double_type = ${doubleType}`;
    validateNumericTableResult(simpleQueryPostgresqlClient(sqlQuery));
}

@test:Config {
    groups: ["query","query-simple-params"]
}
function queryDecimalParam() {
    decimal decimalValue = 123.456;
    sql:ParameterizedQuery sqlQuery = `SELECT * from NumericTypes WHERE decimal_type = ${decimalValue}`;
    validateNumericTableResult(simpleQueryPostgresqlClient(sqlQuery));
}

@test:Config {
    groups: ["query","query-simple-params"]
}
function queryDecimalAnFloatParam() {
    decimal decimalValue = 123.456;
    float doubleType = 234.567;
    sql:ParameterizedQuery sqlQuery = `SELECT * from NumericTypes WHERE decimal_type = ${decimalValue}
                                                                    and double_type = ${doubleType}`;
    validateNumericTableResult(simpleQueryPostgresqlClient(sqlQuery));
}

@test:Config {
    groups: ["query","query-simple-params"]
}
function queryTypeVarcharStringParam() {
    sql:VarcharValue typeVal = new ("This is a varchar1");
    sql:ParameterizedQuery sqlQuery = `SELECT * from CharacterTypes WHERE string_type = ${typeVal}`;
    validateCharacterTableResult(simpleQueryPostgresqlClient(sqlQuery));
}

@test:Config {
    groups: ["query","query-simple-params"]
}
function queryTypeCharStringParam() {
    sql:CharValue typeVal = new ("This is a char1");
    sql:ParameterizedQuery sqlQuery = `SELECT * from CharacterTypes WHERE string_type = ${typeVal}`;
    validateCharacterTableResult(simpleQueryPostgresqlClient(sqlQuery));
}

@test:Config {
    groups: ["query","query-simple-params"]
}
function queryTypeBooleanParam() {
    sql:BooleanValue typeVal = new (true);
    sql:ParameterizedQuery sqlQuery = `SELECT * from BooleanTypes WHERE boolean_type = ${typeVal}`;
    validateBooleanTableResult(simpleQueryPostgresqlClient(sqlQuery));
}

// @test:Config {
//     groups: ["query","query-simple-params"]
// }
// function queryTypBitIntParam() {
//     sql:BitValue typeVal = new (1);
//     sql:ParameterizedQuery sqlQuery = `SELECT * from NumericTypes WHERE boolean_type = ${typeVal}`;
//     validateNumericTableResult(simpleQueryPostgresqlClient(sqlQuery));
// }

// @test:Config {
//     groups: ["query","query-simple-params"]
// }
// function queryTypBitStringParam() {
//     sql:BitValue typeVal = new (true);
//     sql:ParameterizedQuery sqlQuery = `SELECT * from NumericTypes WHERE boolean_type = ${typeVal}`;
//     validateNumericTableResult(simpleQueryPostgresqlClient(sqlQuery));
// }

// @test:Config {
//     groups: ["query","query-simple-params"]
// }
// function queryTypBitInvalidIntParam() {
//     sql:BitValue typeVal = new (12);
//     sql:ParameterizedQuery sqlQuery = `SELECT * from NumericTypes WHERE boolean_type = ${typeVal}`;
//     record{}|error? returnVal = trap simpleQueryPostgresqlClient(sqlQuery);
//     test:assertTrue(returnVal is error);
//     error dbError = <error> returnVal;
//     test:assertEquals(dbError.message(), "Only 1 or 0 can be passed for BitValue SQL Type, but found :12");
// }

@test:Config {
    groups: ["query","query-simple-params"]
}
function queryTypeIntParam() {
    sql:IntegerValue typeVal = new (123);
    sql:ParameterizedQuery sqlQuery = `SELECT * from NumericTypes WHERE int_type = ${typeVal}`;
    validateNumericTableResult(simpleQueryPostgresqlClient(sqlQuery));
}

@test:Config {
    groups: ["query","query-simple-params"]
}
function queryTypeSmallIntIntParam() {
    sql:SmallIntValue typeVal = new (1);
    sql:ParameterizedQuery sqlQuery = `SELECT * from NumericTypes WHERE smallint_type = ${typeVal}`;
    validateNumericTableResult(simpleQueryPostgresqlClient(sqlQuery));
}

@test:Config {
    groups: ["query","query-simple-params"]
}
function queryTypeBigIntIntParam() {
    sql:BigIntValue typeVal = new (123456);
    sql:ParameterizedQuery sqlQuery = `SELECT * from NumericTypes WHERE bigint_type = ${typeVal}`;
    validateNumericTableResult(simpleQueryPostgresqlClient(sqlQuery));
}

@test:Config {
    groups: ["query","query-simple-params"]
}
function queryTypeDoubleDoubleParam() {
    sql:DoubleValue typeVal = new (234.56);
    sql:DoubleValue typeVal2 = new (234.57);
    sql:ParameterizedQuery sqlQuery = `SELECT * from NumericTypes WHERE double_type between ${typeVal} AND ${typeVal2}`;
    validateNumericTableResult(simpleQueryPostgresqlClient(sqlQuery));
}

@test:Config {
    groups: ["query","query-simple-params"]
}
function queryTypeDoubleIntParam() {
    sql:DoubleValue typeVal = new (234.567);
    sql:ParameterizedQuery sqlQuery = `SELECT * from NumericTypes WHERE double_type = ${typeVal}`;
    record{}? returnData = simpleQueryPostgresqlClient(sqlQuery);

    if (returnData is ()) {
        test:assertFail("Returned data is nil");
    } else {
        test:assertEquals(returnData.length(), 8);
        test:assertEquals(returnData["id"], 2);
        test:assertEquals(returnData["real_type"], 234.567);
    }

}

@test:Config {
    groups: ["query","query-simple-params"]
}
function queryTypeDoubleDecimalParam() {
    float floatVal = 1234.567;
    float floatVal2 = 1234.57;
    sql:DoubleValue typeVal = new (floatVal);
    sql:DoubleValue typeVal2 = new (floatVal2);
    sql:ParameterizedQuery sqlQuery = `SELECT * from NumericTypes WHERE double_type between ${typeVal} AND ${typeVal2}`;
    validateNumericTableResult(simpleQueryPostgresqlClient(sqlQuery));
}

// @test:Config {
//     groups: ["query","query-simple-params"]
// }
// function queryTypeFloatDoubleParam() {
//     sql:DoubleValue typeVal1 = new (1234.567);
//     sql:DoubleValue typeVal2 = new (1234.57);
//     sql:ParameterizedQuery sqlQuery = `SELECT * from NumericTypes WHERE float_type between ${typeVal1} AND ${typeVal2}`;
//     validateNumericTableResult(simpleQueryPostgresqlClient(sqlQuery));
// }

@test:Config {
    groups: ["query","query-simple-params"]
}
function queryTypeRealDoubleParam() {
    sql:RealValue typeVal = new (1234.567);
    sql:ParameterizedQuery sqlQuery = `SELECT * from NumericTypes WHERE real_type = ${typeVal}`;
    validateNumericTableResult(simpleQueryPostgresqlClient(sqlQuery));
}

@test:Config {
    groups: ["query","query-simple-params"]
}
function queryTypeNumericDoubleParam() {
    sql:NumericValue typeVal = new (1234.567);
    sql:ParameterizedQuery sqlQuery = `SELECT * from NumericTypes WHERE numeric_type = ${typeVal}`;
    validateNumericTableResult(simpleQueryPostgresqlClient(sqlQuery));
}

@test:Config {
    groups: ["query","query-simple-params"]
}
function queryTypeNumericIntParam() {
    sql:NumericValue typeVal = new (1234);
    sql:ParameterizedQuery sqlQuery = `SELECT * from NumericTypes WHERE numeric_type = ${typeVal}`;
    record{}? returnData = simpleQueryPostgresqlClient(sqlQuery);

    if (returnData is ()) {
        test:assertFail("Returned data is nil");
    } else {
        test:assertEquals(returnData.length(), 8);
        test:assertEquals(returnData["id"], 2);
        test:assertEquals(returnData["real_type"], 1234.0);
    }
}

@test:Config {
    groups: ["query","query-simple-params"]
}
function queryTypeNumericDecimalParam() {
    decimal decimalVal = 1234.567;
    sql:NumericValue typeVal = new (decimalVal);
    sql:ParameterizedQuery sqlQuery = `SELECT * from NumericTypes WHERE numeric_type = ${typeVal}`;
    validateNumericTableResult(simpleQueryPostgresqlClient(sqlQuery));
}

// @test:Config {
//     groups: ["query","query-simple-params"]
// }
// function queryTypeDecimalDoubleParam() {
//     sql:DecimalValue typeVal = new (1234.567);
//     sql:ParameterizedQuery sqlQuery = `SELECT * from NumericTypes WHERE decimal_type = ${typeVal}`;
//     validateNumericTableResult(simpleQueryPostgresqlClient(sqlQuery));
// }

// @test:Config {
//     groups: ["query","query-simple-params"]
// }
// function queryTypeDecimalDecimalParam() {
//     decimal decimalVal = 1234.567;
//     sql:DecimalValue typeVal = new (decimalVal);
//     sql:ParameterizedQuery sqlQuery = `SELECT * from NumericTypes WHERE decimal_type = ${typeVal}`;
//     validateNumericTableResult(simpleQueryPostgresqlClient(sqlQuery));
// }

// @test:Config {
//     groups: ["query","query-simple-params"]
// }
// function queryTypeBinaryReadableByteChannelParam() {
//     io:ReadableByteChannel? byteaChannel = getByteaColumnChannel();
//     sql:BinaryValue typeVal = new (byteaChannel);
//     sql:ParameterizedQuery sqlQuery = `SELECT * from ComplexTypes WHERE bytea_type = ${typeVal}`;
//     validateComplexTableResult(simpleQueryPostgresqlClient(sqlQuery));
// }

@test:Config {
    groups: ["query","query-simple-params"]
}
function queryTypeByteaParam() {
    record {}|error? value = simpleQueryPostgresqlClient("Select * from ComplexTypes where row_id = 1");
    byte[] binaryData = <byte[]>getUntaintedData(value, "bytea_type");
    sql:BinaryValue typeVal = new (binaryData);
    sql:ParameterizedQuery sqlQuery = `SELECT * from ComplexTypes WHERE bytea_type = ${typeVal}`;
    validateComplexTableResult(simpleQueryPostgresqlClient(sqlQuery));
}

@test:Config {
    groups: ["query","query-simple-params"]
}
function queryTypeTextStringParam() {
    sql:TextValue typeVal = new ("very long text");
    sql:ParameterizedQuery sqlQuery = `SELECT * from ComplexTypes WHERE text_type = ${typeVal}`;
    validateComplexTableResult(simpleQueryPostgresqlClient(sqlQuery));
}

// @test:Config {
//     groups: ["query","query-simple-params"]
// }
// function queryDateStringParam() {
//     //Setting this as var char since the test database seems not working with date type.
//     sql:VarcharValue typeVal = new ("2017-02-03");
//     sql:ParameterizedQuery sqlQuery = `SELECT * from DateTimeTypes WHERE date_type = ${typeVal}`;
//     validateDateTimeTypesTableResult(simpleQueryPostgresqlClient(sqlQuery));
// }

@test:Config {
    groups: ["query","query-simple-params"]
}
function queryDateString2Param() {
    sql:DateValue typeVal = new ("2017-02-03");
    sql:ParameterizedQuery sqlQuery = `SELECT * from DateTimeTypes WHERE date_type = ${typeVal}`;
    validateDateTimeTypesTableResult(simpleQueryPostgresqlClient(sqlQuery));
}

@test:Config {
    groups: ["query","query-simple-params"]
}
function queryTimeStringParam() {
    sql:TimeValue typeVal = new ("11:35:45");
    sql:ParameterizedQuery sqlQuery = `SELECT * from DateTimeTypes WHERE time_type = ${typeVal}`;
    validateDateTimeTypesTableResult(simpleQueryPostgresqlClient(sqlQuery));
}

@test:Config {
    groups: ["query","query-simple-params"]
}
function queryTimeStringInvalidParam() {
    sql:TimeValue typeVal = new ("11-35-45");
    sql:ParameterizedQuery sqlQuery = `SELECT * from DateTimeTypes WHERE time_type = ${typeVal}`;
    record{}|error? returnVal = trap simpleQueryPostgresqlClient(sqlQuery);
    test:assertTrue(returnVal is error);
    error dbError = <error> returnVal;
    test:assertEquals(dbError.message(), 
        "Error while executing SQL query: SELECT * from DateTimeTypes WHERE time_type =  ? . java.lang.IllegalArgumentException");
}

@test:Config {
    groups: ["query","query-simple-params"]
}
function queryTimestampStringParam() {
    sql:TimestampValue typeVal = new ("2017-02-03 11:53:00");
    sql:ParameterizedQuery sqlQuery = `SELECT * from DateTimeTypes WHERE timestamp_type = ${typeVal}`;
    validateDateTimeTypesTableResult(simpleQueryPostgresqlClient(sqlQuery));
}

@test:Config {
    groups: ["query","query-simple-params"]
}
function queryTimestampStringInvalidParam() {
    sql:TimestampValue typeVal = new ("2017/02/03 11:53:00");
    sql:ParameterizedQuery sqlQuery = `SELECT * from DateTimeTypes WHERE timestamp_type = ${typeVal}`;
    record{}|error? returnVal = trap simpleQueryPostgresqlClient(sqlQuery);
    test:assertTrue(returnVal is error);
    error dbError = <error> returnVal;
    test:assertEquals(dbError.message(), 
        "Error while executing SQL query: SELECT * from DateTimeTypes WHERE timestamp_type =  ? . Timestamp format must be yyyy-mm-dd hh:mm:ss[.fffffffff]");
}



// isolated function validateNumericTableResult(record{}? returnData) {
//     decimal decimalVal = 23.45;
//     if (returnData is ()) {
//         test:assertFail("Empty row returned.");
//     } else {
//         test:assertEquals(returnData["row_id"], 1);
//         test:assertEquals(returnData["int_type"], 1);
//         test:assertEquals(returnData["long_type"], 9223372036854774807);
//         test:assertEquals(returnData["double_type"], <float> 2139095039);
//         test:assertEquals(returnData["boolean_type"], true);
//         test:assertEquals(returnData["decimal_type"], decimalVal);
//         test:assertEquals(returnData["string_type"], "Hello");
//         test:assertTrue(returnData["numeric_type"] is decimal);   
//     } 
// }

isolated function validateNumericTableResult(record{}? returnData) {
    if (returnData is ()) {
        test:assertFail("Empty row returned.");
    } else {
        decimal decimalVal = 123.456;
        test:assertEquals(returnData["row_id"], 1);
        test:assertEquals(returnData["smallint_type"], 1);
        test:assertEquals(returnData["int_type"], 123);
        test:assertEquals(returnData["bigint_type"], 123456);
        test:assertEquals(returnData["decimal_type"], decimalVal);
        test:assertEquals(returnData["numeric_type"], decimalVal);
        test:assertTrue(returnData["real_type"] is float);
        test:assertTrue(returnData["double_type"] is float);
        test:assertEquals(returnData["smallserial_type"], 1);
        test:assertEquals(returnData["serial_type"], 123);
        test:assertEquals(returnData["bigserial_type"], 123456);  
    }
}

isolated function validateCharacterTableResult(record{}? returnData) {
    if (returnData is ()) {
        test:assertFail("Empty row returned.");
    } else {
        test:assertEquals(returnData["row_id"], 1);
        test:assertEquals(returnData["char_type"], "This is a char1");
        test:assertEquals(returnData["varchar_type"], "This is a varchar1");
        test:assertEquals(returnData["text_type"], "This is a text1");   
        test:assertEquals(returnData["name_type"], "This is a name1");  
    }
}

isolated function validateBooleanTableResult(record{}? returnData) {
    if (returnData is ()) {
        test:assertFail("Empty row returned.");
    } else {
        test:assertEquals(returnData["row_id"], 1);
        test:assertEquals(returnData["boolean_type"], true);  
    }
}

// isolated function validateComplexTableResult(record{}? returnData) {
//     if (returnData is ()) {
//         test:assertFail("Returned data is nil");
//     } else {
//         test:assertEquals(returnData.length(), 3);
//         test:assertEquals(returnData["row_id"], 1);
//         test:assertEquals(returnData["text_type"], "very long text");
//     }
// }

isolated function validateDateTimeTypesTableResult(record{}? returnData) {
    if (returnData is ()) {
        test:assertFail("Returned data is nil");
    } else {
        io:println("\nreturn data\n",returnData,"\nreturn data");
        test:assertEquals(returnData.length(), 6);
        test:assertEquals(returnData["row_id"], 1);
        test:assertTrue(returnData["date_type"].toString().startsWith("2017-02-03"));
        // test:assertTrue(returnData["time_type"].toString().startsWith("11:35:45"));
        // test:assertTrue(returnData["timetz_type"].toString().startsWith("11:35:45+3"));
        // test:assertTrue(returnData["timestamp_type"].toString().startsWith("2017-02-03 11:53:00"));
        // test:assertTrue(returnData["timestamptz_type"].toString().startsWith("2017-02-03 11:53:00+2"));
        io:println(returnData);
        test:assertEquals(returnData["row_id"], 1);
        test:assertEquals(returnData["time_type"], "09:35:06.000+05:30");
        test:assertEquals(returnData["timetz_type"], "13:35:06.000+05:30");
        test:assertEquals(returnData["timestamp_type"], "1999-01-08T10:05:06.000+06:00");
        test:assertEquals(returnData["timestamptz_type"], "2004-10-19T14:23:54.000+06:00");
        test:assertEquals(returnData["date_type"], "1999-01-08+06:00");
        test:assertEquals(returnData["interval_type"], "1 year 2 mons 3 days 04:05:06");
    }
}

// isolated function validateEnumTable(record{}? returnData) {
//     if (returnData is ()) {
//         test:assertFail("Returned data is nil");
//     } else {
//         test:assertEquals(returnData.length(), 2);
//         test:assertEquals(returnData["id"], 1);
//         test:assertEquals(returnData["enum_type"].toString(), "doctor");
//     }
// }

// isolated function validateGeoTable(record{}? returnData) {
//     if (returnData is ()) {
//         test:assertFail("Returned data is nil");
//     } else {
//         test:assertEquals(returnData.length(), 2);
//         test:assertEquals(returnData["id"], 1);
//         test:assertEquals(returnData["geomText"].toString(), "POINT(7 52)");
//     }
// }

// isolated function validateJsonTable(record{}? returnData) {
//     if (returnData is ()) {
//         test:assertFail("Returned data is nil");
//     } else {
//         test:assertEquals(returnData.length(), 2);
//         test:assertEquals(returnData["id"], 1);
//         test:assertEquals(returnData["json_type"], "{\"id\": 100, \"name\": \"Joe\", \"groups\": \"[2,5]\"}");
//     }
// }


