import ballerina/sql;

public function initInoutProcedureTestScripts() {
    _ = createNetworkInoutProcedure();
    _ = createGeometricInoutProcedure();
    _ = createUuidInoutProcedure();
    _ = createPglsnInoutProcedure();
    _ = createJsonInoutProcedure();
    _ = createBitInoutProcedure();
    _ = createDatetimeInoutProcedure();
    _ = createRangeInoutProcedure(); 
    _ = createTextsearchInoutProcedure();   
    _ = createObjectidentifierInoutProcedure();
}

public function createNetworkInoutProcedure() {
    sql:ParameterizedQuery networkInoutProcedureCreationQuery = `
        create or replace procedure NetworkInoutProcedure(
            inout row_id_inout bigint,
            inout inet_inout inet,
            inout cidr_inout cidr,
            inout macaddr_inout macaddr,
            inout macaddr8_inout macaddr8
            )
            language plpgsql    
            as $$
            begin
                Select row_id, inet_type, cidr_type, macaddr_type, macaddr8_type
                into row_id_inout, inet_inout, cidr_inout, macaddr_inout, macaddr8_inout
                     from NetworkTypes where NetworkTypes.row_id = 1;
        end;$$  
    `;
    _ = executeQuery("network_db", networkInoutProcedureCreationQuery);
}

public function createGeometricInoutProcedure() {
    sql:ParameterizedQuery geometricInoutProcedureCreationQuery = `
        create or replace procedure GeometricInoutProcedure(
            row_id_inout bigint,
            point_inout point,
            line_inout line,
            lseg_inout lseg,
            box_inout box,
            circle_inout circle
            )
            language plpgsql    
            as $$
            begin
                SELECT row_id, point_type, line_type, lseg_type, box_type,circle_type 
                into row_id_inout, point_inout, line_inout, lseg_inout, box_inout, circle_inout
                from GeometricTypes where GeometricTypes.row_id = row_id_inout
        end;$$  
    `;
    _ = executeQuery("geometric_db", geometricInoutProcedureCreationQuery);
}

public function createUuidInoutProcedure() {
    sql:ParameterizedQuery uuidInoutProcedureCreationQuery = `
        create or replace procedure UuidInoutProcedure(
            row_id_inout bigint,
            uuid_inout uuid
            )
            language plpgsql    
            as $$
            begin
                SELECT row_id, uuid_type from UuidTypes
                 into row_id_inout, uuid_inout
                 where UuidTypes.row_id = row_id_inout;
        end;$$  
    `;
    _ = executeQuery("uuid_db", uuidInoutProcedureCreationQuery);
}

public function createPglsnInoutProcedure() {
    sql:ParameterizedQuery pglsnInoutProcedureCreationQuery = `
        create or replace procedure PglsnInoutProcedure(
            row_id_inout bigint,
            pglsn_inout pg_lsn
            )
            language plpgsql    
            as $$
            begin
                SELECT row_id, pglsn_type from PglsnTypes
                into row_id_inout, pglsn_inout
                 where PglsnTypes.row_id = row_id_inout;
        end;$$  
    `;
    _ = executeQuery("pglsn_db", pglsnInoutProcedureCreationQuery);
}

public function createJsonInoutProcedure() {
    sql:ParameterizedQuery jsonInoutProcedureCreationQuery = `
        create or replace procedure JsonInoutProcedure(
            row_id_inout bigint,
            json_inout json,
            jsonb_inout jsonb,
            jsonpath_inout jsonpath
            )
            language plpgsql    
            as $$
            begin
                SELECT row_id, json_type, jsonb_type, jsonpath_type 
                into row_id_inout, json_inout, jsonb_inout, jsonpath_inout
                from JsonTypes where JsonTypes.row_id = row_id_inout;
        end;$$  
    `;
    _ = executeQuery("json_db", jsonInoutProcedureCreationQuery);
}

public function createBitInoutProcedure() {
    sql:ParameterizedQuery bitInoutProcedureCreationQuery = `
        create or replace procedure BitInoutProcedure(
            row_id_inout bigint,
            bitvarying_inout bit varying(10),
            bit_inout bit
            )
            language plpgsql    
            as $$
            begin
                SELECT row_id, varbitstring_type, bit_type 
                into row_id_inout, bitvarying_inout, bit_inout
                from BitTypes where BitTypes.row_id = row_id_inout;
        end;$$  
    `;
    _ = executeQuery("bitstring_db", bitInoutProcedureCreationQuery);
}

public function createDatetimeInoutProcedure() {
    sql:ParameterizedQuery datetimeInoutProcedureCreationQuery = `
        create or replace procedure DatetimeInoutProcedure(
            row_id_inout bigint,
            date_inout date,
            time_inout time,
            timetz_inout timetz,
            timestamp_inout timestamp,
            timestamptz_inout timestamptz,
			interval_inout interval
            )
            language plpgsql    
            as $$
            begin
                SELECT row_id, date_type, time_type, timetz_type, timestamp_type, 
                timestamptz_type, interval_type from DatetimeTypes 
                into date_inout, time_inout, timetz_inout, timestamp_inout, timestamptz_inout, interval_inout
                where DatetimeTypes.row_id = row_id_inout;
        end;$$  
    `;
    _ = executeQuery("datetime_db", datetimeInoutProcedureCreationQuery);
}

public function createRangeInoutProcedure() {
    sql:ParameterizedQuery rangeInoutProcedureCreationQuery = `
        create or replace procedure RangeProcedure(
            row_id_inout bigint,
            int4range_inout int4range,
            int8range_inout int8range,
            numrange_inout numrange,
            tsrange_inout tsrange,
            tstzrange_inout tstzrange,
			daterange_inout daterange
            )
            language plpgsql    
            as $$
            begin
                SELECT row_id, int4range_type, int8range_type, numrange_type, tsrange_type, 
                    tstzrange_type, daterange_type from RangeTypes 
                into row_id_inout, int4range_inout, int8range_inout,
                    numrange_inout, tsrange_inout, tstzrange_inout, daterange_inout
                where RangeTypes.row_id = row_id_inout;
        end;$$  
    `;
    _ = executeQuery("range_db", rangeInoutProcedureCreationQuery);
}

public function createTextsearchInoutProcedure() {
    sql:ParameterizedQuery textsearchInoutProcedureCreationQuery = `
        create or replace procedure TextsearchProcedure(
            row_id_inout bigint,
            tsvector_inout tsvector,
            tsquery_inout tsquery
            )
            language plpgsql    
            as $$
            begin
                SELECT row_id, tsvector_type, tsquery_type 
                into row_id_inout, tsvector_inout, tsquery_inout
                from TextsearchTypes where TextsearchTypes.row_id = row_id_inout;
        end;$$  
    `;
    _ = executeQuery("ts_db", textsearchInoutProcedureCreationQuery);
}

public function createObjectidentifierInoutProcedure() {
    sql:ParameterizedQuery objectidentifierInoutProcedureCreationQuery = `
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
    _ = executeQuery("objectidentifier_db", objectidentifierInoutProcedureCreationQuery);
}