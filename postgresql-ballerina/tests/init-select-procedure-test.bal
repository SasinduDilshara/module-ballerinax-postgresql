import ballerina/sql;

public function initMultipleSelectProcedureTestScripts() {
    _ = createSingleSelectProcedure();
    _ = createMultipleSelectProcedure();
    _ = createMultipleSelectQueryProcedure();
}

public function createSingleSelectProcedure() {
    sql:ParameterizedQuery singleSelectProcedureCreationQuery = `
        create or replace function singleSelectProcedure(
            row_id_in bigint
            )
        returns table(char_type char(15), varchar_type varchar(30), text_type text, name_type name)
            language plpgsql    
            as $$
            begin
                return QUERY
                 SELECT CharacterTypes.char_type, CharacterTypes.varchar_type, CharacterTypes.text_type, CharacterTypes.name_type from CharacterTypes
                    where CharacterTypes.row_id = row_id_in;
        end;$$  
    `;
    _ = executeQuery("procedure_db", singleSelectProcedureCreationQuery);
}

public function createMultipleSelectProcedure() {
    sql:ParameterizedQuery multpleSelectProcedureCreationQuery = `
         create or replace function multipleSelectProcedure()
        RETURNS table(char_type char(15), varchar_type varchar(30), text_type text, name_type name)   
            as $$
           begin
                return QUERY
                SELECT CharacterTypes.char_type, CharacterTypes.varchar_type, CharacterTypes.text_type, CharacterTypes.name_type from CharacterTypes;            
        end;
        $$  
            language plpgsql 
 ;
    `;
    _ = executeQuery("procedure_db", multpleSelectProcedureCreationQuery);
}

public function createMultipleSelectQueryProcedure() {
    sql:ParameterizedQuery multpleSelectProcedureCreationQuery = `
         create or replace function multipleQuerySelectProcedure()
          returns SETOF CharacterTypes
            as $$
            DECLARE
                rec CharacterTypes;
           begin
                SELECT CharacterTypes.row_id, CharacterTypes.char_type, CharacterTypes.varchar_type, CharacterTypes.text_type, CharacterTypes.name_type from CharacterTypes
                where CharacterTypes.row_id = 1 into rec;
                return next rec;
                SELECT CharacterTypes.row_id, CharacterTypes.char_type, CharacterTypes.varchar_type, CharacterTypes.text_type, CharacterTypes.name_type from CharacterTypes
                   where CharacterTypes.row_id = 1 into rec;     
                return next rec;       
        end;
        $$  
            language plpgsql 
 ;
    `;
    _ = executeQuery("procedure_db", multpleSelectProcedureCreationQuery);
}
