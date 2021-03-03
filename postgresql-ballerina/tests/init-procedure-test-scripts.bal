import ballerina/sql;

public function initProcedureTestScripts() {
    _ =  createNetworkProcedure();
    _ =  createGeometricProcedure();
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

public function createGeometricProcedure() {
    sql:ParameterizedQuery geometricProcedureCreationQuery = `
        create or replace procedure GeometricProcedure(
            row_id bigint,
            point_type point,
            line_type line,
            lseg_type lseg,
            box_type box,
            circle_type circle
            )
            language plpgsql    
            as $$
            begin
                INSERT INTO GeometricTypes(
                    row_id,
                    point_type,
                    line_type,
                    lseg_type,
                    box_type,
                    circle_type
                    ) 
                VALUES (
                    row_id,
                    point_type,
                    line_type,
                    lseg_type,
                    box_type,
                    circle_type
                    );
        end;$$  
    `;
    _ = executeQuery("geometric_db", geometricProcedureCreationQuery);
}