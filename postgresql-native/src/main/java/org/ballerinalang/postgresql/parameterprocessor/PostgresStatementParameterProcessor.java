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

package org.ballerinalang.postgresql.parameterprocessor;

import io.ballerina.runtime.api.TypeTags;
import io.ballerina.runtime.api.types.ArrayType;
import io.ballerina.runtime.api.types.Field;
import io.ballerina.runtime.api.types.StructureType;
import io.ballerina.runtime.api.types.Type;
import io.ballerina.runtime.api.utils.TypeUtils;
import io.ballerina.runtime.api.values.BArray;
import io.ballerina.runtime.api.values.BDecimal;
import io.ballerina.runtime.api.values.BMap;
import io.ballerina.runtime.api.values.BObject;
import io.ballerina.runtime.api.values.BString;
import io.ballerina.runtime.api.values.BXml;
// import org.ballerinalang.sql.Constants;
import org.ballerinalang.sql.exception.ApplicationError;
import org.ballerinalang.stdlib.io.channels.base.Channel;
import org.ballerinalang.stdlib.io.channels.base.CharacterChannel;
import org.ballerinalang.stdlib.io.readers.CharacterChannelReader;
import org.ballerinalang.stdlib.io.utils.IOConstants;
import org.ballerinalang.stdlib.io.utils.IOUtils;
import org.ballerinalang.stdlib.time.util.TimeUtils;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.MathContext;
import java.sql.Array;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.RowId;
import java.sql.SQLException;
import java.sql.Struct;
import java.sql.Time;
import java.sql.Timestamp;
import java.sql.Types;
import java.time.ZonedDateTime;
import java.util.Iterator;
import java.util.Locale;
import java.util.Map;

import static io.ballerina.runtime.api.utils.StringUtils.fromString;
import static org.ballerinalang.sql.utils.Utils.throwInvalidParameterError;
import org.ballerinalang.sql.parameterprocessor.DefaultStatementParameterProcessor;
import org.ballerinalang.postgresql.Constants;
import org.ballerinalang.postgresql.helper.Convertor;

/**
 * Represent the Process methods for statements.
 *
 * @since 0.5.6
 */
public class PostgresStatementParameterProcessor extends DefaultStatementParameterProcessor {

    private static final Object lock = new Object();
    private static volatile PostgresStatementParameterProcessor instance;

    public static PostgresStatementParameterProcessor getInstance() {
        if (instance == null) {
            synchronized (lock) {
                if (instance == null) {
                    instance = new PostgresStatementParameterProcessor();
                }
            }
        }
        return instance;
    }

    private Object[] getArrayData(Object value) throws ApplicationError {
        Type type = TypeUtils.getType(value);
        if (value == null || type.getTag() != TypeTags.ARRAY_TAG) {
            return new Object[]{null, null};
        }
        Type elementType = ((ArrayType) type).getElementType();
        int typeTag = elementType.getTag();
        Object[] arrayData;
        int arrayLength;
        switch (typeTag) {
            case TypeTags.INT_TAG:
                return getIntArrayData(value);
            case TypeTags.FLOAT_TAG:
                return getFloatArrayData(value);
            case TypeTags.DECIMAL_TAG:
                return getDecimalArrayData(value);
            case TypeTags.STRING_TAG:
                return getStringArrayData(value);
            case TypeTags.BOOLEAN_TAG:
                return getBooleanArrayData(value);
            case TypeTags.ARRAY_TAG:
                return getNestedArrayData(value);
            default:
                return getCustomArrayData(value);
        }
    }

    private Object[] getStructData(Connection conn, Object value) throws SQLException, ApplicationError {
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
                    getCustomStructData(conn, value);
            }
        }
        return new Object[]{structData, structuredSQLType};
    }

    private void setBinaryAndBlob(PreparedStatement preparedStatement, String sqlType, int index, Object value)
            throws SQLException, ApplicationError, IOException {
        if (value == null) {
            preparedStatement.setBytes(index, null);
        } else if (value instanceof BArray) {
            BArray arrayValue = (BArray) value;
            if (arrayValue.getElementType().getTag() == org.wso2.ballerinalang.compiler.util.TypeTags.BYTE) {
                preparedStatement.setBytes(index, arrayValue.getBytes());
            } else {
                throw throwInvalidParameterError(value, sqlType);
            }
        } else if (value instanceof BObject) {
            BObject objectValue = (BObject) value;
            if (objectValue.getType().getName().equalsIgnoreCase(org.ballerinalang.sql.Constants.READ_BYTE_CHANNEL_STRUCT) &&
                    objectValue.getType().getPackage().toString()
                        .equalsIgnoreCase(IOUtils.getIOPackage().toString())) {
                Channel byteChannel = (Channel) objectValue.getNativeData(IOConstants.BYTE_CHANNEL_NAME);
                preparedStatement.setBinaryStream(index, byteChannel.getInputStream());
            } else {
                throw throwInvalidParameterError(value, sqlType);
            }
        } else {
            throw throwInvalidParameterError(value, sqlType);
        }
    }

    private void setDateTimeAndTimestamp(PreparedStatement preparedStatement, String sqlType, int index, Object value)
            throws SQLException, ApplicationError {
        if (value == null) {
            preparedStatement.setTimestamp(index, null);
        } else {
            Timestamp timestamp;
            if (value instanceof BString) {
                timestamp = Timestamp.valueOf(value.toString());
            } else if (value instanceof Long) {
                timestamp = new Timestamp((Long) value);
            } else if (value instanceof BMap) {
                BMap<BString, Object> dateTimeStruct = (BMap<BString, Object>) value;
                if (dateTimeStruct.getType().getName()
                        .equalsIgnoreCase(org.ballerinalang.stdlib.time.util.Constants.STRUCT_TYPE_TIME)) {
                    ZonedDateTime zonedDateTime = TimeUtils.getZonedDateTime(dateTimeStruct);
                    timestamp = new Timestamp(zonedDateTime.toInstant().toEpochMilli());
                } else {
                    throw throwInvalidParameterError(value, sqlType);
                }
            } else {
                throw throwInvalidParameterError(value, sqlType);
            }
            preparedStatement.setTimestamp(index, timestamp);
        }
    }

    @Override
    public int getCustomOutParameterType(BObject typedValue) throws ApplicationError {
        String sqlType = typedValue.getType().getName();
        throw new ApplicationError("Unsupported OutParameter type: " + sqlType);
    }

    @Override
    protected int getCustomSQLType(BObject typedValue) throws ApplicationError {
        String sqlType = typedValue.getType().getName();
        throw new ApplicationError("Unsupported SQL type: " + sqlType);
    }

    @Override
    protected void setCustomSqlTypedParam(Connection connection, PreparedStatement preparedStatement,
                                          int index, BObject typedValue)
            throws SQLException, ApplicationError, IOException {
        String sqlType = typedValue.getType().getName();
        Object value = typedValue.get(org.ballerinalang.sql.Constants.TypedValueFields.VALUE);
        // System.out.println("\n\n\n\n\n\n\n"+sqlType+" "+value+"\n\n\n\n\n\n\n");
        switch (sqlType) {
            case Constants.PGTypeNames.INET:
                setInet(preparedStatement, index, value);
                break;
            case Constants.PGTypeNames.CIDR:
                setCidr(preparedStatement, index, value);
                break;
            case Constants.PGTypeNames.MACADDR:
                setMacaddr(preparedStatement, index, value);
                break;
            case Constants.PGTypeNames.MACADDR8:
                setMaacadr8(preparedStatement, index, value);
                break;
            default:
                throw new ApplicationError("Unsupported SQL type: " + sqlType);
        }
    }

    private void setInet(PreparedStatement preparedStatement, int index, Object value)
            throws SQLException {
        if (value == null) {
            preparedStatement.setObject(index, null);
        } else {
            Object object = Convertor.convertInet(value);
            preparedStatement.setObject(index, object);
        }
    }

    private void setCidr(PreparedStatement preparedStatement, int index, Object value)
            throws SQLException {
        if (value == null) {
            preparedStatement.setObject(index, null);
        } else {
            Object object = Convertor.convertCidr(value);
            preparedStatement.setObject(index, object);
        }
    }

    private void setMacaddr(PreparedStatement preparedStatement, int index, Object value)
            throws SQLException {
        if (value == null) {
            preparedStatement.setObject(index, null);
        } else {
            Object object = Convertor.convertMac(value);
            preparedStatement.setObject(index, object);
        }
    }

    private void setMaacadr8(PreparedStatement preparedStatement, int index, Object value)
            throws SQLException {
        if (value == null) {
            preparedStatement.setObject(index, null);
        } else {
            Object object = Convertor.convertMac8(value);
            preparedStatement.setObject(index, object);
        }
    }

    @Override
    protected Object[] getCustomArrayData(Object value) throws ApplicationError {
        throw throwInvalidParameterError(value, org.ballerinalang.sql.Constants.SqlTypes.ARRAY);
    }

    @Override
    protected Object[] getCustomStructData(Connection conn, Object value)
            throws SQLException, ApplicationError {
        Type type = TypeUtils.getType(value);
        String structuredSQLType = type.getName().toUpperCase(Locale.getDefault());
        throw new ApplicationError("unsupported data type of " + structuredSQLType
                + " specified for struct parameter");
    }

    @Override
    protected void setBit(PreparedStatement preparedStatement, String sqlType, int index, Object value)
            throws SQLException, ApplicationError {
        super.setBit(preparedStatement, sqlType, index, value);
    }

    @Override
    protected void setBinary(PreparedStatement preparedStatement, String sqlType, int index, Object value)
            throws SQLException, ApplicationError, IOException {
        setBinaryAndBlob(preparedStatement, sqlType, index, value);
    }

    @Override
    protected void setArray(Connection conn, PreparedStatement preparedStatement, int index, Object value)
            throws SQLException, ApplicationError {
        Object[] arrayData = getArrayData(value);
        if (arrayData[0] != null) {
            Array array = conn.createArrayOf((String) arrayData[1], (Object[]) arrayData[0]);
            preparedStatement.setArray(index, array);
        } else {
            preparedStatement.setArray(index, null);
        }
    }

    @Override
    protected void setDateTime(PreparedStatement preparedStatement, String sqlType, int index, Object value)
            throws SQLException, ApplicationError {
        setDateTimeAndTimestamp(preparedStatement, sqlType, index, value);
    }

    @Override
    protected void setTimestamp(PreparedStatement preparedStatement, String sqlType, int index, Object value)
            throws SQLException, ApplicationError {
        setDateTimeAndTimestamp(preparedStatement, sqlType, index, value);
    }

    @Override
    protected void setDate(PreparedStatement preparedStatement, String sqlType, int index, Object value)
            throws SQLException, ApplicationError {
        Date date;
        if (value == null) {
            preparedStatement.setDate(index, null);
        } else {
            if (value instanceof BString) {
                date = Date.valueOf(value.toString());
            } else if (value instanceof Long) {
                date = new Date((Long) value);
            } else if (value instanceof BMap) {
                BMap<BString, Object> dateTimeStruct = (BMap<BString, Object>) value;
                if (dateTimeStruct.getType().getName()
                        .equalsIgnoreCase(org.ballerinalang.stdlib.time.util.Constants.STRUCT_TYPE_TIME)) {
                    ZonedDateTime zonedDateTime = TimeUtils.getZonedDateTime(dateTimeStruct);
                    date = new Date(zonedDateTime.toInstant().toEpochMilli());
                } else {
                    throw throwInvalidParameterError(value, sqlType);
                }
            } else {
                throw throwInvalidParameterError(value, sqlType);
            }
            preparedStatement.setDate(index, date);
        }
    }

    @Override
    protected void setTime(PreparedStatement preparedStatement, String sqlType, int index, Object value)
            throws SQLException, ApplicationError {
        if (value == null) {
            preparedStatement.setTime(index, null);
        } else {
            Time time;
            if (value instanceof BString) {
                time = Time.valueOf(value.toString());
            } else if (value instanceof Long) {
                time = new Time((Long) value);
            } else if (value instanceof BMap) {
                BMap<BString, Object> dateTimeStruct = (BMap<BString, Object>) value;
                if (dateTimeStruct.getType().getName()
                        .equalsIgnoreCase(org.ballerinalang.stdlib.time.util.Constants.STRUCT_TYPE_TIME)) {
                    ZonedDateTime zonedDateTime = TimeUtils.getZonedDateTime(dateTimeStruct);
                    time = new Time(zonedDateTime.toInstant().toEpochMilli());
                } else {
                    throw throwInvalidParameterError(value, sqlType);
                }
            } else {
                throw throwInvalidParameterError(value, sqlType);
            }
            preparedStatement.setTime(index, time);
        }
    }

    @Override
    protected Object[] getIntArrayData(Object value) throws ApplicationError {
        int arrayLength = ((BArray) value).size();
        Object[] arrayData = new Long[arrayLength];
        for (int i = 0; i < arrayLength; i++) {
            arrayData[i] = ((BArray) value).getInt(i);
        }
        return new Object[]{arrayData, "BIGINT"};
    }

    @Override
    protected Object[] getFloatArrayData(Object value) throws ApplicationError {
        int arrayLength = ((BArray) value).size();
        Object[] arrayData = new Double[arrayLength];
        for (int i = 0; i < arrayLength; i++) {
            arrayData[i] = ((BArray) value).getFloat(i);
        }
        return new Object[]{arrayData, "DOUBLE"};
    }

    @Override
    protected Object[] getDecimalArrayData(Object value) throws ApplicationError {
        int arrayLength = ((BArray) value).size();
        Object[] arrayData = new BigDecimal[arrayLength];
        for (int i = 0; i < arrayLength; i++) {
            arrayData[i] = ((BDecimal) ((BArray) value).getRefValue(i)).value();
        }
        return new Object[]{arrayData, "DECIMAL"};
    }

    @Override
    protected Object[] getStringArrayData(Object value) throws ApplicationError {
        int arrayLength = ((BArray) value).size();
        Object[] arrayData = new String[arrayLength];
        for (int i = 0; i < arrayLength; i++) {
            arrayData[i] = ((BArray) value).getBString(i).getValue();
        }
        return new Object[]{arrayData, "VARCHAR"};
    }

    @Override
    protected Object[] getBooleanArrayData(Object value) throws ApplicationError {
        int arrayLength = ((BArray) value).size();
        Object[] arrayData = new Boolean[arrayLength];
        for (int i = 0; i < arrayLength; i++) {
            arrayData[i] = ((BArray) value).getBoolean(i);
        }
        return new Object[]{arrayData, "BOOLEAN"};
    }

    @Override
    protected Object[] getNestedArrayData(Object value) throws ApplicationError {
        Type type = TypeUtils.getType(value);
        Type elementType = ((ArrayType) type).getElementType();
        Type elementTypeOfArrayElement = ((ArrayType) elementType)
                .getElementType();
        if (elementTypeOfArrayElement.getTag() == TypeTags.BYTE_TAG) {
            BArray arrayValue = (BArray) value;
            Object[] arrayData = new byte[arrayValue.size()][];
            for (int i = 0; i < arrayData.length; i++) {
                arrayData[i] = ((BArray) arrayValue.get(i)).getBytes();
            }
            return new Object[]{arrayData, "BINARY"};
        } else {
            throw throwInvalidParameterError(value, org.ballerinalang.sql.Constants.SqlTypes.ARRAY);
        }
    }

    @Override
    protected void getRecordStructData(Connection conn, Object[] structData, int i, Object bValue)
            throws SQLException, ApplicationError {
        Object structValue = bValue;
        Object[] internalStructData = getStructData(conn, structValue);
        Object[] dataArray = (Object[]) internalStructData[0];
        String internalStructType = (String) internalStructData[1];
        structValue = conn.createStruct(internalStructType, dataArray);
        structData[i] = structValue;
    }

    @Override
    protected void getArrayStructData(Field field, Object[] structData, String structuredSQLType, int i, Object bValue)
            throws SQLException, ApplicationError {
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
