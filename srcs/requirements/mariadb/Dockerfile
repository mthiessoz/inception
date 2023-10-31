FROM alpine:3.18

RUN	apk -i update && apk -i upgrade
RUN apk add mariadb \
	mariadb-client \
	openrc \
	curl \
	zsh \
	git \
	vim \
	busybox-extras
COPY /conf/my.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY	"./init_db.sh" .
RUN		chmod 0755 init_db.sh

ENTRYPOINT ["sh", "./init_db.sh"]