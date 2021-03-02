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
public type GeometricRecord record {
    int row_id;
    record{} point_type;
    record{} line_type;
    record{} lseg_type;
    record{} box_type;
    record{} circle_type;
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
function testSelectFromGeometricDataTable() {
    int rowId = 4;
    InetValue inetValue = new ("192.168.0.1/24");
    CidrValue cidrValue = new ("::ffff:1.2.3.0/120");
    MacaddrValue macaddrValue = new ("08:00:2b:01:02:03");
    Macaddr8Value macaddr8Value = new ("08-00-2b-01-02-03-04-00");
    

    sql:ParameterizedQuery sqlQuery = `select line_type, point_type, box_type, lseg_type, circle_type  from geometrictypes where row_id = ${rowId}`;

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
    if (returnData is ()) {
        test:assertFail("Empty row returned.");
    } else {
        test:assertEquals(returnData["row_id"], 4);
        test:assertEquals(returnData["point_type"], {x: 1, y:2});
        test:assertEquals(returnData["line_type"], "::ffff:1.2.3.0/120");
        test:assertEquals(returnData["lseg_type"], "08:00:2b:01:02:03");   
        test:assertEquals(returnData["box_type"], "08:00:2b:01:02:03:04:00");
        // // test:assertEquals(returnData["path_type"], "::ffff:1.2.3.0/120");
        // // test:assertEquals(returnData["polygon_type"], "08:00:2b:01:02:03");   
        // test:assertEquals(returnData["circle_type"], "08:00:2b:01:02:03:04:00");
    } 
}
