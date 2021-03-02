
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
