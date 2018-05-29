.PHONY: clean logs stop up down

-include .env

.init:
	@./init.sh

up: .init
	@docker-compose up -d

stop:
	@docker-compose stop

logs:
	@docker-compose logs -f

clean: stop
	@docker-compose down -v --rmi local --remove-orphans
	@if [ `docker network ls | grep -c -w $(NETWORK_NAME)` -ne 0 ]; then \
		docker network rm $(NETWORK_NAME); \
	fi;

down: clean
