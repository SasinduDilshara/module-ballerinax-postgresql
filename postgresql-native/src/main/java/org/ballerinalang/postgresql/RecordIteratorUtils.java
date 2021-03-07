package org.ballerinalang.postgresql;

import io.ballerina.runtime.api.values.BObject;

import org.ballerinalang.postgresql.parameterprocessor.PostgresResultParameterProcessor;

public class RecordIteratorUtils {
    public static Object nextResult(BObject postgresRecordIterator, BObject recordIterator) {
        System.out.println("\nPostgresql RecordIteratorUtilsn");
        return org.ballerinalang.sql.utils.RecordIteratorUtils.nextResult(recordIterator, PostgresResultParameterProcessor.getInstance());
    }
    public static Object getNextQueryResult(BObject procedureCallResultset, BObject procedureCallResult) {
        System.out.println("\nPostgresql RecordIteratorUtilsn procedureCallResult"+ procedureCallResult);
        return org.ballerinalang.sql.utils.ProcedureCallResultUtils.getNextQueryResult(procedureCallResult, PostgresResultParameterProcessor.getInstance());
    }
}