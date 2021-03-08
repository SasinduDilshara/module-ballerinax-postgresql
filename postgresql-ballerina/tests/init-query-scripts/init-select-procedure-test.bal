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
            Returns setof CharacterTypes
            as $$
            DECLARE
                rec1 CharacterTypes;
                rec2 CharacterTypes;
           begin
                SELECT CharacterTypes.row_id, CharacterTypes.char_type, CharacterTypes.varchar_type,
                CharacterTypes.text_type, CharacterTypes.name_type from CharacterTypes into rec1
                where CharacterTypes.row_id = 1;
                return next rec1;
                SELECT * from CharacterTypes into rec2
                   where CharacterTypes.row_id = 2;     
                return next rec2;       
        end;
        $$  
            language plpgsql 
 ;
    `;
    _ = executeQuery("procedure_db", multpleSelectProcedureCreationQuery);
}
