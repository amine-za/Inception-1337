name = Inception
DockerComposePath = srcs/docker-compose.yml

all: sudo
	mkdir -m 777 -p /home/azaghlou/data/wordpress 
	mkdir -m 777 -p /home/azaghlou/data/mariadb
	@docker-compose -f $(DockerComposePath) up --build -d

sudo : 
	@sudo -v

down: sudo
	@if [ -z $$(docker network ls -qf "name=srcs_my_network") ]; then \
		docker-compose -f $(DockerComposePath) down; \
	else \
		echo "no network"; \
	fi
	@if [ -z $$(docker volume ls -q) ]; then \
		docker volume rm $$(docker volume ls -q); \
	else \
		echo "no volume in there !"; \
	fi
	@sudo rm -rf /home/azaghlou/data




re: down all

stop: sudo 
	@docker-compose -f $(DockerComposePath) stop

clean: sudo
	@docker-compose -f $(DockerComposePath) down --rmi all

fclean: sudo
	@if ! [ -z $(shell docker ps -aq)]; \
		then @printf "Total clean of all configurations docker\n"; \
	 	docker stop $(shell docker ps -aq); \
		sudo rm -rf /home/azaghlou/data \
	else \
		echo "nothing to be cleaned !"; \
	fi
	@docker system prune --all --force
