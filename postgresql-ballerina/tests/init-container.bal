// Copyright (c) 2020 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/io;
import ballerina/system;
import ballerina/test;
import ballerina/file;
import ballerina/runtime;

string resourcePath = check file:getAbsolutePath("tests/resources");

string host = "localhost";
string user = "postgres";
string password = "postgres";
int port = 5431;

@test:BeforeSuite
function beforeSuite() {
    
    system:Process process = checkpanic system:exec("docker", {}, resourcePath, "build", "-t", "ballerina-postgresql", ".");
        io:println("\n",process,"\n");
    int exitCode = checkpanic process.waitForExit();
    test:assertExactEquals(exitCode, 0, "Docker image 'ballerina-postgresql' creation failed!");
 
    process = checkpanic system:exec("docker", {}, resourcePath, 
                    "run", "--rm", "-d", "--name", "ballerina-postgresql", "-p", "5431:5432", "-t", "ballerina-postgresql");
    exitCode = checkpanic process.waitForExit();
    test:assertExactEquals(exitCode, 0, "Docker container 'ballerina-postgresql' creation failed!");
    runtime:sleep(50000);

    int healthCheck = 1;
    int counter = 0;
    while(healthCheck > 0 && counter < 12) {
        runtime:sleep(10000);
        process = checkpanic system:exec("docker", {}, resourcePath, 
                    "exec", "ballerina-postgresql", "postgresqladmin", "ping", "-hlocalhost", "-uroot", "-ppostgres", "--silent");
        healthCheck = checkpanic process.waitForExit();
        counter = counter + 1;
    }
    test:assertExactEquals(healthCheck, 0, "Docker container 'ballerina-postgresql' health test exceeded timeout!");    
    io:println("Docker container started.");
}

@test:AfterSuite {}
function afterSuite() {
    system:Process process = checkpanic system:exec("docker", {}, resourcePath, "stop", "ballerina-postgresql");
    int exitCode = checkpanic process.waitForExit();
    test:assertExactEquals(exitCode, 0, "Docker container 'ballerina-postgresql' stop failed!");
}
