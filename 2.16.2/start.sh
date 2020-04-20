#!/bin/sh

#We need this line to ensure that data has the correct rights
chown -R tomcat:tomcat ${GEOSERVER_DATA_DIR}
chown -R tomcat:tomcat ${GEOSERVER_EXT_DIR}

echo "Copying GeoServer extensions..."
cp -r ${GEOSERVER_EXT_DIR}/*.jar /usr/local/geoserver/WEB-INF/lib

echo "Start GeoServer..."
su tomcat -c "/usr/local/tomcat/bin/catalina.sh run"
