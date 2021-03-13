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
        end;$$;  

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
        end;$$;  

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
        end;$$;  

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
        end;$$;  

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
        end;$$;  

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
        end;$$;  

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
        end;$$;  

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
        end;$$;  

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
        end;$$;  

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
        end;$$;  

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
        end;$$;  

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
        end;$$;  

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
        end;$$;  

        create or replace procedure NumericOutProcedure(
            inout row_id_inout bigint,
            inout smallint_inout smallint,
            inout int_inout integer,
            inout bigint_inout bigint,
            inout decimal_inout decimal,
            inout numeric_inout numeric,
            inout real_inout real,
            inout double_precision_inout double precision
            )
            language plpgsql    
            as $$
            begin
                SELECT row_id, smallint_type, int_type, bigint_type,
                decimal_type,
            numeric_type,
             real_type,
              double_type
            from NumericTypes2
                into row_id_inout, smallint_inout, int_inout, bigint_inout,
                decimal_inout,
                 numeric_inout,
                    real_inout,
                     double_precision_inout
            where NumericTypes2.row_id = row_id_inout;
        end;$$;  

        create or replace procedure CharacterOutProcedure(
            inout row_id_inout bigint,
            inout char_inout char(15),
            inout varchar_inout varchar(15),
            inout text_inout text,
            inout name_inout name
            )
            language plpgsql    
            as $$
            begin
                Select row_id, char_type, varchar_type, text_type, name_type
                into row_id_inout, char_inout, varchar_inout, text_inout, name_inout
                     from CharacterTypes where CharacterTypes.row_id = row_id_inout;
        end;$$;  

        create or replace procedure BooleanOutProcedure(
            inout row_id_inout bigint,
            inout boolean_inout boolean
            )
            language plpgsql    
            as $$
            begin
                SELECT row_id, boolean_type from BooleanTypes
                 into row_id_inout, boolean_inout
                 where BooleanTypes.row_id = row_id_inout;
        end;$$;  

        create or replace procedure NetworkOutProcedure(
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
        end;$$;  

        create or replace procedure GeometricOutProcedure(
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
                SELECT row_id, point_type, line_type, lseg_type, box_type, circle_type 
                into row_id_inout, point_inout, line_inout, lseg_inout, box_inout, circle_inout
                from GeometricTypes where GeometricTypes.row_id = row_id_inout;
        end;$$;  

        create or replace procedure UuidOutProcedure(
            inout row_id_inout bigint,
            inout uuid_inout uuid
            )
            language plpgsql    
            as $$
            begin
                SELECT row_id, uuid_type from UuidTypes
                 into row_id_inout, uuid_inout
                 where UuidTypes.row_id = row_id_inout;
        end;$$;  

        create or replace procedure PglsnOutProcedure(
            inout row_id_inout bigint,
            inout pglsn_inout pg_lsn
            )
            language plpgsql    
            as $$
            begin
                SELECT row_id, pglsn_type from PglsnTypes
                into row_id_inout, pglsn_inout
                 where PglsnTypes.row_id = row_id_inout;
        end;$$;  

        create or replace procedure JsonOutProcedure(
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
        end;$$;  

        create or replace procedure BitOutProcedure(
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
        end;$$;  

        create or replace procedure DatetimeOutProcedure(
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
        end;$$;  

        create or replace procedure RangeOutProcedure(
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
        end;$$;  

        create or replace procedure TextsearchOutProcedure(
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
        end;$$;  

        create or replace procedure ObjectidentifierOutProcedure(
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
        end;$$;  


        create or replace procedure NumericInoutProcedure(
            inout row_id_inout bigint,
            inout smallint_inout smallint,
            inout int_inout int,
            inout bigint_inout bigint,
            inout decimal_inout decimal,
            inout numeric_inout numeric,
            inout real_inout real,
            inout double_precision_inout double precision
            )
            language plpgsql    
            as $$
            begin
            INSERT INTO NumericTypes2( row_id, smallint_type, int_type, bigint_type, decimal_type, numeric_type, 
                                                double_type, real_type
                    ) 
                VALUES ( row_id_inout, smallint_inout, int_inout, bigint_inout, decimal_inout, numeric_inout, double_precision_inout, real_inout
                    );
                    
                SELECT row_id, smallint_type, int_type, bigint_type, decimal_type,
                    numeric_type, double_type, real_type 
                from NumericTypes2
                    into row_id_inout, smallint_inout, int_inout, bigint_inout, decimal_inout, numeric_inout,
                        double_precision_inout, real_inout
                where NumericTypes2.row_id = row_id_inout;
        end;$$;  
        
        create or replace procedure CharacterInoutProcedure(
            inout row_id_inout bigint,
            inout char_inout char(15),
            inout varchar_inout varchar(15),
            inout text_inout text,
            inout name_inout name
            )
            language plpgsql    
            as $$
            begin
                INSERT INTO CharacterTypes (row_id, char_type, varchar_type, text_type, name_type)
                    VALUES(row_id_inout, char_inout, varchar_inout, text_inout, name_inout);
                Select row_id, char_type, varchar_type, text_type, name_type
                into row_id_inout, char_inout, varchar_inout, text_inout, name_inout
                     from CharacterTypes where CharacterTypes.row_id = row_id_inout;
        end;$$;  
        
        create or replace procedure BooleanInoutProcedure(
            inout row_id_inout bigint,
            inout boolean_inout boolean
            )
            language plpgsql    
            as $$
            begin
            INSERT INTO BooleanTypes( 
                row_id, boolean_type
            ) 
            VALUES ( 
                row_id_inout, boolean_inout
            );
            SELECT row_id, boolean_type from BooleanTypes
                into row_id_inout, boolean_inout
                where BooleanTypes.row_id = row_id_inout;
        end;$$;  
        
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
                INSERT INTO NetworkTypes (row_id, inet_type, cidr_type, macaddr_type, macaddr8_type)
                    VALUES(row_id_inout, inet_inout, cidr_inout, macaddr_inout, macaddr8_inout);
                Select row_id, inet_type, cidr_type, macaddr_type, macaddr8_type
                into row_id_inout, inet_inout, cidr_inout, macaddr_inout, macaddr8_inout
                     from NetworkTypes where NetworkTypes.row_id = row_id_inout;
        end;$$;  
        
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
            INSERT INTO GeometricTypes(
                row_id, point_type, line_type, lseg_type, box_type, circle_type
            ) 
            VALUES (
                row_id_inout, point_inout, line_inout, lseg_inout, box_inout, circle_inout
            );
                SELECT row_id, point_type, line_type, lseg_type, box_type, circle_type 
                into row_id_inout, point_inout, line_inout, lseg_inout, box_inout, circle_inout
                from GeometricTypes where GeometricTypes.row_id = row_id_inout;
        end;$$;  
        
        create or replace procedure UuidInoutProcedure(
            inout row_id_inout bigint,
            inout uuid_inout uuid
            )
            language plpgsql    
            as $$
            begin
            INSERT INTO UuidTypes( 
                row_id, uuid_type
            ) 
            VALUES ( 
                row_id_inout, uuid_inout
            );
            SELECT row_id, uuid_type from UuidTypes
                into row_id_inout, uuid_inout
                where UuidTypes.row_id = row_id_inout;
        end;$$;  
        
        create or replace procedure PglsnInoutProcedure(
            inout row_id_inout bigint,
            inout pglsn_inout pg_lsn
            )
            language plpgsql    
            as $$
            begin
            INSERT INTO PglsnTypes(
                row_id,
                pglsn_type
            ) 
            VALUES (
                row_id_inout,
                pglsn_inout
            );
                SELECT row_id, pglsn_type from PglsnTypes
                into row_id_inout, pglsn_inout
                 where PglsnTypes.row_id = row_id_inout;
        end;$$;  
        
        create or replace procedure JsonInoutProcedure(
            inout row_id_inout bigint,
            inout json_inout json,
            inout jsonb_inout jsonb,
            inout jsonpath_inout jsonpath
            )
            language plpgsql    
            as $$
            begin
                INSERT INTO JsonTypes (row_id, json_type, jsonb_type, jsonpath_type)
                        VALUES(row_id_inout, json_inout, jsonb_inout, jsonpath_inout);
                SELECT row_id, json_type, jsonb_type, jsonpath_type 
                into row_id_inout, json_inout, jsonb_inout, jsonpath_inout
                from JsonTypes where JsonTypes.row_id = row_id_inout;
        end;$$;  
        
        create or replace procedure BitInoutProcedure(
            inout row_id_inout bigint,
            inout bitvarying_inout bit varying(10),
            inout bit_inout bit(1)
            )
            language plpgsql    
            as $$
            begin
                INSERT INTO BitTypes (row_id, varbitstring_type, bit_type)
                        VALUES(row_id_inout, bitvarying_inout, bit_inout);
                SELECT row_id, varbitstring_type, bit_type 
                into row_id_inout, bitvarying_inout, bit_inout
                from BitTypes where BitTypes.row_id = row_id_inout;
        end;$$;  
        
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
            INSERT INTO DatetimeTypes( row_id, date_type, time_type, timetz_type, timestamp_type, timestamptz_type, interval_type
                    ) 
                VALUES ( row_id_inout, date_inout, time_inout, timetz_inout, timestamp_inout, timestamptz_inout, interval_inout
                    );
                SELECT row_id, date_type, time_type, timetz_type, timestamp_type, 
                timestamptz_type, interval_type from DatetimeTypes 
                into row_id_inout, date_inout, time_inout, timetz_inout, timestamp_inout, timestamptz_inout, interval_inout
                where DatetimeTypes.row_id = row_id_inout;
        end;$$;  
        
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
            INSERT INTO RangeTypes( row_id, int4range_type, int8range_type, numrange_type, tsrange_type, tstzrange_type, daterange_type
                    ) 
                VALUES ( row_id_inout, int4range_inout, int8range_inout, numrange_inout, tsrange_inout, tstzrange_inout, daterange_inout
                    );
                SELECT row_id, int4range_type, int8range_type, numrange_type, tsrange_type, 
                    tstzrange_type, daterange_type from RangeTypes 
                into row_id_inout, int4range_inout, int8range_inout,
                    numrange_inout, tsrange_inout, tstzrange_inout, daterange_inout
                where RangeTypes.row_id = row_id_inout;
        end;$$;  
        
        create or replace procedure TextsearchInoutProcedure(
            inout row_id_inout bigint,
            inout tsvector_inout tsvector,
            inout tsquery_inout tsquery
            )
            language plpgsql    
            as $$
            begin
             INSERT INTO TextsearchTypes( row_id, tsvector_type, tsquery_type
                    ) 
                VALUES ( row_id_inout, tsvector_inout, tsquery_inout
                    );
                SELECT row_id, tsvector_type, tsquery_type 
                into row_id_inout, tsvector_inout, tsquery_inout
                from TextsearchTypes where TextsearchTypes.row_id = row_id_inout;
        end;$$;  
        
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
            INSERT INTO ObjectidentifierTypes( row_id, oid_type, regclass_type, regconfig_type, regdictionary_type, regnamespace_type, 
                                                regoper_type, regoperator_type, regproc_type, regprocedure_type, regrole_type, regtype_type
                    ) 
                VALUES ( row_id_inout, oid_inout, regclass_inout, regconfig_inout, regdictionary_inout, regnamespace_inout, regoper_inout, regoperator_inout, 
                                                regproc_inout, regprocedure_inout, regrole_inout, regtype_inout
                    );
                    
                SELECT row_id, oid_type, regclass_type, regconfig_type, regdictionary_type,
            regnamespace_type, regoper_type, regoperator_type, regproc_type, regprocedure_type, regrole_type, regtype_type 
            from ObjectidentifierTypes
            into row_id_inout, oid_inout, regclass_inout, regconfig_inout, regdictionary_inout, regnamespace_inout,
             regoper_inout, regoperator_inout, regproc_inout, regprocedure_inout, regrole_inout, regtype_inout
             where ObjectidentifierTypes.row_id = row_id_inout;
        end;$$;  

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
        end;$$;  

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
            language plpgsql;

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
        end;$$;  

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
            language plpgsql;
            