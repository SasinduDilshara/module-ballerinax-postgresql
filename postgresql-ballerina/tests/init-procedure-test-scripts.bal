import ballerina/sql;

public function initProcedureTestScripts() {
    _ = createNumericProcedure();
    _ = createCharacterProcedure();
    _ = createBooleanProcedure();
    _ = createNetworkProcedure();
    _ = createGeometricProcedure();
    _ = createUuidProcedure();
    _ = createPglsnProcedure();
    _ = createJsonProcedure();
    _ = createBitProcedure();
    _ = createDatetimeProcedure();
    _ = createRangeProcedure(); 
    _ = createTextsearchProcedure();   
    _ = createObjectidentifierProcedure();
}

public function createNumericProcedure() {
    sql:ParameterizedQuery numericProcedureCreationQuery = `
        create or replace procedure NumericProcedure(
            row_id_in bigint,
            smallint_in smallint,
            int_in int,
            bigint_in bigint,
            decimal_in decimal,
            numeric_in numeric,
            real_in real,
            double_in double precision
            )
            language plpgsql    
            as $$
            begin
                INSERT INTO NumericTypes2(
                    row_id,
                    smallint_type,
                    int_type,
                    bigint_type,
                    decimal_type,
                    numeric_type,
                    double_type,
                    real_type
                    ) 
                VALUES (
                    row_id_in,
                    smallint_in,
                    int_in,
                    bigint_in,
                    decimal_in,
                    numeric_in,
                    double_in,
                    real_in
                    );
        end;$$  
    `;
    _ = executeQuery("numeric_db", numericProcedureCreationQuery);
}

public function createCharacterProcedure() {
    sql:ParameterizedQuery characterProcedureCreationQuery = `
        create or replace procedure CharacterProcedure(
            row_id bigint,
            char_in char(15),
            varchar_in varchar(15),
            text_in text,
            name_in name
            )
            language plpgsql    
            as $$
            begin
                INSERT INTO CharacterTypes (row_id, char_type, varchar_type, text_type, name_type)
                    VALUES(row_id, char_in, varchar_in, text_in, name_in);
        end;$$  
    `;
    _ = executeQuery("character_db", characterProcedureCreationQuery);
}

public function createBooleanProcedure() {
    sql:ParameterizedQuery booleanProcedureCreationQuery = `
        create or replace procedure BooleanProcedure(
            row_id bigint,
            boolean_in boolean
            )
            language plpgsql    
            as $$
            begin
                INSERT INTO BooleanTypes(
                    row_id,
                    boolean_type
                    ) 
                VALUES (
                    row_id,
                    boolean_in
                    );
        end;$$  
    `;
    _ = executeQuery("boolean_db", booleanProcedureCreationQuery);
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
            point_in point,
            line_in line,
            lseg_in lseg,
            box_in box,
            circle_in circle
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
                    point_in,
                    line_in,
                    lseg_in,
                    box_in,
                    circle_in
                    );
        end;$$  
    `;
    _ = executeQuery("geometric_db", geometricProcedureCreationQuery);
}

public function createUuidProcedure() {
    sql:ParameterizedQuery uuidProcedureCreationQuery = `
        create or replace procedure UuidProcedure(
            row_id bigint,
            uuid_in UUID
            )
            language plpgsql    
            as $$
            begin
                INSERT INTO UuidTypes(
                    row_id,
                    uuid_type
                    ) 
                VALUES (
                    row_id,
                    uuid_in
                    );
        end;$$  
    `;
    _ = executeQuery("uuid_db", uuidProcedureCreationQuery);
}

public function createPglsnProcedure() {
    sql:ParameterizedQuery pglsnProcedureCreationQuery = `
        create or replace procedure PglsnProcedure(
            row_id bigint,
            pglsn_in pg_lsn
            )
            language plpgsql    
            as $$
            begin
                INSERT INTO PglsnTypes(
                    row_id,
                    pglsn_type
                    ) 
                VALUES (
                    row_id,
                    pglsn_in
                    );
        end;$$  
    `;
    _ = executeQuery("pglsn_db", pglsnProcedureCreationQuery);
}

public function createJsonProcedure() {
    sql:ParameterizedQuery jsonProcedureCreationQuery = `
        create or replace procedure JsonProcedure(
            row_id bigint,
            json_in json,
            jsonb_in jsonb,
            jsonpath_in jsonpath
            )
            language plpgsql    
            as $$
            begin
                INSERT INTO JsonTypes (row_id, json_type, jsonb_type, jsonpath_type)
                    VALUES(row_id, json_in, jsonb_in, jsonpath_in);
        end;$$  
    `;
    _ = executeQuery("json_db", jsonProcedureCreationQuery);
}

public function createBitProcedure() {
    sql:ParameterizedQuery bitProcedureCreationQuery = `
        create or replace procedure BitProcedure(
            row_id bigint,
            bitvarying_in bit varying(10),
            bit_in bit
            )
            language plpgsql    
            as $$
            begin
                INSERT INTO BitTypes (row_id, varbitstring_type, bit_type)
                    VALUES(row_id, bitvarying_in, bit_in);
        end;$$  
    `;
    _ = executeQuery("bitstring_db", bitProcedureCreationQuery);
}

public function createDatetimeProcedure() {
    sql:ParameterizedQuery datetimeProcedureCreationQuery = `
        create or replace procedure DatetimeProcedure(
            row_id bigint,
            date_in date,
            time_in time,
            timetz_in timetz,
            timestamp_in timestamp,
            timestamptz_in timestamptz,
			interval_in interval
            )
            language plpgsql    
            as $$
            begin
                INSERT INTO DatetimeTypes(
                    row_id,
                    date_type,
                    time_type,
                    timetz_type,
                    timestamp_type,
                    timestamptz_type,
					interval_type
                    ) 
                VALUES (
                    row_id,
                    date_in,
                    time_in,
                    timetz_in,
                    timestamp_in,
                    timestamptz_in,
					interval_in
                    );
        end;$$  
    `;
    _ = executeQuery("datetime_db", datetimeProcedureCreationQuery);
}

public function createRangeProcedure() {
    sql:ParameterizedQuery rangeProcedureCreationQuery = `
        create or replace procedure RangeProcedure(
            row_id bigint,
            int4range_in int4range,
            int8range_in int8range,
            numrange_in numrange,
            tsrange_in tsrange,
            tstzrange_in tstzrange,
			daterange_in daterange
            )
            language plpgsql    
            as $$
            begin
                INSERT INTO RangeTypes(
                    row_id,
                    int4range_type,
                    int8range_type,
                    numrange_type,
                    tsrange_type,
                    tstzrange_type,
					daterange_type
                    ) 
                VALUES (
                    row_id,
                    int4range_in,
                    int8range_in,
                    numrange_in,
                    tsrange_in,
                    tstzrange_in,
					daterange_in
                    );
        end;$$  
    `;
    _ = executeQuery("range_db", rangeProcedureCreationQuery);
}

public function createTextsearchProcedure() {
    sql:ParameterizedQuery textsearchProcedureCreationQuery = `
        create or replace procedure TextsearchProcedure(
            row_id bigint,
            tsvector_in tsvector,
            tsquery_in tsquery
            )
            language plpgsql    
            as $$
            begin
                INSERT INTO TextsearchTypes(
                    row_id,
                    tsvector_type,
                    tsquery_type
                    ) 
                VALUES (
                    row_id,
                    tsvector_in,
                    tsquery_in
                    );
        end;$$  
    `;
    _ = executeQuery("ts_db", textsearchProcedureCreationQuery);
}

public function createObjectidentifierProcedure() {
    sql:ParameterizedQuery objectidentifierProcedureCreationQuery = `
        create or replace procedure ObjectidentifierProcedure(
            row_id bigint,
            oid_in oid,
            regclass_in regclass,
            regconfig_in regconfig,
            regdictionary_in regdictionary,
            regnamespace_in regnamespace,
            regoper_in regoper,
            regoperator_in regoperator,
            regproc_in regproc,
            regprocedure_in regprocedure,
            regrole_in regrole,
            regtype_in regtype
            )
            language plpgsql    
            as $$
            begin
                INSERT INTO ObjectidentifierTypes(
                    row_id,
                    oid_type,
                    regclass_type,
                    regconfig_type,
                    regdictionary_type,
                    regnamespace_type,
                    regoper_type,
                    regoperator_type,
                    regproc_type,
                    regprocedure_type,
                    regrole_type,
                    regtype_type
                    ) 
                VALUES (
                    row_id,
                    oid_in,
                    regclass_in,
                    regconfig_in,
                    regdictionary_in,
                    regnamespace_in,
                    regoper_in,
                    regoperator_in,
                    regproc_in,
                    regprocedure_in,
                    regrole_in,
                    regtype_in
                    );
        end;$$  
    `;
    _ = executeQuery("objectidentifier_db", objectidentifierProcedureCreationQuery);
}