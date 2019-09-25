docker-geoserver
================

Dockerized GeoServer with extensions: Charts, Control Flow, CSS, MongoDB, Monitor, Query Layer, Vector Tiles, Authkey, GWC-S3, JDBC-Metrics, JDBCConfig, JDBCStore, Importer and Importer BDB. 

The biggest change is the use of GeoServer 2.15.2, and the **JAVA_OPTS**.

### Versions

**heitorcarneiro/geoserver:2.15.2.2-java11-hotspot**
```sh
# Tomcat environment
ENV GEOSERVER_OPTS "-server -Djava.awt.headless=true \
 -Xms128M -Xmx756M \
 -XX:SoftRefLRUPolicyMSPerMB=36000 -XX:+UseParallelGC \
 -XX:PerfDataSamplingInterval=500 -XX:NewRatio=2 \
 -XX:-UseContainerSupport -XX:InitialRAMPercentage=50 -XX:MaxRAMPercentage=70 \
 -Dorg.geotools.referencing.forceXY=true -Dfile.encoding=UTF8 -Duser.timezone=GMT -Djavax.servlet.request.encoding=UTF-8 -Djavax.servlet.response.encoding=UTF-8 -Duser.timezone=GMT -Dorg.geotools.shapefile.datetime=true \
 -DGEOSERVER_DATA_DIR=${GEOSERVER_DATA_DIR}"
```


**heitorcarneiro/geoserver:2.15.2.2-java11-hotspot-readonly**
```sh
# Tomcat environment
ENV GEOSERVER_OPTS "-server -Djava.awt.headless=true \
 -Xms128M -Xmx756M -DGEOSERVER_CONSOLE_DISABLED=true \
 -XX:SoftRefLRUPolicyMSPerMB=36000 -XX:+UseParallelGC \
 -XX:PerfDataSamplingInterval=500 -XX:NewRatio=2 \
 -XX:-UseContainerSupport -XX:InitialRAMPercentage=50 -XX:MaxRAMPercentage=70 \
 -Dorg.geotools.referencing.forceXY=true -Dfile.encoding=UTF8 -Duser.timezone=GMT -Djavax.servlet.request.encoding=UTF-8 -Djavax.servlet.response.encoding=UTF-8 -Duser.timezone=GMT -Dorg.geotools.shapefile.datetime=true \
 -DGEOSERVER_DATA_DIR=${GEOSERVER_DATA_DIR}"
```


**heitorcarneiro/geoserver:2.15.2.2-java11-hotspot-master**
```sh
# Tomcat environment
ENV GEOSERVER_OPTS "-server -Djava.awt.headless=true \
 -Xms768M -Xmx2048M \
 -XX:SoftRefLRUPolicyMSPerMB=36000 -XX:+UseParallelGC \
 -XX:PerfDataSamplingInterval=500 -XX:NewRatio=2 \
 -XX:-UseContainerSupport -XX:InitialRAMPercentage=50 -XX:MaxRAMPercentage=70 \
 -Dorg.geotools.referencing.forceXY=true -Dfile.encoding=UTF8 -Duser.timezone=GMT -Djavax.servlet.request.encoding=UTF-8 -Djavax.servlet.response.encoding=UTF-8 -Duser.timezone=GMT -Dorg.geotools.shapefile.datetime=true \
 -DGEOSERVER_DATA_DIR=${GEOSERVER_DATA_DIR}"
```


**heitorcarneiro/geoserver:2.15.2.2-java11-hotspot-slave**
```sh
# Tomcat environment
ENV GEOSERVER_OPTS "-server -Djava.awt.headless=true \
 -Xms2G -Xmx3G -DGEOSERVER_CONSOLE_DISABLED=true \
 -XX:SoftRefLRUPolicyMSPerMB=36000 -XX:+UseParallelGC \
 -XX:PerfDataSamplingInterval=500 -XX:NewRatio=2 \
 -XX:-UseContainerSupport -XX:InitialRAMPercentage=50 -XX:MaxRAMPercentage=70 \
 -Dorg.geotools.referencing.forceXY=true -Dfile.encoding=UTF8 -Duser.timezone=GMT -Djavax.servlet.request.encoding=UTF-8 -Djavax.servlet.response.encoding=UTF-8 -Duser.timezone=GMT -Dorg.geotools.shapefile.datetime=true \
 -DGEOSERVER_DATA_DIR=${GEOSERVER_DATA_DIR}"
```



## Features

* Built on top of [Docker's official tomcat image](https://hub.docker.com/_/tomcat/).
* Taken care of [JVM Options](http://docs.geoserver.org/latest/en/user/production/container.html), to avoid PermGen space issues &c.
* Separate GEOSERVER_DATA_DIR location (on /var/local/geoserver).
* [CORS ready](http://enable-cors.org/server_tomcat.html).
* Automatic installation of [Native JAI and Image IO](http://docs.geoserver.org/latest/en/user/production/java.html#install-native-jai-and-jai-image-i-o-extensions) for better performance.
* Configurable extensions.
* Automatic installation of [Microsoft Core Fonts](http://www.microsoft.com/typography/fonts/web.aspx) for better labelling compatibility.
* AWS configuration files and scripts in order to deploy easily using [Elastic Beanstalk](https://aws.amazon.com/documentation/elastic-beanstalk/). See [github repo](https://github.com/hguerra/docker-geoserver/blob/master/aws/README.md). 
* Extension [Authkey](https://repo.boundlessgeo.com/main/org/geoserver/community/gs-authkey/2.15.2/) installed by default.
* Extension [Control Flow](http://sourceforge.net/projects/geoserver/files/GeoServer/2.15.2/extensions/geoserver-2.15.2-control-flow-plugin.zip) installed by default.
* Extension [Monitor](http://sourceforge.net/projects/geoserver/files/GeoServer/2.15.2/extensions/geoserver-2.15.2-monitor-plugin.zip) installed by default.


## Trusted builds

Active versions with [automated builds](https://hub.docker.com/r/heitorcarneiro/geoserver/) available on [docker registry](https://registry.hub.docker.com/):

* [`maintenance`, `2.15.2` (*2.15.2/java11-hotspot.dockerfile*)](https://github.com/hguerra/docker-geoserver/blob/master/2.15.2/java11-hotspot.dockerfile)

Other experimental (not automated build):

* [`oracle`](https://github.com/hguerra/docker-geoserver/blob/master/oracle/java11-hotspot.dockerfile). Uses [wnameless/oracle-xe-11g](https://hub.docker.com/r/wnameless/oracle-xe-11g/), needs ojdbc7.jar and [setting up a database](https://github.com/hguerra/docker-geoserver/blob/master/oracle/setup.sql). See [the run commands](https://github.com/hguerra/docker-geoserver/blob/master/oracle/run.sh).

* [`h2-vector`](https://github.com/hguerra/docker-geoserver/blob/master/h2-vector/java11-hotspot.dockerfile). Plays nice with [hguerra/h2:geodb](https://hub.docker.com/r/hguerra/h2/tags/), and includes sample scripts for docker-compose and systemd.


## Running

Get the image:

```
docker pull heitorcarneiro/geoserver
```

Run as a service, exposing port 8080 and using a hosted GEOSERVER_DATA_DIR:

```
docker run -d -p 8080:8080 -v /path/to/local/data_dir:/var/local/geoserver --name=MyGeoServerInstance heitorcarneiro/geoserver
```


#### Using `docker-compose`:

```yml
version: "3"

services:
  db:
    image: mdillon/postgis:11
    restart: always
    environment:
      - POSTGRES_USER=geoserver
      - POSTGRES_PASSWORD=geoserver
    ports:
      - "5432:5432"
    volumes:
      - "$PWD/postgres-data:/var/lib/postgresql/data"
      - "$PWD/postgres-backup:/var/lib/postgresql/backup"

  geoserver:
    image: heitorcarneiro/geoserver:2.15.2.2-java11-hotspot
    restart: always
    environment:
      - CATALINA_OPTS="-Djava.awt.headless=true -server -Xms512M -Xmx512M -DGEOSERVER_DATA_DIR=/var/local/geoserver"
    ports:
      - "8080:8080"
    volumes:
      - "$PWD/geoserver-data:/var/local/geoserver"
      - "$PWD/geoservermaster-logs:/usr/local/tomcat/logs"
    links:
      - "db:postgis"
    depends_on:
      - "db"
```

`mkdir postgres-data && mkdir postgres-backup && mkdir geoserver-data && mkdir geoservermaster-logs`

`docker-compose up`


### Customize JAVA_OPTS

```
docker run --name "geoserver" --link "mydb:postgis" --network proxy -p "8080:8080" -v "$PWD/geoserver-data:/var/local/geoserver" -e CATALINA_OPTS="-Djava.awt.headless=true -server -Xms512M -Xmx512M -DGEOSERVER_DATA_DIR=${GEOSERVER_DATA_DIR}" -d geoserver:2.15.2-java11-hotspot
```


### Configure your own extensions

To add extensions to your GeoServer installation, provide a directory with the unzipped extensions separated by directories (one directory per extension):

```
docker run -d -p 8080:8080 -v /path/to/local/exts_dir:/var/local/geoserver-exts/ --name=MyGeoServerInstance heitorcarneiro/geoserver
```

You can use the `build_exts_dir.sh` script together with a [extensions](https://github.com/hguerra/docker-geoserver/tree/master/extensions) configuration file to create your own extensions directory easily.

> **Warning**: The `.jar` files contained in the extensions directory will be copied to the `WEB-INF/lib` directory of the GeoServer installation. Make sure to include only `.jar` files from trusted extensions to avoid security risks.


### Configure path

It is also possible to configure the context path by providing a Catalina configuration directory:

```
docker run -d -p 8080:8080 -v /path/to/local/data_dir:/var/local/geoserver -v /path/to/local/conf_dir:/usr/local/tomcat/conf/Catalina/localhost --name=MyGeoServerInstance heitorcarneiro/geoserver
```

See some [examples](https://github.com/hguerra/docker-geoserver/tree/master/2.15.2/conf).


### Logs

See the tomcat logs while running:

```
docker logs -f MyGeoServerInstance
```
