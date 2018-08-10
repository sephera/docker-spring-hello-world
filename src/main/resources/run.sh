#!/bin/bash
set -x #echo on

JAR_FILE=$PWD"/"$(ls | grep *.jar | head -1)

LIST_FILE=$(ls $PWD"/config" | grep -e .properties -e .yml)
PROP_FILE=""
echo $LIST_FILE
if [ -n "$LIST_FILE" ]; then
    for line in $LIST_FILE
    do
         PROP_FILE=$PROP_FILE"file:"$PWD"/config/"$line","
         echo $PROP_FILE
    done
    echo $PROP_FILE
    PROP_FILE=" -spring.config.additional-location="${PROP_FILE::-1}
fi


LOG_FILE=$PWD"/config/"$(ls $PWD"/config" | grep .xml | head -1)
echo $LOG_FILE
if [ -n "$LOG_FILE" ]; then
    LOG_FILE="-logging.config=file:"$LOG_FILE
fi

java -jar $JAR_FILE $PROP_FILE $LOG_FILE &