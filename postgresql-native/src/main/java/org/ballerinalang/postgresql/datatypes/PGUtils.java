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

package org.ballerinalang.postgresql.datatypes;


import org.postgresql.util.PGobject;
import org.postgresql.geometric.*;

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
// import io.ballerina.runtime.internal.types.BJsonType;


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
 * @since 1.2.0
 */
// class Inet {
//     public String typeName;
//     public String value;


// }

public class PGUtils {

        public static Object convertInet(Object value){
                String stringValue = value.toString();
                PGobject pgobject =  new PGobject();
                pgobject.setType(PGConstants.PGtypes.INET);
                try{
                    pgobject.setValue(stringValue);

                }
                catch(Exception ex){
                    System.out.println("PGINET CATCH ERROR\n"+ex);
                }
                System.out.println("\nPGINET:- "+pgobject.getType()+" "+pgobject.getValue()+"\n");
                
                return pgobject;
        }

        public static Object convertCidr(Object value){
            String stringValue = value.toString();
            PGobject pgobject =  new PGobject();
            pgobject.setType(PGConstants.PGtypes.CIDR);
            try{
                pgobject.setValue(stringValue);

            }
            catch(Exception ex){
                System.out.println("PGINET CATCH ERROR\n"+ex);
            }
            System.out.println("\nPGINET:- "+pgobject.getType()+" "+pgobject.getValue()+"\n");
            
            return pgobject;
        }

        public static Object convertMac(Object value){
            String stringValue = value.toString();
            PGobject pgobject =  new PGobject();
            pgobject.setType(PGConstants.PGtypes.MACADDR);
            try{
                pgobject.setValue(stringValue);

            }
            catch(Exception ex){
                System.out.println("PGINET CATCH ERROR\n"+ex);
            }
            System.out.println("\nPGINET:- "+pgobject.getType()+" "+pgobject.getValue()+"\n");
            
            return pgobject;
        }

        public static Object convertMac8(Object value){
            String stringValue = value.toString();
            PGobject pgobject =  new PGobject();
            pgobject.setType(PGConstants.PGtypes.MACADDR8);
            try{
                pgobject.setValue(stringValue);

            }
            catch(Exception ex){
                System.out.println("PGINET CATCH ERROR\n"+ex);
            }
            System.out.println("\nPGINET:- "+pgobject.getType()+" "+pgobject.getValue()+"\n");
            
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
                    System.out.println("PGINET CATCH ERROR\n"+ex);
                    return null;
                }
            }
            else{
                Map<String,Object> pointValue = PGhelper.getRecordType(value);

                point = new PGpoint(
                    ((BDecimal)(pointValue.get(PGConstants.PGpoint.X))).decimalValue().doubleValue(),
                    ((BDecimal)(pointValue.get(PGConstants.PGpoint.Y))).decimalValue().doubleValue()
                );                
            }
            System.out.println("\nPGPOINT:- "+point.getValue()+"\n");
            return point;
            
        }

}