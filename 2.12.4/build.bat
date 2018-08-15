docker build -t heitorcarneiro/geoserver:2.12.4 .

docker run --name "geoserver1" --link "sema_ba_min:postgis" --network proxy -p "8081:8080" -v "D:/Projetos/074_2017_sema_ba/digitalocean/geoserver-data:/var/local/geoserver" -v "D:/Projetos/074_2017_sema_ba/digitalocean/geoserver-logs:/usr/local/tomcat/logs" -e CATALINA_OPTS="-Djava.awt.headless=true -server -Xms512M -Xmx512M -DGEOSERVER_DATA_DIR=${GEOSERVER_DATA_DIR}" -d heitorcarneiro/geoserver:2.12.4
docker run --name "geoserver2" --link "sema_ba_min:postgis" --network proxy -p "8082:8080" -v "D:/Projetos/074_2017_sema_ba/digitalocean/geoserver-data:/var/local/geoserver" -e CATALINA_OPTS="-Djava.awt.headless=true -server -Xms512M -Xmx512M -DGEOSERVER_DATA_DIR=${GEOSERVER_DATA_DIR}" -d heitorcarneiro/geoserver:2.12.4

docker logs -f geoserver1
