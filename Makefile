COMPOSE	=	-f srcs/docker-compose.yml
DOCK	=	docker compose $(COMPOSE)

##@ General
all:	build start    ## Build and start all services

##@ Services
build:	## Build all services
	$(DOCK) build

start:	## Start all services
	$(DOCK) up

clean: ##stop all services
	$(DOCK) down

prune: ##purge all services
	docker system prune -f -a --volumes

wp_exec:
	$(DOCK) exec -it wordpress sh

db_exec:
	$(DOCK) exec -it mariadb sh

serv_exec:
	$(DOCK) exec -it nginx sh