docker build -t heitorcarneiro/geoserver:2.15.2 .

docker run --name "geoserver1" --link "sema_ba_min:postgis" --network proxy -p "8081:8080" -v "D:/Projetos/074_2017_sema_ba/digitalocean/geoserver-data:/var/local/geoserver" -v "D:/Projetos/074_2017_sema_ba/digitalocean/geoserver-logs:/usr/local/tomcat/logs" -e CATALINA_OPTS="-Djava.awt.headless=true -server -Xms512M -Xmx512M -DGEOSERVER_DATA_DIR=${GEOSERVER_DATA_DIR}" -d geoserver:2.15.2-java11-hotspot
docker run --name "geoserver2" --link "sema_ba_min:postgis" --network proxy -p "8082:8080" -v "D:/Projetos/074_2017_sema_ba/digitalocean/geoserver-data:/var/local/geoserver" -e CATALINA_OPTS="-Djava.awt.headless=true -server -Xms512M -Xmx512M -DGEOSERVER_DATA_DIR=${GEOSERVER_DATA_DIR}" -d geoserver:2.15.2-java11-hotspot

docker logs -f geoserver1


cd ..
sudo chmod 777 -R 2.15.2/
cd 2.15.2/

docker build -f java11-hotspot.dockerfile -t heitorcarneiro/geoserver:2.15.2-java11-hotspot .
docker run -it --rm --name geoserver -p 8080:8080 heitorcarneiro/geoserver:2.15.2-java11-hotspot
