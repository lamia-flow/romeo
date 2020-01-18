#!/bin/sh

last=0
rtl_433 -F json -M newmodel -R 51 | while read line; do
    now=`date +%s`
    if [ $(($now-$last)) -gt 4 ]; then
        result=`echo $line | jq .id==$ID`
        if [ $result = "true" ]; then
            last=$now
            mosquitto_pub --url $MQTT --message "{\"id\":$id,\"ts\":$now}"
        fi
    fi
done
