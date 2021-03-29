import ballerina/sql;
import ballerina/test;

@test:Config {
    groups: ["execute", "execute-params"]
}
function testPointArray() {
    int rowId = 43;
    Point pointRecord = {x: 1, y: 2};
    PGArrayValue pointarray = new ([pointRecord, pointRecord, pointRecord, pointRecord]);

    sql:ParameterizedQuery sqlQuery =
      `
    INSERT INTO ArrayTypes2 (row_id, pointarray_type)
            VALUES(${rowId}, ${pointarray})
    `;
    validateCustomResult(executeCustomQueryPostgresqlClient(sqlQuery, executeParamsDatabase), 1, rowId);
}


function executeCustomQueryPostgresqlClient(sql:ParameterizedQuery sqlQuery, string database) returns sql:ExecutionResult {
    Client dbClient = checkpanic new (host, user, password, database, port);
    sql:ExecutionResult result = checkpanic dbClient->execute(sqlQuery);
    checkpanic dbClient.close();
    return result;
}

isolated function validateCustomResult(sql:ExecutionResult result, int rowCount, int? lastId = ()) {
    test:assertExactEquals(result.affectedRowCount, rowCount, "Affected row count is different.");

    if (lastId is ()) {
        test:assertEquals(result.lastInsertId, (), "Last Insert Id is not nil.");
    } else {
        int|string? lastInsertIdVal = result.lastInsertId;
        if (lastInsertIdVal is int) {
            test:assertTrue(lastInsertIdVal >= 1, "Last Insert Id is nil.");
        } else {
            test:assertFail("The last insert id should be an integer.");
        }
    }

}

public type CustomArrayRecord record {
  int row_id;
  Point[]? pointarray_type;
};

@test:Config {
    groups: ["execute-params", "execute"]
}
function testSelectFromCustomArrayDataTable() {
    int rowId = 1;
    
    sql:ParameterizedQuery sqlQuery = `select * from ArrayTypes2 where row_id = ${rowId}`;

    _ = validateCustomArrayTableResult(simpleCustomQueryPostgresqlClient(sqlQuery, CustomArrayRecord, database = executeParamsDatabase));
}

isolated function validateCustomArrayTableResult(record{}? returnData) {
    if (returnData is ()) {
        test:assertFail("Empty row returned.");
    } else {
        test:assertEquals(returnData["row_id"], 1);
        test:assertEquals(returnData["pointarray_type"], [{x: 1, y: 2}, {x: 1, y: 2}]);
    } 
}

// @test:Config {
//     groups: ["execute-params", "execute"],
//     dependsOn: [testSelectFromCustomArrayDataTable]
// }
// function testSelectFromCustomArrayDataTable2() {
//     int rowId = 2;
    
//     sql:ParameterizedQuery sqlQuery = `select * from ArrayTypes2 where row_id = ${rowId}`;

//     _ = validateCustomArrayTableResult2(simpleCustomQueryPostgresqlClient(sqlQuery, CustomArrayRecord, database = executeParamsDatabase));
// }

isolated function validateCustomArrayTableResult2(record{}? returnData) {
    if (returnData is ()) {
        test:assertFail("Empty row returned.");
    } else {
        test:assertEquals(returnData["row_id"], 2);
        test:assertEquals(returnData["pointarray_type"], ());
    } 
}

function simpleCustomQueryPostgresqlClient(@untainted string|sql:ParameterizedQuery sqlQuery, typedesc<record {}>? resultType = (), string database = simpleParamsDb)
returns @tainted record {}? {
    Client dbClient = checkpanic new (host, user, password, database, port);
    stream<record {}, error> streamData = dbClient->query(sqlQuery, resultType);
    record {|record {} value;|}? data = checkpanic streamData.next();
    checkpanic streamData.close();
    record {}? value = data?.value;
    checkpanic dbClient.close();
    return value;
}