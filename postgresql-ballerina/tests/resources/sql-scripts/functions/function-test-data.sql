        create or replace function NumericInProcedure(row_id_in bigint, smallint_in smallint, int_in int,
            bigint_in bigint, decimal_in decimal, numeric_in numeric, 
            real_in real, double_in double precision)
            returns table(row_id int, smallint_type smallint, int_type int, bigint_type bigint, decimal_type decimal, numeric_type numeric)
                as $$
                DECLARE
            begin
                    INSERT INTO NumericTypes2(row_id, smallint_type,int_type,bigint_type,decimal_type,numeric_type,real_type,
                        double_type
                    ) 
                    VALUES (
                        row_id_in, smallint_in, int_in, bigint_in, decimal_in,
                        numeric_in, real_in, double_in
                    );
                    return QUERY
                    SELECT NumericTypes2.row_id, NumericTypes2.smallint_type, NumericTypes2.int_type, NumericTypes2.bigint_type, NumericTypes2.decimal_type, NumericTypes2.numeric_type FROM NumericTypes2 order by NumericTypes2.row_id ASC;
            end;
            $$  
                language plpgsql;

        create or replace function CharacterInProcedure(row_id_in bigint, char_in char, varchar_in varchar,
            text_in text, name_in name)
            returns setof CharacterTypes
                as $$
                DECLARE
            begin
                    INSERT INTO CharacterTypes(row_id, char_type,varchar_type,text_type,name_type)
                    VALUES (
                        row_id_in, char_in, varchar_in, text_in, name_in
                    );
                    return QUERY
                    SELECT * FROM CharacterTypes;
            end;
            $$  
                language plpgsql;

        create or replace function BooleanInProcedure(row_id_in bigint, boolean_in boolean) returns setof BooleanTypes
                as $$
                DECLARE
            begin
                    INSERT INTO BooleanTypes(row_id, boolean_type)
                    VALUES (
                        row_id_in, boolean_in
                    );
                    return QUERY
                    SELECT * FROM BooleanTypes;
            end;
            $$  
                language plpgsql;

        create or replace function UuidInProcedure(row_id_in bigint, uuid_in UUID) returns setof UuidTypes
                as $$
                DECLARE
            begin
                    INSERT INTO UuidTypes(row_id, uuid_type)
                    VALUES (
                        row_id_in, uuid_in
                    );
                    return QUERY
                    SELECT * FROM UuidTypes;
            end;
            $$  
                language plpgsql;

        create or replace function NetworkInProcedure(row_id_in bigint, inet_in inet, cidr_in cidr,
            macaddr_in macaddr, macaddr8_in macaddr8)
            returns setof NetworkTypes
                as $$
                DECLARE
            begin
                    INSERT INTO NetworkTypes(row_id, inet_type,cidr_type,macaddr_type,macaddr8_type)
                    VALUES (
                        row_id_in, inet_in, cidr_in, macaddr_in, macaddr8_in
                    );
                    return QUERY
                    SELECT * FROM NetworkTypes;
            end;
            $$  
                language plpgsql;

        create or replace function PglsnInProcedure(row_id_in bigint, pglsn_in pg_lsn)
        returns setof PglsnTypes
                as $$
                DECLARE
            begin
                    INSERT INTO PglsnTypes(row_id, pglsn_type)
                    VALUES (
                        row_id_in, pglsn_in
                    );
                    return QUERY
                    SELECT * FROM PglsnTypes;
            end;
            $$  
                language plpgsql;
                
        create or replace function GeometricInProcedure(row_id_in bigint, point_in point,
            line_in line, lseg_in lseg, box_in box, circle_in circle)
            returns setof GeometricTypes
                as $$
                DECLARE
            begin
                    INSERT INTO GeometricTypes(row_id, point_type, line_type, lseg_type, box_type, circle_type)
                    VALUES (
                        row_id_in, point_in, line_in, lseg_in, box_in, circle_in
                    );
                    return QUERY
                    SELECT * FROM GeometricTypes;
            end;
            $$  
                language plpgsql;

        create or replace function JsonInProcedure(row_id_in bigint, json_in json,
                        jsonb_in jsonb, jsonpath_in jsonpath)
                        returns setof JsonTypes
                as $$
                DECLARE
            begin
                    INSERT INTO JsonTypes(row_id, json_type, jsonb_type, jsonpath_type)
                    VALUES (
                        row_id_in, json_in, jsonb_in, jsonpath_in
                    );
                    return QUERY
                    SELECT * FROM JsonTypes;
            end;
            $$  
                language plpgsql;
        
        create or replace function BitInProcedure(row_id_in bigint,
                        varbitstring_in bit varying(15), bit_in bit)
                        returns table(row_id int, varbitstring_type bit varying(15), bit_type bit)
                as $$
                DECLARE
            begin
                    INSERT INTO BitTypes(row_id, varbitstring_type, bit_type)
                    VALUES (
                        row_id_in, varbitstring_in, bit_in
                    );
                    return QUERY
                    SELECT BitTypes.row_id, BitTypes.varbitstring_type, BitTypes.bit_type FROM BitTypes;
            end;
            $$  
                language plpgsql;

        create or replace function DatetimeInProcedure(row_id_in bigint, date_in date, time_in time,
            timetz_in timetz, timestamp_in timestamp, timestamptz_in timestamptz, interval_in interval)
            returns setof DatetimeTypes
                as $$
                DECLARE
            begin
                INSERT INTO DatetimeTypes(row_id, date_type, time_type, timetz_type, timestamp_type,
                                timestamptz_type, interval_type)
                    VALUES (
                        row_id_in, date_in, time_in, timetz_in, timestamp_in,
                        timestamptz_in, interval_in
                    );
                    return QUERY
                    SELECT * FROM DatetimeTypes;
            end;
            $$  
                language plpgsql;

        create or replace function RangeInProcedure(row_id_in bigint, int4range_in int4range, int8range_in int8range,
            numrange_in numrange, tsrange_in tsrange,tstzrange_in tstzrange , daterange_in daterange )
            returns setof RangeTypes
                as $$
                DECLARE
            begin
                INSERT INTO RangeTypes(row_id, int4range_type, int8range_type, numrange_type, tsrange_type,
                                tstzrange_type, daterange_type) 
                    VALUES (
                        row_id_in, int4range_in, int8range_in, numrange_in, tsrange_in,
                        tstzrange_in, daterange_in
                    );
                    return QUERY
                    SELECT * FROM RangeTypes;
            end;
            $$  
                language plpgsql;

        create or replace function TextsearchInProcedure(row_id_in bigint,
                        tsvector_in tsvector, tsquery_in tsquery)
                        returns setof TextsearchTypes
                as $$
                DECLARE
            begin
                    INSERT INTO TextsearchTypes(row_id, tsvector_type, tsquery_type)
                    VALUES (
                        row_id_in, tsvector_in, tsquery_in
                    );
                    return QUERY
                    SELECT * FROM TextsearchTypes;
            end;
            $$  
                language plpgsql;

        create or replace function ObjectidentifierInProcedure(row_id_in regconfig, oid_in oid, regclass_in regclass,
            regconfig_in regconfig, regdictionary_in regdictionary, regnamespace_in regnamespace, regoper_in regoper,
            regoperator_in regoperator, regproc_in regproc, regprocedure_in regprocedure, regrole_in regrole, regtype_in regtype )
            returns setof ObjectidentifierTypes
                as $$
                DECLARE
            begin
                INSERT INTO ObjectidentifierTypes(row_id, oid_type, regclass_type, regconfig_type, regdictionary_type,
                                regnamespace_type, regoper_type, regoperator_type, regproc_type, regprocedure_type, regrole_type, regtype_type) 
                    VALUES (
                        row_id_in, oid_in, regclass_in, regconfig_in, regdictionary_in,
                        regnamespace_in, regoper_in, regoperator_in, regproc_in, regprocedure_in, regrole_in, regtype_in
                    );
                    return QUERY
                    SELECT * FROM ObjectidentifierTypes;
            end;
            $$  
                language plpgsql;

    create or replace function NumericInoutProcedure(inout row_id_inout bigint, inout smallint_inout smallint, inout int_inout int,
            inout bigint_inout bigint, inout decimal_inout decimal, inout numeric_inout numeric, 
            inout real_inout real, inout double_inout double precision)
                as $$
                DECLARE
            begin
                    INSERT INTO NumericTypes2(row_id, smallint_type,int_type,bigint_type,decimal_type,numeric_type,real_type,
                        double_type
                    ) 
                    VALUES (
                        row_id_inout, smallint_inout, int_inout, bigint_inout, decimal_inout,
                        numeric_inout, real_inout, double_inout
                    );
                    SELECT row_id, smallint_type,int_type,bigint_type,decimal_type,numeric_type,real_type,
                        double_type into row_id_inout, smallint_inout, int_inout, bigint_inout, decimal_inout, numeric_inout,
                        real_inout, double_inout FROM NumericTypes2 where row_id = 1;
            end;
            $$  
                language plpgsql;

        create or replace function CharacterInoutProcedure(inout row_id_inout bigint, inout char_inout char, inout varchar_inout varchar,
            inout text_inout text, inout name_inout name)
                as $$
                DECLARE
            begin
                    INSERT INTO CharacterTypes(row_id, char_type,varchar_type,text_type,name_type)
                    VALUES (
                        row_id_inout, char_inout, varchar_inout, text_inout, name_inout
                    );
                    SELECT row_id, char_type, varchar_type, text_type, name_type, numeric_type, real_type,
                        double_type into row_id_inout, char_inout, varchar_inout, text_inout, name_inout
                        FROM CharacterTypes where row_id = 1;
            end;
            $$  
                language plpgsql;

        create or replace function BooleanInoutProcedure(inout row_id_inout bigint, inout boolean_inout boolean)
                as $$
                DECLARE
            begin
                    INSERT INTO BooleanTypes(row_id, boolean_type)
                    VALUES (
                        row_id_inout, boolean_inout
                    );
                    SELECT row_id, boolean_type
                        into row_id_inout, boolean_inout
                        FROM BooleanTypes where row_id = 1;
            end;
            $$  
                language plpgsql;

        create or replace function UuidInoutProcedure(inout row_id_inout bigint, inout uuid_inout UUID)
                as $$
                DECLARE
            begin
                    INSERT INTO UuidTypes(row_id, uuid_type)
                    VALUES (
                        row_id_inout, uuid_inout
                    );
                    SELECT row_id, uuid_type
                        into row_id_inout, uuid_inout
                        FROM UuidTypes where row_id = 1;
            end;
            $$  
                language plpgsql;

        create or replace function NetworkInoutProcedure(inout row_id_inout bigint, inout inet_inout inet, inout cidr_inout cidr,
            inout macaddr_inout macaddr, inout macaddr8_inout macaddr8)
                as $$
                DECLARE
            begin
                    INSERT INTO NetworkTypes(row_id, inet_type,cidr_type,macaddr_type,macaddr8_type)
                    VALUES (
                        row_id_inout, inet_inout, cidr_inout, macaddr_inout, macaddr8_inout
                    );
                    SELECT row_id, inet_type, cidr_type, macaddr_type, macaddr8_type
                    into row_id_inout, inet_inout, cidr_inout, macaddr_inout, macaddr8_inout
                        FROM NetworkTypes where row_id = 1;
            end;
            $$  
                language plpgsql;

        create or replace function PglsnInoutProcedure(inout row_id_inout bigint, inout pglsn_inout pg_lsn)
                as $$
                DECLARE
            begin
                    INSERT INTO PglsnTypes(row_id, pglsn_type)
                    VALUES (
                        row_id_inout, pglsn_inout
                    );
                    SELECT row_id, pglsn_type
                        into row_id_inout, pglsn_inout
                        FROM PglsnTypes where row_id = 1;
            end;
            $$  
                language plpgsql;
                
        create or replace function GeometricInoutProcedure(inout row_id_inout bigint, inout point_inout point,
            inout line_inout line, inout lseg_inout lseg, inout box_inout box, inout circle_inout circle)
                as $$
                DECLARE
            begin
                    INSERT INTO GeometricTypes(row_id, point_type, line_type, lseg_type, box_type, circle_type)
                    VALUES (
                        row_id_inout, point_inout, line_inout, lseg_inout, box_inout, circle_inout
                    );
                    SELECT row_id, point_type, line_type, lseg_type, box_type, circle_type,
                    into row_id_inout, point_inout, line_inout, lseg_inout, box_inout
                        circle_inout FROM GeometricTypes where GeometricTypes.row_id = 1;
            end;
            $$  
                language plpgsql;

        create or replace function JsonInoutProcedure(inout row_id_inout bigint, inout json_inout json,
                        inout jsonb_inout jsonb, inout jsonpath_inout jsonpath)
                as $$
                DECLARE
            begin
                    INSERT INTO JsonTypes(row_id, json_type, jsonb_type, jsonpath_type)
                    VALUES (
                        row_id_inout, json_inout, jsonb_inout, jsonpath_inout, box_inout, circle_inout
                    );
                    SELECT row_id, json_type, jsonb_type, jsonpath_type
                    into row_id_inout, json_inout, jsonb_inout, jsonpath_inout FROM JsonTypes where row_id = 1;
            end;
            $$  
                language plpgsql;
        
        create or replace function BitInoutProcedure(inout row_id_inout bigint,
                        inout varbitstring_inout varchar(15), inout bit_inout bit)
                as $$
                DECLARE
            begin
                    INSERT INTO BitTypes(row_id, varbitstring_type, bit_type)
                    VALUES (
                        row_id_inout, varbitstring_inout, bit_inout
                    );
                    SELECT row_id, varbitstring_type, bit_type
                    into row_id_inout, varbitstring_inout, bit_inout FROM BitTypes where row_id = 1;
            end;
            $$  
                language plpgsql;

        create or replace function DatetimeInoutProcedure(inout row_id_inout timetz, inout date_inout date, inout time_inout time,
            inout timetz_inout timetz, inout timestamp_inout timestamp, inout interval_inout interval, 
            inout timestamptz_inout timestamptz)
                as $$
                DECLARE
            begin
                INSERT INTO DatetimeTypes(row_id, date_type, time_type, timetz_type, timestamp_type,
                                timestamptz_type, interval_type)
                    VALUES (
                        row_id_inout, date_inout, time_inout, timetz_inout, timestamp_inout,
                        timestamptz_inout, interval_inout
                    );
                    SELECT row_id, date_type, time_type, timetz_type, timestamp_type, timestamptz_type, interval_type
                        into row_id_inout, date_inout, time_inout, timetz_inout, timestamp_inout, interval_inout,
                        timestamptz_inout FROM DatetimeTypes where row_id = 1;
            end;
            $$  
                language plpgsql;

        create or replace function RangeInoutProcedure(inout row_id_inout numrange, inout int4range_inout int4range, inout int8range_inout int8range,
            inout numrange_inout numrange, inout tsrange_inout tsrange, inout daterange_inout daterange, 
            inout tstzrange_inout tstzrange)
                as $$
                DECLARE
            begin
                INSERT INTO RangeTypes(row_id, int4range_type, int8range_type, numrange_type, tsrange_type,
                                tstzrange_type, daterange_type) 
                    VALUES (
                        row_id_inout, int4range_inout, int8range_inout, numrange_inout, tsrange_inout,
                        tstzrange_inout, daterange_inout
                    );
                    SELECT row_id, int4range_type, int8range_type, numrange_type, tsrange_type, daterange_type, tstzrange_type
                        into row_id_inout, int4range_inout, int8range_inout, numrange_inout, tsrange_inout, daterange_inout,
                        tstzrange_inout FROM RangeTypes where row_id = 1;
            end;
            $$  
                language plpgsql;

        create or replace function TextsearchInoutProcedure(inout row_id_inout bigint,
                        inout tsvector_inout tsvector, inout tsquery_inout tsquery)
                as $$
                DECLARE
            begin
                    INSERT INTO TextsearchTypes(row_id, tsvector_type, tsquery_type)
                    VALUES (
                        row_id_inout, tsvector_inout, tsquery_inout
                    );
                    SELECT row_id, tsvector_type, tsquery_type
                    into row_id_inout, tsvector_inout, tsquery_inout FROM TextsearchTypes where row_id = 1;
            end;
            $$  
                language plpgsql;

        create or replace function ObjectidentifierInoutProcedure(inout row_id_inout regconfig, inout oid_inout oid, inout regclass_inout regclass,
            inout regconfig_inout regconfig, inout regdictionary_inout regdictionary, inout regnamespace_inout regnamespace, inout regoper_inout regoper,
            inout regoperator_inout regoperator, inout regproc_inout regproc, inout regprocedure_inout regprocedure, inout regrole_inout regrole, inout regtype_inout regtype )
                as $$
                DECLARE
            begin
                INSERT INTO ObjectidentifierTypes(row_id, oid_type, regclass_type, regconfig_type, regdictionary_type,
                                regnamespace_type, regoper_type, regoperator_type, regproc_type, regprocedure_type, regrole_type, regtype_type) 
                    VALUES (
                        row_id_inout, oid_inout, regclass_inout, regconfig_inout, regdictionary_inout,
                        regnamespace_inout, regoper_inout, regoperator_inout, regproc_inout, regprocedure_inout, regrole_inout, regtype_inout
                    );
                    SELECT row_id, oid_type, regclass_type, regconfig_type, regdictionary_type, regnamespace_type, regoper_type,
                        regoperator_type, regproc_type, regprocedure_type, regrole_type, regtype_type
                        into row_id_inout, oid_inout, regclass_inout, regconfig_inout, regdictionary_inout, regoper_inout,
                        regnamespace_inout, regoperator_inout, regproc_inout, regprocedure_inout, regrole_inout, regtype_inout FROM ObjectidentifierTypes where row_id = 1;
            end;
            $$  
                language plpgsql;

    create or replace function NumericOutProcedure(inout row_id_out bigint, out smallint_out smallint, out int_out int,
        out bigint_out bigint, out decimal_out decimal, out numeric_out numeric, 
        out real_out real, out double_out double precision)
            as $$
            DECLARE
           begin
                SELECT row_id, smallint_type, int_type, bigint_type,
                decimal_type,
            numeric_type,
             real_type,
              double_type
            from NumericTypes2
                into row_id_out, smallint_out, int_out, bigint_out,
                decimal_out,
                 numeric_out,
                    real_out,
                     double_out
            where NumericTypes2.row_id = row_id_out;
        end;
        $$  
            language plpgsql;

    create or replace function CharacterOutProcedure(inout row_id_out bigint, out char_out char, out varchar_out varchar,
        out text_out text, out name_out name)
            as $$
            DECLARE
           begin
                Select row_id, char_type, varchar_type, text_type, name_type
                into row_id_out, char_out, varchar_out, text_out, name_out
                     from CharacterTypes where CharacterTypes.row_id = row_id_out;
        end;
        $$  
            language plpgsql;

    create or replace function BooleanOutProcedure(inout row_id_out bigint, out boolean_out boolean)
            as $$
            DECLARE
           begin
                SELECT row_id, boolean_type from BooleanTypes
                 into row_id_out, boolean_out
                 where BooleanTypes.row_id = row_id_out;
        end;
        $$  
            language plpgsql;

    create or replace function UuidOutProcedure(inout row_id_out bigint, out uuid_out UUID)
            as $$
            DECLARE
           begin
                SELECT row_id, uuid_type from UuidTypes
                 into row_id_out, uuid_out
                 where UuidTypes.row_id = row_id_out;
        end;
        $$  
            language plpgsql;

    create or replace function NetworkOutProcedure(inout row_id_out bigint, out inet_out inet, out cidr_out cidr,
        out macaddr_out macaddr, out macaddr8_out macaddr8)
            as $$
            DECLARE
           begin
                Select row_id, inet_type, cidr_type, macaddr_type, macaddr8_type
                into row_id_out, inet_out, cidr_out, macaddr_out, macaddr8_out
                     from NetworkTypes where NetworkTypes.row_id = row_id_out;
        end;
        $$  
            language plpgsql;

    create or replace function PglsnOutProcedure(inout row_id_out bigint, out pglsn_out pg_lsn)
            as $$
            DECLARE
           begin
                SELECT row_id, pglsn_type from PglsnTypes
                into row_id_out, pglsn_out
                 where PglsnTypes.row_id = row_id_out;
        end;
        $$  
            language plpgsql;
            
    create or replace function GeometricOutProcedure(inout row_id_out bigint, out point_out point,
        out line_out line, out lseg_out lseg, out box_out box, out circle_out circle)
            as $$
            DECLARE
           begin
                SELECT row_id, point_type, line_type, lseg_type, box_type, circle_type 
                into row_id_out, point_out, line_out, lseg_out, box_out, circle_out
                from GeometricTypes where GeometricTypes.row_id = row_id_out;
        end;
        $$  
            language plpgsql;

    create or replace function JsonOutProcedure(inout row_id_out bigint, out json_out json,
                    out jsonb_out jsonb, out jsonpath_out jsonpath)
            as $$
            DECLARE
           begin
                SELECT row_id, json_type, jsonb_type, jsonpath_type 
                into row_id_out, json_out, jsonb_out, jsonpath_out
                from JsonTypes where JsonTypes.row_id = row_id_out;
        end;
        $$  
            language plpgsql;
    
    create or replace function BitOutProcedure(inout row_id_out bigint,
                    out varbitstring_out varchar(15), out bit_out bit)
            as $$
            DECLARE
           begin
                SELECT row_id, varbitstring_type, bit_type 
                into row_id_out, varbitstring_out, bit_out
                from BitTypes where BitTypes.row_id = row_id_out;
        end;
        $$  
            language plpgsql;

    create or replace function DatetimeOutProcedure(inout row_id_out timetz, out date_out date, out time_out time,
        out timetz_out timetz, out timestamp_out timestamp, out interval_out interval, 
        out timestamptz_out timestamptz)
            as $$
            DECLARE
           begin
                SELECT row_id, date_type, time_type, timetz_type, timestamp_type, 
                timestamptz_type, interval_type from DatetimeTypes 
                into row_id_out, date_out, time_out, timetz_out, timestamp_out, timestamptz_out, interval_out
                where DatetimeTypes.row_id = row_id_out;
        end;
        $$  
            language plpgsql;

    create or replace function RangeOutProcedure(inout row_id_out numrange, out int4range_out int4range, out int8range_out int8,
        out numrange_out numrange, out tsrange_out tsrange, out daterange_out daterange, 
        out tstzrange_out tstzrange)
            as $$
            DECLARE
           begin
            SELECT row_id, int4range_type, int8range_type, numrange_type, tsrange_type, 
                    tstzrange_type, daterange_type from RangeTypes 
                into row_id_out, int4range_out, int8range_out,
                    numrange_out, tsrange_out, tstzrange_out, daterange_out
                where RangeTypes.row_id = row_id_out;
        end;
        $$  
            language plpgsql;

    create or replace function TextsearchOutProcedure(inout row_id_out bigint,
                    out tsvector_out tsvector, out tsquery_out tsquery)
            as $$
            DECLARE
           begin
                SELECT row_id, tsvector_type, tsquery_type 
                into row_id_out, tsvector_out, tsquery_out
                from TextsearchTypes where TextsearchTypes.row_id = row_id_out;
        end;
        $$  
            language plpgsql;

    create or replace function ObjectidentifierOutProcedure(inout row_id_out regconfig, out oid_out oid, out regclass_out regclass,
        out regconfig_out regconfig, out regdictionary_out regdictionary, out regnamespace_out regnamespace, out regoper_out regoper,
         out regoperator_out regoperator, out regproc_out regproc, out regprocedure_out regprocedure, out regrole_out regrole, out regtype_out regtype )
            as $$
            DECLARE
           begin
            SELECT row_id, oid_type, regclass_type, regconfig_type, regdictionary_type,
            regnamespace_type, regoper_type, regoperator_type, regproc_type, regprocedure_type, regrole_type, regtype_type 
            from ObjectidentifierTypes
            into row_id_out, oid_out, regclass_out, regconfig_out, regdictionary_out, regnamespace_out,
             regoper_out, regoperator_out, regproc_out, regprocedure_out, regrole_out, regtype_out
             where ObjectidentifierTypes.row_id = row_id_out;
        end;
        $$  
            language plpgsql;

