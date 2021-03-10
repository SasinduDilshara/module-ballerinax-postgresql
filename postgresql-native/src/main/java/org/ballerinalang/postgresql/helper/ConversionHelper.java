
package org.ballerinalang.postgresql.helper;

import io.ballerina.runtime.api.TypeTags;
import io.ballerina.runtime.api.types.Field;
import io.ballerina.runtime.api.types.StructureType;
import io.ballerina.runtime.api.types.Type;
import io.ballerina.runtime.api.utils.TypeUtils;
import io.ballerina.runtime.api.values.BArray;
import io.ballerina.runtime.api.values.BMap;
import io.ballerina.runtime.api.values.BString;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import static io.ballerina.runtime.api.utils.StringUtils.fromString;
import io.ballerina.runtime.api.values.BError;

import org.ballerinalang.postgresql.Constants;
import org.ballerinalang.stdlib.time.util.TimeUtils;

public class ConversionHelper {

    private ConversionHelper() {

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
            customValue += ", ";

        } 
        int length = customValue.length();
        customValue = customValue.substring(0, length);
        customValue += ")";

        return customValue;

    }

    public static Object toTimeString(Object timeObject) {
        try {
            BMap<BString, Object> timeRecord = (BMap<BString, Object>) timeObject;
            return TimeUtils.getDefaultString(timeRecord);
        } catch (BError e) {
            return TimeUtils.getTimeError(e.getMessage());
        }
    }

}
