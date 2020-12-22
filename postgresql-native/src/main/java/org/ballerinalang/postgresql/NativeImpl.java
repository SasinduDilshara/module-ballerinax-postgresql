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

import io.ballerina.runtime.api.values.BMap;
import io.ballerina.runtime.api.values.BObject;
import io.ballerina.runtime.api.values.BString;
import org.ballerinalang.sql.datasource.SQLDatasource;
import org.ballerinalang.sql.utils.ClientUtils;

import java.util.Properties;

/**
 * Native implementation for the mysql client methods.
 *
 * @since 1.2.0
 */
public class NativeImpl {

    public static Object createClient(BObject client, BMap<BString, Object> clientConfig,
                                      BMap<BString, Object> globalPool) {
        // String url = "jdbc:mysql://" + clientConfig.getStringValue(Constants.ClientConfiguration.HOST);
        String url = "jdbc:postgresql://" + clientConfig.getStringValue(Constants.ClientConfiguration.HOST);
        Long portValue = clientConfig.getIntValue(Constants.ClientConfiguration.PORT);
        if (portValue > 0) {
            url += ":" + portValue.intValue();
        }
        BString userVal = clientConfig.getStringValue(Constants.ClientConfiguration.USER);
        String user = userVal == null ? null : userVal.getValue();
        BString passwordVal = clientConfig.getStringValue(Constants.ClientConfiguration.PASSWORD);
        String password = passwordVal == null ? null : passwordVal.getValue();
        BString databaseVal = clientConfig.getStringValue(Constants.ClientConfiguration.DATABASE);
        String database = databaseVal == null ? null : databaseVal.getValue();
        if (database != null && !database.isEmpty()) {
            url += "/" + database;
        }
        System.out.println("Initialization Url :- "+url);
        BMap options = clientConfig.getMapValue(Constants.ClientConfiguration.OPTIONS);
        BMap properties = null;
        Properties poolProperties = null;
        if (options != null) {
            System.out.println("Options\n"+options);
            properties = Utils.generateOptionsMap(options);

            System.out.println("Properties\n"+properties);

            Object connectTimeout = properties.get(Constants.DatabaseProps.CONNECT_TIMEOUT);
            if (connectTimeout != null) {
                poolProperties = new Properties();
                poolProperties.setProperty(Constants.POOL_CONNECT_TIMEOUT, connectTimeout.toString());
            }
            System.out.println("poolProperties\n"+poolProperties);
        }

        BMap connectionPool = clientConfig.getMapValue(Constants.ClientConfiguration.CONNECTION_POOL_OPTIONS);

        System.out.println("connectionPool\n"+ connectionPool);

        String datasourceName = Constants.MYSQL_DATASOURCE_NAME;
        // if (options != null && options.getBooleanValue(Constants.Options.USE_XA_DATASOURCE)) {
            
        //     datasourceName = Constants.MYSQL_XA_DATASOURCE_NAME;
        // }

        System.out.println("1111111111");

        System.out.println(connectionPool+"\n"+datasourceName+"\n"+globalPool);

        SQLDatasource.SQLDatasourceParams sqlDatasourceParams = new SQLDatasource.SQLDatasourceParams()
                .setUrl(url).setUser(user)
                .setPassword(password)
                .setDatasourceName(datasourceName)
                .setOptions(properties)
                .setConnectionPool(connectionPool, globalPool)
                .setPoolProperties(poolProperties);

        System.out.println(sqlDatasourceParams.toString());

        return ClientUtils.createClient(client, sqlDatasourceParams);
    }

    public static Object close(BObject client) {
        return ClientUtils.close(client);
    }
}
