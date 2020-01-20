#!/usr/bin/env sh

last=0
mosquitto_sub --url $MQTT_URL | while read line; do
    curl --silent \
        https://slack.com/api/chat.postMessage \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $SLACK_API_TOKEN" \
        -d "{\"channel\":\"$SLACK_CHANNEL\",\"text\":\"Ding! Dong!\"}"
done
