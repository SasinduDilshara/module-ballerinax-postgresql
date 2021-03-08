import ballerina/sql;
import ballerina/test;
import ballerina/io;
import ballerina/time;

public function cc(){
    io:println(1);
    time:Time|error timeValue = time:createTime(2017, 3, 28, 23, 42, 45,554, "Asia/Colombo");

}

// public type NumericRecord record {
//     int row_id;
//     int smallint_type;
//     int int_type;
//     int bigint_type;
//     decimal decimal_type;
//     decimal numeric_type;
//     float real_type;
//     float double_type;
//     int smallserial_type;
//     int serial_type;
//     int bigserial_type;
// };

// @test:Config {
//     groups: ["datatypes"]
// }
// function testInsertIntoNumericDataTable() {
//     int rowId = 3;
//     sql:SmallIntValue smallintType = new(1);
//     sql:IntegerValue intType = new(1);
//     sql:BigIntValue bigintType = new(123456);
//     sql:DecimalValue decimalType = new(1234.567);
//     sql:NumericValue numericType = new(1234.567);
//     sql:RealValue realType = new(123.456);
//     sql:DoubleValue doubleType = new(123.456);
//     int smallserialType = 1;
//     int serialType = 123;
//     int bigserialType = 12345;

//     sql:ParameterizedQuery sqlQuery =
//       `
//     INSERT INTO NumericTypes (row_id, smallint_type, int_type, bigint_type, decimal_type, 
//     numeric_type, real_type, double_type, smallserial_type, serial_type, bigserial_type) 
//             VALUES(${rowId}, ${smallintType}, ${intType}, ${bigintType}, ${decimalType}, ${numericType},
//             ${realType}, ${doubleType}, ${smallserialType}, ${serialType}, ${bigserialType})
//     `;
//     validateResult(executeQueryPostgresqlClient(sqlQuery, "numeric_db"), 1, rowId);
// }

// @test:Config {
//     groups: ["datatypes"],
//     dependsOn: [testInsertIntoNumericDataTable]
// }
// function testInsertIntoNumericDataTable2() {
//     int rowId = 4;
//     sql:SmallIntValue smallintType = new ();
//     sql:IntegerValue intType = new();
//     sql:BigIntValue bigintType = new();
//     sql:DecimalValue decimalType = new();
//     sql:NumericValue numericType = new();
//     sql:RealValue realType = new();
//     sql:DoubleValue doubleType = new();

//     sql:ParameterizedQuery sqlQuery =
//       `
//     INSERT INTO NumericTypes2 (row_id, smallint_type, int_type, bigint_type, decimal_type, 
//     numeric_type, real_type, double_type) 
//             VALUES(${rowId}, ${smallintType}, ${intType}, ${bigintType}, ${decimalType}, ${numericType},
//             ${realType}, ${doubleType})
//     `;
//     validateResult(executeQueryPostgresqlClient(sqlQuery, "numeric_db"), 1, rowId);
// }

// @test:Config {
//     groups: ["datatypes"],
//     dependsOn: [testInsertIntoNumericDataTable2]
// }
// function testInsertIntoNumericDataTable3() {
//     int rowId = 5;
//     int smallintType = 1;
//     int intType = 1;
//     int bigintType = 123456;
//     decimal decimalType = 1234.567;
//     decimal numericType = 1234.567;
//     float realType = 123.456;
//     float doubleType = 123.456;
//     int smallserialType = 1;
//     int serialType = 123;
//     int bigserialType = 12345;

//     sql:ParameterizedQuery sqlQuery =
//       `
//     INSERT INTO NumericTypes (row_id, smallint_type, int_type, bigint_type, decimal_type, 
//     numeric_type, real_type, double_type, smallserial_type, serial_type, bigserial_type) 
//             VALUES(${rowId}, ${smallintType}, ${intType}, ${bigintType}, ${decimalType}, ${numericType},
//             ${realType}, ${doubleType}, ${smallserialType}, ${serialType}, ${bigserialType})
//     `;
//     validateResult(executeQueryPostgresqlClient(sqlQuery, "numeric_db"), 1, rowId);
// }

// @test:Config {
//     groups: ["datatypes"],
//     dependsOn: [testInsertIntoNumericDataTable2]
// }
// function testSelectFromNumericDataTable() {
//     int rowId = 3;
    
//     sql:ParameterizedQuery sqlQuery = `select * from Numerictypes where row_id = ${rowId}`;

//     _ = validateNumericTableResult(simpleQueryPostgresqlClient(sqlQuery, NumericRecord, database = "numeric_db"));
// }

// public function validateNumericTableResult(record{}? returnData) {
//     if (returnData is ()) {
//         test:assertFail("Empty row returned.");
//     } else {
//         decimal decimalVal = 1234.567;
//         test:assertEquals(returnData["row_id"], 3);
//         test:assertEquals(returnData["smallint_type"], 1);
//         test:assertEquals(returnData["int_type"], 1);
//         test:assertEquals(returnData["bigint_type"], 123456);
//         test:assertEquals(returnData["decimal_type"], decimalVal);
//         test:assertEquals(returnData["numeric_type"], decimalVal);
//         test:assertTrue(returnData["real_type"] is float);
//         test:assertTrue(returnData["double_type"] is float);
//         test:assertEquals(returnData["smallserial_type"], 1);
//         test:assertEquals(returnData["serial_type"], 123);
//         test:assertEquals(returnData["bigserial_type"], 12345);
//     } 
// }

// //-------------------------------------------------------------------------------------------------------------------------------


// public type CharacterRecord record {
//     int row_id;
//     string char_type;
//     string varchar_type;
//     string text_type;
//     string name_type;
// };

// @test:Config {
//     groups: ["datatypes"]
// }
// function testInsertIntoCharacterDataTable() {
//     int rowId = 3;
//     string charValue = "This is a char3";
//     string varcharValue = "This is a varchar3";
//     string textValue = "This is a text3";
//     string nameValue = "This is a name3";

//     sql:ParameterizedQuery sqlQuery =
//       `
//     INSERT INTO CharacterTypes (row_id, char_type, varchar_type, text_type, name_type)
//             VALUES(${rowId}, ${charValue}, ${varcharValue}, ${textValue}, ${nameValue})
//     `;
//     validateResult(executeQueryPostgresqlClient(sqlQuery, "character_db"), 1, rowId);
// }

// @test:Config {
//     groups: ["datatypes"],
//     dependsOn: [testInsertIntoCharacterDataTable]
// }
// function testInsertIntoCharacterDataTable2() {
//     int rowId = 4;
//     sql:CharValue charValue = new ("This is a char3");
//     sql:VarcharValue varcharValue = new ("This is a varchar3");
//     sql:TextValue textValue = new ("This is a text3");
//     string nameValue = "This is a name3";

//     sql:ParameterizedQuery sqlQuery =
//       `
//     INSERT INTO CharacterTypes (row_id, char_type, varchar_type, text_type, name_type)
//             VALUES(${rowId}, ${charValue}, ${varcharValue}, ${textValue}, ${nameValue})
//     `;
//     validateResult(executeQueryPostgresqlClient(sqlQuery, "character_db"), 1, rowId);
// }

// @test:Config {
//     groups: ["datatypes"],
//     dependsOn: [testInsertIntoCharacterDataTable2]
// }
// function testInsertIntoCharacterDataTable3() {
//     int rowId = 5;
//     sql:CharValue charValue = new ();
//     sql:VarcharValue varcharValue = new ();
//     sql:TextValue textValue = new ();
//     string? nameValue = ();

//     sql:ParameterizedQuery sqlQuery =
//       `
//     INSERT INTO CharacterTypes (row_id, char_type, varchar_type, text_type, name_type)
//             VALUES(${rowId}, ${charValue}, ${varcharValue}, ${textValue}, ${nameValue})
//     `;
//     validateResult(executeQueryPostgresqlClient(sqlQuery, "character_db"), 1, rowId);
// }

// @test:Config {
//     groups: ["datatypes"],
//     dependsOn: [testInsertIntoCharacterDataTable2]
// }
// function testSelectFromCharacterDataTable() {
//     int rowId = 4;
    
//     sql:ParameterizedQuery sqlQuery = `select * from charactertypes where row_id = ${rowId}`;

//     _ = validateCharacterTableResult(simpleQueryPostgresqlClient(sqlQuery, CharacterRecord, database = "character_db"));
// }

// public function validateCharacterTableResult(record{}? returnData) {
//     if (returnData is ()) {
//         test:assertFail("Empty row returned.");
//     } else {
//         test:assertEquals(returnData["row_id"], 4);
//         test:assertEquals(returnData["char_type"], "This is a char3");
//         test:assertEquals(returnData["varchar_type"], "This is a varchar3");
//         test:assertEquals(returnData["text_type"], "This is a text3");   
//         test:assertEquals(returnData["name_type"], "This is a name3");
//     } 
// }

// //======================================================================================================================

// public type BooleanRecord record {
//   int row_id;
//   boolean boolean_type;
// };

// @test:Config {
//     groups: ["datatypes"]
// }
// function testInsertIntoBooleanDataTable() {
//     int rowId = 3;
//     boolean booleanType = true;

//     sql:ParameterizedQuery sqlQuery =
//       `
//     INSERT INTO BooleanTypes (row_id, boolean_type)
//             VALUES(${rowId}, ${booleanType})
//     `;
//     validateResult(executeQueryPostgresqlClient(sqlQuery, "boolean_db"), 1, rowId);
// }

// @test:Config {
//     groups: ["datatypes"],
//     dependsOn: [testInsertIntoBooleanDataTable]
// }
// function testInsertIntoBooleanDataTable2() {
//     int rowId = 4;
//     boolean? booleanType = ();

//     sql:ParameterizedQuery sqlQuery =
//       `
//     INSERT INTO BooleanTypes (row_id, boolean_type)
//             VALUES(${rowId}, ${booleanType})
//     `;
//     validateResult(executeQueryPostgresqlClient(sqlQuery, "boolean_db"), 1, rowId);
// }

// @test:Config {
//     groups: ["datatypes"],
//     dependsOn: [testInsertIntoBooleanDataTable2]
// }
// function testSelectFromBooleanDataTable() {
//     int rowId = 3;
    
//     sql:ParameterizedQuery sqlQuery = `select * from booleantypes where row_id = ${rowId}`;

//     _ = validateBooleanTableResult(simpleQueryPostgresqlClient(sqlQuery, BooleanRecord, database = "boolean_db"));
// }

// public function validateBooleanTableResult(record{}? returnData) {
//     if (returnData is ()) {
//         test:assertFail("Empty row returned.");
//     } else {
//         test:assertEquals(returnData["row_id"], 3);
//         test:assertEquals(returnData["boolean_type"], true);
//     } 
// }

// //-------------------------------------------------------------------------------------------------------------------------------


// public type NetworkRecord record {
    
//     int row_id;
//     string inet_type;
//     string cidr_type;
//     string macaddr_type;
//     string macaddr8_type;
// };

// // public type NetworkRecord record{
// //     int row_id;
// //     InetValue inet_type;
// //     CidrValue cidr_type;
// //     MacaddrValue macaddr_type;
// //     Macaddr8Value macaddr8_type;
// // };

// @test:Config {
//     groups: ["datatypes"]
// }
// function testInsertIntoNetworkDataTable() {
//     int rowId = 4;
//     InetValue inetValue = new ("192.168.0.1/24");
//     CidrValue cidrValue = new ("::ffff:1.2.3.0/120");
//     MacaddrValue macaddrValue = new ("08:00:2b:01:02:03");
//     Macaddr8Value macaddr8Value = new ("08-00-2b-01-02-03-04-00");

//     sql:ParameterizedQuery sqlQuery =
//       `
//     INSERT INTO NetworkTypes (row_id, inet_type, cidr_type, macaddr_type, macaddr8_type)
//             VALUES(${rowId}, ${inetValue}, ${cidrValue}, ${macaddrValue}, ${macaddr8Value})
//     `;
//     validateResult(executeQueryPostgresqlClient(sqlQuery, "network_db"), 1, rowId);
// }

// @test:Config {
//     groups: ["datatypes"],
//     dependsOn: [testInsertIntoNetworkDataTable]
// }
// function testInsertIntoNetworkDataTable2() {
//     int rowId = 5;
//     InetValue inetValue = new ();
//     CidrValue cidrValue = new ();
//     MacaddrValue macaddrValue = new ();
//     Macaddr8Value macaddr8Value = new ();

//     sql:ParameterizedQuery sqlQuery =
//       `
//     INSERT INTO NetworkTypes (row_id, inet_type, cidr_type, macaddr_type, macaddr8_type)
//             VALUES(${rowId}, ${inetValue}, ${cidrValue}, ${macaddrValue}, ${macaddr8Value})
//     `;
//     validateResult(executeQueryPostgresqlClient(sqlQuery, "network_db"), 1, rowId);
// }

// @test:Config {
//     groups: ["datatypes"],
//     dependsOn: [testInsertIntoNetworkDataTable2]
// }
// function testSelectFromNetworkDataTable() {
//     int rowId = 4;
//     InetValue inetValue = new ("192.168.0.1/24");
//     CidrValue cidrValue = new ("::ffff:1.2.3.0/120");
//     MacaddrValue macaddrValue = new ("08:00:2b:01:02:03");
//     Macaddr8Value macaddr8Value = new ("08-00-2b-01-02-03-04-00");
    
//     sql:ParameterizedQuery sqlQuery = `select * from networktypes where row_id = ${rowId}`;

//     _ = validateNetworkTableResult(simpleQueryPostgresqlClient(sqlQuery, NetworkRecord, database = "network_db"));
// }

// public function validateNetworkTableResult(record{}? returnData) {
//     if (returnData is ()) {
//         test:assertFail("Empty row returned.");
//     } else {
//         test:assertEquals(returnData["row_id"], 4);
//         test:assertEquals(returnData["inet_type"], "192.168.0.1/24");
//         test:assertEquals(returnData["cidr_type"], "::ffff:1.2.3.0/120");
//         test:assertEquals(returnData["macaddr_type"], "08:00:2b:01:02:03");   
//         test:assertEquals(returnData["macaddr8_type"], "08:00:2b:01:02:03:04:00");
//     } 
// }

// //------------------------------------------------------------------------------------------------------------------

// // public type GeometricRecord record {
// //     int row_id;
// //     PointValue point_type;
// //     LineValue line_type;
// //     LsegValue lseg_type;
// //     BoxValue box_type;
// //     CircleValue circle_type;
// //     string? path_type;
// //     string? polygon_type;
// // };

// public type GeometricRecord record {
//     int row_id;
//     string point_type;
//     string line_type;
//     string lseg_type;
//     string box_type;
//     string circle_type;
//     string? path_type;
//     string? polygon_type;
// };

// @test:Config {
//     groups: ["datatypes"]
// }
// function testInsertIntoGeometricDataTable() {
//     int rowId = 3;
//     PointValue pointType = new ("(1,2)");
//     LineValue lineType = new ("{1,2,3}");
//     LsegValue lsegType = new ("(1,1),(2,2)");
//     BoxValue boxType = new ("(1,1),(2,2)");
//     // PathValue pathType = new ("[(1,1),(2,2)]");
//     // PolygonValue polygonType = new ("[(1,1),(2,2)]");
//     CircleValue circleType = new ("<1,1,1>");

//     sql:ParameterizedQuery sqlQuery =
//       `
//     INSERT INTO GeometricTypes (row_id, point_type, line_type, lseg_type, box_type,circle_type)
//             VALUES(${rowId}, ${pointType}, ${lineType}, ${lsegType}, ${boxType},${circleType})
//     `;
//     validateResult(executeQueryPostgresqlClient(sqlQuery, "geometric_db"), 1, rowId);
// }

// @test:Config {
//     groups: ["datatypes"],
//     dependsOn: [testInsertIntoGeometricDataTable]
// }
// function testInsertIntoGeometricDataTable2() {
//     int rowId = 5;
//     PointValue pointType = new ({x: 2, y:2});
//     LineValue lineType = new ({a:2, b:3, c:4});
//     LsegValue lsegType = new ({x1: 2, x2: 3, y1: 2, y2:3});
//     BoxValue boxType = new ({x1: 2, x2: 3, y1: 2, y2:3});
//     // PathValue pathType = new ("[(1,1),(2,2)]");
//     // PolygonValue polygonType = new ("[(1,1),(2,2)]");
//     CircleValue circleType = new ({x: 2, y:2, r:2});

//     sql:ParameterizedQuery sqlQuery =
//       `
//     INSERT INTO GeometricTypes (row_id, point_type, line_type, lseg_type, box_type,circle_type)
//             VALUES(${rowId}, ${pointType}, ${lineType}, ${lsegType}, ${boxType},${circleType})
//     `;
//     validateResult(executeQueryPostgresqlClient(sqlQuery, "geometric_db"), 1, rowId);
// }

// @test:Config {
//     groups: ["datatypes"],
//     dependsOn: [testInsertIntoGeometricDataTable2]
// }
// function testInsertIntoGeometricDataTable3() {
//     int rowId = 6;
//     PointValue pointType = new ();
//     LineValue lineType = new ();
//     LsegValue lsegType = new ();
//     BoxValue boxType = new ();
//     // PathValue pathType = new ("[(1,1),(2,2)]");
//     // PolygonValue polygonType = new ("[(1,1),(2,2)]");
//     CircleValue circleType = new ();

//     sql:ParameterizedQuery sqlQuery =
//       `
//     INSERT INTO GeometricTypes (row_id, point_type, line_type, lseg_type, box_type,circle_type)
//             VALUES(${rowId}, ${pointType}, ${lineType}, ${lsegType}, ${boxType},${circleType})
//     `;
//     validateResult(executeQueryPostgresqlClient(sqlQuery, "geometric_db"), 1, rowId);
// }

// @test:Config {
//     groups: ["datatypes"],
//     dependsOn: [testInsertIntoGeometricDataTable2]
// }
// function testSelectFromGeometricDataTable() {
//     int rowId = 5;

//     sql:ParameterizedQuery sqlQuery = `select * from geometrictypes where row_id = ${rowId}`;

//      _ = validateGeometricTableResult(simpleQueryPostgresqlClient(sqlQuery, GeometricRecord, database = "geometric_db"));
// }

// public function validateGeometricTableResult(record{}? returnData) {
//     PointValue pointType = new ("(1,2)");
//     LineValue lineType = new ("{1,2,3}");
//     LsegValue lsegType = new ("(1,1),(2,2)");
//     BoxValue boxType = new ("(1,1),(2,2)");
//     // PathValue pathType = new ("[(1,1),(2,2)]");
//     // PolygonValue polygonType = new ("[(1,1),(2,2)]");
//     CircleValue circleType = new ("<1,1,1>");
//     // io:println("returnData", returnData);
//     if (returnData is ()) {
//         test:assertFail("Empty row returned.");
//     } else {
//         test:assertEquals(returnData["row_id"], 5);
//         test:assertEquals(returnData["point_type"], "(2,2)");
//         test:assertEquals(returnData["line_type"], "{2,3,4}");
//         test:assertEquals(returnData["lseg_type"], "[(2,2),(3,3)]");   
//         test:assertEquals(returnData["box_type"], "(3,3),(2,2)"); 
//         test:assertEquals(returnData["circle_type"], "<(2,2),2>");
//     } 
// }

// //--------------------------------------------------------------------------------------------------------------

// public type UuidRecord record {
//   int row_id;
//   string uuid_type;
// };

// @test:Config {
//     groups: ["datatypes"]
// }
// function testInsertIntoUuidDataTable() {
//     int rowId = 3;
//     UuidValue uuidType = new ("a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11");

//     sql:ParameterizedQuery sqlQuery =
//       `
//     INSERT INTO UuidTypes (row_id, uuid_type)
//             VALUES(${rowId}, ${uuidType})
//     `;
//     validateResult(executeQueryPostgresqlClient(sqlQuery, "uuid_db"), 1, rowId);
// }

// @test:Config {
//     groups: ["datatypes"],
//     dependsOn: [testInsertIntoUuidDataTable]
// }
// function testInsertIntoUuidDataTable2() {
//     int rowId = 4;
//     UuidValue uuidType = new ();

//     sql:ParameterizedQuery sqlQuery =
//       `
//     INSERT INTO UuidTypes (row_id, uuid_type)
//             VALUES(${rowId}, ${uuidType})
//     `;
//     validateResult(executeQueryPostgresqlClient(sqlQuery, "uuid_db"), 1, rowId);
// }

// @test:Config {
//     groups: ["datatypes"],
//     dependsOn: [testInsertIntoUuidDataTable2]
// }
// function testSelectFromUuidDataTable() {
//     int rowId = 3;
//     UuidValue uuidType = new ("a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11");
    
//     sql:ParameterizedQuery sqlQuery = `select * from uuidtypes where row_id = ${rowId}`;

//     _ = validateUuidTableResult(simpleQueryPostgresqlClient(sqlQuery, UuidRecord, database = "uuid_db"));
// }

// public function validateUuidTableResult(record{}? returnData) {
//     if (returnData is ()) {
//         test:assertFail("Empty row returned.");
//     } else {
//         test:assertEquals(returnData["row_id"], 3);
//         test:assertEquals(returnData["uuid_type"], "a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11");
//     } 
// }

// //---------------------------------------------------------------------------------------------------------------------

// public type TextSearchRecord record {
//   int row_id;
//   string tsvector_type;
//   string tsquery_type;
// };

// @test:Config {
//     groups: ["datatypes"]
// }
// function testInsertIntoTextSearchDataTable() {
//     int rowId = 3;
//     TsvectorValue tsvectorType = new ("a fat cat sat on a mat and ate a fat rat");
//     TsqueryValue tsqueryType = new ("fat & rat");

//     sql:ParameterizedQuery sqlQuery =
//       `
//     INSERT INTO TextSearchTypes (row_id, tsvector_type, tsquery_type)
//             VALUES(${rowId}, ${tsvectorType}, ${tsqueryType})
//     `;
//     validateResult(executeQueryPostgresqlClient(sqlQuery, "ts_db"), 1, rowId);
// }

// @test:Config {
//     groups: ["datatypes"],
//     dependsOn: [testInsertIntoTextSearchDataTable]
// }
// function testInsertIntoTextSearchDataTable2() {
//     int rowId = 4;
//     TsvectorValue tsvectorType = new ();
//     TsqueryValue tsqueryType = new ();

//     sql:ParameterizedQuery sqlQuery =
//       `
//     INSERT INTO TextSearchTypes (row_id, tsvector_type, tsquery_type)
//             VALUES(${rowId}, ${tsvectorType}, ${tsqueryType})
//     `;
//     validateResult(executeQueryPostgresqlClient(sqlQuery, "ts_db"), 1, rowId);
// }

// @test:Config {
//     groups: ["datatypes"],
//     dependsOn: [testInsertIntoTextSearchDataTable2]
// }
// function testSelectFromTextSearchDataTable() {
//     int rowId = 3;
    
//     sql:ParameterizedQuery sqlQuery = `select * from TextSearchTypes where row_id = ${rowId}`;

//     _ = validateTextSearchTableResult(simpleQueryPostgresqlClient(sqlQuery, TextSearchRecord, database = "ts_db"));
// }

// public function validateTextSearchTableResult(record{}? returnData) {
//     if (returnData is ()) {
//         test:assertFail("Empty row returned.");
//     } else {
//         test:assertEquals(returnData["row_id"], 3);
//         test:assertEquals(returnData["tsvector_type"], "'a' 'and' 'ate' 'cat' 'fat' 'mat' 'on' 'rat' 'sat'");
//         test:assertEquals(returnData["tsquery_type"], "'fat' & 'rat'");
//     } 
// }

// //--------------------------------------------------------------------------------------------------------------------

// public type JsonRecord record {
//   int row_id;
//   json json_type;
//   json jsonb_type;
//   string jsonpath_type;
// };

// @test:Config {
//     groups: ["datatypes"]
// }
// function testInsertIntoJsonDataTable() {
//     int rowId = 3;
//     JsonValue jsonType = new("{\"a\":1,\"b\":\"Hello\"}");
//     JsonbValue jsonbType = new("{\"a\":2,\"b\":\"Hello\"}");
//     JsonpathValue jsonpathType = new("$.\"floor\"[*].\"apt\"[*]?(@.\"area\" > 40 && @.\"area\" < 90)?(@.\"rooms\" > 1)");
//     sql:ParameterizedQuery sqlQuery =
//       `
//     INSERT INTO JsonTypes (row_id, json_type, jsonb_type, jsonpath_type)
//             VALUES(${rowId}, ${jsonType}, ${jsonbType}, ${jsonpathType})
//     `;
//     validateResult(executeQueryPostgresqlClient(sqlQuery, "json_db"), 1, rowId);
// }

// @test:Config {
//     groups: ["datatypes"],
//     dependsOn: [testInsertIntoJsonDataTable]
// }
// function testInsertIntoJsonDataTable2() {
//     int rowId = 4;
//     JsonValue jsonType = new();
//     JsonbValue jsonbType = new();
//     JsonpathValue jsonpathType = new();

//     sql:ParameterizedQuery sqlQuery =
//       `
//     INSERT INTO JsonTypes (row_id, json_type, jsonb_type, jsonpath_type)
//             VALUES(${rowId}, ${jsonType}, ${jsonbType}, ${jsonpathType})
//     `;
//     validateResult(executeQueryPostgresqlClient(sqlQuery, "json_db"), 1, rowId);
// }

// @test:Config {
//     groups: ["datatypes"],
//     dependsOn: [testInsertIntoJsonDataTable2]
// }
// function testInsertIntoJsonDataTable3() {
//     int rowId = 5;
//     json jsonValue = {"a":11,"b":2};
//     JsonValue jsonType = new(jsonValue);
//     JsonbValue jsonbType = new(jsonValue);
//     JsonpathValue jsonpathType = new("$.\"floor\"[*].\"apt\"[*]?(@.\"area\" > 40 && @.\"area\" < 90)?(@.\"rooms\" > 10)");

//     sql:ParameterizedQuery sqlQuery =
//       `
//     INSERT INTO JsonTypes (row_id, json_type, jsonb_type, jsonpath_type)
//             VALUES(${rowId}, ${jsonType}, ${jsonbType}, ${jsonpathType})
//     `;
//     validateResult(executeQueryPostgresqlClient(sqlQuery, "json_db"), 1, rowId);
// }

// @test:Config {
//     groups: ["datatypes"],
//     dependsOn: [testInsertIntoJsonDataTable3]
// }
// function testSelectFromJsonDataTable() {
//     int rowId = 5;
    
//     sql:ParameterizedQuery sqlQuery = `select * from JsonTypes where row_id = ${rowId}`;

//     _ = validateJsonTableResult(simpleQueryPostgresqlClient(sqlQuery, JsonRecord, database = "json_db"));
// }

// public function validateJsonTableResult(record{}? returnData) {
//     if (returnData is ()) {
//         test:assertFail("Empty row returned.");
//     } else {
//         test:assertEquals(returnData["row_id"], 5);
//         test:assertEquals(returnData["json_type"], {"a":11,"b":2});
//         test:assertEquals(returnData["jsonb_type"], {"a":11,"b":2});
//         test:assertEquals(returnData["jsonpath_type"], "$.\"floor\"[*].\"apt\"[*]?(@.\"area\" > 40 && @.\"area\" < 90)?(@.\"rooms\" > 10)");
//     } 
// }

// // -----------------------------------------------------------------------------------------------------------------------

// public type DateTimeRecord record {
//   int row_id;
//   time:Time date_type;
//   time:Time time_type;
//   time:Time timetz_type;
//   time:Time timestamp_type;
//   time:Time timestamptz_type;
//   IntervalValue interval_type;
// };

public type DateTimeRecord record {
  int row_id;
  string date_type;
  string time_type;
  string timetz_type;
  string timestamp_type;
  string timestamptz_type;
  string interval_type;
};

@test:Config {
    groups: ["datatypes"]
}
function testInsertIntoDateDataTable() {
    time:Time|error timeValue = time:createTime(2017, 3, 28, 23, 42, 45,554, "Asia/Colombo");
    if(timeValue is time:Time){
        int rowId = 3;
        sql:TimestampValue timestampType = new(timeValue);
        sql:TimestampValue timestamptzType = new(timeValue);
        sql:DateValue dateType = new(timeValue);
        sql:TimeValue timeType = new(timeValue);
        sql:TimeValue timetzType= new(timeValue);
        IntervalValue intervalType= new({years:1,months:2,days:3,hours:4,minutes:5,seconds:6});

        sql:ParameterizedQuery sqlQuery =
            `
            INSERT INTO DateTimeTypes (row_id, timestamp_type, timestamptz_type, date_type, time_type, timetz_type, interval_type)
                    VALUES(${rowId}, ${timestampType}, ${timestamptzType}, ${dateType}, ${timeType}, ${timetzType}, ${intervalType})
            `;
        validateResult(executeQueryPostgresqlClient(sqlQuery, "datetime_db"), 1, rowId);
    }
    else{
        test:assertFail("Invalid Time value generated ");
    }
}


@test:Config {
    groups: ["datatypes"],
    dependsOn: [testInsertIntoDateDataTable]
}
function testInsertIntoDateDataTable2() {
    int rowId = 4;
    sql:TimestampValue timestampType = new();
    sql:TimestampValue timestamptzType = new();
    sql:DateValue dateType = new();
    sql:TimeValue timeType = new();
    sql:TimeValue timetzType= new();
    IntervalValue intervalType = new();

    sql:ParameterizedQuery sqlQuery =
         `
            INSERT INTO DateTimeTypes (row_id, timestamp_type, timestamptz_type, date_type, time_type, timetz_type, interval_type)
                    VALUES(${rowId}, ${timestampType}, ${timestamptzType}, ${dateType}, ${timeType}, ${timetzType}, ${intervalType})
        `;
    validateResult(executeQueryPostgresqlClient(sqlQuery, "datetime_db"), 1, rowId);
}

@test:Config {
    groups: ["datatypes"],
    dependsOn: [testInsertIntoDateDataTable2]
}
function testInsertIntoDateDataTable3() {
    int rowId = 5;
    IntervalValue intervalType= new("1 years 2 mons");

    sql:ParameterizedQuery sqlQuery =
            `
        INSERT INTO DateTimeTypes (row_id, interval_type)
                VALUES(${rowId}, ${intervalType})
        `;
    validateResult(executeQueryPostgresqlClient(sqlQuery, "datetime_db"), 1, rowId);
}

@test:Config {
    groups: ["datatypes"],
    dependsOn: [testInsertIntoDateDataTable3]
}
function testSelectFromDateDataTable() {
    int rowId = 3;
    
    sql:ParameterizedQuery sqlQuery = `select * from DateTimeTypes where row_id = ${rowId}`;

    _ = validateDateTableResult(simpleQueryPostgresqlClient(sqlQuery, DateTimeRecord, database = "datetime_db"));
}

public function validateDateTableResult(record{}? returnData) {
    if (returnData is ()) {
        test:assertFail("Empty row returned.");
    } else {
        io:println(returnData);
        test:assertEquals(returnData["row_id"], 3);
        test:assertEquals(returnData["time_type"], "05:12:45.554+05:30");
        test:assertEquals(returnData["timetz_type"], "23:42:45.554+05:30");
        test:assertEquals(returnData["timestamp_type"], "2017-03-29T05:12:45.554+05:30");
        test:assertEquals(returnData["timestamptz_type"], "2017-03-28T23:42:45.554+05:30");
        test:assertEquals(returnData["date_type"], "2017-03-28+05:30");
        test:assertEquals(returnData["interval_type"], "1 year 2 mons 3 days 04:05:06");
    } 
}

// //----------------------------------------------------------------------------------------------------------------

// // public type RangeRecord record {
// //   int row_id;
// //   record{} int4range_type;
// //   record{} int8range_type;
// //   record{} numrange_type;
// //   record{} tsrange_type;
// //   record{} tstzrange_type;
// //   record{} daterange_type;
// // };

// public type RangeRecord record {
//   int row_id;
//   string int4range_type;
//   string int8range_type;
//   string numrange_type;
//   string tsrange_type;
//   string tstzrange_type;
//   string daterange_type;
// };

// @test:Config {
//     groups: ["datatypes"]
// }
// function testInsertIntoRangeDataTable() {

//     time:Time|error startTime = time:createTime(2017, 3, 28, 23, 42, 45,554, "Asia/Colombo");
//     time:Time|error endTime = time:createTime(2021, 6, 12, 11, 43, 55,324, "Asia/Colombo");
//     if((startTime is time:Time) && (endTime is time:Time)){
    
//         int rowId = 3;
//         Int4rangeValue int4rangeType = new({upper:100 , lower:10 , isUpperboundInclusive: true, isLowerboundInclusive: false});
//         Int8rangeValue int8rangeType = new({upper:123450 , lower:13245 , isUpperboundInclusive: false , isLowerboundInclusive: true});
//         NumrangeValue numrangeType = new({upper: 12330.121, lower: 1229.12, isUpperboundInclusive: true, isLowerboundInclusive: true});
//         TsrangeValue tsrangeType = new({upper:endTime , lower:startTime});
//         TstzrangeValue tstzrangeType= new({upper:endTime , lower:startTime});
//         DaterangeValue daterangeType= new({upper:endTime , lower:startTime , isUpperboundInclusive: true , isLowerboundInclusive: true});
//         // TstzrangeValue tstzrangeType = new ();
//         // DaterangeValue daterangeType = new ();

//         sql:ParameterizedQuery sqlQuery =
//             `
//             INSERT INTO RangeTypes (row_id, int4range_type, int8range_type, numrange_type, tsrange_type, tstzrange_type, daterange_type)
//                     VALUES(${rowId}, ${int4rangeType}, ${int8rangeType}, ${numrangeType}, ${tsrangeType}, ${tstzrangeType}, ${daterangeType})
//             `;
//         validateResult(executeQueryPostgresqlClient(sqlQuery, "range_db"), 1, rowId);
//     }
//     else{
//         test:assertFail("Invalid Time value generated ");
//     }
// }


// @test:Config {
//     groups: ["datatypes"],
//     dependsOn: [testInsertIntoRangeDataTable]
// }
// function testInsertIntoRangeDataTable2() {
//     int rowId = 4;
//     Int4rangeValue int4rangeType = new();
//     Int8rangeValue int8rangeType = new();
//     NumrangeValue numrangeType = new();
//     TsrangeValue tsrangeType = new();
//     TstzrangeValue tstzrangeType= new();
//     DaterangeValue daterangeType = new();

//          sql:ParameterizedQuery sqlQuery =
//             `
//             INSERT INTO RangeTypes (row_id, int4range_type, int8range_type, numrange_type, tsrange_type, tstzrange_type, daterange_type)
//                     VALUES(${rowId}, ${int4rangeType}, ${int8rangeType}, ${numrangeType}, ${tsrangeType}, ${tstzrangeType}, ${daterangeType})
//             `;
//     validateResult(executeQueryPostgresqlClient(sqlQuery, "range_db"), 1, rowId);
// }

// @test:Config {
//     groups: ["datatypes"],
//     dependsOn: [testInsertIntoRangeDataTable2]
// }
// function testInsertIntoRangeDataTable3() {
//     int rowId = 5;
//     Int4rangeValue int4rangeType = new("(2,50)");
//     Int8rangeValue int8rangeType = new("(10,100)");
//     NumrangeValue numrangeType = new("(0.1,2.4)");
//     TsrangeValue tsrangeType = new("(2010-01-01 14:30, 2010-01-01 15:30)");
//     TstzrangeValue tstzrangeType= new("(2010-01-01 14:30, 2010-01-01 15:30)");
//     DaterangeValue daterangeType= new("(2010-01-01 14:30, 2010-01-03 )");

//     sql:ParameterizedQuery sqlQuery =
//         `
//         INSERT INTO RangeTypes (row_id, int4range_type, int8range_type, numrange_type, tsrange_type, tstzrange_type, daterange_type)
//                 VALUES(${rowId}, ${int4rangeType}, ${int8rangeType}, ${numrangeType}, ${tsrangeType}, ${tstzrangeType}, ${daterangeType})
//         `;
//     validateResult(executeQueryPostgresqlClient(sqlQuery, "range_db"), 1, rowId);
// }

// @test:Config {
//     groups: ["datatypes"],
//     dependsOn: [testInsertIntoRangeDataTable3]
// }
// function testSelectFromRangeDataTable() {
//     int rowId = 5;
    
//     sql:ParameterizedQuery sqlQuery = `select * from RangeTypes where row_id = ${rowId}`;

//     _ = validateRangeTableResult(simpleQueryPostgresqlClient(sqlQuery, RangeRecord, database = "range_db"));
// }

// public function validateRangeTableResult(record{}? returnData) {
//     if (returnData is ()) {
//         test:assertFail("Empty row returned.");
//     } else {
//         io:println(returnData);
//         test:assertEquals(returnData["row_id"], 5);
//         test:assertEquals(returnData["int4range_type"], "[3,50)");
//         test:assertEquals(returnData["int8range_type"], "[11,100)");
//         test:assertEquals(returnData["numrange_type"], "(0.1,2.4)");
//         test:assertEquals(returnData["tsrange_type"], "(\"2010-01-01 14:30:00\",\"2010-01-01 15:30:00\")");
//         test:assertEquals(returnData["tstzrange_type"], "(\"2010-01-01 14:30:00+05:30\",\"2010-01-01 15:30:00+05:30\")");
//         test:assertEquals(returnData["daterange_type"], "[2010-01-02,2010-01-03)");
//     } 
// }

// //-----------------------------------------------------------------------------------------------------------------------

// public type BitRecord record {
//   int row_id;
// //   string bitstring_type;
//   string varbitstring_type;
//   boolean bit_type;
// };
// //         json jj = {"a":11,"b":2};
// //         json jj2 = {"a":22,"b":2};
// //         json jj3 = {"a":33,"b":2};

// //         // postgresql:JsonValue j = new(jj);
// //         // postgresql:JsonValue j2 = new(jj2);
// //         // postgresql:JsonValue j3 = new(jj3);

// //         // postgresql:JsonValue j = new("{\"a\":1,\"b\":\"Hello\"}");
// //         // postgresql:JsonValue j2 = new("{\"a\":2,\"b\":\"Hello\"}");
// //         // postgresql:JsonValue j3 = new("{\"a\":3,\"b\":\"Hello\"}");

// @test:Config {
//     groups: ["datatypes"]
// }
// function testInsertIntoBitDataTable() {
//     int rowId = 3;
//     BitstringValue bitstringType = new("1110001100");
//     VarbitstringValue varbitstringType = new("11001");
//     PGBitValue bitType = new("0");
//     sql:ParameterizedQuery sqlQuery =
//       `
//     INSERT INTO BitTypes (row_id, bitstring_type, varbitstring_type, bit_type)
//             VALUES(${rowId}, ${bitstringType}, ${varbitstringType}, ${bitType})
//     `;
//     validateResult(executeQueryPostgresqlClient(sqlQuery, "bitstring_db"), 1, rowId);
// }

// @test:Config {
//     groups: ["datatypes"],
//     dependsOn: [testInsertIntoBitDataTable]
// }
// function testInsertIntoBitDataTable2() {
//     int rowId = 4;
//     BitstringValue bitstringType = new();
//     VarbitstringValue varbitstringType = new();
//     PGBitValue bitType = new();

//     sql:ParameterizedQuery sqlQuery =
//       `
//     INSERT INTO BitTypes (row_id, bitstring_type, varbitstring_type, bit_type)
//             VALUES(${rowId}, ${bitstringType}, ${varbitstringType}, ${bitType})
//     `;
//     validateResult(executeQueryPostgresqlClient(sqlQuery, "bitstring_db"), 1, rowId);
// }

// @test:Config {
//     groups: ["datatypes"],
//     dependsOn: [testInsertIntoBitDataTable2]
// }
// function testSelectFromBitDataTable() {
//     int rowId = 3;
    
//     sql:ParameterizedQuery sqlQuery = `select row_id, varbitstring_type, bit_type from BitTypes where row_id = ${rowId}`;

//     _ = validateBitTableResult(simpleQueryPostgresqlClient(sqlQuery, BitRecord, database = "bitstring_db"));
// }

// public function validateBitTableResult(record{}? returnData) {
//     if (returnData is ()) {
//         test:assertFail("Empty row returned.");
//     } else {
//         test:assertEquals(returnData["row_id"], 3);
//         // test:assertEquals(returnData["bitstring_type"], "1110001100");
//         test:assertEquals(returnData["varbitstring_type"], "11001");
//         test:assertEquals(returnData["bit_type"], false);
//     } 
// }

// //------------------------------------------------------------------------------------------------------------------------------------------------

// public type PglsnRecord record {
//   int row_id;
//   string pglsn_type;
// };

// @test:Config {
//     groups: ["datatypes"]
// }
// function testInsertIntoPglsnDataTable() {
//     int rowId = 3;
//     PglsnValue pglsnType = new ("16/B374D848");

//     sql:ParameterizedQuery sqlQuery =
//       `
//     INSERT INTO PglsnTypes (row_id, pglsn_type)
//             VALUES(${rowId}, ${pglsnType})
//     `;
//     validateResult(executeQueryPostgresqlClient(sqlQuery, "pglsn_db"), 1, rowId);
// }

// @test:Config {
//     groups: ["datatypes"],
//     dependsOn: [testInsertIntoPglsnDataTable]
// }
// function testInsertIntoPglsnDataTable2() {
//     int rowId = 4;
//     PglsnValue pglsnType = new ();

//     sql:ParameterizedQuery sqlQuery =
//       `
//     INSERT INTO PglsnTypes (row_id, pglsn_type)
//             VALUES(${rowId}, ${pglsnType})
//     `;
//     validateResult(executeQueryPostgresqlClient(sqlQuery, "pglsn_db"), 1, rowId);
// }

// @test:Config {
//     groups: ["datatypes"],
//     dependsOn: [testInsertIntoPglsnDataTable2]
// }
// function testSelectFromPglsnDataTable() {
//     int rowId = 3;
    
//     sql:ParameterizedQuery sqlQuery = `select * from Pglsntypes where row_id = ${rowId}`;

//     _ = validatePglsnTableResult(simpleQueryPostgresqlClient(sqlQuery, PglsnRecord, database = "pglsn_db"));
// }

// public function validatePglsnTableResult(record{}? returnData) {
//     if (returnData is ()) {
//         test:assertFail("Empty row returned.");
//     } else {
//         test:assertEquals(returnData["row_id"], 3);
//         test:assertEquals(returnData["pglsn_type"], "16/B374D848");
//     } 
// }

// //-------------------------------------------------------------------------------------------------------------------------------------------------

// // public type MoneyRecord record {
// //   int row_id;
// //   string money_type;
// // };

// // @test:Config {
// //     groups: ["datatypes"]
// // }
// // function testInsertIntoMoneyDataTable() {
// //     int rowId = 3;
// //     MoneyValue moneyType = new ("12.23");

// //     sql:ParameterizedQuery initMoneyType = 
// //     `
// //         set lc_monetary to 'en_US.utf8';
// //     `;

// //     _ = executeQueryPostgresqlClient(initMoneyType, "money_db");

// //     sql:ParameterizedQuery sqlQuery =
// //       `
// //     INSERT INTO MoneyTypes (row_id, money_type)
// //             VALUES(${rowId}, ${moneyType})
// //     `;
// //     validateResult(executeQueryPostgresqlClient(sqlQuery, "money_db"), 1, rowId);
// // }

// // @test:Config {
// //     groups: ["datatypes"],
// //     dependsOn: [testInsertIntoMoneyDataTable]
// // }
// // function testInsertIntoMoneyDataTable2() {
// //     int rowId = 4;
// //     MoneyValue moneyType = new ();

// //     sql:ParameterizedQuery sqlQuery =
// //       `
// //     INSERT INTO MoneyTypes (row_id, money_type)
// //             VALUES(${rowId}, ${moneyType})
// //     `;
// //     validateResult(executeQueryPostgresqlClient(sqlQuery, "money_db"), 1, rowId);
// // }

// // @test:Config {
// //     groups: ["datatypes"],
// //     dependsOn: [testInsertIntoMoneyDataTable2]
// // }
// // function testSelectFromMoneyDataTable() {
// //     int rowId = 3;
    
// //     sql:ParameterizedQuery sqlQuery = `select * from moneytypes where row_id = ${rowId}`;

// //     _ = validateMoneyTableResult(simpleQueryPostgresqlClient(sqlQuery, MoneyRecord, database = "money_db"));
// // }

// // public function validateMoneyTableResult(record{}? returnData) {
// //     if (returnData is ()) {
// //         test:assertFail("Empty row returned.");
// //     } else {
// //         test:assertEquals(returnData["row_id"], 3);
// //         test:assertEquals(returnData["money_type"], "12.23");
// //     } 
// // }

// //-------------------------------------------------------------------------------------------------------------------------------------------------

// public type ObjectidentifierRecord record {
//   int row_id;
//   string oid_type;
//   string regclass_type;
//   string regconfig_type;
//   string regdictionary_type;
//   string regnamespace_type;
//   string regoper_type;
//   string regoperator_type;
//   string regproc_type;
//   string regprocedure_type;
//   string regrole_type;
//   string regtype_type;
// };
// //"pg_type","english","simple","pg_catalog","!","*(int,int)","NOW","sum(int4)","postgres","int"
// @test:Config {
//     groups: ["datatypes"]
// }
// function testInsertIntoObjectidentifierDataTable() {
//     int rowId = 3;
//     int oidType = 12;
//     RegclassValue regclassType = new("pg_type");
//     RegconfigValue regconfigType = new("english");
//     RegdictionaryValue regdictionaryType = new("simple");
//     RegnamespaceValue regnamespaceType = new("pg_catalog");
//     RegoperValue regoperType = new("!");
//     RegoperatorValue regoperatorType = new("*(int,int)");
//     RegprocValue regprocType = new("NOW");
//     RegprocedureValue regprocedureType = new("sum(int4)");
//     RegroleValue regroleType = new("postgres");
//     RegtypeValue regtypeType = new("int");

//     sql:ParameterizedQuery sqlQuery =
//       `
//     INSERT INTO ObjectidentifierTypes (row_id, oid_type, regclass_type, regconfig_type, regdictionary_type, 
//     regnamespace_type, regoper_type, regoperator_type, regproc_type, regprocedure_type, regrole_type, regtype_type) 
//             VALUES(${rowId}, ${oidType}, ${regclassType}, ${regconfigType}, ${regdictionaryType}, ${regnamespaceType},
//             ${regoperType}, ${regoperatorType}, ${regprocType}, ${regprocedureType}, ${regroleType}, ${regtypeType})
//     `;
//     validateResult(executeQueryPostgresqlClient(sqlQuery, "objectidentifier_db"), 1, rowId);
// }

// @test:Config {
//     groups: ["datatypes"],
//     dependsOn: [testInsertIntoPglsnDataTable]
// }
// function testInsertIntoObjectidentifierDataTable2() {
//     int rowId = 4;
//     int? oidType = ();
//     RegclassValue regclassType = new();
//     RegconfigValue regconfigType = new();
//     RegdictionaryValue regdictionaryType = new();
//     RegnamespaceValue regnamespaceType = new();
//     RegoperValue regoperType = new();
//     RegoperatorValue regoperatorType = new();
//     RegprocValue regprocType = new();
//     RegprocedureValue regprocedureType = new();
//     RegroleValue regroleType = new();
//     RegtypeValue regtypeType = new();

//     sql:ParameterizedQuery sqlQuery =
//       `
//     INSERT INTO ObjectidentifierTypes (row_id, oid_type, regclass_type, regconfig_type, regdictionary_type, 
//     regnamespace_type, regoper_type, regoperator_type, regproc_type, regprocedure_type, regrole_type, regtype_type) 
//             VALUES(${rowId}, ${oidType}, ${regclassType}, ${regconfigType}, ${regdictionaryType}, ${regnamespaceType},
//             ${regoperType}, ${regoperatorType}, ${regprocType}, ${regprocedureType}, ${regroleType}, ${regtypeType})
//     `;
//     validateResult(executeQueryPostgresqlClient(sqlQuery, "objectidentifier_db"), 1, rowId);
// }

// @test:Config {
//     groups: ["datatypes"],
//     dependsOn: [testInsertIntoPglsnDataTable2]
// }
// function testSelectFromObjectidentifierDataTable() {
//     int rowId = 3;
    
//     sql:ParameterizedQuery sqlQuery = `select * from Objectidentifiertypes where row_id = ${rowId}`;

//     _ = validateObjectidentifierTableResult(simpleQueryPostgresqlClient(sqlQuery, ObjectidentifierRecord, database = "objectidentifier_db"));
// }

// public function validateObjectidentifierTableResult(record{}? returnData) {
//     if (returnData is ()) {
//         test:assertFail("Empty row returned.");
//     } else {
//         test:assertEquals(returnData["row_id"], 3);
//         test:assertEquals(returnData["oid_type"], "12");
//         test:assertEquals(returnData["regclass_type"], "pg_type");
//         test:assertEquals(returnData["regconfig_type"], "english");
//         test:assertEquals(returnData["regdictionary_type"], "simple");
//         test:assertEquals(returnData["regnamespace_type"], "pg_catalog");
//         test:assertEquals(returnData["regoper_type"], "!");
//         test:assertEquals(returnData["regoperator_type"], "*(integer,integer)");
//         test:assertEquals(returnData["regproc_type"], "now");
//         test:assertEquals(returnData["regprocedure_type"], "sum(integer)");
//         test:assertEquals(returnData["regrole_type"], "postgres");
//         test:assertEquals(returnData["regtype_type"], "integer");
//     } 
// }

// //--------------------------------------------------------------------------------------------------------------------

// public type XmlRecord record {
//   int row_id;
//   xml xml_type;
// };

// @test:Config {
//     groups: ["datatypes"]
// }
// function testInsertIntoXmlDataTable() {
//     int rowId = 3;
//     // XmlValue xmlType = new ("16/B374D848");
//     xml xmlType = xml `<foo>Value</foo>`;

//     sql:ParameterizedQuery sqlQuery =
//       `
//     INSERT INTO XmlTypes (row_id, xml_type)
//             VALUES(${rowId}, ${xmlType})
//     `;
//     validateResult(executeQueryPostgresqlClient(sqlQuery, "xml_db"), 1, rowId);
// }

// @test:Config {
//     groups: ["datatypes"],
//     dependsOn: [testInsertIntoXmlDataTable]
// }
// function testInsertIntoXmlDataTable2() {
//     int rowId = 4;
//     // XmlValue xmlType = new ();
//     xml? xmlType = ();

//     sql:ParameterizedQuery sqlQuery =
//       `
//     INSERT INTO XmlTypes (row_id, xml_type)
//             VALUES(${rowId}, ${xmlType})
//     `;
//     validateResult(executeQueryPostgresqlClient(sqlQuery, "xml_db"), 1, rowId);
// }

// // @test:Config {
// //     groups: ["datatypes"],
// //     dependsOn: [testInsertIntoXmlDataTable]
// // }
// // function testSelectFromXmlDataTable() {
// //     int rowId = 3;
    
// //     sql:ParameterizedQuery sqlQuery = `select * from Xmltypes where row_id = ${rowId}`;

// //     _ = validateXmlTableResult(simpleQueryPostgresqlClient(sqlQuery, XmlRecord, database = "xml_db"));
// // }

// public function validateXmlTableResult(record{}? returnData) {
//     if (returnData is ()) {
//         test:assertFail("Empty row returned.");
//     } else {
//         test:assertEquals(returnData["row_id"], 3);
//         test:assertEquals(returnData["xml_type"], xml `<foo>Test</foo>`);
//     } 
// }

// //// -----------------------------------------------------------------------------------------------------------------------------------------------


