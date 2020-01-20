#!/usr/bin/env sh

last=0
rtl_433 -F json -M newmodel -R 51 | while read line; do
    now=`date +%s`
    if [ $(($now-$last)) -gt 4 ]; then
        result=`echo $line | jq .id==$BELL_ID`
        if [ $result = "true" ]; then
            last=$now
            mosquitto_pub --url $MQTT_URL --message "{\"id\":$BELL_ID,\"ts\":$now}"
        fi
    fi
done
