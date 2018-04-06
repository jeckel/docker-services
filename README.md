[![Twitter](https://img.shields.io/badge/Twitter-%40jeckel4-blue.svg)](https://twitter.com/jeckel4) [![LinkedIn](https://img.shields.io/badge/LinkedIn-Julien%20Mercier-blue.svg)](https://www.linkedin.com/in/jeckel/)

# Docker Services
Some usefull services to manage a server running only container, mostly for developpement purpose

- [Traefik](https://traefik.io/): A powerful reverse proxy
- [Portainer](https://portainer.io/): A powerful container management tool

## Installation

This is simple, just :
- git clone the repository
- copy the `.env.dist` file into `.env``
- edit the `.env` file with your own requirements
- and start it with `make up`

## How it works

This configuration create a global docker network on which you will connect all container that needs to be accessible through your reverse proxy.

See the [Traefik Documentation](https://docs.traefik.io/) on how to configure you container.

By default, `portainer` and `traefik` will be accessible throught the `.local` domain like `portainer.local` and `traefik.local`. You can change it with the `SERVICES_DOMAIN` variable in the `.env` file.