import ballerina/sql;
import ballerina/test;
// import ballerina/io;
// import ballerina/time;

string networkDB = "network_db";

public type NetworkRecord record {
    
    int row_id;
    string inet_type;
    string cidr_type;
    string macaddr_type;
    string macaddr8_type;
};
// public type GeometricRecord record {
//     int row_id;
//     record{} point_type;
//     record{} line_type;
//     record{} lseg_type;
//     record{} box_type;
//     record{} circle_type;
// };

public type GeometricRecord record {
    int row_id;
    string point_type;
    string line_type;
    string lseg_type;
    string box_type;
    string circle_type;
    string? path_type;
    string? polygon_type;
};

// public type NetworkRecord record{
//     int row_id;
//     InetValue inet_type;
//     CidrValue cidr_type;
//     MacaddrValue macaddr_type;
//     Macaddr8Value macaddr8_type;
// };

@test:Config {
    groups: ["datatypes"]
}
function testInsertIntoNetworkDataTable() {
    int rowId = 4;
    InetValue inetValue = new ("192.168.0.1/24");
    CidrValue cidrValue = new ("::ffff:1.2.3.0/120");
    MacaddrValue macaddrValue = new ("08:00:2b:01:02:03");
    Macaddr8Value macaddr8Value = new ("08-00-2b-01-02-03-04-00");

    sql:ParameterizedQuery sqlQuery =
      `
    INSERT INTO NetworkTypes (row_id, inet_type, cidr_type, macaddr_type, macaddr8_type)
            VALUES(${rowId}, ${inetValue}, ${cidrValue}, ${macaddrValue}, ${macaddr8Value})
    `;
    validateResult(executeQueryPostgresqlClient(sqlQuery, "network_db"), 1, rowId);
}

@test:Config {
    groups: ["datatypes"],
    dependsOn: [testInsertIntoNetworkDataTable]
}
function testInsertIntoNetworkDataTable2() {
    int rowId = 5;
    InetValue inetValue = new ();
    CidrValue cidrValue = new ();
    MacaddrValue macaddrValue = new ();
    Macaddr8Value macaddr8Value = new ();

    sql:ParameterizedQuery sqlQuery =
      `
    INSERT INTO NetworkTypes (row_id, inet_type, cidr_type, macaddr_type, macaddr8_type)
            VALUES(${rowId}, ${inetValue}, ${cidrValue}, ${macaddrValue}, ${macaddr8Value})
    `;
    validateResult(executeQueryPostgresqlClient(sqlQuery, "network_db"), 1, rowId);
}

@test:Config {
    groups: ["datatypes"],
    dependsOn: [testInsertIntoNetworkDataTable2]
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

//------------------------------------------------------------------------------------------------------------------

@test:Config {
    groups: ["datatypes"]
}
function testInsertIntoGeometricDataTable() {
    int rowId = 4;
    PointValue pointType = new ("(1,2)");
    LineValue lineType = new ("{1,2,3}");
    LsegValue lsegType = new ("(1,1),(2,2)");
    BoxValue boxType = new ("(1,1),(2,2)");
    // PathValue pathType = new ("[(1,1),(2,2)]");
    // PolygonValue polygonType = new ("[(1,1),(2,2)]");
    CircleValue circleType = new ("<1,1,1>");

    sql:ParameterizedQuery sqlQuery =
      `
    INSERT INTO GeometricTypes (row_id, point_type, line_type, lseg_type, box_type,circle_type)
            VALUES(${rowId}, ${pointType}, ${lineType}, ${lsegType}, ${boxType},${circleType})
    `;
    validateResult(executeQueryPostgresqlClient(sqlQuery, "geometric_db"), 1, rowId);
}

@test:Config {
    groups: ["datatypes"],
    dependsOn: [testInsertIntoGeometricDataTable]
}
function testInsertIntoGeometricDataTable2() {
    int rowId = 5;
    PointValue pointType = new ({x: 2, y:2});
    LineValue lineType = new ({a:2, b:3, c:4});
    LsegValue lsegType = new ({x1: 2, x2: 3, y1: 2, y2:3});
    BoxValue boxType = new ({x1: 2, x2: 3, y1: 2, y2:3});
    // PathValue pathType = new ("[(1,1),(2,2)]");
    // PolygonValue polygonType = new ("[(1,1),(2,2)]");
    CircleValue circleType = new ({x: 2, y:2, r:2});

    sql:ParameterizedQuery sqlQuery =
      `
    INSERT INTO GeometricTypes (row_id, point_type, line_type, lseg_type, box_type,circle_type)
            VALUES(${rowId}, ${pointType}, ${lineType}, ${lsegType}, ${boxType},${circleType})
    `;
    validateResult(executeQueryPostgresqlClient(sqlQuery, "geometric_db"), 1, rowId);
}

@test:Config {
    groups: ["datatypes"],
    dependsOn: [testInsertIntoGeometricDataTable]
}
function testInsertIntoGeometricDataTable3() {
    int rowId = 6;
    PointValue pointType = new ();
    LineValue lineType = new ();
    LsegValue lsegType = new ();
    BoxValue boxType = new ();
    // PathValue pathType = new ("[(1,1),(2,2)]");
    // PolygonValue polygonType = new ("[(1,1),(2,2)]");
    CircleValue circleType = new ();

    sql:ParameterizedQuery sqlQuery =
      `
    INSERT INTO GeometricTypes (row_id, point_type, line_type, lseg_type, box_type,circle_type)
            VALUES(${rowId}, ${pointType}, ${lineType}, ${lsegType}, ${boxType},${circleType})
    `;
    validateResult(executeQueryPostgresqlClient(sqlQuery, "geometric_db"), 1, rowId);
}

// @test:Config {
//     groups: ["datatypes"],
//     dependsOn: [testInsertIntoGeometricDataTable2]
// }
// function testSelectFromGeometricDataTable() {
//     int rowId = 5;
//     // InetValue inetValue = new ("192.168.0.1/24");
//     // CidrValue cidrValue = new ("::ffff:1.2.3.0/120");
//     // MacaddrValue macaddrValue = new ("08:00:2b:01:02:03");
//     // Macaddr8Value macaddr8Value = new ("08-00-2b-01-02-03-04-00");
    

//     sql:ParameterizedQuery sqlQuery = `select * from geometrictypes`;

//     Client dbClient = checkpanic new (host, user, password, "geometric_db", port);
//     stream<record {}, error> streamData = dbClient->query(sqlQuery, GeometricRecord);
//     record {|record {} value;|}? data = checkpanic streamData.next();
//     checkpanic streamData.close();
//     record {}? value = data?.value;
//     checkpanic dbClient.close();
//     io:println("value", data);
//     validateGeometricTableResult(value);

//     // _ = validateGeometricTableResult(simpleQueryPostgresqlClient(sqlQuery, GeometricRecord, database = "geometric_db"));
// }

// public function validateGeometricTableResult(record{}? returnData) {
//     PointValue pointType = new ("(1,2)");
//     LineValue lineType = new ("{1,2,3}");
//     LsegValue lsegType = new ("(1,1),(2,2)");
//     BoxValue boxType = new ("(1,1),(2,2)");
//     // PathValue pathType = new ("[(1,1),(2,2)]");
//     // PolygonValue polygonType = new ("[(1,1),(2,2)]");
//     CircleValue circleType = new ("<1,1,1>");
//     io:println("returnData", returnData);
//     if (returnData is ()) {
//         test:assertFail("Empty row returned.");
//     } else {
//         test:assertEquals(returnData["row_id"], 4);
//         // test:assertEquals(returnData["point_type"], {x: 1, y:2});
//         // test:assertEquals(returnData["line_type"], "::ffff:1.2.3.0/120");
//         // test:assertEquals(returnData["lseg_type"], "08:00:2b:01:02:03");   
//         // test:assertEquals(returnData["box_type"], "08:00:2b:01:02:03:04:00");
//         // // test:assertEquals(returnData["path_type"], "::ffff:1.2.3.0/120");
//         // // test:assertEquals(returnData["polygon_type"], "08:00:2b:01:02:03");   
//         // test:assertEquals(returnData["circle_type"], "08:00:2b:01:02:03:04:00");
//     } 
// }

//--------------------------------------------------------------------------------------------------------------

public type UuidRecord record {
  int row_id;
  string uuid_type;
};

@test:Config {
    groups: ["datatypes"]
}
function testInsertIntoUuidDataTable() {
    int rowId = 3;
    UuidValue uuidType = new ("a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11");

    sql:ParameterizedQuery sqlQuery =
      `
    INSERT INTO UuidTypes (row_id, uuid_type)
            VALUES(${rowId}, ${uuidType})
    `;
    validateResult(executeQueryPostgresqlClient(sqlQuery, "uuid_db"), 1, rowId);
}

@test:Config {
    groups: ["datatypes"],
    dependsOn: [testInsertIntoUuidDataTable]
}
function testInsertIntoUuidDataTable2() {
    int rowId = 4;
    UuidValue uuidType = new ();

    sql:ParameterizedQuery sqlQuery =
      `
    INSERT INTO UuidTypes (row_id, uuid_type)
            VALUES(${rowId}, ${uuidType})
    `;
    validateResult(executeQueryPostgresqlClient(sqlQuery, "uuid_db"), 1, rowId);
}

@test:Config {
    groups: ["datatypes"],
    dependsOn: [testInsertIntoUuidDataTable2]
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

//---------------------------------------------------------------------------------------------------------------------

public type TextSearchRecord record {
  int row_id;
  string tsvector_type;
  string tsquery_type;
};

@test:Config {
    groups: ["datatypes"]
}
function testInsertIntoTextSearchDataTable() {
    int rowId = 3;
    TsvectorValue tsvectorType = new ("a fat cat sat on a mat and ate a fat rat");
    TsqueryValue tsqueryType = new ("fat & rat");

    sql:ParameterizedQuery sqlQuery =
      `
    INSERT INTO TextSearchTypes (row_id, tsvector_type, tsquery_type)
            VALUES(${rowId}, ${tsvectorType}, ${tsqueryType})
    `;
    validateResult(executeQueryPostgresqlClient(sqlQuery, "ts_db"), 1, rowId);
}

@test:Config {
    groups: ["datatypes"],
    dependsOn: [testInsertIntoUuidDataTable]
}
function testInsertIntoTextSearchDataTable2() {
    int rowId = 4;
    TsvectorValue tsvectorType = new ();
    TsqueryValue tsqueryType = new ();

    sql:ParameterizedQuery sqlQuery =
      `
    INSERT INTO TextSearchTypes (row_id, tsvector_type, tsquery_type)
            VALUES(${rowId}, ${tsvectorType}, ${tsqueryType})
    `;
    validateResult(executeQueryPostgresqlClient(sqlQuery, "ts_db"), 1, rowId);
}

@test:Config {
    groups: ["datatypes"],
    dependsOn: [testInsertIntoUuidDataTable2]
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

//--------------------------------------------------------------------------------------------------------------------

public type JsonRecord record {
  int row_id;
  json json_type;
  json jsonb_type;
  string jsonpath_type;
};
//         json jj = {"a":11,"b":2};
//         json jj2 = {"a":22,"b":2};
//         json jj3 = {"a":33,"b":2};

//         // postgresql:JsonValue j = new(jj);
//         // postgresql:JsonValue j2 = new(jj2);
//         // postgresql:JsonValue j3 = new(jj3);

//         // postgresql:JsonValue j = new("{\"a\":1,\"b\":\"Hello\"}");
//         // postgresql:JsonValue j2 = new("{\"a\":2,\"b\":\"Hello\"}");
//         // postgresql:JsonValue j3 = new("{\"a\":3,\"b\":\"Hello\"}");

@test:Config {
    groups: ["datatypes"]
}
function testInsertIntoJsonDataTable() {
    int rowId = 3;
    JsonValue jsonType = new("{\"a\":1,\"b\":\"Hello\"}");
    JsonbValue jsonbType = new("{\"a\":2,\"b\":\"Hello\"}");
    JsonpathValue jsonpathType = new("$.\"floor\"[*].\"apt\"[*]?(@.\"area\" > 40 && @.\"area\" < 90)?(@.\"rooms\" > 1)");
    sql:ParameterizedQuery sqlQuery =
      `
    INSERT INTO JsonTypes (row_id, json_type, jsonb_type, jsonpath_type)
            VALUES(${rowId}, ${jsonType}, ${jsonbType}, ${jsonpathType})
    `;
    validateResult(executeQueryPostgresqlClient(sqlQuery, "json_db"), 1, rowId);
}

@test:Config {
    groups: ["datatypes"],
    dependsOn: [testInsertIntoUuidDataTable]
}
function testInsertIntoJsonDataTable2() {
    int rowId = 4;
    JsonValue jsonType = new();
    JsonbValue jsonbType = new();
    JsonpathValue jsonpathType = new();

    sql:ParameterizedQuery sqlQuery =
      `
    INSERT INTO JsonTypes (row_id, json_type, jsonb_type, jsonpath_type)
            VALUES(${rowId}, ${jsonType}, ${jsonbType}, ${jsonpathType})
    `;
    validateResult(executeQueryPostgresqlClient(sqlQuery, "json_db"), 1, rowId);
}

@test:Config {
    groups: ["datatypes"],
    dependsOn: [testInsertIntoUuidDataTable2]
}
function testInsertIntoJsonDataTable3() {
    int rowId = 5;
    json jsonValue = {"a":11,"b":2};
    JsonValue jsonType = new(jsonValue);
    JsonbValue jsonbType = new(jsonValue);
    JsonpathValue jsonpathType = new("$.\"floor\"[*].\"apt\"[*]?(@.\"area\" > 40 && @.\"area\" < 90)?(@.\"rooms\" > 10)");

    sql:ParameterizedQuery sqlQuery =
      `
    INSERT INTO JsonTypes (row_id, json_type, jsonb_type, jsonpath_type)
            VALUES(${rowId}, ${jsonType}, ${jsonbType}, ${jsonpathType})
    `;
    validateResult(executeQueryPostgresqlClient(sqlQuery, "json_db"), 1, rowId);
}

@test:Config {
    groups: ["datatypes"],
    dependsOn: [testInsertIntoUuidDataTable2]
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