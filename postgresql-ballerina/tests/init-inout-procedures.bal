import ballerina/sql;
// import ballerina/time;

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
            inout row_id_inout bigint,
            inout point_inout point,
            inout line_inout line,
            inout lseg_inout lseg,
            inout box_inout box,
            inout circle_inout circle
            )
            language plpgsql    
            as $$
            begin
                SELECT row_id, point_type, line_type, lseg_type, box_type,circle_type 
                into row_id_inout, point_inout, line_inout, lseg_inout, box_inout, circle_inout
                from GeometricTypes where GeometricTypes.row_id = row_id_inout;
        end;$$  
    `;
    _ = executeQuery("geometric_db", geometricInoutProcedureCreationQuery);
}

public function createUuidInoutProcedure() {
    sql:ParameterizedQuery uuidInoutProcedureCreationQuery = `
        create or replace procedure UuidInoutProcedure(
            inout row_id_inout bigint,
            inout uuid_inout uuid
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
            inout row_id_inout bigint,
            inout pglsn_inout pg_lsn
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
            inout row_id_inout bigint,
            inout json_inout json,
            inout jsonb_inout jsonb,
            inout jsonpath_inout jsonpath
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
            inout row_id_inout bigint,
            inout bitvarying_inout bit varying(10),
            inout bit_inout bit(1)
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
            inout row_id_inout bigint,
            inout date_inout date,
            inout time_inout time,
            inout timetz_inout timetz,
            inout timestamp_inout timestamp,
            inout timestamptz_inout timestamptz,
			inout interval_inout interval
            )
            language plpgsql    
            as $$
            begin
                SELECT row_id, date_type, time_type, timetz_type, timestamp_type, 
                timestamptz_type, interval_type from DatetimeTypes 
                into row_id_inout, date_inout, time_inout, timetz_inout, timestamp_inout, timestamptz_inout, interval_inout
                where DatetimeTypes.row_id = row_id_inout;
        end;$$  
    `;
    _ = executeQuery("datetime_db", datetimeInoutProcedureCreationQuery);
}

public function createRangeInoutProcedure() {
    sql:ParameterizedQuery rangeInoutProcedureCreationQuery = `
        create or replace procedure RangeInoutProcedure(
            inout row_id_inout bigint,
            inout int4range_inout int4range,
            inout int8range_inout int8range,
            inout numrange_inout numrange,
            inout tsrange_inout tsrange,
            inout tstzrange_inout tstzrange,
			inout daterange_inout daterange
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
        create or replace procedure TextsearchInoutProcedure(
            inout row_id_inout bigint,
            inout tsvector_inout tsvector,
            inout tsquery_inout tsquery
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
        create or replace procedure ObjectidentifierInoutProcedure(
            inout row_id_inout bigint,
            inout oid_inout oid,
            inout regclass_inout regclass,
            inout regconfig_inout regconfig,
            inout regdictionary_inout regdictionary,
            inout regnamespace_inout regnamespace,
            inout regoper_inout regoper,
            inout regoperator_inout regoperator,
            inout regproc_inout regproc,
            inout regprocedure_inout regprocedure,
            inout regrole_inout regrole,
            inout regtype_inout regtype
            )
            language plpgsql    
            as $$
            begin
                SELECT row_id, oid_type, regclass_type, regconfig_type, regdictionary_type,
            regnamespace_type, regoper_type, regoperator_type, regproc_type, regprocedure_type, regrole_type, regtype_type 
            from ObjectidentifierTypes
            into row_id_inout, oid_inout, regclass_inout, regconfig_inout, regdictionary_inout, regnamespace_inout,
             regoper_inout, regoperator_inout, regproc_inout, regprocedure_inout, regrole_inout, regtype_inout
             where ObjectidentifierTypes.row_id = row_id_inout;
        end;$$  
    `;
    _ = executeQuery("objectidentifier_db", objectidentifierInoutProcedureCreationQuery);
}