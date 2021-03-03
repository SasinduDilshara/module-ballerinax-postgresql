
package org.ballerinalang.postgresql.helper;

import io.ballerina.runtime.api.Module;
import io.ballerina.runtime.api.PredefinedTypes;
import io.ballerina.runtime.api.TypeTags;
import io.ballerina.runtime.api.creators.TypeCreator;
import io.ballerina.runtime.api.creators.ValueCreator;
import io.ballerina.runtime.api.flags.SymbolFlags;
import io.ballerina.runtime.api.flags.TypeFlags;
import io.ballerina.runtime.api.types.ArrayType;
import io.ballerina.runtime.api.types.Field;
import io.ballerina.runtime.api.types.RecordType;
import io.ballerina.runtime.api.types.StructureType;
import io.ballerina.runtime.api.types.Type;
import io.ballerina.runtime.api.types.UnionType;
import io.ballerina.runtime.api.utils.StringUtils;
import io.ballerina.runtime.api.utils.TypeUtils;
import io.ballerina.runtime.api.utils.XmlUtils;
import io.ballerina.runtime.api.values.BArray;
import io.ballerina.runtime.api.values.BDecimal;
import io.ballerina.runtime.api.values.BMap;
import io.ballerina.runtime.api.values.BObject;
import io.ballerina.runtime.api.values.BString;
import io.ballerina.runtime.api.values.BValue;
import io.ballerina.runtime.api.values.BXml;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.Reader;
import java.math.BigDecimal;
import java.math.MathContext;
import java.sql.Array;
import java.sql.Blob;
import java.sql.CallableStatement;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.RowId;
import java.sql.SQLException;
import java.sql.SQLXML;
import java.sql.Statement;
import java.sql.Struct;
import java.sql.Time;
import java.sql.Timestamp;
import java.sql.Types;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.TimeZone;

import static io.ballerina.runtime.api.utils.StringUtils.fromString;
import io.ballerina.runtime.api.values.BError;
import org.ballerinalang.stdlib.time.util.TimeUtils;

public class ConversionHelper {

    private ConversionHelper() {

    }

    public static Map<String,Object> getRecordType(Object value){

        System.out.println("Inside getRecordedType :- "+value.toString()+" "+((BMap)value).toString()+"\n((BMap) value).get(fromString(key))"+((BMap) value).get(fromString("p1")));
        Map<String,Object> result = new HashMap<>();
        String key;
        Object bValue;
        Type type = TypeUtils.getType(value);

        Map<String, Field> structFields = ((StructureType) type).getFields();
        System.out.println("structFields:- "+structFields);
        int fieldCount = structFields.size();
        Iterator<Field> fieldIterator = structFields.values().iterator();
        for (int i = 0; i < fieldCount; ++i) {
            Field field = fieldIterator.next();
            key = field.getFieldName();
            bValue = ((BMap) value).get(fromString(key));
            result.put(key,bValue);
            System.out.println("Field name:- "+" "+fromString(field.getFieldName())+" bValue:- "+bValue+"  "+"Key "+key+"field:- "+field);
            System.out.println("(BMap) value):- "+" "+(BMap) value+" ((BMap) value).get(fromString(key)):- "+((BMap) value).get(fromString(key))+" "+"((BMap) value).getkey:- "+"  "+"Key "+key+"field:- "+field);
        }
        System.out.println("result:- "+result);
        return result;
    }

    public static String setRange(String upper, String lower, boolean upperInclusive, boolean lowerInclusive){

        String rangeValue = "";
        if(upperInclusive){
            rangeValue += "[";
        }
        else{
            rangeValue += "(";
        }

        rangeValue += lower;
        rangeValue += ",";
        rangeValue += upper;

        if(lowerInclusive){
            rangeValue += "]";
        }
        else{
            rangeValue += ")";
        }

        return rangeValue;

    }

    public static String setCustomType(Map<String,Object> record){

        String customValue = "";
        customValue+= "(";

        for (Map.Entry<String,Object> entry : record.entrySet()){  

            customValue += entry.getValue().toString();
            customValue += ", ";

        } 
        int length = customValue.length();
        customValue = customValue.substring(0, length);
        customValue+= ")";

        return customValue;

    }

    public static Object toTimeString(Object timeObject) {
        try {
            BMap<BString,Object> timeRecord = (BMap<BString,Object>) timeObject;
            return TimeUtils.getDefaultString(timeRecord);
        } catch (BError e) {
            return TimeUtils.getTimeError(e.getMessage());
        }
    }

}