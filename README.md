docker-geoserver-lt
================

Dockerized GeoServer. This repository is a fork of [`oscarfonts`](https://github.com/oscarfonts/docker-geoserver).

The biggest change is the use of GeoServer 2.12.3, and the JAVA_OPTS.

```sh
# Tomcat environment
ENV CATALINA_OPTS "-Djava.awt.headless=true -server -Xms2G -Xmx4G -Xrs -XX:PerfDataSamplingInterval=500 \
 -Dorg.geotools.referencing.forceXY=true -XX:SoftRefLRUPolicyMSPerMB=36000 -XX:+UseParallelGC -XX:NewRatio=2 \
 -XX:+CMSClassUnloadingEnabled -DGEOSERVER_DATA_DIR=${GEOSERVER_DATA_DIR}"
```

## Features

* Built on top of [Docker's official tomcat image](https://hub.docker.com/_/tomcat/).
* Taken care of [JVM Options](http://docs.geoserver.org/latest/en/user/production/container.html), to avoid PermGen space issues &c.
* Separate GEOSERVER_DATA_DIR location (on /var/local/geoserver).
* [CORS ready](http://enable-cors.org/server_tomcat.html).
* Automatic installation of [Native JAI and Image IO](http://docs.geoserver.org/latest/en/user/production/java.html#install-native-jai-and-jai-image-i-o-extensions) for better performance.
* Configurable extensions.
* Automatic installation of [Microsoft Core Fonts](http://www.microsoft.com/typography/fonts/web.aspx) for better labelling compatibility.
* AWS configuration files and scripts in order to deploy easily using [Elastic Beanstalk](https://aws.amazon.com/documentation/elastic-beanstalk/). See [github repo](https://github.com/hguerra/docker-geoserver-lt/blob/master/aws/README.md). Thanks to @victorzinho


## Trusted builds

Active versions with [automated builds](https://hub.docker.com/r/heitorcarneiro/geoserver/) available on [docker registry](https://registry.hub.docker.com/):

* [`latest`, `2.13.0` (*2.13.0/Dockerfile*)](https://github.com/hguerra/docker-geoserver-lt/blob/master/2.13.0/Dockerfile)
* [`maintenance`, `2.12.3` (*2.12.3/Dockerfile*)](https://github.com/hguerra/docker-geoserver-lt/blob/master/2.12.3/Dockerfile)
* [`maintenance`, `2.12.2` (*2.12.2/Dockerfile*)](https://github.com/hguerra/docker-geoserver-lt/blob/master/2.12.2/Dockerfile)


Other experimental (not automated build):

* [`oracle`](https://github.com/hguerra/docker-geoserver-lt/blob/master/oracle/Dockerfile). Uses [wnameless/oracle-xe-11g](https://hub.docker.com/r/wnameless/oracle-xe-11g/), needs ojdbc7.jar and [setting up a database](https://github.com/hguerra/docker-geoserver-lt/blob/master/oracle/setup.sql). See [the run commands](https://github.com/hguerra/docker-geoserver-lt/blob/master/oracle/run.sh).

* [`h2-vector`](https://github.com/hguerra/docker-geoserver-lt/blob/master/h2-vector/Dockerfile). Plays nice with [hguerra/h2:geodb](https://hub.docker.com/r/hguerra/h2/tags/), and includes sample scripts for docker-compose and systemd.


## Running

Get the image:

```
docker pull heitorcarneiro/geoserver
```

Run as a service, exposing port 8080 and using a hosted GEOSERVER_DATA_DIR:

```
docker run -d -p 8080:8080 -v /path/to/local/data_dir:/var/local/geoserver --name=MyGeoServerInstance heitorcarneiro/geoserver
```

### Configure extensions

To add extensions to your GeoServer installation, provide a directory with the unzipped extensions separated by directories (one directory per extension):

```
docker run -d -p 8080:8080 -v /path/to/local/exts_dir:/var/local/geoserver-exts/ --name=MyGeoServerInstance heitorcarneiro/geoserver
```

You can use the `build_exts_dir.sh` script together with a [extensions](https://github.com/hguerra/docker-geoserver-lt/tree/master/extensions) configuration file to create your own extensions directory easily.

> **Warning**: The `.jar` files contained in the extensions directory will be copied to the `WEB-INF/lib` directory of the GeoServer installation. Make sure to include only `.jar` files from trusted extensions to avoid security risks.

### Configure path

It is also possible to configure the context path by providing a Catalina configuration directory:

```
docker run -d -p 8080:8080 -v /path/to/local/data_dir:/var/local/geoserver -v /path/to/local/conf_dir:/usr/local/tomcat/conf/Catalina/localhost --name=MyGeoServerInstance heitorcarneiro/geoserver
```

See some [examples](https://github.com/hguerra/docker-geoserver-lt/tree/master/2.9.1/conf).

### Logs

See the tomcat logs while running:

```
docker logs -f MyGeoServerInstance
```
