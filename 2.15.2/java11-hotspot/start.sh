#!/bin/bash
echo "Copying GeoServer extensions..."
cp /var/local/geoserver-exts/*.jar /usr/local/geoserver/WEB-INF/lib

echo "Start GeoServer..."
catalina.sh run
