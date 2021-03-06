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

package org.ballerinalang.postgresql.helper;

import org.postgresql.core.BaseConnection;
import org.postgresql.util.PGobject;
import org.postgresql.geometric.*;
import org.postgresql.util.PGInterval;
import org.postgresql.util.PGmoney;
import org.postgresql.jdbc.PgSQLXML;

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
import org.ballerinalang.postgresql.Constants;
import org.ballerinalang.sql.utils.ErrorGenerator;
// import io.ballerina.runtime.internal.types.BJsonType;

import static io.ballerina.runtime.api.utils.StringUtils.fromString;

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


/**
 * This class implements the utils methods for the clients to be used.
 *
 * @since 5.6.0
 */
// class Inet {
//     public String typeName;
//     public String value;


// }

public class Convertor {

        private Convertor() {

        }

        public static Object convertInet(Object value){
                String stringValue = value.toString();

                PGobject pgobject = setPGobject(Constants.PGtypes.INET,stringValue);
                System.out.println("\nPGINET:- "+pgobject.getType()+" "+pgobject.getValue()+"\n");

                return pgobject;
        }

        public static Object convertCidr(Object value){
            String stringValue = value.toString();
            PGobject pgobject = setPGobject(Constants.PGtypes.CIDR, stringValue);
            System.out.println("\nPGCIDR:- "+pgobject.getType()+" "+pgobject.getValue()+"\n");

            return pgobject;
        }

        public static Object convertMac(Object value){
            String stringValue = value.toString();
            PGobject pgobject = setPGobject(Constants.PGtypes.MACADDR, stringValue);
            System.out.println("\nPGMAC:- "+pgobject.getType()+" "+pgobject.getValue()+"\n");

            return pgobject;
        }

        public static Object convertMac8(Object value){
            String stringValue = value.toString();
            PGobject pgobject = setPGobject(Constants.PGtypes.MACADDR8, stringValue);
            System.out.println("\nPGMAC8:- "+pgobject.getType()+" "+pgobject.getValue()+"\n");

            return pgobject;
        }

// Geometric Data types

        public static Object convertPoint(Object value){
            PGpoint point; 
            if(value instanceof BString){
                try{
                    point = new PGpoint(value.toString());
                }
                catch(Exception ex){
                    System.out.println("PGPOINT CATCH ERROR\n"+ex);
                    return null;
                }
            }
            else{
                Map<String,Object> pointValue = ConversionHelper.getRecordType(value);

                point = new PGpoint(
                    ((BDecimal)(pointValue.get(Constants.Geometric.X))).decimalValue().doubleValue(),
                    ((BDecimal)(pointValue.get(Constants.Geometric.Y))).decimalValue().doubleValue()
                );                
            }
            System.out.println("\nPGPOINT:- "+point.getValue()+"\n");
            return point;

        }

        public static Object convertLine(Object value){
            PGline line;
            Type type = TypeUtils.getType(value);
            // type.getTag() != TypeTags.RECORD_TYPE_TAG

            if(value instanceof BString){
                try{
                    line = new PGline(value.toString());
                }
                catch(Exception ex){
                    System.out.println("PGLINE CATCH ERROR\n"+ex);
                    return null;
                }
                System.out.println("\nPGLINE:- "+line.getValue()+"\n");
            }
            else if(type.getTag() == TypeTags.RECORD_TYPE_TAG){
                Map<String,Object> lineValue = ConversionHelper.getRecordType(value);

                if(lineValue.containsKey(Constants.Geometric.A) && lineValue.containsKey(Constants.Geometric.B)
                            && lineValue.containsKey(Constants.Geometric.C)){
                        line = new PGline(
                            ((BDecimal)(lineValue.get(Constants.Geometric.A))).decimalValue().doubleValue(),
                            ((BDecimal)(lineValue.get(Constants.Geometric.B))).decimalValue().doubleValue(),
                            ((BDecimal)(lineValue.get(Constants.Geometric.C))).decimalValue().doubleValue()
                        );    

                    System.out.println("\nPGLINE:- "+line.getValue()+"\n");
                }

                else if(lineValue.containsKey(Constants.Geometric.X1) && lineValue.containsKey(Constants.Geometric.Y1)
                && lineValue.containsKey(Constants.Geometric.X2) && lineValue.containsKey(Constants.Geometric.Y2)){
                    line = new PGline(
                        ((BDecimal)(lineValue.get(Constants.Geometric.X1))).decimalValue().doubleValue(),
                        ((BDecimal)(lineValue.get(Constants.Geometric.Y1))).decimalValue().doubleValue(),
                        ((BDecimal)(lineValue.get(Constants.Geometric.X2))).decimalValue().doubleValue(),
                        ((BDecimal)(lineValue.get(Constants.Geometric.Y2))).decimalValue().doubleValue()
                    );  

                    System.out.println("\nPGLINE:- "+line.getValue()+"\n");

                }


            //     else if(lineValue.containsKey(Constants.Geometric.P1) && lineValue.containsKey(Constants.Geometric.P2)){

            //         Object cordinate1 = lineValue.get(Constants.Geometric.P1);
            //         Object cordinate2 = lineValue.get(Constants.Geometric.P2);

            //         if(cordinate1 instanceof BObject && cordinate2 instanceof BObject){

            //             Object point1 = ((BObject)cordinate1).get(Constants.TypedValueFields.VALUE);
            //             Object point2 = ((BObject)cordinate2).get(Constants.TypedValueFields.VALUE);

            //                 line = new PGline(

            //                     (PGpoint)point1,
            //                     (PGpoint)point2
            //                 );  

            //                 System.out.println("\nPGLINE with 2 points:- "+line.getValue()+"\n");

            //             }
            //             else{
            //                 System.out.println("Didnt found BObject for two points\n");
            //                 return null;
            //             }
            // }

                else{
                        System.out.println("PGLINE CATCH ERROR WRONG SYNTAX RECORD\n");
                        return null;
                }
                // String sqlType = typedValue.getType().getName();
                // Object value = typedValue.get(Constants.TypedValueFields.VALUE);

            }
            else{
                System.out.println("PGLINE CATCH ERROR WRONG SYNTAX RECORD\n");
                return null;
            }
            return line;

        }

        public static Object convertLseg(Object value){
            PGlseg lseg;
            Type type = TypeUtils.getType(value);
            // type.getTag() != TypeTags.RECORD_TYPE_TAG

            if(value instanceof BString){
                try{
                    lseg = new PGlseg(value.toString());
                }
                catch(Exception ex){
                    System.out.println("PGlseg CATCH ERROR\n"+ex);
                    return null;
                }
            }
            else if(type.getTag() == TypeTags.RECORD_TYPE_TAG){
                Map<String,Object> lsegValue = ConversionHelper.getRecordType(value);

                if(lsegValue.containsKey(Constants.Geometric.X1) && lsegValue.containsKey(Constants.Geometric.Y1)
                && lsegValue.containsKey(Constants.Geometric.X2) && lsegValue.containsKey(Constants.Geometric.Y2)){
                    lseg = new PGlseg(
                        ((BDecimal)(lsegValue.get(Constants.Geometric.X1))).decimalValue().doubleValue(),
                        ((BDecimal)(lsegValue.get(Constants.Geometric.Y1))).decimalValue().doubleValue(),
                        ((BDecimal)(lsegValue.get(Constants.Geometric.X2))).decimalValue().doubleValue(),
                        ((BDecimal)(lsegValue.get(Constants.Geometric.Y2))).decimalValue().doubleValue()
                    );  

                    System.out.println("\nPGlseg:- "+lseg.getValue()+"\n");

                }

                else{
                        System.out.println("PGlseg CATCH ERROR WRONG SYNTAX RECORD\n");
                        return null;
                }
                // String sqlType = typedValue.getType().getName();
                // Object value = typedValue.get(Constants.TypedValueFields.VALUE);

            }
            else{
                System.out.println("PGlseg CATCH ERROR WRONG SYNTAX RECORD\n");
                return null;
            }
            return lseg;

        }

        public static Object convertBox(Object value){
            PGbox box;
            Type type = TypeUtils.getType(value);
            // type.getTag() != TypeTags.RECORD_TYPE_TAG

            if(value instanceof BString){
                try{
                    box = new PGbox(value.toString());
                }
                catch(Exception ex){
                    System.out.println("PGbox CATCH ERROR\n"+ex);
                    return null;
                }
            }
            else if(type.getTag() == TypeTags.RECORD_TYPE_TAG){
                Map<String,Object> boxValue = ConversionHelper.getRecordType(value);

                if(boxValue.containsKey(Constants.Geometric.X1) && boxValue.containsKey(Constants.Geometric.Y1)
                && boxValue.containsKey(Constants.Geometric.X2) && boxValue.containsKey(Constants.Geometric.Y2)){
                    box = new PGbox(
                        ((BDecimal)(boxValue.get(Constants.Geometric.X1))).decimalValue().doubleValue(),
                        ((BDecimal)(boxValue.get(Constants.Geometric.Y1))).decimalValue().doubleValue(),
                        ((BDecimal)(boxValue.get(Constants.Geometric.X2))).decimalValue().doubleValue(),
                        ((BDecimal)(boxValue.get(Constants.Geometric.Y2))).decimalValue().doubleValue()
                    );  

                    System.out.println("\nPGbox:- "+box.getValue()+"\n");

                }

                else{
                        System.out.println("PGbox CATCH ERROR WRONG SYNTAX RECORD\n");
                        return null;
                }
                // String sqlType = typedValue.getType().getName();
                // Object value = typedValue.get(Constants.TypedValueFields.VALUE);

            }
            else{
                System.out.println("PGbox CATCH ERROR WRONG SYNTAX RECORD\n");
                return null;
            }
            return box;

        }

        public static Object convertCircle(Object value){
            PGcircle circle;
            Type type = TypeUtils.getType(value);
            // type.getTag() != TypeTags.RECORD_TYPE_TAG

            if(value instanceof BString){
                try{
                    circle = new PGcircle(value.toString());
                }
                catch(Exception ex){
                    System.out.println("PGcircle CATCH ERROR\n"+ex);
                    return null;
                }
            }
            else if(type.getTag() == TypeTags.RECORD_TYPE_TAG){
                Map<String,Object> circleValue = ConversionHelper.getRecordType(value);

                if(circleValue.containsKey(Constants.Geometric.X) && circleValue.containsKey(Constants.Geometric.Y)
                && circleValue.containsKey(Constants.Geometric.R)){
                    circle = new PGcircle(
                        ((BDecimal)(circleValue.get(Constants.Geometric.X))).decimalValue().doubleValue(),
                        ((BDecimal)(circleValue.get(Constants.Geometric.Y))).decimalValue().doubleValue(),
                        ((BDecimal)(circleValue.get(Constants.Geometric.R))).decimalValue().doubleValue()
                    );  

                    System.out.println("\nPGcircle:- "+circle.getValue()+"\n");

                }

                else{
                        System.out.println("PGcircle CATCH ERROR WRONG SYNTAX RECORD\n");
                        return null;
                }
                // String sqlType = typedValue.getType().getName();
                // Object value = typedValue.get(Constants.TypedValueFields.VALUE);

            }
            else{
                System.out.println("PGcircle CATCH ERROR WRONG SYNTAX RECORD\n");
                return null;
            }
            return circle;

        }

        public static Object convertUuid(Object value){
            String stringValue = value.toString();

            PGobject pgobject = setPGobject(Constants.PGtypes.UUID,stringValue);
            System.out.println("\nPGUUID:- "+pgobject.getType()+" "+pgobject.getValue()+"\n");

            return pgobject;
        }

        public static Object convertTsVector(Object value){
            String stringValue = value.toString();

            PGobject pgobject = setPGobject(Constants.PGtypes.TSVECTOR,stringValue);
            System.out.println("\nPGVector:- "+pgobject.getType()+" "+pgobject.getValue()+"\n");

            return pgobject;
        }

        public static Object convertTsQuery(Object value){
            String stringValue = value.toString();

            PGobject pgobject = setPGobject(Constants.PGtypes.TSQUERY,stringValue);
            System.out.println("\nPGQuery:- "+pgobject.getType()+" "+pgobject.getValue()+"\n");

            return pgobject;
        }

        public static Object convertJson(Object value){
            String stringValue = value.toString();
            System.out.println("Json string value:- "+stringValue+"\n");
            PGobject pgobject = setPGobject(Constants.PGtypes.JSON,stringValue);
            System.out.println("\nPGJSON:- "+pgobject.getType()+" "+pgobject.getValue()+"\n");

            return pgobject;
        }

        public static Object convertJsonb(Object value){
            String stringValue = value.toString();
            System.out.println("JsonB string value:- "+stringValue+"\n");
            PGobject pgobject = setPGobject(Constants.PGtypes.JSONB,stringValue);
            System.out.println("\nPGJSONB:- "+pgobject.getType()+" "+pgobject.getValue()+"\n");

            return pgobject;
        }

        public static Object convertJsonPath(Object value){
            String stringValue = value.toString();
            System.out.println("Json path string value:- "+stringValue+"\n");
            PGobject pgobject = setPGobject(Constants.PGtypes.JSONPATH,stringValue);
            System.out.println("\nPGJSON PATH:- "+pgobject.getType()+" "+pgobject.getValue()+"\n");

            return pgobject;
        }


        public static Object convertInterval(Object value){
            Type type = TypeUtils.getType(value);
            PGInterval interval; 
            if(value instanceof BString){
                try{
                    interval = new PGInterval(value.toString());
                }
                catch(Exception ex){
                    System.out.println("PGInterval CATCH ERROR\n"+ex);
                    return null;
                }
            }
            else if(type.getTag() == TypeTags.RECORD_TYPE_TAG){
                Map<String,Object> intervalValue = ConversionHelper.getRecordType(value);

                if(intervalValue.containsKey(Constants.Interval.YEARS) && intervalValue.containsKey(Constants.Interval.MONTHS)
                    && intervalValue.containsKey(Constants.Interval.DAYS) && intervalValue.containsKey(Constants.Interval.HOURS)
                    && intervalValue.containsKey(Constants.Interval.MINUTES) && intervalValue.containsKey(Constants.Interval.SECONDS)){

                    interval = new PGInterval(
                        ((Number)(intervalValue.get(Constants.Interval.YEARS))).intValue(),
                        ((Number)(intervalValue.get(Constants.Interval.MONTHS))).intValue(),
                        ((Number)(intervalValue.get(Constants.Interval.DAYS))).intValue(),
                        ((Number)(intervalValue.get(Constants.Interval.HOURS))).intValue(),
                        ((Number)(intervalValue.get(Constants.Interval.MINUTES))).intValue(),
                        ((BDecimal)(intervalValue.get(Constants.Interval.SECONDS))).decimalValue().doubleValue()
                    );
                }
                else{
                    System.out.println("PGINTERVALCATCH - 1 ERROR WRONG SYNTAX RECORD\n");
                    return null;
                }

            }
            else{
                System.out.println("PGINTERVALCATCH -2  ERROR WRONG SYNTAX RECORD\n");
                return null;
            }
            System.out.println("PGInterval:- "+interval.getValue()+"\n");
            return interval;

        }


        public static Object convertInt4Range(Object value){
            Type type = TypeUtils.getType(value);
            PGobject int4rangeObject; 
            if(value instanceof BString){
                String stringValue = value.toString();
                int4rangeObject = setPGobject(Constants.PGtypes.INT4RANGE,stringValue);
            }
            else if(type.getTag() == TypeTags.RECORD_TYPE_TAG){
                Map<String,Object> rangeValue = ConversionHelper.getRecordType(value);

                if(rangeValue.containsKey(Constants.Range.UPPER) && rangeValue.containsKey(Constants.Range.LOWER)
                    && rangeValue.containsKey(Constants.Range.UPPERINCLUSIVE) && rangeValue.containsKey(Constants.Range.LOWERINCLUSIVE)){

                    String upperValue = rangeValue.get(Constants.Range.UPPER).toString();
                    String lowerValue = rangeValue.get(Constants.Range.LOWER).toString();
                    boolean upperInclusive = ((Boolean)(rangeValue.get(Constants.Range.UPPERINCLUSIVE))).booleanValue();
                    boolean lowerInclusive = ((Boolean)(rangeValue.get(Constants.Range.LOWERINCLUSIVE))).booleanValue();

                    String range = ConversionHelper.setRange(upperValue, lowerValue, upperInclusive, lowerInclusive);

                    int4rangeObject = setPGobject(Constants.PGtypes.INT4RANGE,range);
                }
                else{
                    System.out.println("PGRANGE CATCH - 1 ERROR WRONG SYNTAX RECORD\n");
                    return null;
                }

            }
            else{
                System.out.println("PGRANGE CATCH -2  ERROR WRONG SYNTAX RECORD\n");
                return null;
            }
            System.out.println("PGRANGE:- "+int4rangeObject.getValue()+"\n");
            return int4rangeObject;

        }

        public static Object convertInt8Range(Object value){
            Type type = TypeUtils.getType(value);
            PGobject int8rangeObject; 
            if(value instanceof BString){
                String stringValue = value.toString();
                int8rangeObject = setPGobject(Constants.PGtypes.INT8RANGE,stringValue);
            }
            else if(type.getTag() == TypeTags.RECORD_TYPE_TAG){
                Map<String,Object> rangeValue = ConversionHelper.getRecordType(value);

                if(rangeValue.containsKey(Constants.Range.UPPER) && rangeValue.containsKey(Constants.Range.LOWER)
                    && rangeValue.containsKey(Constants.Range.UPPERINCLUSIVE) && rangeValue.containsKey(Constants.Range.LOWERINCLUSIVE)){

                    String upperValue = rangeValue.get(Constants.Range.UPPER).toString();
                    String lowerValue = rangeValue.get(Constants.Range.LOWER).toString();
                    boolean upperInclusive = ((Boolean)(rangeValue.get(Constants.Range.UPPERINCLUSIVE))).booleanValue();
                    boolean lowerInclusive = ((Boolean)(rangeValue.get(Constants.Range.LOWERINCLUSIVE))).booleanValue();

                    String range = ConversionHelper.setRange(upperValue, lowerValue, upperInclusive, lowerInclusive);

                    int8rangeObject = setPGobject(Constants.PGtypes.INT8RANGE,range);
                }
                else{
                    System.out.println("PGRANGE CATCH - 1 ERROR WRONG SYNTAX RECORD\n");
                    return null;
                }

            }
            else{
                System.out.println("PGRANGE CATCH -2  ERROR WRONG SYNTAX RECORD\n");
                return null;
            }
            System.out.println("PGRANGE:- "+int8rangeObject.getValue()+"\n");
            return int8rangeObject;

        }

        public static Object convertNumRange(Object value){
            Type type = TypeUtils.getType(value);
            PGobject numrangeObject; 
            if(value instanceof BString){
                String stringValue = value.toString();
                numrangeObject = setPGobject(Constants.PGtypes.NUMRANGE,stringValue);
            }
            else if(type.getTag() == TypeTags.RECORD_TYPE_TAG){
                Map<String,Object> rangeValue = ConversionHelper.getRecordType(value);

                if(rangeValue.containsKey(Constants.Range.UPPER) && rangeValue.containsKey(Constants.Range.LOWER)
                    && rangeValue.containsKey(Constants.Range.UPPERINCLUSIVE) && rangeValue.containsKey(Constants.Range.LOWERINCLUSIVE)){

                    String upperValue = rangeValue.get(Constants.Range.UPPER).toString();
                    String lowerValue = rangeValue.get(Constants.Range.LOWER).toString();
                    boolean upperInclusive = ((Boolean)(rangeValue.get(Constants.Range.UPPERINCLUSIVE))).booleanValue();
                    boolean lowerInclusive = ((Boolean)(rangeValue.get(Constants.Range.LOWERINCLUSIVE))).booleanValue();

                    String range = ConversionHelper.setRange(upperValue, lowerValue, upperInclusive, lowerInclusive);

                    numrangeObject = setPGobject(Constants.PGtypes.NUMRANGE,range);
                }
                else{
                    System.out.println("PGRANGE CATCH - 1 ERROR WRONG SYNTAX RECORD\n");
                    return null;
                }

            }
            else{
                System.out.println("PGRANGE CATCH -2  ERROR WRONG SYNTAX RECORD\n");
                return null;
            }
            System.out.println("PGRANGE:- "+numrangeObject.getValue()+"\n");
            return numrangeObject;

        }

        public static Object convertTsRange(Object value){
            Type type = TypeUtils.getType(value);
            PGobject tsrangeObject; 
            if(value instanceof BString){
                String stringValue = value.toString();
                tsrangeObject = setPGobject(Constants.PGtypes.TSRANGE,stringValue);
            }
            else if(type.getTag() == TypeTags.RECORD_TYPE_TAG){
                Map<String,Object> rangeValue = ConversionHelper.getRecordType(value);

                if(rangeValue.containsKey(Constants.Range.UPPER) && rangeValue.containsKey(Constants.Range.LOWER)
                    && rangeValue.containsKey(Constants.Range.UPPERINCLUSIVE) && rangeValue.containsKey(Constants.Range.LOWERINCLUSIVE)){

                    String upperValue = ConversionHelper.toTimeString(rangeValue.get(Constants.Range.UPPER)).toString();
                    String lowerValue = ConversionHelper.toTimeString(rangeValue.get(Constants.Range.LOWER)).toString();
                    boolean upperInclusive = ((Boolean)(rangeValue.get(Constants.Range.UPPERINCLUSIVE))).booleanValue();
                    boolean lowerInclusive = ((Boolean)(rangeValue.get(Constants.Range.LOWERINCLUSIVE))).booleanValue();

                    String range = ConversionHelper.setRange(upperValue, lowerValue, upperInclusive, lowerInclusive);

                    tsrangeObject = setPGobject(Constants.PGtypes.TSRANGE,range);
                }
                else{
                    System.out.println("PGRANGE CATCH - 1 ERROR WRONG SYNTAX RECORD\n");
                    return null;
                }

            }
            else{
                System.out.println("PGRANGE CATCH -2  ERROR WRONG SYNTAX RECORD\n");
                return null;
            }
            System.out.println("PGRANGE:- "+tsrangeObject.getValue()+"\n");
            return tsrangeObject;

        }

        public static Object convertTstzRange(Object value){
            Type type = TypeUtils.getType(value);
            PGobject tstzrangeObject; 
            if(value instanceof BString){
                String stringValue = value.toString();
                tstzrangeObject = setPGobject(Constants.PGtypes.TSTZRANGE,stringValue);
            }
            else if(type.getTag() == TypeTags.RECORD_TYPE_TAG){
                Map<String,Object> rangeValue = ConversionHelper.getRecordType(value);

                if(rangeValue.containsKey(Constants.Range.UPPER) && rangeValue.containsKey(Constants.Range.LOWER)
                    && rangeValue.containsKey(Constants.Range.UPPERINCLUSIVE) && rangeValue.containsKey(Constants.Range.LOWERINCLUSIVE)){

                    String upperValue = ConversionHelper.toTimeString(rangeValue.get(Constants.Range.UPPER)).toString();
                    String lowerValue = ConversionHelper.toTimeString(rangeValue.get(Constants.Range.LOWER)).toString();
                    boolean upperInclusive = ((Boolean)(rangeValue.get(Constants.Range.UPPERINCLUSIVE))).booleanValue();
                    boolean lowerInclusive = ((Boolean)(rangeValue.get(Constants.Range.LOWERINCLUSIVE))).booleanValue();

                    String range = ConversionHelper.setRange(upperValue, lowerValue, upperInclusive, lowerInclusive);

                    tstzrangeObject = setPGobject(Constants.PGtypes.TSTZRANGE,range);
                }
                else{
                    System.out.println("PGRANGE CATCH - 1 ERROR WRONG SYNTAX RECORD\n");
                    return null;
                }

            }
            else{
                System.out.println("PGRANGE CATCH -2  ERROR WRONG SYNTAX RECORD\n");
                return null;
            }
            System.out.println("PGRANGE:- "+tstzrangeObject.getValue()+"\n");
            return tstzrangeObject;

        }

        public static Object convertDateRange(Object value){
            Type type = TypeUtils.getType(value);
            PGobject daterangeObject; 
            if(value instanceof BString){
                String stringValue = value.toString();
                daterangeObject = setPGobject(Constants.PGtypes.DATERANGE,stringValue);
            }
            else if(type.getTag() == TypeTags.RECORD_TYPE_TAG){
                Map<String,Object> rangeValue = ConversionHelper.getRecordType(value);

                if(rangeValue.containsKey(Constants.Range.UPPER) && rangeValue.containsKey(Constants.Range.LOWER)
                    && rangeValue.containsKey(Constants.Range.UPPERINCLUSIVE) && rangeValue.containsKey(Constants.Range.LOWERINCLUSIVE)){

                    String upperValue = ConversionHelper.toTimeString(rangeValue.get(Constants.Range.UPPER)).toString();
                    String lowerValue = ConversionHelper.toTimeString(rangeValue.get(Constants.Range.LOWER)).toString();
                    boolean upperInclusive = ((Boolean)(rangeValue.get(Constants.Range.UPPERINCLUSIVE))).booleanValue();
                    boolean lowerInclusive = ((Boolean)(rangeValue.get(Constants.Range.LOWERINCLUSIVE))).booleanValue();

                    String range = ConversionHelper.setRange(upperValue, lowerValue, upperInclusive, lowerInclusive);

                    daterangeObject = setPGobject(Constants.PGtypes.DATERANGE,range);
                }
                else{
                    System.out.println("PGRANGE CATCH - 1 ERROR WRONG SYNTAX RECORD\n");
                    return null;
                }

            }
            else{
                System.out.println("PGRANGE CATCH -2  ERROR WRONG SYNTAX RECORD\n");
                return null;
            }
            System.out.println("PGRANGE:- "+daterangeObject.getValue()+"\n");
            return daterangeObject;

        }



        public static Object convertPglsn(Object value){
            String stringValue = value.toString();
            PGobject pgobject = setPGobject(Constants.PGtypes.PGLSN,stringValue);
            System.out.println("\nPGLSN VALUE:- "+pgobject.getType()+" "+pgobject.getValue()+"\n");

            return pgobject;
        }



        public static Object convertBitn(Object value){
            String stringValue = value.toString();
            PGobject pgobject = setPGobject(Constants.PGtypes.BITSTRING,stringValue);
            System.out.println("\nPGBIT(N) VALUE:- "+pgobject.getType()+" "+pgobject.getValue()+"\n");

            return pgobject;
        }

        public static Object convertVarbit(Object value){
            String stringValue = value.toString();
            PGobject pgobject = setPGobject(Constants.PGtypes.VARBITSTRING,stringValue);
            System.out.println("\nPGVARBIT(N) VALUE:- "+pgobject.getType()+" "+pgobject.getValue()+"\n");

            return pgobject;
        }

        public static Object convertBit(Object value){
            String stringValue;
            if(value instanceof Boolean){
                Boolean booleanValue = (Boolean)value;
                stringValue = booleanValue?"1":"0";
            }
            else{
                stringValue = value.toString();
            }
            PGobject pgobject = setPGobject(Constants.PGtypes.PGBIT,stringValue);
            System.out.println("\nPGBIT(1) VALUE:- "+pgobject.getType()+" "+pgobject.getValue()+"\n");

            return pgobject;
        }


        public static Object convertMoney(Object value){

            PGmoney money;
            if(value instanceof BString){
                String stringValue = value.toString();
                money = setPGmoney(stringValue);
            }
            else if(value instanceof BDecimal){
                double decimalValue = ((BDecimal)value).decimalValue().doubleValue();
                money = setPGmoney(decimalValue);
            }
            else{
                System.out.println("Money wrong syntax");
                return null;
            }

            return money;
        }

        public static Object convertCustomType(BString datatype,Object value){
            String stringValue;
            Type type = TypeUtils.getType(value);
            String typeName = datatype.toString();
            if(value instanceof BString){
                stringValue = value.toString();
            }
            else if(type.getTag() == TypeTags.RECORD_TYPE_TAG){
                Map<String,Object> customValue = ConversionHelper.getRecordType(value);
                stringValue = ConversionHelper.setCustomType(customValue);
            }
            else{
                System.out.println("Custom wrong syntax");
                return null;
            }
            PGobject pgobject = setPGobject(typeName,stringValue);
            System.out.println(typeName+" VALUE:- "+pgobject.getType()+" "+pgobject.getValue()+"\n");

            return pgobject;
        }


        public static Object convertRegclass(Object value){
            String stringValue = value.toString();
            PGobject pgobject = setPGobject(Constants.PGtypes.REGCLASS,stringValue);
            System.out.println("\nPGLSN VALUE:- "+pgobject.getType()+" "+pgobject.getValue()+"\n");

            return pgobject;
        }

        public static Object convertRegconfig(Object value){
            String stringValue = value.toString();
            PGobject pgobject = setPGobject(Constants.PGtypes.REGCONFIG,stringValue);
            System.out.println("\nPGLSN VALUE:- "+pgobject.getType()+" "+pgobject.getValue()+"\n");

            return pgobject;
        }


        public static Object convertRegdictionary(Object value){
            String stringValue = value.toString();
            PGobject pgobject = setPGobject(Constants.PGtypes.REGDICTIONARY,stringValue);
            System.out.println("\nPGLSN VALUE:- "+pgobject.getType()+" "+pgobject.getValue()+"\n");

            return pgobject;
        }


        public static Object convertRegnamespace(Object value){
            String stringValue = value.toString();
            PGobject pgobject = setPGobject(Constants.PGtypes.REGNAMESPACE,stringValue);
            System.out.println("\nPGLSN VALUE:- "+pgobject.getType()+" "+pgobject.getValue()+"\n");

            return pgobject;
        }


        public static Object convertRegoper(Object value){
            String stringValue = value.toString();
            PGobject pgobject = setPGobject(Constants.PGtypes.REGOPER,stringValue);
            System.out.println("\nPGLSN VALUE:- "+pgobject.getType()+" "+pgobject.getValue()+"\n");

            return pgobject;
        }


        public static Object convertRegoperator(Object value){
            String stringValue = value.toString();
            PGobject pgobject = setPGobject(Constants.PGtypes.REGOPERATOR,stringValue);
            System.out.println("\nPGLSN VALUE:- "+pgobject.getType()+" "+pgobject.getValue()+"\n");

            return pgobject;
        }


        public static Object convertRegproc(Object value){
            String stringValue = value.toString();
            PGobject pgobject = setPGobject(Constants.PGtypes.REGPROC,stringValue);
            System.out.println("\nPGLSN VALUE:- "+pgobject.getType()+" "+pgobject.getValue()+"\n");

            return pgobject;
        }


        public static Object convertRegprocedure(Object value){
            String stringValue = value.toString();
            PGobject pgobject = setPGobject(Constants.PGtypes.REGPROCEDURE,stringValue);
            System.out.println("\nPGLSN VALUE:- "+pgobject.getType()+" "+pgobject.getValue()+"\n");

            return pgobject;
        }


        public static Object convertRegrole(Object value){
            String stringValue = value.toString();
            PGobject pgobject = setPGobject(Constants.PGtypes.REGROLE,stringValue);
            System.out.println("\nPGLSN VALUE:- "+pgobject.getType()+" "+pgobject.getValue()+"\n");

            return pgobject;
        }


        public static Object convertRegtype(Object value){
            String stringValue = value.toString();
            PGobject pgobject = setPGobject(Constants.PGtypes.REGTYPE,stringValue);
            System.out.println("\nPGLSN VALUE:- "+pgobject.getType()+" "+pgobject.getValue()+"\n");

            return pgobject;
        }

        public static Object convertXml(Connection connection, Object value){
            String xmlValue = value.toString();
            SQLXML xml = new PgSQLXML((BaseConnection) connection,xmlValue);
            return xml;
        }


        public static PGobject setPGobject(String type, String value){
            PGobject pgobject =  new PGobject();
            pgobject.setType(type);
            try{
                pgobject.setValue(value);

            }catch(Exception ex){
                System.out.println(type+" CATCH ERROR\n"+ex);
            }
            return pgobject;
        }

        public static PGmoney setPGmoney(double value){
            PGmoney money;
            try{
                money = new PGmoney(value);

            }catch(Exception ex){
                System.out.println(" CATCH ERROR MONEY:-:\n"+ex);
                return null;
            }
            return money;
        }

        public static PGmoney setPGmoney(String value){
            PGmoney money;
            try{
                money = new PGmoney(value);

            }catch(Exception ex){
                System.out.println(" CATCH ERROR MONEY:-:\n"+ex);
                return null;
            }
            return money;
        }

} 