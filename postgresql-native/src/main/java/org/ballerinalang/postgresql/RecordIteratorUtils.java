package org.ballerinalang.postgresql;

import io.ballerina.runtime.api.values.BObject;

import org.ballerinalang.postgresql.parameterprocessor.PostgresResultParameterProcessor;

public class RecordIteratorUtils {
    public static Object nextResult(BObject postgresRecordIterator, BObject recordIterator) {
        System.out.println("\n\n\n\n\n\nRecordIteratorUtils\n\n\n\\n\n\n\n");
        return org.ballerinalang.sql.utils.RecordIteratorUtils.nextResult(recordIterator, PostgresResultParameterProcessor.getInstance());
    }
    public static Object getNextQueryResult(BObject procedureCallResultset, BObject procedureCallResult) {
        return true;
    }
}