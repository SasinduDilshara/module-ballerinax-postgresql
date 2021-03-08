import ballerina/sql;
import ballerina/test;
import ballerina/io;
import ballerina/time;

public function cc(){
    io:println(1);
    time:Time|error timeValue = time:createTime(2017, 3, 28, 23, 42, 45,554, "Asia/Colombo");

}
//========================================================================================================================

@test:Config {
    groups: ["datatypes"]
}
function testSelectFromNumericDataTable() {
    int rowId = 3;
    
    sql:ParameterizedQuery sqlQuery = `select * from Numerictypes where row_id = ${rowId}`;

    _ = validateNumericTableResult(simpleQueryPostgresqlClient(sqlQuery, NumericRecord, database = "numeric_db"));
}

public function validateNumericTableResult(record{}? returnData) {
    if (returnData is ()) {
        test:assertFail("Empty row returned.");
    } else {
        decimal decimalVal = 1234.567;
        test:assertEquals(returnData["row_id"], 3);
        test:assertEquals(returnData["smallint_type"], 1);
        test:assertEquals(returnData["int_type"], 1);
        test:assertEquals(returnData["bigint_type"], 123456);
        test:assertEquals(returnData["decimal_type"], decimalVal);
        test:assertEquals(returnData["numeric_type"], decimalVal);
        test:assertTrue(returnData["real_type"] is float);
        test:assertTrue(returnData["double_type"] is float);
        test:assertEquals(returnData["smallserial_type"], 1);
        test:assertEquals(returnData["serial_type"], 123);
        test:assertEquals(returnData["bigserial_type"], 12345);
    } 
}

//========================================================================================================================

@test:Config {
    groups: ["datatypes"]
}
function testSelectFromCharacterDataTable() {
    int rowId = 4;
    
    sql:ParameterizedQuery sqlQuery = `select * from charactertypes where row_id = ${rowId}`;

    _ = validateCharacterTableResult(simpleQueryPostgresqlClient(sqlQuery, CharacterRecord, database = "character_db"));
}

public function validateCharacterTableResult(record{}? returnData) {
    if (returnData is ()) {
        test:assertFail("Empty row returned.");
    } else {
        test:assertEquals(returnData["row_id"], 4);
        test:assertEquals(returnData["char_type"], "This is a char3");
        test:assertEquals(returnData["varchar_type"], "This is a varchar3");
        test:assertEquals(returnData["text_type"], "This is a text3");   
        test:assertEquals(returnData["name_type"], "This is a name3");
    } 
}

//========================================================================================================================
@test:Config {
    groups: ["datatypes"]
}
function testSelectFromBooleanDataTable() {
    int rowId = 3;
    
    sql:ParameterizedQuery sqlQuery = `select * from booleantypes where row_id = ${rowId}`;

    _ = validateBooleanTableResult(simpleQueryPostgresqlClient(sqlQuery, BooleanRecord, database = "boolean_db"));
}

public function validateBooleanTableResult(record{}? returnData) {
    if (returnData is ()) {
        test:assertFail("Empty row returned.");
    } else {
        test:assertEquals(returnData["row_id"], 3);
        test:assertEquals(returnData["boolean_type"], true);
    } 
}
//========================================================================================================================

@test:Config {
    groups: ["datatypes"]
}
function testSelectFromNetworkDataTable() {
    int rowId = 4;
    InetValue inetValue = new ("192.168.0.1/24");
    CidrValue cidrValue = new ("::ffff:1.2.3.0/120");
    MacaddrValue macaddrValue = new ("08:00:2b:01:02:03");
    Macaddr8Value macaddr8Value = new ("08-00-2b-01-02-03-04-00");
    
    sql:ParameterizedQuery sqlQuery = `select * from networktypes where row_id = ${rowId}`;

    _ = validateNetworkTableResult(simpleQueryPostgresqlClient(sqlQuery, NetworkRecord, database = "network_db"));
}

public function validateNetworkTableResult(record{}? returnData) {
    if (returnData is ()) {
        test:assertFail("Empty row returned.");
    } else {
        test:assertEquals(returnData["row_id"], 4);
        test:assertEquals(returnData["inet_type"], "192.168.0.1/24");
        test:assertEquals(returnData["cidr_type"], "::ffff:1.2.3.0/120");
        test:assertEquals(returnData["macaddr_type"], "08:00:2b:01:02:03");   
        test:assertEquals(returnData["macaddr8_type"], "08:00:2b:01:02:03:04:00");
    } 
}

//========================================================================================================================


@test:Config {
    groups: ["datatypes"]
}
function testSelectFromGeometricDataTable() {
    int rowId = 5;

    sql:ParameterizedQuery sqlQuery = `select * from geometrictypes where row_id = ${rowId}`;

     _ = validateGeometricTableResult(simpleQueryPostgresqlClient(sqlQuery, GeometricRecord, database = "geometric_db"));
}

public function validateGeometricTableResult(record{}? returnData) {
    PointValue pointType = new ("(1,2)");
    LineValue lineType = new ("{1,2,3}");
    LsegValue lsegType = new ("(1,1),(2,2)");
    BoxValue boxType = new ("(1,1),(2,2)");
    // PathValue pathType = new ("[(1,1),(2,2)]");
    // PolygonValue polygonType = new ("[(1,1),(2,2)]");
    CircleValue circleType = new ("<1,1,1>");
    // io:println("returnData", returnData);
    if (returnData is ()) {
        test:assertFail("Empty row returned.");
    } else {
        test:assertEquals(returnData["row_id"], 5);
        test:assertEquals(returnData["point_type"], "(2,2)");
        test:assertEquals(returnData["line_type"], "{2,3,4}");
        test:assertEquals(returnData["lseg_type"], "[(2,2),(3,3)]");   
        test:assertEquals(returnData["box_type"], "(3,3),(2,2)"); 
        test:assertEquals(returnData["circle_type"], "<(2,2),2>");
    } 
}

//========================================================================================================================

@test:Config {
    groups: ["datatypes"]
}
function testSelectFromUuidDataTable() {
    int rowId = 3;
    UuidValue uuidType = new ("a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11");
    
    sql:ParameterizedQuery sqlQuery = `select * from uuidtypes where row_id = ${rowId}`;

    _ = validateUuidTableResult(simpleQueryPostgresqlClient(sqlQuery, UuidRecord, database = "uuid_db"));
}

public function validateUuidTableResult(record{}? returnData) {
    if (returnData is ()) {
        test:assertFail("Empty row returned.");
    } else {
        test:assertEquals(returnData["row_id"], 3);
        test:assertEquals(returnData["uuid_type"], "a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11");
    } 
}

//========================================================================================================================

@test:Config {
    groups: ["datatypes"]
}
function testSelectFromTextSearchDataTable() {
    int rowId = 3;
    
    sql:ParameterizedQuery sqlQuery = `select * from TextSearchTypes where row_id = ${rowId}`;

    _ = validateTextSearchTableResult(simpleQueryPostgresqlClient(sqlQuery, TextSearchRecord, database = "ts_db"));
}

public function validateTextSearchTableResult(record{}? returnData) {
    if (returnData is ()) {
        test:assertFail("Empty row returned.");
    } else {
        test:assertEquals(returnData["row_id"], 3);
        test:assertEquals(returnData["tsvector_type"], "'a' 'and' 'ate' 'cat' 'fat' 'mat' 'on' 'rat' 'sat'");
        test:assertEquals(returnData["tsquery_type"], "'fat' & 'rat'");
    } 
}

//========================================================================================================================


@test:Config {
    groups: ["datatypes"]
}
function testSelectFromJsonDataTable() {
    int rowId = 5;
    
    sql:ParameterizedQuery sqlQuery = `select * from JsonTypes where row_id = ${rowId}`;

    _ = validateJsonTableResult(simpleQueryPostgresqlClient(sqlQuery, JsonRecord, database = "json_db"));
}

public function validateJsonTableResult(record{}? returnData) {
    if (returnData is ()) {
        test:assertFail("Empty row returned.");
    } else {
        test:assertEquals(returnData["row_id"], 5);
        test:assertEquals(returnData["json_type"], {"a":11,"b":2});
        test:assertEquals(returnData["jsonb_type"], {"a":11,"b":2});
        test:assertEquals(returnData["jsonpath_type"], "$.\"floor\"[*].\"apt\"[*]?(@.\"area\" > 40 && @.\"area\" < 90)?(@.\"rooms\" > 10)");
    } 
}

//========================================================================================================================

@test:Config {
    groups: ["datatypes"]
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

//========================================================================================================================

@test:Config {
    groups: ["datatypes"]
}
function testSelectFromRangeDataTable() {
    int rowId = 5;
    
    sql:ParameterizedQuery sqlQuery = `select * from RangeTypes where row_id = ${rowId}`;

    _ = validateRangeTableResult(simpleQueryPostgresqlClient(sqlQuery, RangeRecord, database = "range_db"));
}

public function validateRangeTableResult(record{}? returnData) {
    if (returnData is ()) {
        test:assertFail("Empty row returned.");
    } else {
        io:println(returnData);
        test:assertEquals(returnData["row_id"], 5);
        test:assertEquals(returnData["int4range_type"], "[3,50)");
        test:assertEquals(returnData["int8range_type"], "[11,100)");
        test:assertEquals(returnData["numrange_type"], "(0.1,2.4)");
        test:assertEquals(returnData["tsrange_type"], "(\"2010-01-01 14:30:00\",\"2010-01-01 15:30:00\")");
        test:assertEquals(returnData["tstzrange_type"], "(\"2010-01-01 14:30:00+05:30\",\"2010-01-01 15:30:00+05:30\")");
        test:assertEquals(returnData["daterange_type"], "[2010-01-02,2010-01-03)");
    } 
}

//========================================================================================================================

@test:Config {
    groups: ["datatypes"]
}
function testSelectFromBitDataTable() {
    int rowId = 3;
    
    sql:ParameterizedQuery sqlQuery = `select row_id, varbitstring_type, bit_type from BitTypes where row_id = ${rowId}`;

    _ = validateBitTableResult(simpleQueryPostgresqlClient(sqlQuery, BitRecord, database = "bitstring_db"));
}

public function validateBitTableResult(record{}? returnData) {
    if (returnData is ()) {
        test:assertFail("Empty row returned.");
    } else {
        test:assertEquals(returnData["row_id"], 3);
        // test:assertEquals(returnData["bitstring_type"], "1110001100");
        test:assertEquals(returnData["varbitstring_type"], "11001");
        test:assertEquals(returnData["bit_type"], false);
    } 
}

//========================================================================================================================

@test:Config {
    groups: ["datatypes"]
}
function testSelectFromPglsnDataTable() {
    int rowId = 3;
    
    sql:ParameterizedQuery sqlQuery = `select * from Pglsntypes where row_id = ${rowId}`;

    _ = validatePglsnTableResult(simpleQueryPostgresqlClient(sqlQuery, PglsnRecord, database = "pglsn_db"));
}

public function validatePglsnTableResult(record{}? returnData) {
    if (returnData is ()) {
        test:assertFail("Empty row returned.");
    } else {
        test:assertEquals(returnData["row_id"], 3);
        test:assertEquals(returnData["pglsn_type"], "16/B374D848");
    } 
}

//========================================================================================================================

@test:Config {
    groups: ["datatypes"]
}
function testSelectFromObjectidentifierDataTable() {
    int rowId = 3;
    
    sql:ParameterizedQuery sqlQuery = `select * from Objectidentifiertypes where row_id = ${rowId}`;

    _ = validateObjectidentifierTableResult(simpleQueryPostgresqlClient(sqlQuery, ObjectidentifierRecord, database = "objectidentifier_db"));
}

public function validateObjectidentifierTableResult(record{}? returnData) {
    if (returnData is ()) {
        test:assertFail("Empty row returned.");
    } else {
        test:assertEquals(returnData["row_id"], 3);
        test:assertEquals(returnData["oid_type"], "12");
        test:assertEquals(returnData["regclass_type"], "pg_type");
        test:assertEquals(returnData["regconfig_type"], "english");
        test:assertEquals(returnData["regdictionary_type"], "simple");
        test:assertEquals(returnData["regnamespace_type"], "pg_catalog");
        test:assertEquals(returnData["regoper_type"], "!");
        test:assertEquals(returnData["regoperator_type"], "*(integer,integer)");
        test:assertEquals(returnData["regproc_type"], "now");
        test:assertEquals(returnData["regprocedure_type"], "sum(integer)");
        test:assertEquals(returnData["regrole_type"], "postgres");
        test:assertEquals(returnData["regtype_type"], "integer");
    } 
}

//========================================================================================================================
