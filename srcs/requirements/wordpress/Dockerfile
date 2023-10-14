FROM	debian:buster
RUN		apt-get update && apt-get upgrade
RUN		apt-get -y install wget
RUN 	apt-get install -y php\
							php-fpm\
							php-mysql\
							mariadb-client
RUN 	wget https://fr.wordpress.org/wordpress-6.3-fr_FR.tar.gz -P /var/www
RUN 	cd /var/www && tar -xzf wordpress-6.3-fr_FR.tar.gz && rm wordpress-6.3-fr_FR.tar.gz
RUN		chown -R root:root /var/www/wordpress
COPY	conf/www.conf /etc/php/7.3/fpm/pool.d
RUN 	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN 	chmod +x wp-cli.phar
RUN 	mv wp-cli.phar /usr/local/bin/wp
COPY 	auto_config.sh /auto_config.sh
RUN		chmod +x /auto_config.sh
ENTRYPOINT 	["./auto_config.sh"]