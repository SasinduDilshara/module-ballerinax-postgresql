import ballerina/java;

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
