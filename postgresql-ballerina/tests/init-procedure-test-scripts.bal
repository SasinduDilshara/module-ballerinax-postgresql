import ballerina/sql;

public function initProcedureTestScripts() {
    _ =  createNetworkProcedure();
}

public function createNetworkProcedure() {
    sql:ParameterizedQuery networkProcedureCreationQuery = `
        create or replace procedure NetworkProcedure(
            row_id bigint,
            inet_in inet,
            cidr_in cidr,
            macaddr_in macaddr,
            macaddr8_in macaddr8
            )
            language plpgsql    
            as $$
            begin
                INSERT INTO NetworkTypes (row_id, inet_type, cidr_type, macaddr_type, macaddr8_type)
                    VALUES(row_id, inet_in, cidr_in, macaddr_in, macaddr8_in);
        end;$$  
    `;
    _ = executeQuery("network_db", networkProcedureCreationQuery);
}