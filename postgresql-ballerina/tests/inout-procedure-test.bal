// import ballerina/time;
// import ballerina/sql;
// import ballerina/test;
// import ballerina/io;

// public function c() {
//     io:println(1);
//     time:Time|error timeValue = time:createTime(2017, 3, 28, 23, 42, 45,554, "Asia/Colombo");
// }
// @test:Config {
//     groups: ["datatypes"]
// }
// function testNumericProcedureInoutCall() {
//     int rowId = 10;
//     decimal decimalVal = 1234.567;
//     sql:SmallIntValue smallintType = new(1);
//     sql:IntegerValue intType = new(1);
//     sql:BigIntValue bigintType = new(123456);
//     sql:DecimalValue decimalType = new(decimalVal);
//     sql:NumericValue numericType = new(decimalVal);
//     sql:RealValue realType = new(123.456);
//     sql:DoubleValue doubleType = new(123.456);

//     InOutParameter rowIdInoutValue = new (rowId);
//     InOutParameter smallintInoutValue = new (smallintType);
//     InOutParameter intInoutValue = new (intType);
//     InOutParameter bigintInoutValue = new (bigintType);
//     InOutParameter decimalInoutValue = new (decimalType);
//     InOutParameter numericInoutValue = new (numericType);
//     InOutParameter realInoutValue = new (realType);
//     InOutParameter doubleInoutValue = new (doubleType);

//     sql:ParameterizedCallQuery sqlQuery =
//       `
//       call NumericInoutProcedure(${rowIdInoutValue}, ${smallintInoutValue}, ${intInoutValue}, ${bigintInoutValue}, ${decimalInoutValue}, 
//                                 ${numericInoutValue}, ${realInoutValue}, ${doubleInoutValue});
//     `;
//     sql:ProcedureCallResult result = callInoutProcedure(sqlQuery, "numeric_db");

//     test:assertEquals(smallintInoutValue.get(int), 1, "Smallint Datatype Doesn;t Match");
//     test:assertEquals(intInoutValue.get(int), 1, "Integer Datatype Doesn't Match");
//     test:assertEquals(bigintInoutValue.get(int), 123456, "Bigint Datatype Doesn;t Match");
//     test:assertEquals(decimalInoutValue.get(decimal), decimalVal, "Decimal Datatype Doesn't Match");
//     test:assertEquals(numericInoutValue.get(decimal), decimalVal, "Numeric Datatype Doesn;t Match");
//     test:assertTrue(realInoutValue.get(float) is float, "Real Datatype Doesn't Match");
//     test:assertTrue(doubleInoutValue.get(float) is float, "Double Datatype Doesn;t Match");

// }

// //=================================================================================================================================================================

// @test:Config {
//     groups: ["datatypes"]
// }
// function testCharacterProcedureInoutCall() {
//     int rowId = 10;
//     sql:CharValue charValue = new ("This is a char4");
//     sql:VarcharValue varcharValue = new ("This is a varchar4");
//     sql:TextValue textValue = new ("This is a text4");
//     string nameValue = "This is a name4";

//     InOutParameter rowIdInoutValue = new (rowId);
//     InOutParameter charInoutValue = new (charValue);
//     InOutParameter varcharInoutValue = new (varcharValue);
//     InOutParameter textInoutValue = new (textValue);
//     InOutParameter nameInoutValue = new (nameValue);

//     sql:ParameterizedCallQuery sqlQuery =
//       `
//       call CharacterInoutProcedure(${rowIdInoutValue}, ${charInoutValue}, ${varcharInoutValue}, ${textInoutValue}, ${nameInoutValue});
//     `;
//     sql:ProcedureCallResult result = callInoutProcedure(sqlQuery, "character_db");

 
//     test:assertEquals(charInoutValue.get(string), "This is a char4", "Char Data type doesnt match.");
//     test:assertEquals(varcharInoutValue.get(string), "This is a varchar4", "Varchar Data type doesnt match.");
//     test:assertEquals(textInoutValue.get(string), "This is a text4", "Text Data type doesnt match.");
//     test:assertEquals(nameInoutValue.get(string), "This is a name4", "Name Data type doesnt match.");

// }

// //=============================================================================================================================================================


// @test:Config {
//     groups: ["datatypes"]
// }
// function testBooleanProcedureInoutCall() {
//     int rowId = 10;
//     boolean booleanType = false;

//     InOutParameter rowIdInoutValue = new (rowId);
//     InOutParameter booleanInoutValue = new (booleanType);

//     sql:ParameterizedCallQuery sqlQuery =
//       `
//       call BooleanInoutProcedure(${rowIdInoutValue}, ${booleanInoutValue});
//     `;
//     sql:ProcedureCallResult result = callInoutProcedure(sqlQuery, "boolean_db");

//     test:assertEquals(booleanInoutValue.get(boolean), false, "Boolean Datatype doesn't match");
// }

// //=================================================================================================================================================================

// @test:Config {
//     groups: ["datatypes"]
// }
// function testNetworkProcedureInoutCall() {
//     int rowId = 10;
//     InetValue inetValue = new ("192.168.0.1/24");
//     CidrValue cidrValue = new ("::ffff:1.2.3.0/120");
//     MacaddrValue macaddrValue = new ("08:00:2b:01:02:03");
//     Macaddr8Value macaddr8Value = new ("08-00-2b-01-02-03-04-00");

//     InOutParameter rowIdInoutValue = new (rowId);
//     InOutParameter inetInoutValue = new (inetValue);
//     InOutParameter cidrInoutValue = new (cidrValue);
//     InOutParameter macaddrInoutValue = new (macaddrValue);
//     InOutParameter macaddr8InoutValue = new (macaddr8Value);

//     sql:ParameterizedCallQuery sqlQuery =
//       `
//       call NetworkInoutProcedure(${rowIdInoutValue}, ${inetInoutValue}, ${cidrInoutValue}, ${macaddrInoutValue}, ${macaddr8InoutValue});
//     `;
//     sql:ProcedureCallResult result = callInoutProcedure(sqlQuery, "network_db");

 
//     test:assertEquals(inetInoutValue.get(string), "192.168.0.1/24", "Inet Data type doesnt match.");
//     test:assertEquals(cidrInoutValue.get(string), "::ffff:1.2.3.0/120", "Cidr Data type doesnt match.");
//     test:assertEquals(macaddrInoutValue.get(string), "08:00:2b:01:02:03", "Macaddress Data type doesnt match.");
//     test:assertEquals(macaddr8InoutValue.get(string), "08:00:2b:01:02:03:04:00", "Macadress8 Data type doesnt match.");

// }

// // ---------------------------------------------------------------------------------------------------------------------------------------------------

// @test:Config {
//     groups: ["datatypes"]
// }
// function testGeometricProcedureInoutCall() {
//     int rowId = 10;
//     PointValue pointType = new ({x: 2, y:2});
//     LineValue lineType = new ({a:2, b:3, c:4});
//     LsegValue lsegType = new ({x1: 2, x2: 3, y1: 2, y2:3});
//     BoxValue boxType = new ({x1: 2, x2: 3, y1: 2, y2:3});
//     // PathValue pathType = new ("[(1,1),(2,2)]");
//     // PolygonValue polygonType = new ("[(1,1),(2,2)]");
//     CircleValue circleType = new ({x: 2, y:2, r:2});

//     InOutParameter rowIdInoutValue = new (rowId);
//     InOutParameter pointInoutValue = new (pointType);
//     InOutParameter lineInoutValue = new (lineType);
//     InOutParameter lsegInoutValue = new (lsegType);
//     InOutParameter boxInoutValue = new (boxType);
//     InOutParameter circleInoutValue = new (circleType);

//     sql:ParameterizedCallQuery sqlQuery =
//       `
//       call GeometricInoutProcedure(${rowIdInoutValue}, ${pointInoutValue}, ${lineInoutValue}, ${lsegInoutValue}, ${boxInoutValue}, ${circleInoutValue});
//     `;
//     sql:ProcedureCallResult result = callInoutProcedure(sqlQuery, "geometric_db");
//     test:assertEquals(pointInoutValue.get(string), "(2.0,2.0)", "Point Data type doesnt match.");
//     test:assertEquals(lineInoutValue.get(string), "{2.0,3.0,4.0}", "Line Data type doesnt match.");
//     test:assertEquals(lsegInoutValue.get(string), "[(2.0,2.0),(3.0,3.0)]", "Line Segment Data type doesnt match.");
//     test:assertEquals(boxInoutValue.get(string), "(3.0,3.0),(2.0,2.0)", "Box Data type doesnt match.");
//     test:assertEquals(circleInoutValue.get(string), "<(2.0,2.0),2.0>", "Circle Data type doesnt match.");

//     // test:assertEquals(pointInoutValue.get(string), "(2,2)", "Point Data type doesnt match.");
//     // test:assertEquals(lineInoutValue.get(string), "{2,3,4}", "Line Data type doesnt match.");
//     // test:assertEquals(lsegInoutValue.get(string), "[(2,2),(3,3)]", "Line Segment Data type doesnt match.");
//     // test:assertEquals(boxInoutValue.get(string), "(3,3),(2,2)", "Box Data type doesnt match.");
//     // test:assertEquals(circleInoutValue.get(string), "<(2,2),2>", "Circle Data type doesnt match.");

// }

// // //----------------------------------------------------------------------------------------------------------------------------------------------------

// @test:Config {
//     groups: ["datatypes"]
// }
// function testUuidProcedureInoutCall() {
//     int rowId = 10;
//     UuidValue uuidType = new ("a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12");

//     InOutParameter rowIdInoutValue = new (rowId);
//     InOutParameter uuidInoutValue = new (uuidType);

//     sql:ParameterizedCallQuery sqlQuery =
//       `
//       call UuidInoutProcedure(${rowIdInoutValue}, ${uuidInoutValue});
//     `;
//     sql:ProcedureCallResult result = callInoutProcedure(sqlQuery, "uuid_db");

//     test:assertEquals(uuidInoutValue.get(string), "a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12", "UUID Datatype doesn't match");
// }

// // // //----------------------------------------------------------------------------------------------------------------------------------------------------

// @test:Config {
//     groups: ["datatypes"]
// }
// function testPglsnProcedureInoutCall() {
//     int rowId = 10;
//     PglsnValue pglsnType = new ("16/B374D848");

//     InOutParameter rowIdInoutValue = new (rowId);
//     InOutParameter pglsnInoutValue = new (pglsnType);

//     sql:ParameterizedCallQuery sqlQuery =
//       `
//       call PglsnInoutProcedure(${rowIdInoutValue}, ${pglsnInoutValue});
//     `;
//     sql:ProcedureCallResult result = callInoutProcedure(sqlQuery, "pglsn_db");

//     test:assertEquals(pglsnInoutValue.get(string), "16/B374D848", "Pg_lsn Data type Doesn't match");

// }

// // // //-------------------------------------------------------------------------------------------------------------------------

// @test:Config {
//     groups: ["datatypes"]
// }
// function testJsonProcedureInoutCall() {
//     int rowId = 10;
//     json jsonValue = {"key1":"value","key2":2};
//     JsonValue jsonType = new(jsonValue);
//     JsonbValue jsonbType = new(jsonValue);
//     JsonpathValue jsonpathType = new("$.\"floor\"[*].\"apt\"[*]?(@.\"area\" > 40 && @.\"area\" < 90)?(@.\"rooms\" > 10)");

//     InOutParameter rowIdInoutValue = new (rowId);
//     InOutParameter jsonInoutValue = new (jsonType);
//     InOutParameter jsonbInoutValue = new (jsonbType);
//     InOutParameter jsonPathInoutValue = new (jsonpathType);

//     sql:ParameterizedCallQuery sqlQuery =
//       `
//       call JsonInoutProcedure(${rowIdInoutValue}, ${jsonInoutValue}, ${jsonbInoutValue}, ${jsonPathInoutValue});
//     `;
//     sql:ProcedureCallResult result = callInoutProcedure(sqlQuery, "json_db");

//     test:assertEquals(jsonInoutValue.get(string), "{\"key1\":\"value\",\"key2\":2}", "Json Datatype Doesn't Match");
//     test:assertEquals(jsonbInoutValue.get(string), "{\"key1\": \"value\", \"key2\": 2}", "Jsonb Datatype Doesn't Match");
//     test:assertEquals(jsonPathInoutValue.get(string), "$.\"floor\"[*].\"apt\"[*]?(@.\"area\" > 40 && @.\"area\" < 90)?(@.\"rooms\" > 10)", "Json path Datatype Doesn't Match");

//     // test:assertEquals(jsonInoutValue.get(json), {"key1": "value", "key2": 2}, "Json Datatype Doesn't Match");
//     // test:assertEquals(jsonbInoutValue.get(json), {"key1": "value", "key2": 2}, "Jsonb Datatype Doesn't Match");
// }

// // // //-------------------------------------------------------------------------------------------------------------------------

// @test:Config {
//     groups: ["datatypes"]
// }
// function testBitProcedureInoutCall() {
//     int rowId = 10;
//     VarbitstringValue varbitstringType = new("111110");
//     PGBitValue bitType = new("0");

//     InOutParameter rowIdInoutValue = new (rowId);
//     InOutParameter varbitInoutValue = new (varbitstringType);
//     InOutParameter bitInoutValue = new (bitType);

//     sql:ParameterizedCallQuery sqlQuery =
//       `
//       call BitInoutProcedure(${rowIdInoutValue}, ${varbitInoutValue}, ${bitInoutValue});
//     `;
//     sql:ProcedureCallResult result = callInoutProcedure(sqlQuery, "bitstring_db");

//     test:assertEquals(varbitInoutValue.get(string), "111110", "Bit Vary Datatype Doesn;t Match");
//     test:assertEquals(bitInoutValue.get(boolean), false, "Bit Datatype Doesn't Match");

// }

// // // //-----------------------------------------------------------------------------------------------------------------------

// @test:Config {
//     groups: ["datatypes"]
// }
// function testDatetimeProcedureInoutCall() {

//     time:Time|error timeValue = time:createTime(2017, 3, 28, 23, 42, 45,554, "Asia/Colombo");
//     if(timeValue is time:Time){
//         int rowId = 10;
//         sql:TimestampValue timestampType = new(timeValue);
//         sql:TimestampValue timestamptzType = new(timeValue);
//         sql:DateValue dateType = new(timeValue);
//         sql:TimeValue timeType = new(timeValue);
//         sql:TimeValue timetzType= new(timeValue);
//         IntervalValue intervalType= new({years:1,months:2,days:3,hours:4,minutes:5,seconds:7});

//         InOutParameter rowIdInoutValue = new (rowId);
//         InOutParameter timestampInoutValue = new (timestampType);
//         InOutParameter timestamptzInoutValue = new (timestamptzType);
//         InOutParameter dateInoutValue = new (dateType);
//         InOutParameter timeInoutValue = new (timeType);
//         InOutParameter timetzInoutValue = new (timetzType);
//         InOutParameter intervalInoutValue = new (intervalType);
    
//         sql:ParameterizedCallQuery sqlQuery =
//         `
//             call DatetimeInoutProcedure(${rowIdInoutValue}, ${dateInoutValue}, ${timeInoutValue}, ${timetzInoutValue},
//                 ${timestampInoutValue}, ${timestamptzInoutValue}, ${intervalInoutValue});
//         `;
//         sql:ProcedureCallResult result = callInoutProcedure(sqlQuery, "datetime_db");

//         test:assertEquals(timestampInoutValue.get(string), "2017-03-29T05:12:45.554+05:30", " Timestamp Datatype Doesn't Match");
//         test:assertEquals(timestamptzInoutValue.get(string), "2017-03-29T05:12:45.554+05:30", " Timestamptz Datatype Doesn't Match");
//         test:assertEquals(dateInoutValue.get(string), "2017-03-28+05:30", " Date Datatype Doesn't Match");
//         test:assertEquals(timeInoutValue.get(string), "05:12:45.000+05:30", " Time Datatype Doesn't Match");
//         test:assertEquals(timetzInoutValue.get(string), "05:12:45.000+05:30", " Timetz Datatype Doesn't Match");
//         test:assertEquals(intervalInoutValue.get(string), "1 years 2 mons 3 days 4 hours 5 mins 7.0 secs", " Interval Datatype Doesn't Match");

//         // test:assertEquals(timestampInoutValue.get(string), "2017-03-28+05:30", " Timestamp Datatype Doesn't Match");
//         // test:assertEquals(timestamptzInoutValue.get(string), "05:12:45.554+05:30", " Timestamptz Datatype Doesn't Match");
//         // test:assertEquals(dateInoutValue.get(string), "23:42:45.554+05:30", " Date Datatype Doesn't Match");
//         // test:assertEquals(timeInoutValue.get(string), "2017-03-29T05:12:45.554+05:30", " Time Datatype Doesn't Match");
//         // test:assertEquals(timetzInoutValue.get(string), "2017-03-28T23:42:45.554+05:30", " Timetz Datatype Doesn't Match");
//         // test:assertEquals(intervalInoutValue.get(string), "1 year 2 mons 3 days 04:05:06", " Interval Datatype Doesn't Match");
//     }
//     else{
//         test:assertFail("Invalid Time value generated ");
//     }
// }

// // //--------------------------------------------------------------------------------------------------------------------------

// @test:Config {
//     groups: ["datatypes"]
// }
// function testRangeProcedureInoutCall() {

//         int rowId = 10;
//         Int4rangeValue int4rangeType = new("(2,50)");
//         Int8rangeValue int8rangeType = new("(10,100)");
//         NumrangeValue numrangeType = new("(0.1,2.4)");
//         TsrangeValue tsrangeType = new("(2010-01-01 14:30, 2010-01-01 15:30)");
//         TstzrangeValue tstzrangeType= new("(2010-01-01 14:30, 2010-01-01 15:30)");
//         DaterangeValue daterangeType= new("(2010-01-01 14:30, 2010-01-03 )");

//         InOutParameter rowIdInoutValue = new (rowId);
//         InOutParameter int4rangeInoutValue = new (int4rangeType);
//         InOutParameter int8rangeInoutValue = new (int8rangeType);
//         InOutParameter numrangeInoutValue = new (numrangeType);
//         InOutParameter tsrangeInoutValue = new (tsrangeType);
//         InOutParameter tstzrangeInoutValue = new (tstzrangeType);
//         InOutParameter daterangeInoutValue = new (daterangeType);
        
//         sql:ParameterizedCallQuery sqlQuery =
//         `
//         call RangeInoutProcedure(${rowIdInoutValue}, ${int4rangeInoutValue}, ${int8rangeInoutValue}, ${numrangeInoutValue}, ${tsrangeInoutValue}, ${tstzrangeInoutValue}, ${daterangeInoutValue});
//         `;
//         sql:ProcedureCallResult result = callInoutProcedure(sqlQuery, "range_db");

//         test:assertEquals(int4rangeInoutValue.get(string), "[3,50)", "Int4range Datatype Doesn't Match");
//         test:assertEquals(int8rangeInoutValue.get(string), "[11,100)", "Int8range Datatype Doesn't Match");
//         test:assertEquals(numrangeInoutValue.get(string), "(0.1,2.4)", "Numrnge Datatype Doesn't Match");
//         test:assertEquals(tsrangeInoutValue.get(string), "(\"2010-01-01 14:30:00\",\"2010-01-01 15:30:00\")", "Tsrange Datatype Doesn't Match");
//         test:assertEquals(tstzrangeInoutValue.get(string), "(\"2010-01-01 14:30:00+05:30\",\"2010-01-01 15:30:00+05:30\")", "Tstzrange Datatype Doesn't Match");
//         test:assertEquals(daterangeInoutValue.get(string), "[2010-01-02,2010-01-03)", "Daterange Datatype Doesn't Match");

//         // test:assertEquals(int4rangeInoutValue.get(string), "[3,50)", "Int4range Datatype Doesn't Match");
//         // test:assertEquals(int8rangeInoutValue.get(string), "[11,100)", "Int8range Datatype Doesn't Match");
//         // test:assertEquals(numrangeInoutValue.get(string), "(0.1,2.4)", "Numrnge Datatype Doesn't Match");
//         // test:assertEquals(tsrangeInoutValue.get(string), "\"2010-01-01 14:30:00\",\"2010-01-01 15:30:00\")", "Tsrange Datatype Doesn't Match");
//         // test:assertEquals(tstzrangeInoutValue.get(string), "(\"2010-01-01 14:30:00+05:30\",\"2010-01-01 15:30:00+05:30\")", "Tstzrange Datatype Doesn't Match");
//         // test:assertEquals(daterangeInoutValue.get(string), "[2010-01-02,2010-01-03)", "Daterange Datatype Doesn't Match");

// }
 

// // // //---------------------------------------------------------------------------------------------------------------------------

// @test:Config {
//     groups: ["datatypes"]
// }
// function testTextsearchProcedureInoutCall() {
//     int rowId = 10;
//     TsvectorValue tsvectorType = new ("a fat cat sat on a mat and ate a fat rat");
//     TsqueryValue tsqueryType = new ("fat & rat");

//     InOutParameter rowIdInoutValue = new (rowId);
//     InOutParameter tsvectorInoutValue = new (tsvectorType);
//     InOutParameter tsqueryInoutValue = new (tsqueryType);

//     sql:ParameterizedCallQuery sqlQuery =
//       `
//       call TextsearchInoutProcedure(${rowIdInoutValue}, ${tsvectorInoutValue}, ${tsqueryInoutValue});
//     `;
//     sql:ProcedureCallResult result = callInoutProcedure(sqlQuery, "ts_db");

//     test:assertEquals(tsvectorInoutValue.get(string), "'a' 'and' 'ate' 'cat' 'fat' 'mat' 'on' 'rat' 'sat'", "Tsvector Datatype Doesn't Match");
//     test:assertEquals(tsqueryInoutValue.get(string), "'fat' & 'rat'", "Tsquery Datatype Doesn't Match");

// }

// // // //----------------------------------------------------------------------------------------------------------------------------

// @test:Config {
//     groups: ["datatypes"]
// }
// function testObjectidentifierProcedureInoutCall() {
//     int rowId = 10;
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

//     InOutParameter rowIdInoutValue = new (rowId);
//     InOutParameter oidInoutValue = new (oidType);
//     InOutParameter regclassInoutValue = new (regclassType);
//     InOutParameter regconfigInoutValue = new (regconfigType);
//     InOutParameter regdictionaryInoutValue = new (regdictionaryType);
//     InOutParameter regnamespaceInoutValue = new (regnamespaceType);
//     InOutParameter regoperInoutValue = new (regoperType);
//     InOutParameter regoperatorInoutValue = new (regoperatorType);
//     InOutParameter regprocInoutValue = new (regprocType);
//     InOutParameter regprocedureInoutValue = new (regprocedureType);
//     InOutParameter regroleInoutValue = new (regroleType);
//     InOutParameter regtypeInoutValue = new(regtypeType);

//     sql:ParameterizedCallQuery sqlQuery =
//       `
//       call ObjectidentifierInoutProcedure(${rowIdInoutValue}, ${oidInoutValue}, ${regclassInoutValue}, ${regconfigInoutValue}, ${regdictionaryInoutValue}, 
//                                 ${regnamespaceInoutValue}, ${regoperInoutValue}, ${regoperatorInoutValue}, ${regprocInoutValue}, ${regprocedureInoutValue},
//                                  ${regroleInoutValue}, ${regtypeInoutValue});
//     `;
//     sql:ProcedureCallResult result = callInoutProcedure(sqlQuery, "objectidentifier_db");

//     test:assertEquals(oidInoutValue.get(string), "12", "OID Datatype Doesn;t Match");
//     test:assertEquals(regclassInoutValue.get(string), "pg_type", "Reg class Datatype Doesn't Match");
//     test:assertEquals(regconfigInoutValue.get(string), "english", "Reg config Datatype Doesn;t Match");
//     test:assertEquals(regdictionaryInoutValue.get(string), "simple", "Reg Dictionary Datatype Doesn't Match");
//     test:assertEquals(regnamespaceInoutValue.get(string), "pg_catalog", "Reg namespace Datatype Doesn;t Match");
//     test:assertEquals(regoperInoutValue.get(string), "!", "Reg oper Datatype Doesn't Match");
//     test:assertEquals(regoperatorInoutValue.get(string), "*(integer,integer)", "Reg operator Datatype Doesn;t Match");
//     test:assertEquals(regprocInoutValue.get(string), "now", "Reg proc Datatype Doesn't Match");
//     test:assertEquals(regprocedureInoutValue.get(string), "sum(integer)", "Reg procedure Datatype Doesn;t Match");
//     test:assertEquals(regroleInoutValue.get(string), "postgres", "Reg role Datatype Doesn't Match");
//     test:assertEquals(regtypeInoutValue.get(string), "integer", "Reg type Datatype Doesn;t Match");

// }

// function callInoutProcedure(sql:ParameterizedCallQuery sqlQuery, string database) returns sql:ProcedureCallResult {
//     Client dbClient = checkpanic new (host, user, password, database, port);
//     sql:ProcedureCallResult result = checkpanic dbClient->call(sqlQuery);
//     checkpanic dbClient.close();
//     return result;
// }