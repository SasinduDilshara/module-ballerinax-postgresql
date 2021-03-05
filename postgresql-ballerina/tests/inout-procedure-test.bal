import ballerina/sql;
import ballerina/test;
// import ballerina/io;
import ballerina/time;

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


public type UuidProcedureRecord record {
    int row_id;
    string uuid_type;
};

@test:Config {
    groups: ["datatypes"]
}
function testUuidProcedureCall() {
    int rowId = 2;
    UuidValue uuidType = new ("a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12");

    sql:ParameterizedCallQuery sqlQuery =
      `
      call UuidProcedure(${rowId}, ${uuidType});
    `;
    sql:ProcedureCallResult result = callProcedure(sqlQuery, "uuid_db");

    sql:ParameterizedQuery query = `SELECT row_id, uuid_type from UuidTypes where row_id = ${rowId}`;

    UuidProcedureRecord expectedDataRow = {
        row_id: rowId,
        uuid_type: "a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12"
    };
 
    test:assertEquals(queryProcedureClient(query, "uuid_db", UuidProcedureRecord), expectedDataRow, "Uuid Call procedure insert and query did not match.");

}

//----------------------------------------------------------------------------------------------------------------------------------------------------

public type PglsnProcedureRecord record {
    int row_id;
    string pglsn_type;
};

@test:Config {
    groups: ["datatypes"]
}
function testPglsnProcedureCall() {
    int rowId = 2;
    PglsnValue pglsnType = new ("16/B374D848");

    sql:ParameterizedCallQuery sqlQuery =
      `
      call PglsnProcedure(${rowId}, ${pglsnType});
    `;
    sql:ProcedureCallResult result = callProcedure(sqlQuery, "pglsn_db");

    sql:ParameterizedQuery query = `SELECT row_id, pglsn_type from PglsnTypes where row_id = ${rowId}`;

    PglsnProcedureRecord expectedDataRow = {
        row_id: rowId,
        pglsn_type: "16/B374D848"
    };
 
    test:assertEquals(queryProcedureClient(query, "pglsn_db", PglsnProcedureRecord), expectedDataRow, "Pglsn Call procedure insert and query did not match.");

}

//-------------------------------------------------------------------------------------------------------------------------

public type JsonProcedureRecord record {
    int row_id;
    json json_type;
    json jsonb_type;
    string jsonpath_type;
};

@test:Config {
    groups: ["datatypes"]
}
function testJsonProcedureCall() {
    int rowId = 2;
    json jsonValue = {"a":11,"b":2};
    JsonValue jsonType = new(jsonValue);
    JsonbValue jsonbType = new(jsonValue);
    JsonpathValue jsonpathType = new("$.\"floor\"[*].\"apt\"[*]?(@.\"area\" > 40 && @.\"area\" < 90)?(@.\"rooms\" > 10)");

    sql:ParameterizedCallQuery sqlQuery =
      `
      call JsonProcedure(${rowId}, ${jsonType}, ${jsonbType}, ${jsonpathType});
    `;
    sql:ProcedureCallResult result = callProcedure(sqlQuery, "json_db");

    sql:ParameterizedQuery query = `SELECT row_id, json_type, jsonb_type, jsonpath_type from JsonTypes where row_id = ${rowId}`;

    JsonProcedureRecord expectedDataRow = {
        row_id: rowId,
        json_type: jsonValue,
        jsonb_type: jsonValue,
        jsonpath_type: "$.\"floor\"[*].\"apt\"[*]?(@.\"area\" > 40 && @.\"area\" < 90)?(@.\"rooms\" > 10)"
    };
 
    test:assertEquals(queryProcedureClient(query, "json_db", JsonProcedureRecord), expectedDataRow, "Json Call procedure insert and query did not match.");

}

//-------------------------------------------------------------------------------------------------------------------------

public type BitProcedureRecord record {
    int row_id;
    // string bitstring_type;
    string varbitstring_type;
    boolean bit_type;
};

@test:Config {
    groups: ["datatypes"]
}
function testBitProcedureCall() {
    int rowId = 2;
    VarbitstringValue bitstringType = new("1110001100");
    VarbitstringValue varbitstringType = new("111110");
    PGBitValue bitType = new("1");

    sql:ParameterizedCallQuery sqlQuery =
      `
      call BitProcedure(${rowId}, ${varbitstringType}, ${bitType});
    `;
    sql:ProcedureCallResult result = callProcedure(sqlQuery, "bitstring_db");

    sql:ParameterizedQuery query = `SELECT row_id, varbitstring_type, bit_type from BitTypes where row_id = ${rowId}`;

    BitProcedureRecord expectedDataRow = {
        row_id: rowId,
        // bitstring_type: "1110001100",
        varbitstring_type: "111110",
        bit_type: true
    };
 
    test:assertEquals(queryProcedureClient(query, "bitstring_db", BitProcedureRecord), expectedDataRow, "Bit Call procedure insert and query did not match.");

}

//-----------------------------------------------------------------------------------------------------------------------

public type DatetimeProcedureRecord record {
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
function testDatetimeProcedureCall() {

    time:Time|error timeValue = time:createTime(2017, 3, 28, 23, 42, 45,554, "Asia/Colombo");
    if(timeValue is time:Time){
        int rowId = 2;
        sql:TimestampValue timestampType = new(timeValue);
        sql:TimestampValue timestamptzType = new(timeValue);
        sql:DateValue dateType = new(timeValue);
        sql:TimeValue timeType = new(timeValue);
        sql:TimeValue timetzType= new(timeValue);
        IntervalValue intervalType= new({years:1,months:2,days:3,hours:4,minutes:5,seconds:6});

        
        sql:ParameterizedCallQuery sqlQuery =
        `
        call DatetimeProcedure(${rowId}, ${dateType}, ${timeType}, ${timetzType}, ${timestampType}, ${timestamptzType}, ${intervalType});
        `;
        sql:ProcedureCallResult result = callProcedure(sqlQuery, "datetime_db");

        sql:ParameterizedQuery query = `SELECT row_id, date_type, time_type, timetz_type, timestamp_type, 
                timestamptz_type, interval_type from DatetimeTypes where row_id = ${rowId}`;

        DatetimeProcedureRecord expectedDataRow = {
            row_id: rowId,
            date_type: "2017-03-28+05:30",
            time_type: "05:12:45.554+05:30",
            timetz_type: "23:42:45.554+05:30",
            timestamp_type: "2017-03-29T05:12:45.554+05:30",
            timestamptz_type: "2017-03-28T23:42:45.554+05:30",
            interval_type: "1 year 2 mons 3 days 04:05:06"
        };
    
        test:assertEquals(queryProcedureClient(query, "datetime_db", DatetimeProcedureRecord), expectedDataRow, "Datetime Call procedure insert and query did not match.");

    }
    else{
        test:assertFail("Invalid Time value generated ");
    }
}

//--------------------------------------------------------------------------------------------------------------------------


public type RangeProcedureRecord record {
  int row_id;
  string int4range_type;
  string int8range_type;
  string numrange_type;
  string tsrange_type;
  string tstzrange_type;
  string daterange_type;
};

@test:Config {
    groups: ["datatypes"]
}
function testRangeProcedureCall() {

        int rowId = 2;
        Int4rangeValue int4rangeType = new("(2,50)");
        Int8rangeValue int8rangeType = new("(10,100)");
        NumrangeValue numrangeType = new("(0.1,2.4)");
        TsrangeValue tsrangeType = new("(2010-01-01 14:30, 2010-01-01 15:30)");
        TstzrangeValue tstzrangeType= new("(2010-01-01 14:30, 2010-01-01 15:30)");
        DaterangeValue daterangeType= new("(2010-01-01 14:30, 2010-01-03 )");
        
        sql:ParameterizedCallQuery sqlQuery =
        `
        call RangeProcedure(${rowId}, ${int4rangeType}, ${int8rangeType}, ${numrangeType}, ${tsrangeType}, ${tstzrangeType}, ${daterangeType});
        `;
        sql:ProcedureCallResult result = callProcedure(sqlQuery, "range_db");

        sql:ParameterizedQuery query = `SELECT row_id, int4range_type, int8range_type, numrange_type, tsrange_type, 
                tstzrange_type, daterange_type from RangeTypes where row_id = ${rowId}`;

        RangeProcedureRecord expectedDataRow = {
            row_id: rowId,
            int4range_type: "[3,50)",
            int8range_type: "[11,100)",
            numrange_type: "(0.1,2.4)",
            tsrange_type: "(\"2010-01-01 14:30:00\",\"2010-01-01 15:30:00\")",
            tstzrange_type: "(\"2010-01-01 14:30:00+05:30\",\"2010-01-01 15:30:00+05:30\")",
            daterange_type: "[2010-01-02,2010-01-03)"
        };
    
        test:assertEquals(queryProcedureClient(query, "range_db", RangeProcedureRecord), expectedDataRow, "Range Call procedure insert and query did not match.");
}
 

//---------------------------------------------------------------------------------------------------------------------------

public type TextsearchProcedureRecord record {
    
    int row_id;
    string tsvector_type;
    string tsquery_type;
};

@test:Config {
    groups: ["datatypes"]
}
function testTextsearchProcedureCall() {
    int rowId = 2;
    TsvectorValue tsvectorType = new ("a fat cat sat on a mat and ate a fat rat");
    TsqueryValue tsqueryType = new ("fat & rat");

    sql:ParameterizedCallQuery sqlQuery =
      `
      call TextsearchProcedure(${rowId}, ${tsvectorType}, ${tsqueryType});
    `;
    sql:ProcedureCallResult result = callProcedure(sqlQuery, "ts_db");

    sql:ParameterizedQuery query = `SELECT row_id, tsvector_type, tsquery_type from TextsearchTypes where row_id = ${rowId}`;

    TextsearchProcedureRecord expectedDataRow = {
        row_id: rowId,
        tsvector_type: "'a' 'and' 'ate' 'cat' 'fat' 'mat' 'on' 'rat' 'sat'",
        tsquery_type: "'fat' & 'rat'"
    };
 
    test:assertEquals(queryProcedureClient(query, "ts_db", TextsearchProcedureRecord), expectedDataRow, "Textsearch Call procedure insert and query did not match.");

}

//----------------------------------------------------------------------------------------------------------------------------


public type ObjectidentifierProcedureRecord record {
    int row_id;
    string oid_type;
    string regclass_type;
    string regconfig_type;
    string regdictionary_type;
    string regnamespace_type;
    string regoper_type;
    string regoperator_type;
    string regproc_type;
    string regprocedure_type;
    string regrole_type;
    string regtype_type;
};

@test:Config {
    groups: ["datatypes"]
}
function testObjectidentifierProcedureCall() {
    int rowId = 2;
    int oidType = 12;
    RegclassValue regclassType = new("pg_type");
    RegconfigValue regconfigType = new("english");
    RegdictionaryValue regdictionaryType = new("simple");
    RegnamespaceValue regnamespaceType = new("pg_catalog");
    RegoperValue regoperType = new("!");
    RegoperatorValue regoperatorType = new("*(int,int)");
    RegprocValue regprocType = new("NOW");
    RegprocedureValue regprocedureType = new("sum(int4)");
    RegroleValue regroleType = new("postgres");
    RegtypeValue regtypeType = new("int");

    sql:ParameterizedCallQuery sqlQuery =
      `
      call ObjectidentifierProcedure(${rowId}, ${oidType}, ${regclassType}, ${regconfigType}, ${regdictionaryType}, 
                                ${regnamespaceType}, ${regoperType}, ${regoperatorType}, ${regprocType}, ${regprocedureType},
                                 ${regroleType}, ${regtypeType});
    `;
    sql:ProcedureCallResult result = callProcedure(sqlQuery, "objectidentifier_db");

    sql:ParameterizedQuery query = `SELECT row_id, oid_type, regclass_type, regconfig_type, regdictionary_type,
        regnamespace_type, regoper_type, regoperator_type, regproc_type, regprocedure_type, regrole_type, regtype_type 
        from ObjectidentifierTypes where row_id = ${rowId}`;

    ObjectidentifierProcedureRecord expectedDataRow = {
        row_id: rowId,
        oid_type: "12",
        regclass_type: "pg_type",
        regconfig_type: "english",
        regdictionary_type: "simple",
        regnamespace_type: "pg_catalog",
        regoper_type: "!",
        regoperator_type: "*(integer,integer)",
        regproc_type: "now",
        regprocedure_type: "sum(integer)",
        regrole_type: "postgres",
        regtype_type: "integer"
    };
 
    test:assertEquals(queryProcedureClient(query, "objectidentifier_db", ObjectidentifierProcedureRecord), expectedDataRow, "Objectidentifier Call procedure insert and query did not match.");

}


//----------------------------------------------------------------------------------------------------------------------------
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
    checkpanic dbClient.close();
    return result;
}


