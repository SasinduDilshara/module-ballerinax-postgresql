import ballerina/sql;
import ballerina/test;
// import ballerina/io;
// import ballerina/time;

string networkParamsDb = "network_params_db";

@test:Config {
    groups: ["datatypes"]
}
function testInsertIntoNetworkDataTable() {
    int rowId = 4;
    InetValue inetValue = new ("192.168.0.1/24");
    CidrValue cidrValue = new ("::ffff:1.2.3.0/120");
    MacaddrValue macaddrValue = new ("08:00:2b:01:02:03");
    Macaddr8Value macaddr8Value = new ("08-00-2b-01-02-03-04-0");

    sql:ParameterizedQuery sqlQuery =
      `
    INSERT INTO NetworkTable (row_id, inet_type, cidr_type, macaddr_type, macaddr8_type)
            VALUES(${rowId}, ${inetValue}, ${cidrValue}, ${macaddrValue}, ${macaddr8Value})
    `;
    validateResult(executeQueryPostgresqlClient(sqlQuery), 1, rowId);
}