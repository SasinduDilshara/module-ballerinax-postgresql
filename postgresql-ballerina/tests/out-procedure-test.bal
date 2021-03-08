import ballerina/sql;
import ballerina/test;
import ballerina/io;
import ballerina/time;

public function cccx(){
    io:println(1);
    time:Time|error timeValue = time:createTime(2017, 3, 28, 23, 42, 45,554, "Asia/Colombo");

}

// @test:Config {
//     groups: ["datatypes"]
// }
// function testNumericProcedureOutCall() {
//     int rowId = 1;
//     sql:SmallIntValue smallintType = new ();
//     sql:IntegerValue intType = new();
//     sql:BigIntValue bigintType = new();
//     sql:DecimalValue decimalType = new();
//     sql:NumericValue numericType = new();
//     sql:RealValue realType = new();
//     sql:DoubleValue doubleType = new();

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
//       call NumericOutProcedure(${rowIdInoutValue}, ${smallintInoutValue}, ${intInoutValue}, ${bigintInoutValue}, ${decimalInoutValue},
//                                 ${numericInoutValue}, ${realInoutValue}, ${doubleInoutValue});
//     `;
//     sql:ProcedureCallResult result = callOutProcedure(sqlQuery, "numeric_db");

//     decimal decimalVal = 123.456;

//     test:assertEquals(smallintInoutValue.get(int), 1, "SmallInt Datatype Doesn;t Match");
//     test:assertEquals(intInoutValue.get(int), 123, "Int Datatype Doesn't Match");
//     test:assertEquals(bigintInoutValue.get(int), 123456, "Bigint Datatype Doesn;t Match");
//     test:assertEquals(decimalInoutValue.get(decimal), decimalVal, "Decimal Datatype Doesn't Match");
//     test:assertEquals(numericInoutValue.get(decimal), decimalVal, "Numeric Datatype Doesn;t Match");
//     test:assertTrue(realInoutValue.get(float) is float, "Real Datatype Doesn't Match");
//     test:assertTrue(doubleInoutValue.get(float) is float, "Double Datatype Doesn't Match");

// }

// //===============================================================================================================================

// @test:Config {
//     groups: ["datatypes"]
// }
// function testCharacterProcedureOutCall() {
//     int rowId = 1;
//     sql:CharValue charValue = new ();
//     sql:VarcharValue varcharValue = new ();
//     sql:TextValue textValue = new ();
//     string nameValue = "";

//     InOutParameter rowIdInoutValue = new (rowId);
//     InOutParameter charInoutValue = new (charValue);
//     InOutParameter varcharInoutValue = new (varcharValue);
//     InOutParameter textInoutValue = new (textValue);
//     InOutParameter nameInoutValue = new (nameValue);

//     sql:ParameterizedCallQuery sqlQuery =
//       `
//       call CharacterOutProcedure(${rowIdInoutValue}, ${charInoutValue}, ${varcharInoutValue}, ${textInoutValue}, ${nameInoutValue});
//     `;
//     sql:ProcedureCallResult result = callOutProcedure(sqlQuery, "character_db");

 
//     test:assertEquals(charInoutValue.get(string), "This is a char1", "Char Data type doesnt match.");
//     test:assertEquals(varcharInoutValue.get(string), "This is a varchar1", "Varchar Data type doesnt match.");
//     test:assertEquals(textInoutValue.get(string), "This is a text1", "Text Data type doesnt match.");
//     test:assertEquals(nameInoutValue.get(string), "This is a name1", "Name Data type doesnt match.");

// }

// //=================================================================================================================================



// @test:Config {
//     groups: ["datatypes"]
// }
// function testBooleanProcedureOutCall() {
//     int rowId = 1;
//     sql:BooleanValue booleanType = new();

//     InOutParameter rowIdInoutValue = new (rowId);
//     InOutParameter booleanInoutValue = new (booleanType);

//     sql:ParameterizedCallQuery sqlQuery =
//       `
//       call BooleanOutProcedure(${rowIdInoutValue}, ${booleanInoutValue});
//     `;
//     sql:ProcedureCallResult result = callOutProcedure(sqlQuery, "boolean_db");

//     test:assertEquals(booleanInoutValue.get(boolean), true, "Boolean Datatype doesn't match");
// }



// //==============================================================================================================================

// @test:Config {
//     groups: ["datatypes"]
// }
// function testNetworkProcedureOutCall() {
//     int rowId = 1;
//     InetValue inetValue = new ();
//     CidrValue cidrValue = new ();
//     MacaddrValue macaddrValue = new ();
//     Macaddr8Value macaddr8Value = new ();

//     InOutParameter rowIdInoutValue = new (rowId);
//     InOutParameter inetInoutValue = new (inetValue);
//     InOutParameter cidrInoutValue = new (cidrValue);
//     InOutParameter macaddrInoutValue = new (macaddrValue);
//     InOutParameter macaddr8InoutValue = new (macaddr8Value);

//     sql:ParameterizedCallQuery sqlQuery =
//       `
//       call NetworkOutProcedure(${rowIdInoutValue}, ${inetInoutValue}, ${cidrInoutValue}, ${macaddrInoutValue}, ${macaddr8InoutValue});
//     `;
//     sql:ProcedureCallResult result = callOutProcedure(sqlQuery, "network_db");

 
//     test:assertEquals(inetInoutValue.get(string), "192.168.0.1/24", "Inet Data type doesnt match.");
//     test:assertEquals(cidrInoutValue.get(string), "::ffff:1.2.3.0/120", "Cidr Data type doesnt match.");
//     test:assertEquals(macaddrInoutValue.get(string), "08:00:2b:01:02:03", "Macaddress Data type doesnt match.");
//     test:assertEquals(macaddr8InoutValue.get(string), "08:00:2b:01:02:03:04:05", "Macadress8 Data type doesnt match.");

// }

// //---------------------------------------------------------------------------------------------------------------------------------------------------

public type PointOutRecord record {
    float x;
    float y;
};

public type LineOutRecord record {
    float a;
    float b;
    float c;
};

public type LsegOutRecord record {
    float x1;
    float x2;
    float y1;
    float y2;
};

public type BoxOutRecord record {
    float x1;
    float x2;
    float y1;
    float y2;
};

public type CircleOutRecord record {
    float x;
    float y;
    float r;
};

@test:Config {
    groups: ["datatypes"]
}
function testGeometricProcedureOutCall() {
    int rowId = 1;
    PointValue pointType = new ();
    LineValue lineType = new ();
    LsegValue lsegType = new ();
    BoxValue boxType = new ();
    // PathValue pathType = new ();
    // PolygonValue polygonType = new ();
    CircleValue circleType = new ();

    InOutParameter rowIdInoutValue = new (rowId);
    InOutParameter pointInoutValue = new (pointType);
    InOutParameter lineInoutValue = new (lineType);
    InOutParameter lsegInoutValue = new (lsegType);
    InOutParameter boxInoutValue = new (boxType);
    InOutParameter circleInoutValue = new (circleType);

    sql:ParameterizedCallQuery sqlQuery =
      `
      call GeometricOutProcedure(${rowIdInoutValue}, ${pointInoutValue}, ${lineInoutValue}, ${lsegInoutValue}, ${boxInoutValue}, ${circleInoutValue});
    `;
    sql:ProcedureCallResult result = callOutProcedure(sqlQuery, "geometric_db");

    PointOutRecord pointOutRecord = {x: 1.0, y: 2.0};
    LineOutRecord lineOutRecord = {a: 1.0, b: 2.0, c: 3.0};
    LsegOutRecord lsegOutRecord = {x1: 1.0, y1: 1.0, x2: 2.0, y2: 2.0};
    BoxOutRecord boxOutRecord = {x1: 2.0, y1: 2.0, x2: 1.0, y2: 1.0};
    CircleOutRecord circleOutRecord = {x: 1.0, y: 1.0, r:1.0};

    test:assertEquals(pointInoutValue.get(string), "(1.0,2.0)", "Point Data type doesnt match.");
    test:assertEquals(lineInoutValue.get(string), "{1.0,2.0,3.0}", "Line Data type doesnt match.");
    test:assertEquals(lsegInoutValue.get(string), "[(1.0,1.0),(2.0,2.0)]", "Line Segment Data type doesnt match.");
    test:assertEquals(boxInoutValue.get(string), "(2.0,2.0),(1.0,1.0)", "Box Data type doesnt match.");
    test:assertEquals(circleInoutValue.get(string), "<(1.0,1.0),1.0>", "Circle Data type doesnt match.");

    test:assertEquals(pointInoutValue.get(PointOutRecord), pointOutRecord, "Point Data type doesnt match.");
    test:assertEquals(lineInoutValue.get(LineOutRecord), lineOutRecord, "Line Data type doesnt match.");
    test:assertEquals(lsegInoutValue.get(LsegOutRecord), lsegOutRecord, "Line Segment Data type doesnt match.");
    test:assertEquals(boxInoutValue.get(BoxOutRecord), boxOutRecord, "Box Data type doesnt match.");
    test:assertEquals(circleInoutValue.get(CircleOutRecord), circleOutRecord, "Circle Data type doesnt match.");

}

// // //----------------------------------------------------------------------------------------------------------------------------------------------------

// @test:Config {
//     groups: ["datatypes"]
// }
// function testUuidProcedureOutCall() {
//     int rowId = 1;
//     UuidValue uuidType = new ();

//     InOutParameter rowIdInoutValue = new (rowId);
//     InOutParameter uuidInoutValue = new (uuidType);

//     sql:ParameterizedCallQuery sqlQuery =
//       `
//       call UuidOutProcedure(${rowIdInoutValue}, ${uuidInoutValue});
//     `;
//     sql:ProcedureCallResult result = callOutProcedure(sqlQuery, "uuid_db");

//     test:assertEquals(uuidInoutValue.get(string), "a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11", "UUID Datatype doesn't match");
// }

// // //----------------------------------------------------------------------------------------------------------------------------------------------------

// @test:Config {
//     groups: ["datatypes"]
// }
// function testPglsnProcedureOutCall() {
//     int rowId = 1;
//     PglsnValue pglsnType = new ();

//     InOutParameter rowIdInoutValue = new (rowId);
//     InOutParameter pglsnInoutValue = new (pglsnType);

//     sql:ParameterizedCallQuery sqlQuery =
//       `
//       call PglsnOutProcedure(${rowIdInoutValue}, ${pglsnInoutValue});
//     `;
//     sql:ProcedureCallResult result = callOutProcedure(sqlQuery, "pglsn_db");

//     test:assertEquals(pglsnInoutValue.get(string), "16/B374D848", "Pg_lsn Data type Doesn't match");

// }

// // //-------------------------------------------------------------------------------------------------------------------------

// @test:Config {
//     groups: ["datatypes"]
// }
// function testJsonProcedureOutCall() {
//     int rowId = 1;
//     JsonValue jsonType = new();
//     JsonbValue jsonbType = new();
//     JsonpathValue jsonpathType = new();

//     InOutParameter rowIdInoutValue = new (rowId);
//     InOutParameter jsonInoutValue = new (jsonType);
//     InOutParameter jsonbInoutValue = new (jsonbType);
//     InOutParameter jsonPathInoutValue = new (jsonpathType);

//     sql:ParameterizedCallQuery sqlQuery =
//       `
//       call JsonOutProcedure(${rowIdInoutValue}, ${jsonInoutValue}, ${jsonbInoutValue}, ${jsonPathInoutValue});
//     `;
//     sql:ProcedureCallResult result = callOutProcedure(sqlQuery, "json_db");

//     test:assertEquals(jsonInoutValue.get(string), "{\"key1\": \"value\", \"key2\": 2}", "Json Datatype Doesn't Match");
//     test:assertEquals(jsonbInoutValue.get(string), "{\"key1\": \"value\", \"key2\": 2}", "Jsonb Datatype Doesn't Match");
//     test:assertEquals(jsonPathInoutValue.get(string), "$.\"floor\"[*].\"apt\"[*]?(@.\"area\" > 40 && @.\"area\" < 90)?(@.\"rooms\" > 1)", "Json path Datatype Doesn't Match");

//     // test:assertEquals(jsonInoutValue.get(json), {"key1": "value", "key2": 2}, "Json Datatype Doesn't Match");
//     // test:assertEquals(jsonbInoutValue.get(json), {"key1": "value", "key2": 2}, "Jsonb Datatype Doesn't Match");
// }

// // //-------------------------------------------------------------------------------------------------------------------------

// @test:Config {
//     groups: ["datatypes"]
// }
// function testBitProcedureOutCall() {
//     int rowId = 1;
//     VarbitstringValue varbitstringType = new();
//     PGBitValue bitType = new();
//     // sql:BitValue bitType = new();

//     InOutParameter rowIdInoutValue = new (rowId);
//     InOutParameter varbitInoutValue = new (varbitstringType);
//     InOutParameter bitInoutValue = new (bitType);

//     sql:ParameterizedCallQuery sqlQuery =
//       `
//       call BitOutProcedure(${rowIdInoutValue}, ${varbitInoutValue}, ${bitInoutValue});
//     `;
//     sql:ProcedureCallResult result = callOutProcedure(sqlQuery, "bitstring_db");

//     test:assertEquals(varbitInoutValue.get(string), "1101", "Bit Vary Datatype Doesn;t Match");
//     test:assertEquals(bitInoutValue.get(boolean), true, "Bit Datatype Doesn't Match");

// }

// // //-----------------------------------------------------------------------------------------------------------------------


public type TimeRecord record{
    int time;
    record{
        string id;
        int offset;
    } zone;
};


public type IntervalRecord record{
    int years;
    int months;
    int days;
    int hours;
    int minutes;
    decimal seconds;
};

public class IntervalRecordClass {
    public int years;
    public int months;
    public int days;
    public int hours;
    public int minutes;
    public decimal seconds;

    public function init(int years, int months, int days, int hours, int minutes, decimal seconds) {
        self.years = years;
        self.months = months;
        self.days = days;
        self.hours = hours;
        self.minutes = minutes;
        self.seconds = seconds;
    }
}

@test:Config {
    groups: ["datatypes"]
}
function testDatetimeProcedureOutCall() {

        int rowId = 1;
        sql:TimestampValue timestampType = new();
        sql:TimestampValue timestamptzType = new();
        sql:DateValue dateType = new();
        sql:TimeValue timeType = new();
        sql:TimeValue timetzType= new();
        IntervalValue intervalType= new();

        InOutParameter rowIdInoutValue = new (rowId);
        InOutParameter timestampInoutValue = new (timestampType);
        InOutParameter timestamptzInoutValue = new (timestamptzType);
        InOutParameter dateInoutValue = new (dateType);
        InOutParameter timeInoutValue = new (timeType);
        InOutParameter timetzInoutValue = new (timetzType);
        InOutParameter intervalInoutValue = new (intervalType);
    
        sql:ParameterizedCallQuery sqlQuery =
        `
            call DatetimeOutProcedure(${rowIdInoutValue}, ${dateInoutValue}, ${timeInoutValue}, ${timetzInoutValue},
                ${timestampInoutValue}, ${timestamptzInoutValue}, ${intervalInoutValue});
        `;
        sql:ProcedureCallResult result = callOutProcedure(sqlQuery, "datetime_db");

        IntervalRecord intervalRecord = {years: 1, months: 2, days: 3, hours: 4, minutes: 5, seconds: 6};
        IntervalRecordClass intervalRecordClass = new (1,2,3,4,5,6);

        test:assertEquals(timestampInoutValue.get(string), "1999-01-08T10:05:06.000+06:00", " Timestamp Datatype Doesn't Match");
        test:assertEquals(timestamptzInoutValue.get(string), "2004-10-19T20:23:54.000+06:00", " Timestamptz Datatype Doesn't Match");
        test:assertEquals(dateInoutValue.get(string), "1999-01-08+06:00", " Date Datatype Doesn't Match");
        test:assertEquals(timeInoutValue.get(string), "09:35:06.000+05:30", " Time Datatype Doesn't Match");
        test:assertEquals(timetzInoutValue.get(string), "19:05:06.000+05:30", " Timetz Datatype Doesn't Match");
        test:assertEquals(intervalInoutValue.get(string), "1 years 2 mons 3 days 4 hours 5 mins 6.0 secs", " Interval Datatype Doesn't Match");

        test:assertTrue(timestampInoutValue.get(TimeRecord) is TimeRecord, " Timestamp Datatype Doesn't Match");
        test:assertTrue(timestamptzInoutValue.get(TimeRecord) is TimeRecord, " Timestamptz Datatype Doesn't Match");
        test:assertTrue(dateInoutValue.get(TimeRecord) is TimeRecord, " Date Datatype Doesn't Match");
        test:assertTrue(timeInoutValue.get(TimeRecord) is TimeRecord, " Time Datatype Doesn't Match");
        test:assertTrue(timetzInoutValue.get(TimeRecord) is TimeRecord, " Timetz Datatype Doesn't Match");
        test:assertEquals(intervalInoutValue.get(IntervalRecord), intervalRecord, " Interval Datatype Doesn't Match");

}

// // //--------------------------------------------------------------------------------------------------------------------------

public type IntRangeRecord record{
    int upper;
    int lower;
    boolean isUpperboundInclusive = false;
    boolean isLowerboundInclusive = false;
};

public type NumericRangeRecord record{
    decimal upper;
    decimal lower;
    boolean isUpperboundInclusive = false;
    boolean isLowerboundInclusive = false;
};

public type TimestampRangeRecord record{
    time:Time upper;
    time:Time lower;
    boolean isUpperboundInclusive = false;
    boolean isLowerboundInclusive = false;
};

@test:Config {
    groups: ["datatypes"]
}
function testRangeProcedureOutCall() {

        int rowId = 1;
        Int4rangeValue int4rangeType = new();
        Int8rangeValue int8rangeType = new();
        NumrangeValue numrangeType = new();
        TsrangeValue tsrangeType = new();
        TstzrangeValue tstzrangeType= new();
        DaterangeValue daterangeType= new();

        InOutParameter rowIdInoutValue = new (rowId);
        InOutParameter int4rangeInoutValue = new (int4rangeType);
        InOutParameter int8rangeInoutValue = new (int8rangeType);
        InOutParameter numrangeInoutValue = new (numrangeType);
        InOutParameter tsrangeInoutValue = new (tsrangeType);
        InOutParameter tstzrangeInoutValue = new (tstzrangeType);
        InOutParameter daterangeInoutValue = new (daterangeType);

        IntRangeRecord int4RangeRecord = {upper: 50 , lower: 3 , isUpperBoundInclusive: false, isLowerBoundInclusive: true};        
        IntRangeRecord int8RangeRecord = {upper: 100, lower: 11, isUpperBoundInclusive: false, isLowerBoundInclusive: true};
        NumericRangeRecord numRangeRecord = {upper: 24, lower: 0, isUpperBoundInclusive: false, isLowerBoundInclusive: false}; 
               
        sql:ParameterizedCallQuery sqlQuery =
        `
        call RangeOutProcedure(${rowIdInoutValue}, ${int4rangeInoutValue}, ${int8rangeInoutValue}, ${numrangeInoutValue}, ${tsrangeInoutValue}, ${tstzrangeInoutValue}, ${daterangeInoutValue});
        `;
        sql:ProcedureCallResult result = callOutProcedure(sqlQuery, "range_db");

        test:assertEquals(int4rangeInoutValue.get(string), "[3,50)", "Int4range Datatype Doesn't Match");
        test:assertEquals(int8rangeInoutValue.get(string), "[11,100)", "Int8range Datatype Doesn't Match");
        test:assertEquals(numrangeInoutValue.get(string), "(0,24)", "Numrnge Datatype Doesn't Match");
        test:assertEquals(tsrangeInoutValue.get(string), "(\"2010-01-01 14:30:00\",\"2010-01-01 15:30:00\")", "Tsrange Datatype Doesn't Match");
        test:assertEquals(tstzrangeInoutValue.get(string), "(\"2010-01-01 14:30:00+05:30\",\"2010-01-01 15:30:00+05:30\")", "Tstzrange Datatype Doesn't Match");
        test:assertEquals(daterangeInoutValue.get(string), "[2010-01-02,2010-01-03)", "Daterange Datatype Doesn't Match");

        test:assertEquals(int4rangeInoutValue.get(IntRangeRecord), int4RangeRecord, "Int4range Datatype Doesn't Match");
        test:assertEquals(int8rangeInoutValue.get(IntRangeRecord), int8RangeRecord, "Int8range Datatype Doesn't Match");
        test:assertEquals(numrangeInoutValue.get(NumericRangeRecord), numRangeRecord, "Numrnge Datatype Doesn't Match");
        test:assertTrue(tsrangeInoutValue.get(TimestampRangeRecord) is TimestampRangeRecord, "Tsrange Datatype Doesn't Match");
        test:assertTrue(tstzrangeInoutValue.get(TimestampRangeRecord) is TimestampRangeRecord, "Tstzrange Datatype Doesn't Match");
        test:assertTrue(daterangeInoutValue.get(TimestampRangeRecord) is TimestampRangeRecord, "Daterange Datatype Doesn't Match");

}
 

// // // //---------------------------------------------------------------------------------------------------------------------------

// @test:Config {
//     groups: ["datatypes"]
// }
// function testTextsearchProcedureOutCall() {
//     int rowId = 1;
//     TsvectorValue tsvectorType = new ();
//     TsqueryValue tsqueryType = new ();

//     InOutParameter rowIdInoutValue = new (rowId);
//     InOutParameter tsvectorInoutValue = new (tsvectorType);
//     InOutParameter tsqueryInoutValue = new (tsqueryType);

//     sql:ParameterizedCallQuery sqlQuery =
//       `
//       call TextsearchOutProcedure(${rowIdInoutValue}, ${tsvectorInoutValue}, ${tsqueryInoutValue});
//     `;
//     sql:ProcedureCallResult result = callOutProcedure(sqlQuery, "ts_db");

//     test:assertEquals(tsvectorInoutValue.get(string), "'a' 'and' 'ate' 'cat' 'fat' 'mat' 'on' 'rat' 'sat'", "Tsvector Datatype Doesn't Match");
//     test:assertEquals(tsqueryInoutValue.get(string), "'fat' & 'rat'", "Tsquery Datatype Doesn't Match");

// }

// // // //----------------------------------------------------------------------------------------------------------------------------

// @test:Config {
//     groups: ["datatypes"]
// }
// function testObjectidentifierProcedureOutCall() {
//     int rowId = 1;
//     int oidType = 12;
//     RegclassValue regclassType = new();
//     RegconfigValue regconfigType = new();
//     RegdictionaryValue regdictionaryType = new();
//     RegnamespaceValue regnamespaceType = new();
//     RegoperValue regoperType = new();
//     RegoperatorValue regoperatorType = new();
//     RegprocValue regprocType = new();
//     RegprocedureValue regprocedureType = new();
//     RegroleValue regroleType = new();
//     RegtypeValue regtypeType = new();

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
//       call ObjectidentifierOutProcedure(${rowIdInoutValue}, ${oidInoutValue}, ${regclassInoutValue}, ${regconfigInoutValue}, ${regdictionaryInoutValue}, 
//                                 ${regnamespaceInoutValue}, ${regoperInoutValue}, ${regoperatorInoutValue}, ${regprocInoutValue}, ${regprocedureInoutValue},
//                                  ${regroleInoutValue}, ${regtypeInoutValue});
//     `;
//     sql:ProcedureCallResult result = callOutProcedure(sqlQuery, "objectidentifier_db");

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


// // //----------------------------------------------------------------------------------------------------------------------------
// function queryInoutProcedureClient(@untainted string|sql:ParameterizedQuery sqlQuery, string database, typedesc<record {}>? resultType = ())
// returns @tainted record {} {
//     Client dbClient = checkpanic new (host, user, password, database, port);
//     stream<record{}, error> streamData = dbClient->query(sqlQuery, resultType);
//     record {|record {} value;|}? data = checkpanic streamData.next();
//     checkpanic streamData.close();
//     record {}? value = data?.value;
//     checkpanic dbClient.close();
//     if (value is ()) {
//         return {};
//     } else {
//         return value;
//     }
// }

function callOutProcedure(sql:ParameterizedCallQuery sqlQuery, string database) returns sql:ProcedureCallResult {
    Client dbClient = checkpanic new (host, user, password, database, port);
    sql:ProcedureCallResult result = checkpanic dbClient->call(sqlQuery);
    checkpanic dbClient.close();
    return result;
}


