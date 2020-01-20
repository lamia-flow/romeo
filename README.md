Romeo – The Boondock Doorbell
=============================

> I dedicate all my today's efforts to my grandma, who has her 90th birthday.
> ~_Piotr 18.01.2020_

Romeo listens to the LPD433 band where doorbells are commonly operating. When signal from the doorbell with desired ID is caught, he publish message under specified MQTT topic.


Configuration
-------------

Romeo is configured via the following environment variables:

- `BELL_ID` – identifier of the doorbell, returned by the `rtl_433`.
- `MQTT_URL` – MQTT URL of the topic in form in the form: `mqtt(s)://[username[:password]@]host[:port]/topic`.
- `SLACK_API_TOKEN` – Slack authorization token with `chat:write:bot` scope.
- `SLACK_CHANNEL` – Slack channel where the "Ding! Dong!" message should be posted.


Deployment
----------

Copy:
- `romeo.sh` and `romeo-slack.sh` to `/usr/bin/`
- `romeo.service` and `romeo-slack.service` to `/lib/systemd/system/`

Create `/etc/romeo.ini` env like file and place configuration variables inside.
```sh
BELL_ID=123456789
MQTT_URL=mqtt://localhost/ding-dong
SLACK_API_TOKEN=xoxp-000000000-000000000000-000000000000-00000000000000000000000000000000
SLACK_CHANNEL=CXXXXXXXX
```

Lunch Romeo by enabling and starting his systemd services
```sh
systemctl enable romeo
systemctl enable romeo-slack
systemctl start romeo
systemctl start romeo-slack
```


Authors
-------
- Piotr Majkrzak <piotr@lamia.fi>
