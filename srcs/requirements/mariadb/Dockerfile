FROM alpine:3.18

RUN	apk -i update && apk -i upgrade
RUN apk add mariadb \
	mariadb-client \
	curl \
	zsh \
	git \
	vim
COPY /conf/my.cnf /etc/my.cnf.d/
COPY	"./init_db.sh" .
RUN		chmod 0755 init_db.sh

ENTRYPOINT ["./init_db.sh"]