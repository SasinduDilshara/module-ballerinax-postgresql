package org.ballerinalang.postgresql;

import io.ballerina.runtime.api.values.BObject;

import org.ballerinalang.postgresql.parameterprocessor.PostgresResultParameterProcessor;

public class RecordIteratorUtils {
    public static Object nextResult(BObject postgresRecordIterator, BObject recordIterator) {
        return org.ballerinalang.sql.utils.RecordIteratorUtils.nextResult(recordIterator, PostgresResultParameterProcessor.getInstance());
    }
}