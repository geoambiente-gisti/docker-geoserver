sudo chmod 777 -R ../2.15.2/

# docker build -f java11-hotspot.dockerfile -t heitorcarneiro/geoserver:2.15.2.1-java11-hotspot .
# docker build -f java11-hotspot.dockerfile -t heitorcarneiro/geoserver:2.15.2.1-java11-hotspot-readonly .
# docker build -f java11-hotspot.dockerfile -t heitorcarneiro/geoserver:2.15.2.1-java11-hotspot-master .
# docker build -f java11-hotspot.dockerfile -t heitorcarneiro/geoserver:2.15.2.1-java11-hotspot-slave .

# docker run -it --rm --name geoserver -p 8080:8080 heitorcarneiro/geoserver:2.15.2.1-java11-hotspot-master
