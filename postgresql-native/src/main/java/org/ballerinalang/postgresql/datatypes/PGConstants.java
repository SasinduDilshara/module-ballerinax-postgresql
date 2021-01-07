package org.ballerinalang.postgresql.datatypes;

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
    }

    public static final class PGtypes{
        public static final String INET = "inet";
        public static final String CIDR = "cidr";
        public static final String MACADDR = "macaddr";
        public static final String MACADDR8 = "macaddr8";

        public static final String POINT = "point";
        public static final String LINE = "line";
    }



}