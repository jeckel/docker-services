.PHONY: up logs stop clean down

include .env

up:
	@docker-compose up -d

logs:
	@docker-compose log -f

stop:
	@docker-compose stop

clean:
	@docker-compose down -v --rmi local --remove-orphans

down: clean
