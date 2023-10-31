FROM	debian:buster
RUN		apt-get update
RUN		apt-get -y install wget
RUN 	apt-get install -y php\
							php-fpm\
							php-mysql\
							curl \
							zsh \
							vim \
							mariadb-client

COPY	conf/www.conf /etc/php/7.3/fpm/pool.d
RUN 	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN 	chmod +x wp-cli.phar && \
	 	mv wp-cli.phar /usr/local/bin/wp
COPY 	auto_config.sh /auto_config.sh

RUN		chmod +x /auto_config.sh && \
		mkdir -p /var/www/html /var/log/php && \
		touch /var/log/php7.3-fpm.log && \
    	chown -R www-data:www-data /var/www/html && \
    	chmod 755 /var/log/php && \
    	chmod 644 /var/log/php7.3-fpm.log
		
RUN		mkdir -p /run/php

ENTRYPOINT 	["./auto_config.sh"]
