import ballerina/sql;

string tableName = "NetworkTypes";

public type NetworkRecord record{
    
    int ID;
    string inetType;
    string cidrType;
    string macaddrType;
    string macaddr8Type;
};

sql:parameterizedQuery networkTableCreateQuery = 
`
CREATE TABLE IF NOT EXISTS ${tableName}(
    id SERIAL,
    inetTyp inet,
    cidrType cidr,
    macaddrType macaddr,
    macaddr8Type macaddr8,
    PRIMARY KEY(id)
);

`

sql:parameterizedQuery networkTableInsertQuery = 
`
    INSERT INTO ${tableName}(
        inetTyp,
        cidrType,
        macaddrType,
        macaddr8Type
        ) 
    VALUES (
        '192.168.0.1/24',
        '::ffff:1.2.3.0/120',
        '08:00:2b:01:02:03',
        '08-00-2b-01-02-03-04-05
        );

    INSERT INTO ${tableName}(
        inetTyp,
        cidrType,
        macaddrType,
        macaddr8Type
        ) 
    VALUES (
        '192.168.0.2/28',
        '10.1.2.3/32',
        '08-00-2b-01-02-03',
        '08-00-2b-01-02-03-04-05'
        )
`;