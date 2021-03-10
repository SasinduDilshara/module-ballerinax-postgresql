/*
 *  Copyright (c) 2021, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

import io.ballerina.runtime.api.values.BObject;
import org.ballerinalang.postgresql.parameterprocessor.PostgresResultParameterProcessor;

/**
 * This class provides functionality for the `RecordIterator` to iterate through the PostgreSQL result set.
 */
public class RecordIteratorUtils {
    public static Object nextResult(BObject postgresRecordIterator, BObject recordIterator) {
        return org.ballerinalang.sql.utils.RecordIteratorUtils
            .nextResult(recordIterator, PostgresResultParameterProcessor.getInstance());
    }
}
