[![Twitter](https://img.shields.io/badge/Twitter-%40jeckel4-blue.svg)](https://twitter.com/jeckel4) [![LinkedIn](https://img.shields.io/badge/LinkedIn-Julien%20Mercier-blue.svg)](https://www.linkedin.com/in/jeckel/)

# Docker Services
Some usefull services to manage a server running only container, mostly for developpement purpose

- [Traefik](https://traefik.io/): A powerful reverse proxy
- [Portainer](https://portainer.io/): A powerful container management tool
- [Syncthing](https://syncthing.net/): Cloud synchronisation (used mainly for backuping)
- [Radicale](https://radicale.org/): A Free and Open-Source CalDAV and CardDAV Server

## Installation

This is simple, just :
- git clone the repository
- copy the `.env.dist` file into `.env`
- edit the `.env` file with your own requirements
- and start it with `make up`

## How it works

This configuration create a global docker network on which you will connect all container that needs to be accessible through your reverse proxy.

See the [Traefik Documentation](https://docs.traefik.io/) on how to configure you container.

By default, `portainer` and `traefik` will be accessible throught the `.local` domain like `portainer.local` and `traefik.local`. You can change it with the `SERVICES_DOMAIN` variable in the `.env` file.

## The wordpress sample

To test the wordpress sample, from the project root, launch:

```bash
$> docker-compose -f wordpress.sample/docker-compose.yml -d
```

Like this, it will use the same `.env` file as the main configuration.

You will then be able to access wordpress at http://wordpress.local


# Environment variables

List of environment variable defined in the .env file

## NETWORK CONFIGURATION
### Traefik Network Name

Unique global network name that will be used by the reverse proxy.
All services which needs to be exposed through the Traefik should join this network.
> `NETWORK_NAME=traefik_proxy`

### Services global host name

Host name shared by the main services

> `SERVICES_DOMAIN=services.local`

### Main domain
Global hostname extension used for other services.

This mean that a service 'radicale' will be accessible at 'radicale.${MAIN_DOMAIN}'

> `MAIN_DOMAIN=local`

## BACKUP AND SYNCHRONISATION

### Syncthing shared volume Name

This volume is shared to other services which require data to be synchronised / backuped on a remote host

> `SYNCTHING_VOLUME_NAME=syncthing_data`
