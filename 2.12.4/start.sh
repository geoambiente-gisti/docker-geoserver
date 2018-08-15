#!/bin/bash
echo "Copying GeoServer extensions..."
for ext in `ls -d /var/local/geoserver-exts/*/`; do
  echo "Copying '${ext}'"
  cp "${ext}"*.jar /usr/local/geoserver/WEB-INF/lib
done

echo "Start GeoServer..."
catalina.sh run
