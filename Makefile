name = Inception

# /home/login/data
all:
	mkdir -m 777 -p /home/azaghlou/data/wordpress
	mkdir -m 777 -p  /home/azaghlou/data/mariadb
	@docker-compose up --build

# build:
# 	@printf "Building configuration ${name}...\n"
# 	@docker-compose up --build

down:
	@printf "Stopping configuration ${name}...\n"
	@docker-compose down
	@docker volume rm $$(docker volume ls -q)
	sudo rm -rf /home/azaghlou/data/wordpress /home/azaghlou/data/mariadb

re: down all

clean: down
	@printf "Cleaning configuration ${name}...\n"
	@docker system prune -a

stop:
	docker stop $$(docker ps -aq)

clean_cn:
	docker rm $$(docker ps -aq)
	
clean_im:
	docker rmi $$(docker images -aq)

fclean:
	@printf "Total clean of all configurations docker\n"
	docker stop $$(docker ps -aq)
	docker system prune --all --force

# @docker network prune --force
# @docker volume prune --force

.PHONY : all build down re clean fclean