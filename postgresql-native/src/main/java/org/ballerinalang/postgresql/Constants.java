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
        static final BString HOST = StringUtils.fromString("host");
        static final BString PORT = StringUtils.fromString("port");
        static final BString USER = StringUtils.fromString("user");
        static final BString PASSWORD = StringUtils.fromString("password");
        static final BString DATABASE = StringUtils.fromString("database");
        static final BString OPTIONS = StringUtils.fromString("options");
        static final BString CONNECTION_POOL_OPTIONS = StringUtils.fromString("connectionPool");
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
        static final BString USE_XA_DATASOURCE = StringUtils.fromString("useXADatasource");
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
    

    static final class DatabaseProps {
        static final BString SSL_MODE = StringUtils.fromString("sslMode");
        static final BString SSL_MODE_DISABLED = StringUtils.fromString("DISABLED");

        static final BString DB_METADATA_CACHE_FIELDS = StringUtils.fromString("databaseMetadataCacheFields");
        static final BString DB_METADATA_CACHE_FIELDS_MIB = StringUtils.fromString("databaseMetadataCacheFieldsMiB");
        static final BString PREPARE_THRESHOLD = StringUtils.fromString("prepareThreshold");
        static final BString PREPARED_STATEMENT_CACHE_QUERIES = StringUtils.fromString("preparedStatementCacheQueries");
        static final BString PREPARED_STATEMENT_CACHE_SIZE_MIB = StringUtils.fromString("preparedStatementCacheSizeMiB");
        static final BString CANCEL_SIGNAL_TIMEOUT = StringUtils.fromString("cancelSignalTimeout");
        static final BString TCP_KEEP_ALIVE = StringUtils.fromString("tcpKeepAlive");
        static final BString CONNECT_TIMEOUT = StringUtils.fromString("connectTimeout");
        static final BString SOCKET_TIMEOUT = StringUtils.fromString("socketTimeout");
        static final BString LOGIN_TIMEOUT = StringUtils.fromString("loginTimeout");
        static final BString ROW_FETCH_SIZE = StringUtils.fromString("defaultRowFetchSize");

    }
    static final String MYSQL_DATASOURCE_NAME = "org.postgresql.ds.PGSimpleDataSource";
    static final String FILE = "file:";
    static final String POOL_CONNECT_TIMEOUT = "ConnectionTimeout";

    /**
     * Constants for ssl configuration.
     */
    static final String MYSQL_XA_DATASOURCE_NAME = "org.postgresql.xa.PGXADataSource";
}
