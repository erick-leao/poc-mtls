
# POC MTLS WITH APACHE version Container

This project is an implementation simple for creating the mutual authentication "mTLS"

## Install

#### 01 - generate structure into folder ssl

	./build-key.sh init

#### 02 - generate Certificate CA

	./build-key.sh ca

#### 03 - generate certificate for server

	./build-key.sh server

#### 04 - generate certificate for client

	./build-key.sh client

#### 05 - build the image

	docker build -t apache-mtls .  

#### 06 - run image

	docker run -it --rm --name apache-mtls -p 8080:443 \
	-v $(pwd)/apache/www:/var/www/html/itaupix-sp/public \
	-v $(pwd)/apache/conf/httpd.conf:/usr/local/apache2/conf/httpd.conf \
	-v $(pwd)/apache/conf/sites-enabled:/usr/local/apache2/conf/sites-enabled \
	apache-mtls

#### 07 - Postman Import/Configure
* Importar Request mTLS.postman_collection.json no Postman
* Configure the client.crt and client.key in File -> Settings -> Certificates 

@test! In port that has configured "8080". 

=)
