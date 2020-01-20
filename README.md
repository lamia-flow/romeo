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


Packaging
---------

```sh
mkdir -p pkg/usr/bin/
mkdir -p pkg/lib/systemd/system/
mkdir -p pkg/DEBIAN

install -D *.sh pkg/usr/bin/
install -D *.service pkg/lib/systemd/system/

echo "\
Package: romeo
Version: $(git describe --tags)
Architecture: any
Depends: rtl-433, mosquitto-clients, curl
Description: $(head -n 1 README.md)
" > pkg/DEBIAN/control

dpkg-deb --build pkg
rm -r pkg
```


Deployment
----------

Install `pkg.deb` and create `/etc/romeo` env like file and place configuration variables inside.
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
