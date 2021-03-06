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
                SELECT row_id, smallint_type, int_type, bigint_type, decimal_type, numerical_type, 
                    real_type, double_type, smallserial_type, serial_type, bigserial_type
                    from NumericTypes
                    where NumericTypes.row_id = row_id_inout;
                SELECT row_id, uuid_type from UuidTypes
                    where UuidTypes.row_id = row_id_inout;
                SELECT row_id, tsvector_type, tsquery_type from TextsearchTypes 
                    where TextsearchTypes.row_id = row_id_inout;
        end;$$  
    `;
    _ = executeQuery("procedure_db", multpleSelectProcedureCreationQuery);
}
