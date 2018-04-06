.PHONY: clean logs stop up

-include .env
#export $(shell sed 's/=.*//' .env)

# Some fancy ansi/unicode variables
RED=\033[0;31m
RED_B=\033[0;31m\033[1m
NC=\033[0m # No Color
ERROR=[\xE2\x9C\x97]

# Initialize requirements.
# - check if .env file exists
# - create proxy network 
.init:
	@if [ ! -f .env ]; then \
		printf "$(RED_B) $(ERROR) Error: $(RED).env$(RED_B) file doesn't exists, start by copy the $(RED).env.dist$(RED_B) file into $(RED).env$(RED_B) and update with your configuration.$(NC)\n"; \
		exit 1; \
	fi;
	@if [ `docker network ls | grep -c -w $(NETWORK_NAME)` -eq 0 ]; then \
		docker network create $(NETWORK_NAME); \
	fi;

up: .init
	@docker-compose up -d

stop:
	@docker-compose stop

logs:
	@docker-compose logs -f

clean:
	@docker-compose down -v --rmi local
	@if [ `docker network ls | grep -c -w $(NETWORK_NAME)` -ne 0 ]; then \
		docker network rm $(NETWORK_NAME); \
	fi;