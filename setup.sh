#!/bin/bash
set -eu

cd $(dirname "$0")

JAVA_JDK=jdk-8u191-linux-x64.tar.gz
JAVA_URL=https://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/jdk-8u191-linux-x64.tar.gz

if [ ! -f _deps/$JAVA_JDK ]; then
    wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" $JAVA_URL -O _deps/$JAVA_JDK
fi

TIZEN_CLI=web-cli_Tizen_Studio_3.0_ubuntu-64.bin
TIZEN_URL=http://download.tizen.org/sdk/Installer/tizen-studio_3.0/web-cli_Tizen_Studio_3.0_ubuntu-64.bin

if [ ! -f _deps/$TIZEN_CLI ]; then
    curl -k -L \
        $TIZEN_URL \
        -o _deps/$TIZEN_CLI
    chmod +x _deps/$TIZEN_CLI
fi
