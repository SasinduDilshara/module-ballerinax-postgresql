@test:Config {
    groups: ["query","query-simple-params"]
}
function queryPointParam() {
    int rowId = 1;
    PointValue pointValue1 = new ("(1,2)");
    PointValue pointValue2 = new ({x: 1, y:2});
    sql:ParameterizedQuery sqlQuery1 = `SELECT * from GeometricTypes WHERE GeometricTypes.point_type = ${pointValue1}`;
    sql:ParameterizedQuery sqlQuery2 = `SELECT * from GeometricTypes WHERE GeometricTypes.point_type = ${pointValue1} and row_id = ${rowId}`;
    sql:ParameterizedQuery sqlQuery3 = `SELECT * from GeometricTypes WHERE GeometricTypes.point_type = ${pointValue2}`;
    sql:ParameterizedQuery sqlQuery4 = `SELECT * from GeometricTypes WHERE GeometricTypes.point_type = ${pointValue2} and row_id = ${rowId}`;

    validateGeometricTableQueryResult(simpleQueryPostgresqlClient(sqlQuery1, database = simpleParamsDb));
    validateGeometricTableQueryResult(simpleQueryPostgresqlClient(sqlQuery2, database = simpleParamsDb));
    validateGeometricTableQueryResult(simpleQueryPostgresqlClient(sqlQuery3, database = simpleParamsDb));
    validateGeometricTableQueryResult(simpleQueryPostgresqlClient(sqlQuery4, database = simpleParamsDb));
}

@test:Config {
    groups: ["query","query-simple-params"]
}
function queryJsonParam() {
    int rowId = 1;
    json jsonValue = {"key1": "value", "key2": 2};
    JsonValue jsonValue1 = new ("{\"key1\": \"value\", \"key2\": 2}");
    JsonValue jsonValue2 = new (jsonValue);
    sql:ParameterizedQuery sqlQuery1 = `SELECT * from JsonTypes WHERE json_type = ${jsonValue1}`;
    sql:ParameterizedQuery sqlQuery2 = `SELECT * from JsonTypes WHERE json_type = ${jsonValue1} and row_id = ${rowId}`;
    sql:ParameterizedQuery sqlQuery3 = `SELECT * from JsonTypes WHERE json_type = ${jsonValue2}`;
    sql:ParameterizedQuery sqlQuery4 = `SELECT * from JsonTypes WHERE json_type = ${jsonValue2} and row_id = ${rowId}`;

    validateJsonTableQueryResult(simpleQueryPostgresqlClient(sqlQuery1, database = simpleParamsDb));
    validateJsonTableQueryResult(simpleQueryPostgresqlClient(sqlQuery2, database = simpleParamsDb));
    validateJsonTableQueryResult(simpleQueryPostgresqlClient(sqlQuery3, database = simpleParamsDb));
    validateJsonTableQueryResult(simpleQueryPostgresqlClient(sqlQuery4, database = simpleParamsDb));

}