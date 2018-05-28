.PHONY: clean logs stop up

-include .env

.init:
	@./init.sh

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
	@#docker-compose -f wordpress.sample/docker-compose.yml down -v