name = Inception
DockerComposePath = docker-compose.yml

all: help

help:
	@echo "Usage: make [target]"
	@echo "Targets:"
	@echo "  up       - Build and start the containers"
	@echo "  down     - Stop and remove the containers and volumes"
	@echo "  re       - Restart the containers"
	@echo "  stop     - Stop the containers"
	@echo "  status   - Show the status of the containers"
	@echo "  clean    - Remove containers and images"
	@echo "  fclean   - Remove all unused Docker data"

up:
	@mkdir -p $(PWD)/data/wordpress
	@mkdir -p $(PWD)/data/mariadb
	@docker compose -f $(DockerComposePath) up --build -d

down:
	@docker compose -f $(DockerComposePath) down -v 2>/dev/null || true

re: down up

stop:
	@docker compose -f $(DockerComposePath) stop

status:
	@docker compose ps --format "table {{.Name}}\t{{.Status}}\t{{.Ports}}"

clean:
	@docker compose -f $(DockerComposePath) down --rmi all

fclean: down
	@docker system prune --all --force
	@docker run --rm -v $(PWD)/data:/data alpine:3.16 sh -c "rm -rf /data/wordpress /data/mariadb" 2>/dev/null || true
