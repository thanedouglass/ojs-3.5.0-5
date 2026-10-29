.PHONY: all up down restart logs health clean init-theme

all: up

# Spin up containers and verify health in <60 seconds
up:
	@chmod +x spinup.sh
	@./spinup.sh

# Stop containers
down:
	docker compose down

# Restart stack
restart: down up

# Tail container logs
logs:
	docker compose logs -f

# Run immediate HTTP healthcheck
health:
	@curl -s -I http://localhost:888/ | head -n 5

# Reset database & file volumes (caution: destructive)
clean:
	docker compose down -v
