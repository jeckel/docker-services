.PHONY: clean logs stop up

-include .env
#export $(shell sed 's/=.*//' .env)

# Some fancy ansi/unicode variables
RED=\e[0;31m
BOLD=\e[1m
ITALIC=\e[3m
CLEAN=\e[0m
ERROR=$(RED)$(BOLD)  \xE2\x9C\x97$(ITALIC) error$(CLEAN)

# Initialize requirements.
# - check if .env file exists
# - create proxy network 
.init:
	@if [ ! -f .env ]; then \
		printf "$(ERROR) The $(BOLD).env$(CLEAN) file doesn't exists, start by copy the $(BOLD).env.dist$(CLEAN) file into $(BOLD).env$(CLEAN) and update with your configuration.$(NC)\n"; \
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
	docker-compose -f wordpress.sample/docker-compose.yml down -v