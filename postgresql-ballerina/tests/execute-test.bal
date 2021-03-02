import ballerina/sql;
import ballerina/test;
// import ballerina/io;
// import ballerina/time;

string networkParamsDb = "network_params_db";

public type NetworkRecord record{
    
    int row_id;
    string inet_type;
    string cidr_type;
    string macaddr_type;
    string macaddr8_type;
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