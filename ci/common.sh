#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -ex

export_or_prefix() {
    export OPENRESTY_PREFIX="/usr/local/openresty-debug"
    export APISIX_MAIN="https://raw.githubusercontent.com/apache/incubator-apisix/master/rockspec/apisix-master-0.rockspec"
    export PATH=$OPENRESTY_PREFIX/nginx/sbin:$OPENRESTY_PREFIX/luajit/bin:$OPENRESTY_PREFIX/bin:$PATH
}

create_lua_deps() {
    echo "Create lua deps"

    git config --global url.https://github.com/.insteadOf git://github.com/
    make deps
    # maybe reopen this feature later
    # luarocks install luacov-coveralls --tree=deps --local > build.log 2>&1 || (cat build.log && exit 1)
}

install_grpcurl () {
    # For more versions, visit https://github.com/fullstorydev/grpcurl/releases
    GRPCURL_VERSION="1.8.5"
    wget https://github.com/fullstorydev/grpcurl/releases/download/v${GRPCURL_VERSION}/grpcurl_${GRPCURL_VERSION}_linux_x86_64.tar.gz
    tar -xvf grpcurl_${GRPCURL_VERSION}_linux_x86_64.tar.gz -C /usr/local/bin
}

install_vault_cli () {
    VAULT_VERSION="1.9.0"
    wget https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip
    unzip vault_${VAULT_VERSION}_linux_amd64.zip && mv ./vault /usr/local/bin
}

GRPC_SERVER_EXAMPLE_VER=20210819
