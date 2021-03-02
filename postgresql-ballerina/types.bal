// import ballerina/jballerina.java;
// import ballerina/time;
# PostgreSQL Network Data types.

# Represents Inet PostgreSQL Field
public class InetValue {
    public string? value;
    public function init(string? value = ()) {
        self.value = value;
    }  
}

# Represents Cidr PostgreSQL Field
public class CidrValue {
    public string? value;
    public function init(string? value = ()) {
        self.value = value;
    }  
}

# Represents Macaddress PostgreSQL Field
public class MacaddrValue {
    public string? value;
    public function init(string? value = ()) {
        self.value = value;
    }  
}

# Represents Macaddress8 PostgreSQL Field
public class Macaddr8Value {
    public string? value;
    public function init(string? value = ()) {
        self.value = value;
    }  
} 

# PostgreSQL Geometric Data types.


## Represents Point PostgreSQL Field
public class PointValue {
    public record{decimal x; decimal y;}|string? value;

    public function init(record{decimal x; decimal y;}|string? value = ()) {
        self.value =value;
    }
}
// record{decimal x1; decimal y1;decimal x2; decimal y2;}|
//                     record{decimal a; decimal b; decimal c;}|record{PointValue p1; PointValue p2;}|string?
# Represents Line PostgreSQL Field
public class LineValue {
    public record{decimal x1; decimal y1;decimal x2; decimal y2;}|
                    record{decimal a; decimal b; decimal c;}|string? value;

    public function init(record{decimal x1; decimal y1;decimal x2; decimal y2;}|
                    record{decimal a; decimal b; decimal c;}|string? value = ()) {
        self.value = value;
    }  
}

# Represents Line segment PostgreSQL Field
public class LsegValue {
    public record{decimal x1; decimal y1;decimal x2; decimal y2;}|string? value;

    public function init(record{decimal x1; decimal y1;decimal x2; decimal y2;}|string? value = ()) {
        self.value = value;
    }  
}

# Represents Box PostgreSQL Field
public class BoxValue {
    public record{decimal x1; decimal y1;decimal x2; decimal y2;}|string? value;

    public function init(record{decimal x1; decimal y1;decimal x2; decimal y2;}|string? value = ()) {
        self.value = value;
    }  
}

// public class PathValue {
//     any value;

//     public function init(record{decimal x; decimal y;}? value = ()) {
//         self.value = convertPoint(value);
//     }  
// }

// public class PolygonValue {
//     any value;

//     public function init(record{decimal x; decimal y;}? value = ()) {
//         self.value = convertPoint(value);
//     }  
// }

# Represents Circle PostgreSQL Field
public class CircleValue {
    public record{decimal x; decimal y; decimal r;}|string? value;

    public function init(record{decimal x; decimal y; decimal r;}|string? value = ()) {
        self.value = value;
    }  
}

// # Represents UUID PostgreSQL Field
// public class UuidValue {
//     any value;
//     public function init(string? value = ()) {
//         self.value = convertUuid(value);
//     }  
// }

// # PostgreSQL Text search Data types.

// # Represents Text vector PostgreSQL Field
// public class TsvectorValue {
//     any value;
//     public function init(string? value = ()) {
//         self.value = convertTsVector(value);
//     }  
// }

// # Represents Text query PostgreSQL Field
// public class TsqueryValue {
//     any value;
//     public function init(string? value = ()) {
//         self.value = convertTsQuery(value);
//     }  
// }

// # PostgreSQL Json Data types.

// # Represents Json PostgreSQL Field
// public class JsonValue {
//     any value;
//     public function init(json|string? value = ()) {
//         self.value = convertJson(value);
//     }  
// }

// # Represents Jsonb PostgreSQL Field
// public class JsonbValue {
//     any value;
//     public function init(json|string? value = ()) {
//         self.value = convertJsonb(value);
//     }  
// }

// # Represents Jsonpath PostgreSQL Field
// public class JsonpathValue {
//     any value;
//     public function init(string? value = ()) {
//         self.value = convertJsonPath(value);
//     }  
// }

// # Represents Time interval PostgreSQL Field
// public class IntervalValue {
//     any value;

//     public function init(record{int years = 0; int months = 0;int days = 0; int hours = 0; int minutes = 0; decimal seconds = 0;}|string? value = ()) {
//         self.value = convertInterval(value);
//     }
// }

// # PostgreSQL Range Data types.

// # Represents Int4 range PostgreSQL Field
// public class Int4rangeValue {
//     any value;

//     public function init(record{int upper; int lower; boolean isUpperboundInclusive = false; boolean isLowerboundInclusive = false;}|string? value = ()) {
//         self.value = convertInt4Range(value);
//     }
// }

// # Represents Int8 range PostgreSQL Field
// public class Int8rangeValue {
//     any value;

//     public function init(record{int upper; int lower; boolean isUpperboundInclusive = false; boolean isLowerboundInclusive = false;}|string? value = ()) {
//         self.value = convertInt8Range(value);
//     }
// }

// # Represents Numerical range PostgreSQL Field
// public class NumrangeValue {
//     any value;

//     public function init(record{decimal upper; decimal lower; boolean isUpperboundInclusive = false; boolean isLowerboundInclusive = false;}|string? value = ()) {
//         self.value = convertNumRange(value);
//     }
// }

// # Represents Timestamp range PostgreSQL Field
// public class TsrangeValue {
//     any value;

//     public function init(record{time:Time|string upper; time:Time|string lower; boolean isUpperboundInclusive = false; boolean isLowerboundInclusive = false;}|string? value = ()) {
//         self.value = convertTsRange(value);
//     }
// }

// # Represents Timestamp with timezone range PostgreSQL Field
// public class TstzrangeValue {
//     any value;

//     public function init(record{time:Time|string  upper; time:Time|string  lower; boolean isUpperboundInclusive = false; boolean isLowerboundInclusive = false;}|string? value = ()) {
//         self.value = convertTstzRange(value);
//     }
// }

// # Represents Date range PostgreSQL Field
// public class DaterangeValue {
//     any value;

//     public function init(record{time:Time|string  upper; time:Time|string  lower; boolean isUpperboundInclusive = false; boolean isLowerboundInclusive = false;}|string? value = ()) {
//         self.value = convertDateRange(value);
//     }
// }


// # Represents Pg_lsn PostgreSQL Field
// public class PglsnValue {
//     any value;
//     public function init(string? value = ()) {
//         self.value = convertPglsn(value);
//     }  
// }


// # PostgreSQL Bit String Data types.

// # Represents Bit(n) PostgreSQL Field
// public class BitstringValue {
//     any value;
//     public function init(string? value = ()) {
//         self.value = convertBitn(value);
//     }  
// }

// # Represents Bit vary(n) PostgreSQL Field
// public class VarbitstringValue {
//     any value;
//     public function init(string? value = ()) {
//         self.value = convertVarbit(value);
//     }  
// }

// # Represents Bit PostgreSQL Field
// public class PGBitValue {
//     any value;
//     public function init(boolean|string? value = ()) {
//         self.value = convertBit(value);
//     }  
// }
   

// # Represents Money PostgreSQL Field
// public class MoneyValue {
//     any value;
//     public function init(decimal|string? value = ()) {
//         self.value = convertMoney(value);
//     }  
// }

// # Represents User Define PostgreSQL Fields
// # Enums, Complex types, Domain
// public class CustomTypeValue {
//     any value;
//     string typeName;
//     public function init(string typeName, record{}|string? value = ()) {
//         self.typeName = typeName;
//         self.value = convertCustomType(typeName,value);
//     }  
// }


// # PostgreSQL Object identifier Data types.
// # Represents regclass PostgreSQL Field
// public class RegclassValue {
//     any value;
//     public function init(string? value = ()) {
//         self.value = convertRegclass(value);
//     }  
// }

// # Represents regconfig PostgreSQL Field
// public class RegconfigValue {
//     any value;
//     public function init(string? value = ()) {
//         self.value = convertRegconfig(value);
//     }  
// }

// # Represents regdictionary PostgreSQL Field
// public class RegdictionaryValue {
//     any value;
//     public function init(string? value = ()) {
//         self.value = convertRegdictionary(value);
//     }  
// }

// # Represents regnamespace PostgreSQL Field
// public class RegnamespaceValue {
//     any value;
//     public function init(string? value = ()) {
//         self.value = convertRegnamespace(value);
//     }  
// }

// # Represents regoper PostgreSQL Field
// public class RegoperValue {
//     any value;
//     public function init(string? value = ()) {
//         self.value = convertRegoper(value);
//     }  
// }

// # Represents regoperator PostgreSQL Field
// public class RegoperatorValue {
//     any value;
//     public function init(string? value = ()) {
//         self.value = convertRegoperator(value);
//     }  
// }

// # Represents regproc PostgreSQL Field
// public class RegprocValue {
//     any value;
//     public function init(string? value = ()) {
//         self.value = convertRegproc(value);
//     }  
// }

// # Represents regprocedure PostgreSQL Field
// public class RegprocedureValue {
//     any value;
//     public function init(string? value = ()) {
//         self.value = convertRegprocedure(value);
//     }  
// }

// # Represents regrole PostgreSQL Field
// public class RegroleValue {
//     any value;
//     public function init(string? value = ()) {
//         self.value = convertRegrole(value);
//     }  
// }

// # Represents regtype PostgreSQL Field
// public class RegtypeValue {
//     any value;
//     public function init(string? value = ()) {
//         self.value = convertRegtype(value);
//     }  
// }






// function convertInet(string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;

// function convertCidr(string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;

// function convertMac(string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;

// function convertMac8(string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;



// function convertPoint(record{decimal x; decimal y;}|string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;

// function convertLine(record{decimal x1; decimal y1;decimal x2; decimal y2;}|
//                     record{decimal a; decimal b; decimal c;}|string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;

// function convertLseg(record{decimal x1; decimal y1;decimal x2; decimal y2;}
//                                         |string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;

// function convertBox(record{decimal x1; decimal y1;decimal x2; decimal y2;}
//                                         |string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;

// function convertCircle(record{decimal x; decimal y;decimal r;}
//                                         |string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;



// function convertUuid(string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;



// function convertTsVector(string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;

// function convertTsQuery(string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;


// function convertJson(json|string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;
// function convertJsonb(json|string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;
// function convertJsonPath(string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;


// function convertInterval(record{int years = 0; int months = 0;int days = 0; int hours = 0; int minutes = 0; decimal seconds = 0;}|string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;


// function convertInt4Range(record{int upper; int lower; boolean isUpperboundInclusive = false; boolean isLowerboundInclusive = false;}|string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;

// function convertInt8Range(record{int upper; int lower; boolean isUpperboundInclusive = false; boolean isLowerboundInclusive = false;}|string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;

// function convertNumRange(record{decimal upper; decimal lower; boolean isUpperboundInclusive = false; boolean isLowerboundInclusive = false;}|string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;

// function convertTsRange(record{time:Time|string upper; time:Time|string lower; boolean isUpperboundInclusive = false; boolean isLowerboundInclusive = false;}|string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;

// function convertTstzRange(record{time:Time|string upper; time:Time|string lower; boolean isUpperboundInclusive = false; boolean isLowerboundInclusive = false;}|string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;

// function convertDateRange(record{time:Time|string upper; time:Time|string lower; boolean isUpperboundInclusive = false; boolean isLowerboundInclusive = false;}|string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;


// function convertPglsn(string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;


// function convertBitn(string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;

// function convertVarbit(string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;

// function convertBit(boolean|string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;


// function convertMoney(decimal|string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;


// function convertCustomType(string typeName,record{}|string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;



// function convertRegclass(string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;

// function convertRegconfig(string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;

// function convertRegdictionary(string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;

// function convertRegnamespace(string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;

// function convertRegoper(string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;

// function convertRegoperator(string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;

// function convertRegproc(string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;

// function convertRegprocedure(string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;

// function convertRegrole(string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;

// function convertRegtype(string? value) returns any = @java:Method {
//     'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
// } external;

public type CustomResultIterator object {
    isolated function nextResult(ResultIterator iterator) returns record {}|Error? = @java:Method {
        'class: "org.ballerinalang.postgresql.ClientProcessor"
    } external;

    isolated function getNextQueryResult(ProcedureCallResult callResult) returns boolean|Error= @java:Method {
        'class: "org.ballerinalang.postgresql.RecordIteratorUtils"
    } external;
};

