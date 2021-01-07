package org.ballerinalang.postgresql.datatypes;


import io.ballerina.runtime.api.values.BString;

import static io.ballerina.runtime.api.utils.StringUtils.fromString;

public final class PGConstants {

    public static final class PGpoint{
        public static final String X = "x";
        public static final String Y = "y";
    }
    public static final class PGline{
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
    }
    public static final class TypedValueFields {
        public static final BString VALUE = fromString("value");
    }



}