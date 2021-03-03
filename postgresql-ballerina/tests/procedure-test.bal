import ballerina/sql;
import ballerina/test;
// import ballerina/io;
// import ballerina/time;

public type NetworkProcedureRecord record {
    
    int row_id;
    string inet_type;
    string cidr_type;
    string macaddr_type;
    string macaddr8_type;
};

@test:Config {
    groups: ["datatypes"]
}
function testNetworkProcedureCall() {
    int rowId = 2;
    InetValue inetValue = new ("192.168.0.2/24");
    CidrValue cidrValue = new ("::ffff:1.2.3.0/120");
    MacaddrValue macaddrValue = new ("08:00:2b:01:02:03");
    Macaddr8Value macaddr8Value = new ("08-00-2b-01-02-03-04-00");

    sql:ParameterizedCallQuery sqlQuery =
      `
      call NetworkProcedure(${rowId}, ${inetValue}, ${cidrValue}, ${macaddrValue}, ${macaddr8Value});
    `;
    sql:ProcedureCallResult result = callProcedure(sqlQuery, "network_db");

    sql:ParameterizedQuery query = `SELECT row_id, inet_type, cidr_type, macaddr_type, macaddr8_type from NetworkTypes where row_id = ${rowId}`;

    NetworkProcedureRecord expectedDataRow = {
        row_id: rowId,
        inet_type: "192.168.0.2/24",
        cidr_type: "::ffff:1.2.3.0/120",
        macaddr_type: "08:00:2b:01:02:03",
        macaddr8_type: "08:00:2b:01:02:03:04:00"
    };
 
    test:assertEquals(queryProcedureClient(query, "network_db", NetworkProcedureRecord), expectedDataRow, "Network Call procedure insert and query did not match.");

}

//---------------------------------------------------------------------------------------------------------------------------------------------------

public type GeometricProcedureRecord record {
    int row_id;
    string point_type;
    string line_type;
    string lseg_type;
    string box_type;
    string circle_type;
    // string? path_type;
    // string? polygon_type;
};

@test:Config {
    groups: ["datatypes"]
}
function testGeometricProcedureCall() {
    int rowId = 2;
    PointValue pointType = new ({x: 2, y:2});
    LineValue lineType = new ({a:2, b:3, c:4});
    LsegValue lsegType = new ({x1: 2, x2: 3, y1: 2, y2:3});
    BoxValue boxType = new ({x1: 2, x2: 3, y1: 2, y2:3});
    // PathValue pathType = new ("[(1,1),(2,2)]");
    // PolygonValue polygonType = new ("[(1,1),(2,2)]");
    CircleValue circleType = new ({x: 2, y:2, r:2});

    sql:ParameterizedCallQuery sqlQuery =
      `
      call GeometricProcedure(${rowId}, ${pointType}, ${lineType}, ${lsegType}, ${boxType}, ${circleType});
    `;
    sql:ProcedureCallResult result = callProcedure(sqlQuery, "geometric_db");

    sql:ParameterizedQuery query = `SELECT row_id, point_type, line_type, lseg_type, box_type, circle_type from GeometricTypes where row_id = ${rowId}`;

    GeometricProcedureRecord expectedDataRow = {
        row_id: rowId,
        point_type: "(2,2)",
        line_type: "{2,3,4}",
        lseg_type: "[(2,2),(3,3)]",
        box_type: "(3,3),(2,2)",
        circle_type: "<(2,2),2>"
    };
 
    test:assertEquals(queryProcedureClient(query, "geometric_db", GeometricProcedureRecord), expectedDataRow, "Geometric Call procedure insert and query did not match.");

}

//----------------------------------------------------------------------------------------------------------------------------------------------------

function queryProcedureClient(@untainted string|sql:ParameterizedQuery sqlQuery, string database, typedesc<record {}>? resultType = ())
returns @tainted record {} {
    Client dbClient = checkpanic new (host, user, password, database, port);
    stream<record{}, error> streamData = dbClient->query(sqlQuery, resultType);
    record {|record {} value;|}? data = checkpanic streamData.next();
    checkpanic streamData.close();
    record {}? value = data?.value;
    checkpanic dbClient.close();
    if (value is ()) {
        return {};
    } else {
        return value;
    }
}

function callProcedure(sql:ParameterizedCallQuery sqlQuery, string database) returns sql:ProcedureCallResult {
    Client dbClient = checkpanic new (host, user, password, database, port);
    sql:ProcedureCallResult result = checkpanic dbClient->call(sqlQuery);
    return result;
}


