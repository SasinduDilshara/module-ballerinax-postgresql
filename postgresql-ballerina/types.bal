import ballerina/java;
import ballerina/time;

public class InetValue {
    any value;
    public function init(string? value = ()) {
        self.value = convertInet(value);
    }  
}

public class CidrValue {
    any value;
    public function init(string? value = ()) {
        self.value = convertCidr(value);
    }  
}

public class MacaddrValue {
    any value;
    public function init(string? value = ()) {
        self.value = convertMac(value);
    }  
}

public class Macaddr8Value {
    any value;
    public function init(string? value = ()) {
        self.value = convertMac8(value);
    }  
}

//Geometric data types
public class PointValue {
    any value;

    public function init(record{decimal x; decimal y;}|string? value = ()) {
        self.value = convertPoint(value);
    }
}
// record{decimal x1; decimal y1;decimal x2; decimal y2;}|
//                     record{decimal a; decimal b; decimal c;}|record{PointValue p1; PointValue p2;}|string?
public class LineValue {
    any value;

    public function init(record{decimal x1; decimal y1;decimal x2; decimal y2;}|
                    record{decimal a; decimal b; decimal c;}|string? value = ()) {
        self.value = convertLine(value);
    }  
}

public class LsegValue {
    any value;

    public function init(record{decimal x; decimal y;}? value = ()) {
        self.value = convertPoint(value);
    }  
}

public class BoxValue {
    any value;

    public function init(record{decimal x; decimal y;}? value = ()) {
        self.value = convertPoint(value);
    }  
}

public class PathValue {
    any value;

    public function init(record{decimal x; decimal y;}? value = ()) {
        self.value = convertPoint(value);
    }  
}

public class PolygonValue {
    any value;

    public function init(record{decimal x; decimal y;}? value = ()) {
        self.value = convertPoint(value);
    }  
}

public class CircleValue {
    any value;

    public function init(record{decimal x; decimal y;}? value = ()) {
        self.value = convertPoint(value);
    }  
}

//UUID Value
public class UuidValue {
    any value;
    public function init(string? value = ()) {
        self.value = convertUuid(value);
    }  
}

//Text search types
public class TsvectorValue {
    any value;
    public function init(string? value = ()) {
        self.value = convertTsVector(value);
    }  
}

public class TsqueryValue {
    any value;
    public function init(string? value = ()) {
        self.value = convertTsQuery(value);
    }  
}

//Json
public class JsonValue {
    any value;
    public function init(json|string? value = ()) {
        self.value = convertJson(value);
    }  
}

public class JsonbValue {
    any value;
    public function init(json|string? value = ()) {
        self.value = convertJsonb(value);
    }  
}

public class JsonpathValue {
    any value;
    public function init(string? value = ()) {
        self.value = convertJsonPath(value);
    }  
}

//Interval
public class IntervalValue {
    any value;

    public function init(record{int years = 0; int months = 0;int days = 0; int hours = 0; int minutes = 0; decimal seconds = 0;}|string? value = ()) {
        self.value = convertInterval(value);
    }
}

//Range values
public class Int4rangeValue {
    any value;

    public function init(record{int upper; int lower; boolean upperInclusive = false; boolean lowerInclusive = false;}|string? value = ()) {
        self.value = convertInt4Range(value);
    }
}

public class Int8rangeValue {
    any value;

    public function init(record{int upper; int lower; boolean upperInclusive = false; boolean lowerInclusive = false;}|string? value = ()) {
        self.value = convertInt8Range(value);
    }
}

public class NumrangeValue {
    any value;

    public function init(record{decimal upper; decimal lower; boolean upperInclusive = false; boolean lowerInclusive = false;}|string? value = ()) {
        self.value = convertNumRange(value);
    }
}

public class TsrangeValue {
    any value;

    public function init(record{time:Time|string upper; time:Time|string lower; boolean upperInclusive = false; boolean lowerInclusive = false;}|string? value = ()) {
        self.value = convertTsRange(value);
    }
}

public class TstzrangeValue {
    any value;

    public function init(record{time:Time|string  upper; time:Time|string  lower; boolean upperInclusive = false; boolean lowerInclusive = false;}|string? value = ()) {
        self.value = convertTstzRange(value);
    }
}

public class DaterangeValue {
    any value;

    public function init(record{time:Time|string  upper; time:Time|string  lower; boolean upperInclusive = false; boolean lowerInclusive = false;}|string? value = ()) {
        self.value = convertDateRange(value);
    }
}





function convertInet(string? value) returns any = @java:Method {
    'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
} external;

function convertCidr(string? value) returns any = @java:Method {
    'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
} external;

function convertMac(string? value) returns any = @java:Method {
    'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
} external;

function convertMac8(string? value) returns any = @java:Method {
    'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
} external;



function convertPoint(record{decimal x; decimal y;}|string? value) returns any = @java:Method {
    'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
} external;

function convertLine(record{decimal x1; decimal y1;decimal x2; decimal y2;}|
                    record{decimal a; decimal b; decimal c;}|string? value) returns any = @java:Method {
    'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
} external;



function convertUuid(string? value) returns any = @java:Method {
    'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
} external;



function convertTsVector(string? value) returns any = @java:Method {
    'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
} external;

function convertTsQuery(string? value) returns any = @java:Method {
    'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
} external;


function convertJson(json|string? value) returns any = @java:Method {
    'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
} external;
function convertJsonb(json|string? value) returns any = @java:Method {
    'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
} external;
function convertJsonPath(string? value) returns any = @java:Method {
    'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
} external;


function convertInterval(record{int years = 0; int months = 0;int days = 0; int hours = 0; int minutes = 0; decimal seconds = 0;}|string? value) returns any = @java:Method {
    'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
} external;


function convertInt4Range(record{int upper; int lower; boolean upperInclusive = false; boolean lowerInclusive = false;}|string? value) returns any = @java:Method {
    'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
} external;

function convertInt8Range(record{int upper; int lower; boolean upperInclusive = false; boolean lowerInclusive = false;}|string? value) returns any = @java:Method {
    'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
} external;

function convertNumRange(record{decimal upper; decimal lower; boolean upperInclusive = false; boolean lowerInclusive = false;}|string? value) returns any = @java:Method {
    'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
} external;

function convertTsRange(record{time:Time|string upper; time:Time|string lower; boolean upperInclusive = false; boolean lowerInclusive = false;}|string? value) returns any = @java:Method {
    'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
} external;

function convertTstzRange(record{time:Time|string upper; time:Time|string lower; boolean upperInclusive = false; boolean lowerInclusive = false;}|string? value) returns any = @java:Method {
    'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
} external;

function convertDateRange(record{time:Time|string upper; time:Time|string lower; boolean upperInclusive = false; boolean lowerInclusive = false;}|string? value) returns any = @java:Method {
    'class: "org.ballerinalang.postgresql.datatypes.PGUtils"
} external;