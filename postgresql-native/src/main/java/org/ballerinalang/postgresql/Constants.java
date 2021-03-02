/*
 * Copyright (c) 2020, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 * WSO2 Inc. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
package org.ballerinalang.postgresql;

import io.ballerina.runtime.api.utils.StringUtils;
import io.ballerina.runtime.api.values.BString;

import static io.ballerina.runtime.api.utils.StringUtils.fromString;
/**
 * Constants for JDBC client.
 *
 * @since 1.2.0
 */
public final class Constants {
    /**
     * Constants for Client Configs.
     */
    public static final class ClientConfiguration {
        public static final BString HOST = StringUtils.fromString("host");
        public static final BString PORT = StringUtils.fromString("port");
        public static final BString USER = StringUtils.fromString("user");
        public static final BString PASSWORD = StringUtils.fromString("password");
        public static final BString DATABASE = StringUtils.fromString("database");
        public static final BString OPTIONS = StringUtils.fromString("options");
        public static final BString CONNECTION_POOL_OPTIONS = StringUtils.fromString("connectionPool");
    }

    /**
     * Constants for database options.
     */
    public static final class Options {
        static final BString SSL = StringUtils.fromString("ssl");
        static final BString CONNECT_TIMEOUT_SECONDS = StringUtils.fromString("connectTimeoutInSeconds");
        static final BString SOCKET_TIMEOUT_SECONDS = StringUtils.fromString("socketTimeoutInSeconds");
        static final BString LOGIN_TIMEOUT_SECONDS = StringUtils.fromString("loginTimeoutInSeconds");
        static final BString ROW_FETCH_SIZE = StringUtils.fromString("rowFetchSize");
        static final BString DB_METADATA_CACHE_FIELDS = StringUtils.fromString("dbMetadataCacheFields");
        static final BString DB_METADATA_CACHE_FIELDS_MIB = StringUtils.fromString("dbMetadataCacheFieldsMiB");
        static final BString PREPARE_THRESHOLD = StringUtils.fromString("prepareThreshold");
        static final BString PREPARED_STATEMENT_CACHE_QUERIES = StringUtils.fromString("preparedStatementCacheQueries");
        static final BString PREPARED_STATEMENT_CACHE_SIZE_MIB = StringUtils.fromString("preparedStatementCacheSize");
        static final BString CANCEL_SIGNAL_TIMEOUT = StringUtils.fromString("cancelSignalTimeoutInSeconds");
        static final BString TCP_KEEP_ALIVE = StringUtils.fromString("tcpKeepAlive");

        /* 
            Use in upcoming versions
        */
        public static final BString USE_XA_DATASOURCE = StringUtils.fromString("useXADatasource");
    }

    /**
     * Constants for ssl configuration.
     */
    static final class SSLConfig {
        static final BString MODE = StringUtils.fromString("mode");
        static final BString SSL_KEY = StringUtils.fromString("sslkey");
        static final BString SSL_PASWORD = StringUtils.fromString("sslpassword");
        static final BString SSL_ROOT_CERT = StringUtils.fromString("sslrootcert");
        static final BString SSL_CERT = StringUtils.fromString("sslcert");

         // The following constants are used to process ballerina `crypto:KeyStore`
         static final class CryptoKeyStoreRecord {
            static final BString KEY_STORE_RECORD_PATH_FIELD = StringUtils.fromString("path");
            static final BString KEY_STORE_RECORD_PASSWORD_FIELD = StringUtils.fromString("password");
        }

        }
    

    public static final class DatabaseProps {
        public static final BString SSL_MODE = StringUtils.fromString("sslMode");
        public static final BString SSL_MODE_DISABLED = StringUtils.fromString("DISABLE");
        public static final BString SSL_MODE_VERIFY_CA = StringUtils.fromString("VERIFY_CA");

        public static final BString KEYSTORE_TYPE_PKCS12 = StringUtils.fromString("PKCS12");
        public static final BString CLIENT_KEYSTORE_URL = StringUtils.fromString("clientCertificateKeyStoreUrl");
        public static final BString CLIENT_KEYSTORE_PASSWORD = StringUtils.fromString("clientCertificateKeyStorePassword");
        public static final BString CLIENT_KEYSTORE_TYPE = StringUtils.fromString("clientCertificateKeyStoreType");
        public static final BString TRUST_KEYSTORE_URL = StringUtils.fromString("trustCertificateKeyStoreUrl");
        public static final BString TRUST_KEYSTORE_PASSWORD = StringUtils.fromString("trustCertificateKeyStorePassword");
        public static final BString TRUST_KEYSTORE_TYPE = StringUtils.fromString("trustCertificateKeyStoreType");

        public static final BString DB_METADATA_CACHE_FIELDS = StringUtils.fromString("databaseMetadataCacheFields");
        public static final BString DB_METADATA_CACHE_FIELDS_MIB = StringUtils.fromString("databaseMetadataCacheFieldsMiB");
        public static final BString PREPARE_THRESHOLD = StringUtils.fromString("prepareThreshold");
        public static final BString PREPARED_STATEMENT_CACHE_QUERIES = StringUtils.
                            fromString("preparedStatementCacheQueries");
        public static final BString PREPARED_STATEMENT_CACHE_SIZE_MIB = StringUtils.
                            fromString("preparedStatementCacheSizeMiB");
        public static final BString CANCEL_SIGNAL_TIMEOUT = StringUtils.fromString("cancelSignalTimeout");
        public static final BString TCP_KEEP_ALIVE = StringUtils.fromString("tcpKeepAlive");
        public static final BString CONNECT_TIMEOUT = StringUtils.fromString("connectTimeout");
        public static final BString SOCKET_TIMEOUT = StringUtils.fromString("socketTimeout");
        public static final BString LOGIN_TIMEOUT = StringUtils.fromString("loginTimeout");
        public static final BString ROW_FETCH_SIZE = StringUtils.fromString("defaultRowFetchSize");

    }

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

    public static final class PGTypeNames {
        public static final String INET = "InetValue";
        public static final String CIDR = "CidrValue";
        public static final String MACADDR = "MacaddrValue";
        public static final String MACADDR8 = "Macaddr8Value";

        public static final String POINT = "PointValue";
        public static final String LINE = "LineValue";
        public static final String LSEG = "LsegValue";
        public static final String PATH = "PathValue";
        public static final String BOX = "BoxValue";
        public static final String POLYGON = "PolygonValue";
        public static final String CIRCLE = "CircleValue";

        public static final String UUID = "UuidValue";

        public static final String TSVECTOR = "TsvectorValue";
        public static final String TSQUERY = "TsqueryValue";

        public static final String JSON = "JsonValue";
        public static final String JSONB = "JsonbValue";
        public static final String JSONPATH = "JsonpathValue";

        public static final String INT4RANGE = "Int4rangeValue";
        public static final String INT8RANGE = "Int8rangeValue";
        public static final String NUMRANGE = "NumrangeValue";
        public static final String TSRANGE = "TsrangeValue";
        public static final String TSTZRANGE = "TstzrangeValue";
        public static final String DATERANGE= "DaterangeValue";

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

    public static final String POSTGRESQL_DATASOURCE_NAME = "org.postgresql.ds.PGSimpleDataSource";
    static final String FILE = "file:";
    public static final String POOL_CONNECT_TIMEOUT = "ConnectionTimeout";
    public static final String CUSTOM_RESULT_ITERATOR_OBJECT = "CustomResultIterator";

    /**
     * Constants for ssl configuration.
     */
    public static final String POSTGRESQL_XA_DATASOURCE_NAME = "org.postgresql.xa.PGXADataSource";
}
