FROM	alpine:3.18
RUN		apk update 
RUN		apk -i add nginx
RUN		apk -i add vim && apk -i add curl
RUN		mkdir -p /etc/nginx/ssl
RUN		apk -i add openssl 
RUN		openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=CH/ST=Vaud/L=./CN=localhost"
RUN		mkdir -p /var/run/nginx
COPY	conf/nginx.conf /etc/nginx/nginx.conf
RUN		chmod 0755 /var/www/localhost/htdocs
CMD		["nginx", "-g", "daemon off;"]