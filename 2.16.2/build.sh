#!/bin/sh

docker build -f java11-hotspot.dockerfile -t heitorcarneiro/geoserver:2.16.2-java11-hotspot .
docker push heitorcarneiro/geoserver:2.16.2-java11-hotspot

# docker build -f java11-hotspot.dockerfile -t heitorcarneiro/geoserver:2.16.2-java11-hotspot-readonly .
# docker push heitorcarneiro/geoserver:2.16.2-java11-hotspot-readonly

# docker build -f java11-hotspot.dockerfile -t heitorcarneiro/geoserver:2.16.2-java11-hotspot-master .
# docker push heitorcarneiro/geoserver:2.16.2-java11-hotspot-master

# docker build -f java11-hotspot.dockerfile -t heitorcarneiro/geoserver:2.16.2-java11-hotspot-slave .
# docker push heitorcarneiro/geoserver:2.16.2-java11-hotspot-slave
