#!/bin/bash

htpasswd -c credentials/geoservermaster.localhost admin

docker-compose up --scale geoserverslave=3

sudo chmod 777 -R cluster/

