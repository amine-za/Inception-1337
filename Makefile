name = simple_nginx_html

all:
	mkdir -p ~/goinfre/mariadb
	mkdir -p ~/goinfre/wordpress
	chmod 777 ~/goinfre/mariadb ~/goinfre/wordpress
	@printf "Launch configuration ${name}...\n"
	docker-compose up --build

build:
	@printf "Building configuration ${name}...\n"
	@docker-compose up --build

down:
	@printf "Stopping configuration ${name}...\n"
	@docker-compose down
	docker rmi $$(docker images -aq)
	sudo rm -rf ~/goinfre/mariadb
	sudo rm -rf ~/goinfre/wordpress

re: fclean all

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