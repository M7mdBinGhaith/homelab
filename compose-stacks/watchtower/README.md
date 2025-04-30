# Watchtower compose file.
## Goal

Deploy Watchtower for automatic updates.

## Requires

* Docker + Docker Compose
* Access to docker sock for automatic label detection.

## Action

* **MUST:** Rename the env file and edit the gotify token value.

## Run

```bash
# In directory with docker-compose.yml and .env
docker-compose up -d
```