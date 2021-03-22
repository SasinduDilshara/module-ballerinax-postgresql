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
package org.ballerinalang.postgresql.utils;

import io.ballerina.runtime.api.TypeTags;
import io.ballerina.runtime.api.types.ArrayType;
import io.ballerina.runtime.api.types.Field;
import io.ballerina.runtime.api.types.StructureType;
import io.ballerina.runtime.api.types.Type;
import io.ballerina.runtime.api.utils.JsonUtils;
import io.ballerina.runtime.api.utils.TypeUtils;
import io.ballerina.runtime.api.values.BArray;
import io.ballerina.runtime.api.values.BError;
import io.ballerina.runtime.api.values.BMap;
import org.ballerinalang.postgresql.Constants;
import org.ballerinalang.sql.exception.ApplicationError;

import java.io.Reader;
import java.io.StringReader;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Locale;
import java.util.Map;

import static io.ballerina.runtime.api.utils.StringUtils.fromString;

/**
 * This class includes helper functions for custom PostgreSQL-Ballerina datatypes.
 *
 */

public class ConversionHelperUtils {

    private ConversionHelperUtils() {

    }

    public static Map<String, Object> getRecordType(Object value) {
        Map<String, Object> result = new HashMap<>();
        String key;
        Object bValue;
        Type type = TypeUtils.getType(value);
        Map<String, Field> structFields = ((StructureType) type).getFields();
        int fieldCount = structFields.size();
        Iterator<Field> fieldIterator = structFields.values().iterator();
        for (int i = 0; i < fieldCount; ++i) {
            Field field = fieldIterator.next();
            key = field.getFieldName();
            bValue = ((BMap) value).get(fromString(key));
            result.put(key, bValue);
        }
        return result;
    }

    public static Object[] getCustomRecordType(Connection conn, BMap<?, ?> bmap) throws SQLException, ApplicationError {
        return new Object[4];
    }

    public static ArrayList<Object> getArrayType(BArray value) {
        ArrayList<Object> elements = new ArrayList<>();
        long length = value.getLength();
        for (int i = 0; i < length; i++) {
            elements.add(value.get(i));
        }
        return elements;
    }

    public static String setRange(String upper, String lower, boolean upperInclusive, boolean lowerInclusive) {
        String rangeValue = "";
        if (lowerInclusive) {
            rangeValue += "[";
        } else {
            rangeValue += "(";
        }
        rangeValue += lower;
        rangeValue += ",";
        rangeValue += upper;
        if (upperInclusive) {
            rangeValue += "]";
        } else {
            rangeValue += ")";
        }
        return rangeValue;
    }

    public static HashMap<String, Object> convertRangeToMap(Object value) {
        HashMap<String, Object> rangeMap;
        if (value == null) {
            return null;
        } else {
            rangeMap = new HashMap<>(); 
            String objectValue = value.toString();
            if (objectValue.length() < 1) {
                return rangeMap;
            }
            if (objectValue.startsWith("[")) {
                rangeMap.put(Constants.Range.LOWERINCLUSIVE, true);
            } else {
                rangeMap.put(Constants.Range.LOWERINCLUSIVE, false);
            }
            objectValue = objectValue.substring(1);
            if (objectValue.endsWith("]")) {
                rangeMap.put(Constants.Range.UPPERINCLUSIVE, true);
            } else {
                rangeMap.put(Constants.Range.UPPERINCLUSIVE, false);
            }
            objectValue = objectValue.substring(0, objectValue.length() - 1);
            String[] rangeElements = objectValue.split(",");            
            rangeMap.put(Constants.Range.UPPER, rangeElements[1]);
            rangeMap.put(Constants.Range.LOWER, rangeElements[0]);
        }
        return rangeMap;
    }

    public static String setCustomType(Map<String, Object> record) {
        String customValue = "";

        customValue += "(";
        for (Map.Entry<String, Object> entry : record.entrySet()) {  
            customValue += entry.getValue().toString();
            customValue += ",";
        } 
        int length = customValue.length();
        customValue = customValue.substring(0, length - 1);
        customValue += ")";
        return customValue;
    }

    public static Object getJson(String jsonString) throws ApplicationError, SQLException {
        Reader reader = new StringReader(jsonString);
        try {
            return JsonUtils.parse(reader, JsonUtils.NonStringValueProcessingMode.FROM_JSON_STRING);
        } catch (BError e) {
            throw new ApplicationError("Error while converting to JSON type. " + e.getDetails());
        }
    }

    private static Object[] getStructData(Connection conn, Object value) throws SQLException, ApplicationError {
        Type type = TypeUtils.getType(value);
        if (value == null || (type.getTag() != TypeTags.OBJECT_TYPE_TAG
                && type.getTag() != TypeTags.RECORD_TYPE_TAG)) {
            return new Object[]{null, null};
        }
        String structuredSQLType = type.getName().toUpperCase(Locale.getDefault());
        Map<String, Field> structFields = ((StructureType) type)
                .getFields();
        int fieldCount = structFields.size();
        Object[] structData = new Object[fieldCount];
        Iterator<Field> fieldIterator = structFields.values().iterator();
        for (int i = 0; i < fieldCount; ++i) {
            Field field = fieldIterator.next();
            Object bValue = ((BMap) value).get(fromString(field.getFieldName()));
            int typeTag = field.getFieldType().getTag();
            switch (typeTag) {
                case TypeTags.INT_TAG:
                case TypeTags.FLOAT_TAG:
                case TypeTags.STRING_TAG:
                case TypeTags.BOOLEAN_TAG:
                case TypeTags.DECIMAL_TAG:
                    structData[i] = bValue;
                    break;
                case TypeTags.ARRAY_TAG:
                    getArrayStructData(field, structData, structuredSQLType, i, bValue);
                    break;
                case TypeTags.RECORD_TYPE_TAG:
                    getRecordStructData(conn, structData, i, bValue);
                    break;
                default:
                    throw new Error("Error");
            }
        }
        return new Object[]{structData, structuredSQLType};
    }

    protected static void getRecordStructData(Connection conn, Object[] structData, int i, Object bValue)
            throws SQLException, ApplicationError {
        Object structValue = bValue;
        Object[] internalStructData = getStructData(conn, structValue);
        Object[] dataArray = (Object[]) internalStructData[0];
        String internalStructType = (String) internalStructData[1];
        structValue = conn.createStruct(internalStructType, dataArray);
        structData[i] = structValue;
    }

    protected static void getArrayStructData(Field field, Object[] structData, String structuredSQLType,
     int i, Object bValue) throws SQLException, ApplicationError {
        Type elementType = ((ArrayType) field
                .getFieldType()).getElementType();
        if (elementType.getTag() == TypeTags.BYTE_TAG) {
            structData[i] = ((BArray) bValue).getBytes();
        } else {
            throw new ApplicationError("unsupported data type of " + structuredSQLType
                    + " specified for struct parameter");
        }
    }
}
