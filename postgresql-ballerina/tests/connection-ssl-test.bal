// Copyright (c) 2020, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied. See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/file;
import ballerina/test;

string clientkeyPath = checkpanic file:getAbsolutePath("./tests/resources/keystore/client/postgresql.key");
string clientCertPath = checkpanic file:getAbsolutePath("./tests/resources/keystore/client/postgresql.crt");
string serverCertPath = checkpanic file:getAbsolutePath("./tests/resources/keystore/server/root.crt");

@test:Config {
    groups: ["connection","ssl"]
}
function testSSLRequire() {
    Options options = {
        ssl: {
            mode: REQUIRE,
            sslrootcert: {
                path: serverCertPath,
                password: "changeit"
            },
            sslkey: {
                path: clientkeyPath,
                password: "changeit"
            },
            sslcert: {
                path: clientCertPath,
                password: "changeit"
            }
        }
    };
    Client dbClient = checkpanic new (username = user, password = password, database = sslDb,
        port = port, options = options);
    test:assertEquals(dbClient.close(), ());
}

@test:Config {
    groups: ["connection","ssl"]
}
function testSSLPrefer() {
    Options options = {
        ssl: {
            mode: PREFER,
            sslrootcert: {
                path: serverCertPath,
                password: "changeit"
            },
            sslkey: {
                path: clientkeyPath,
                password: "changeit"
            },
            sslcert: {
                path: clientCertPath,
                password: "changeit"
            }
        }
    };
    Client dbClient = checkpanic new (username = user, password = password, database = sslDb,
        port = port, options = options);
    test:assertEquals(dbClient.close(), ());
}

@test:Config {
    groups: ["connection","ssl"]
}
function testSSLAllow() {
    Options options = {
        ssl: {
            mode:  ALLOW,
            sslrootcert: {
                path: serverCertPath,
                password: "changeit"
            },
            sslkey: {
                path: clientkeyPath,
                password: "changeit"
            },
            sslcert: {
                path: clientCertPath,
                password: "changeit"
            }
        }
    };
    Client dbClient = checkpanic new (username = user, password = password, database = sslDb,
        port = port, options = options);
    test:assertEquals(dbClient.close(), ());
}

@test:Config {
    groups: ["connection","ssl"]
}
function testSSLDisable() {
    Options options = {
        ssl: {
            mode:  DISABLE,
            sslrootcert: {
                path: serverCertPath,
                password: "changeit"
            },
            sslkey: {
                path: clientkeyPath,
                password: "changeit"
            },
            sslcert: {
                path: clientCertPath,
                password: "changeit"
            }
        }
    };
    Client dbClient = checkpanic new (username = user, password = password, database = sslDb,
        port = port, options = options);
    test:assertEquals(dbClient.close(), ());
}

@test:Config {
    groups: ["connection","ssl"]
}
function testSSLVerifyCert() {
    Options options = {
        ssl: {
            mode: VERIFY_CA,
            sslrootcert: {
                path: serverCertPath,
                password: "changeit"
            },
            sslkey: {
                path: clientkeyPath,
                password: "changeit"
            },
            sslcert: {
                path: clientCertPath,
                password: "changeit"
            }
        }
    };
    Client dbClient = checkpanic new (username = user, password = password, database = sslDb,
        port = port, options = options);
    test:assertEquals(dbClient.close(), ());
}

@test:Config {
    groups: ["connection","ssl"]
}
function testSSLVerifyFull() {
    Options options = {
        ssl: {
            mode: VERIFY_FULL,
            sslrootcert: {
                path: serverCertPath,
                password: "changeit"
            },
            sslkey: {
                path: clientkeyPath,
                password: "changeit"
            },
            sslcert: {
                path: clientCertPath,
                password: "changeit"
            }
        }
    };
    Client dbClient = checkpanic new (username = user, password = password, database = sslDb,
        port = port, options = options);
    test:assertEquals(dbClient.close(), ());
}
