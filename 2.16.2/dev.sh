#!/bin/sh

docker build -f java11-hotspot.dockerfile -t heitorcarneiro/geoserver:2.16.2.2-java11-hotspot .
docker run -it --rm --name geoserver -p 8080:8080 heitorcarneiro/geoserver:2.16.2.2-java11-hotspot
