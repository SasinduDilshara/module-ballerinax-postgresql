import ballerina/sql;

public function initMultipleSelectProcedureTestScripts() {
    _ = createMultipleSelectProcedure();
}

public function createMultipleSelectProcedure() {
    sql:ParameterizedQuery multpleSelectProcedureCreationQuery = `
        create or replace procedure MultpleSelectProcedure(
            row_id_inout bigint
            )
            language plpgsql    
            as $$
            begin
                SELECT row_id, point_type, line_type, lseg_type, box_type,circle_type from GeometricTypes 
                    where GeometricTypes.row_id = row_id_inout;
                SELECT row_id, uuid_type from UuidTypes
                    where UuidTypes.row_id = row_id_inout;
                SELECT row_id, tsvector_type, tsquery_type from TextsearchTypes 
                    where TextsearchTypes.row_id = row_id_inout;
        end;$$  
    `;
    _ = executeQuery("procedure_db", multpleSelectProcedureCreationQuery);
}
