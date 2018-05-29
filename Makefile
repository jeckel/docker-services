.PHONY: clean logs stop up radicale

-include .env

.init:
	@./init.sh

up: .init
	@docker-compose up -d

stop: .stop-deps .stop-main

logs:
	@docker-compose logs -f

radicale:
	@docker-compose -f docker-compose.radicale.yml up -d

clean: stop .clean-deps
	@docker-compose down -v --rmi local --remove-orphans
	@if [ `docker network ls | grep -c -w $(NETWORK_NAME)` -ne 0 ]; then \
		docker network rm $(NETWORK_NAME); \
	fi;
	@#docker-compose -f wordpress.sample/docker-compose.yml down -v

COMPOSE_FILE=$(shell find . -name 'docker-compose.*.yml' | sort)

.stop-main:
	@docker-compose stop

.stop-deps: $(COMPOSE_FILE)
	@docker-compose -f $< stop

.clean-deps: $(COMPOSE_FILE)
	docker-compose  -f $< down -v --rmi
