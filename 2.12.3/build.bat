docker build -t heitorcarneiro/geoserver:2.12.3 .
docker run --name "geoserver" --link "sema_ba_min:postgis" --network proxy -p "8080:8080" -v "D:/Projetos/074_2017_sema_ba/digitalocean/geoserver-data/GEOSERVER_DATA_DIR:/var/local/geoserver" -d -t heitorcarneiro/geoserver:2.12.3
docker logs -f geoserver