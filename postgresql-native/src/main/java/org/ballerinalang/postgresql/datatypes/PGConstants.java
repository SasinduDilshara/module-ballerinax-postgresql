package org.ballerinalang.postgresql.datatypes;


import io.ballerina.runtime.api.values.BString;

import static io.ballerina.runtime.api.utils.StringUtils.fromString;

public final class PGConstants {

    public static final class Geometric{
        public static final String X = "x";
        public static final String Y = "y";
        public static final String R = "r";
        public static final String X1 = "x1";
        public static final String Y1 = "y1";
        public static final String X2 = "x2";
        public static final String Y2 = "y2";
        public static final String A = "a";
        public static final String B = "b";
        public static final String C = "c";
        public static final String P1 = "p1";
        public static final String P2 = "p2";
    }

    public static final class Interval{
        public static final String YEARS = "years";
        public static final String MONTHS = "months";
        public static final String DAYS = "days";
        public static final String HOURS = "hours";
        public static final String MINUTES = "minutes";
        public static final String SECONDS = "seconds";
    }

    public static final class Range{
        public static final String UPPER = "upper";
        public static final String LOWER = "lower";
        public static final String UPPERINCLUSIVE = "isUpperboundInclusive";
        public static final String LOWERINCLUSIVE = "isLowerboundInclusive";
    }

    public static final class PGtypes{
        public static final String INET = "inet";
        public static final String CIDR = "cidr";
        public static final String MACADDR = "macaddr";
        public static final String MACADDR8 = "macaddr8";

        public static final String POINT = "point";
        public static final String LINE = "line";

        public static final String UUID = "uuid";

        public static final String TSVECTOR = "tsvector";
        public static final String TSQUERY = "tsquery";

        public static final String JSON = "json";
        public static final String JSONB = "jsonb";
        public static final String JSONPATH = "jsonpath";

        public static final String INT4RANGE = "int4range";
        public static final String INT8RANGE = "int8range";
        public static final String NUMRANGE = "numrange";
        public static final String TSRANGE = "tsrange";
        public static final String TSTZRANGE = "tstzrange";
        public static final String DATERANGE= "daterange";

        public static final String BIT = "bit";
        public static final String VARBIT = "varbit";

        public static final String PGLSN = "pg_lsn";

        public static final String REGCLASS = "regclass";
        public static final String REGCONFIG = "regconfig";
        public static final String REGDICTIONARY = "regdictionary";
        public static final String REGNAMESPACE = "regnamespace";
        public static final String REGOPER = "regoper";
        public static final String REGOPERATOR = "regoperator";
        public static final String REGPROC = "regproc";
        public static final String REGPROCEDURE = "regprocedure";
        public static final String REGROLE = "regrole";
        public static final String REGTYPE= "regtype";
    }
    public static final class TypedValueFields {
        public static final BString VALUE = fromString("value");
    }



}