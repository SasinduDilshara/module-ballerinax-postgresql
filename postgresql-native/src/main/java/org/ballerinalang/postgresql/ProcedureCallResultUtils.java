package org.ballerinalang.postgresql;

import io.ballerina.runtime.api.values.BObject;

import org.ballerinalang.postgresql.parameterprocessor.PostgresResultParameterProcessor;

public class ProcedureCallResultUtils {
    public static Object getNextQueryResult(BObject procedureCallResultset, BObject procedureCallResult) {
        return org.ballerinalang.sql.utils.ProcedureCallResultUtils
            .getNextQueryResult(procedureCallResult, PostgresResultParameterProcessor.getInstance());
    }
}