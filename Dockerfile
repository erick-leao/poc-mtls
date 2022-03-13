FROM httpd:latest

COPY ssl/ca_certs/ca.crt /root/client/ca.crt
COPY ssl/server_certs/server.crt /root/.ssh/server.crt
COPY ssl/server_certs/server.key /root/.ssh/server.key

RUN mkdir -p /usr/local/apache2/conf/sites-enabled \
    && mkdir -p /var/www/itaupix-sp.edp.com.br

EXPOSE 80 443

CMD ["httpd", "-D", "FOREGROUND"]