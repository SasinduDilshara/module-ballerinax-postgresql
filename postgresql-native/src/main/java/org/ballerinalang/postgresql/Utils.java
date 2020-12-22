/*
 *  Copyright (c) 2020, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 *  WSO2 Inc. licenses this file to you under the Apache License,
 *  Version 2.0 (the "License"); you may not use this file except
 *  in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing,
 *  software distributed under the License is distributed on an
 *  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 *  KIND, either express or implied.  See the License for the
 *  specific language governing permissions and limitations
 *  under the License.
 */
package org.ballerinalang.postgresql;

import io.ballerina.runtime.api.creators.ValueCreator;
import io.ballerina.runtime.api.utils.StringUtils;
import io.ballerina.runtime.api.values.BDecimal;
import io.ballerina.runtime.api.values.BMap;
import io.ballerina.runtime.api.values.BString;

/**
 * This class includes utility functions.
 *
 * @since 1.2.0
 */
public class Utils {

    static BMap generateOptionsMap(BMap mysqlOptions) {
        if (mysqlOptions != null) {
            BMap<BString, Object> options = ValueCreator.createMapValue();
            System.out.println("\n options income\n"+mysqlOptions); 
            System.out.println("\n options init 3\n"+options);            
            addSSLOptions(mysqlOptions.getMapValue(Constants.Options.SSL), options);
            System.out.println("\n options after ssl\n"+options);                
            long connectTimeout = getTimeout(mysqlOptions.get(Constants.Options.CONNECT_TIMEOUT_SECONDS));
            if (connectTimeout > 0) {
                options.put(Constants.DatabaseProps.CONNECT_TIMEOUT, connectTimeout);
            }

            long socketTimeout = getTimeout(mysqlOptions.get(Constants.Options.SOCKET_TIMEOUT_SECONDS));
            if (socketTimeout > 0) {
                options.put(Constants.DatabaseProps.SOCKET_TIMEOUT, socketTimeout);
            }
            long loginTimeout = getTimeout(mysqlOptions.get(Constants.Options.LOGIN_TIMEOUT_SECONDS));
            System.out.println("\n lt\n"+loginTimeout); 
            if (loginTimeout > 0) {
                options.put(Constants.DatabaseProps.LOGIN_TIMEOUT, loginTimeout);
            }

            long rowFetchSize = getIntegerValue(mysqlOptions.get(Constants.Options.ROW_FETCH_SIZE));
            if (rowFetchSize > 0) {
                options.put(Constants.DatabaseProps.ROW_FETCH_SIZE, rowFetchSize);
            }

            long dbMetadataCacheFields = getIntegerValue(mysqlOptions.get(Constants.Options.DB_METADATA_CACHE_FIELDS));
            if (dbMetadataCacheFields > 0) {
                options.put(Constants.DatabaseProps.DB_METADATA_CACHE_FIELDS, dbMetadataCacheFields);
            }
            long dbMetadataCacheFieldsMiB = getIntegerValue(mysqlOptions.get(Constants.Options.DB_METADATA_CACHE_FIELDS_MIB));
            if (dbMetadataCacheFieldsMiB > 0) {
                options.put(Constants.DatabaseProps.DB_METADATA_CACHE_FIELDS_MIB, dbMetadataCacheFieldsMiB);
            }
            long prepareThreshold = getIntegerValue(mysqlOptions.get(Constants.Options.PREPARE_THRESHOLD));
            if (prepareThreshold > 0) {
                options.put(Constants.DatabaseProps.PREPARE_THRESHOLD, prepareThreshold);
            }
            long preparedStatementCacheQueries = getIntegerValue(mysqlOptions.get(Constants.Options.PREPARED_STATEMENT_CACHE_QUERIES));
            if (preparedStatementCacheQueries > 0) {
                options.put(Constants.DatabaseProps.PREPARED_STATEMENT_CACHE_QUERIES, preparedStatementCacheQueries);
            }
            long preparedStatementCacheSize = getIntegerValue(mysqlOptions.get(Constants.Options.PREPARED_STATEMENT_CACHE_SIZE_MIB));
            if (preparedStatementCacheSize > 0) {
                options.put(Constants.DatabaseProps.PREPARED_STATEMENT_CACHE_SIZE_MIB, preparedStatementCacheSize);
            }
            long cancelSignalTimeout = getTimeout(mysqlOptions.get(Constants.Options.CANCEL_SIGNAL_TIMEOUT));
            if (cancelSignalTimeout > 0) {
                options.put(Constants.DatabaseProps.CANCEL_SIGNAL_TIMEOUT, cancelSignalTimeout);
            }
            int tcpKeepAlive = getBooleanValue(mysqlOptions.get(Constants.Options.TCP_KEEP_ALIVE));
            if (tcpKeepAlive >= 0 ) {
                if(tcpKeepAlive == 1){
                    options.put(Constants.DatabaseProps.TCP_KEEP_ALIVE, true);
                }
                else{
                    options.put(Constants.DatabaseProps.TCP_KEEP_ALIVE, false);
                }
            }

            System.out.println("\n final option\n"+options);
            return options;
        }
        return null;
    }

    public static int getBooleanValue(Object value){
        if (value instanceof Boolean) {
            if(((Boolean)value) == true){
                return 1;
            }
            return 0;
        }
        return -1;
    }

    public static long getIntegerValue(Object value){
        if (value instanceof Long) {
            Long output_value = (Long) value;
            if (output_value.longValue() > 0) {
                return output_value;
            }
        }
        return -1;
    }

    public static long getTimeout(Object secondsInt) {
        // if (secondsDecimal instanceof BDecimal) {
        //     BDecimal timeoutSec = (BDecimal) secondsDecimal;
        //     if (timeoutSec.floatValue() > 0) {
        //         return Double.valueOf(timeoutSec.floatValue() * 1000).longValue();
        //     }
        // }
        if (secondsInt instanceof Long) {
            Long timeoutSec = (Long) secondsInt;
            if (timeoutSec.longValue() > 0) {
                return Long.valueOf(timeoutSec.longValue()*1000).longValue();
            }
        }
        return -1;
    }

    private static void addSSLOptions(BMap sslConfig, BMap<BString, Object> options) {
        if (sslConfig == null) {
            options.put(Constants.DatabaseProps.SSL_MODE, Constants.DatabaseProps.SSL_MODE_DISABLED);
        } else {



            BString mode = sslConfig.getStringValue(Constants.SSLConfig.MODE);
            if (mode.getValue().equalsIgnoreCase(Constants.SSLConfig.VERIFY_CERT_MODE)) {
                mode = Constants.DatabaseProps.SSL_MODE_VERIFY_CA;
            }
            options.put(Constants.DatabaseProps.SSL_MODE, mode);

            BMap sslkey = sslConfig.getMapValue(Constants.SSLConfig.SSL_KEY);
            if (sslkey != null) {
                options.put(Constants.SSLConfig.SSL_KEY, StringUtils.fromString(
                        Constants.FILE + sslkey.getStringValue(
                                Constants.SSLConfig.CryptoKeyStoreRecord.KEY_STORE_RECORD_PATH_FIELD)));
                options.put(Constants.SSLConfig.SSL_PASWORD, sslkey
                        .getStringValue(Constants.SSLConfig.CryptoKeyStoreRecord.KEY_STORE_RECORD_PASSWORD_FIELD));
                // options.put(Constants.DatabaseProps.CLIENT_KEYSTORE_TYPE, Constants.DatabaseProps.KEYSTORE_TYPE_PKCS12);
            }

            BString sslrootcert = sslConfig.getStringValue(Constants.SSLConfig.SSL_ROOT_CERT);
            if(sslrootcert != null){
                options.put(Constants.SSLConfig.SSL_ROOT_CERT,sslrootcert);
            }

            BString sslcert = sslConfig.getStringValue(Constants.SSLConfig.SSL_ROOT_CERT);
            if(sslcert != null){
                options.put(Constants.SSLConfig.SSL_CERT,sslcert);
            }

            // BMap clientCertKeystore = sslConfig.getMapValue(Constants.SSLConfig.CLIENT_CERT_KEYSTORE);
            // if (clientCertKeystore != null) {
            //     options.put(Constants.DatabaseProps.CLIENT_KEYSTORE_URL, StringUtils.fromString(
            //             Constants.FILE + clientCertKeystore.getStringValue(
            //                     Constants.SSLConfig.CryptoKeyStoreRecord.KEY_STORE_RECORD_PATH_FIELD)));
            //     options.put(Constants.DatabaseProps.CLIENT_KEYSTORE_PASSWORD, clientCertKeystore
            //             .getStringValue(Constants.SSLConfig.CryptoKeyStoreRecord.KEY_STORE_RECORD_PASSWORD_FIELD));
            //     options.put(Constants.DatabaseProps.CLIENT_KEYSTORE_TYPE, Constants.DatabaseProps.KEYSTORE_TYPE_PKCS12);
            // }

            // BMap trustCertKeystore = sslConfig.getMapValue(Constants.SSLConfig.TRUST_CERT_KEYSTORE);
            // if (trustCertKeystore != null) {
            //     options.put(Constants.DatabaseProps.TRUST_KEYSTORE_URL, StringUtils.fromString(
            //             Constants.FILE + trustCertKeystore.getStringValue(
            //                     Constants.SSLConfig.CryptoKeyStoreRecord.KEY_STORE_RECORD_PATH_FIELD)));
            //     options.put(Constants.DatabaseProps.TRUST_KEYSTORE_PASSWORD, trustCertKeystore
            //             .getStringValue(Constants.SSLConfig.CryptoKeyStoreRecord.KEY_STORE_RECORD_PASSWORD_FIELD));
            //     options.put(Constants.DatabaseProps.TRUST_KEYSTORE_TYPE, Constants.DatabaseProps.KEYSTORE_TYPE_PKCS12);
            // }
        }
    }
}
