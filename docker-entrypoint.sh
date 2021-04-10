#!/bin/bash

get-main-class() {
    local var=$(unzip -p "$1" META-INF/MANIFEST.MF | grep "Main-Class:" | cut -d':' -f2)
    var="${var##[[:space:]]}"
    echo "${var%%[[:space:]]}"
}


JAR_FILE=$1
MAIN_CLASS=$2

if [[ -z "$JAR_FILE" ]]; then
    echo 'Usage: docker run -it --rm --name projector -p 8887:8887 -v /path/to/file.jar:/opt/projector/file.jar projector:tag file.jar'
    exit 1
fi

if [[ ! -e "$JAR_FILE" ]]; then
    echo "Jar file is not exists."
    exit 2
fi

if [[ -z "$MAIN_CLASS" ]]; then
    MAIN_CLASS=$(get-main-class $JAR_FILE)
fi

if [[ -z "$MAIN_CLASS" ]]; then
    echo "Main class is not found"
    exit 3
fi

java -classpath "${JAR_FILE}:lib/*" "-Dorg.jetbrains.projector.server.classToLaunch=${MAIN_CLASS}" org.jetbrains.projector.server.ProjectorLauncher
