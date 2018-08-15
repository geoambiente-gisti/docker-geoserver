FROM tomcat:8-jre8

MAINTAINER Heitor Carneiro <heitor.carneiro@geoambiente.com.br>

ENV GEOSERVER_VERSION 2.12.4
ENV GEOSERVER_DATA_DIR /var/local/geoserver
ENV GEOSERVER_EXT_DIR /var/local/geoserver-exts
ENV GEOSERVER_INSTALL_DIR /usr/local/geoserver

# Uncomment to use APT cache (requires apt-cacher-ng on host)
#RUN echo "Acquire::http { Proxy \"http://`/sbin/ip route|awk '/default/ { print $3 }'`:3142\"; };" > /etc/apt/apt.conf.d/71-apt-cacher-ng

# Microsoft fonts
RUN echo "deb http://httpredir.debian.org/debian jessie contrib" >> /etc/apt/sources.list
RUN set -x \
	&& apt-get update \
	&& apt-get install -yq ttf-mscorefonts-installer \
	&& rm -rf /var/lib/apt/lists/*

# Native JAI & ImageIO
RUN cd /usr/lib/jvm/java-8-openjdk-amd64 \
	&& wget http://download.java.net/media/jai/builds/release/1_1_3/jai-1_1_3-lib-linux-amd64-jdk.bin \
	&& tail -n +139 jai-1_1_3-lib-linux-amd64-jdk.bin > INSTALL-jai \
	&& chmod u+x INSTALL-jai \
	&& ./INSTALL-jai \
	&& rm jai-1_1_3-lib-linux-amd64-jdk.bin INSTALL-jai *.txt \
	&& wget http://download.java.net/media/jai-imageio/builds/release/1.1/jai_imageio-1_1-lib-linux-amd64-jdk.bin \
	&& tail -n +215 jai_imageio-1_1-lib-linux-amd64-jdk.bin > INSTALL-jai_imageio \
	&& chmod u+x INSTALL-jai_imageio \
	&& ./INSTALL-jai_imageio \
	&& rm jai_imageio-1_1-lib-linux-amd64-jdk.bin INSTALL-jai_imageio *.txt

# GeoServer
ADD conf/geoserver.xml /usr/local/tomcat/conf/Catalina/localhost/geoserver.xml
RUN mkdir ${GEOSERVER_DATA_DIR} \
	&& mkdir ${GEOSERVER_INSTALL_DIR} \
	&& cd ${GEOSERVER_INSTALL_DIR} \
	&& wget http://sourceforge.net/projects/geoserver/files/GeoServer/${GEOSERVER_VERSION}/geoserver-${GEOSERVER_VERSION}-war.zip \
	&& unzip geoserver-${GEOSERVER_VERSION}-war.zip \
	&& unzip geoserver.war \
	&& mv data/* ${GEOSERVER_DATA_DIR} \
	&& rm -rf geoserver-${GEOSERVER_VERSION}-war.zip geoserver.war target *.txt

# Extensions
RUN mkdir -p ${GEOSERVER_EXT_DIR}/authkey
ADD geoserver-exts/authkey/gs-authkey-2.12.4.jar ${GEOSERVER_EXT_DIR}/authkey/gs-authkey-2.12.4.jar

RUN mkdir -p ${GEOSERVER_EXT_DIR}/control-flow
ADD geoserver-exts/control-flow/gs-control-flow-2.12.4.jar ${GEOSERVER_EXT_DIR}/control-flow/gs-control-flow-2.12.4.jar
ADD conf/controlflow.properties ${GEOSERVER_DATA_DIR}/controlflow.properties

RUN mkdir -p ${GEOSERVER_EXT_DIR}/monitor
ADD geoserver-exts/monitor/gs-monitor-core-2.12.4.jar ${GEOSERVER_EXT_DIR}/monitor/gs-monitor-core-2.12.4.jar
ADD geoserver-exts/monitor/jcommon-1.0.13.jar ${GEOSERVER_EXT_DIR}/monitor/jcommon-1.0.13.jar
ADD geoserver-exts/monitor/jfreechart-1.0.10.jar ${GEOSERVER_EXT_DIR}/monitor/jfreechart-1.0.10.jar
ADD geoserver-exts/monitor/joda-time-2.8.1.jar ${GEOSERVER_EXT_DIR}/monitor/joda-time-2.8.1.jar
ADD geoserver-exts/monitor/poi-3.14.jar ${GEOSERVER_EXT_DIR}/monitor/poi-3.14.jar
ADD geoserver-exts/monitor/poi-ooxml-3.14.jar ${GEOSERVER_EXT_DIR}/monitor/poi-ooxml-3.14.jar
ADD geoserver-exts/monitor/poi-ooxml-schemas-3.14.jar ${GEOSERVER_EXT_DIR}/monitor/poi-ooxml-schemas-3.14.jar
ADD geoserver-exts/monitor/wicket-datetime-7.6.0.jar ${GEOSERVER_EXT_DIR}/monitor/wicket-datetime-7.6.0.jar

# Enable CORS
RUN sed -i '\:</web-app>:i\
    <filter>\
        <filter-name>CorsFilter</filter-name>\
        <filter-class>org.apache.catalina.filters.CorsFilter</filter-class>\
    </filter>\
\
    <filter-mapping>\
        <filter-name>CorsFilter</filter-name>\
        <url-pattern>/*</url-pattern>\
    </filter-mapping>\
\
    <init-param>\
        <param-name>cors.support.credentials</param-name>\
        <param-value>true</param-value>\
    </init-param>' ${GEOSERVER_INSTALL_DIR}/WEB-INF/web.xml

# Tomcat environment
ENV CATALINA_OPTS "-Djava.awt.headless=true -server -Xms2G -Xmx4G -Xrs -XX:PerfDataSamplingInterval=500 \
 -Dorg.geotools.referencing.forceXY=true -XX:SoftRefLRUPolicyMSPerMB=36000 -XX:+UseParallelGC -XX:NewRatio=2 \
 -XX:+CMSClassUnloadingEnabled -DGEOSERVER_DATA_DIR=${GEOSERVER_DATA_DIR}"

ADD start.sh /usr/local/bin/start.sh
ENTRYPOINT ["/usr/local/bin/start.sh"]

EXPOSE 8080
