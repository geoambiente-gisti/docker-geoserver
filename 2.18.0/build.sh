#!/bin/sh

docker build -f java11-hotspot.dockerfile -t heitorcarneiro/geoserver:2.18.0-java11-hotspot .
docker push heitorcarneiro/geoserver:2.18.0-java11-hotspot

# docker build -f java11-hotspot.dockerfile -t heitorcarneiro/geoserver:2.18.0-java11-hotspot-readonly .
# docker push heitorcarneiro/geoserver:2.18.0-java11-hotspot-readonly

# docker build -f java11-hotspot.dockerfile -t heitorcarneiro/geoserver:2.18.0-java11-hotspot-primary .
# docker push heitorcarneiro/geoserver:2.18.0-java11-hotspot-primary

# docker build -f java11-hotspot.dockerfile -t heitorcarneiro/geoserver:2.18.0-java11-hotspot-secondary .
# docker push heitorcarneiro/geoserver:2.18.0-java11-hotspot-secondary
