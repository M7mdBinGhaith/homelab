# *Arr Stack with Traefik Docker Compose

## Goal

Deploy Sonarr, Radarr, Prowlarr, and Bazarr behind Traefik.

## Requires

* Docker + Docker Compose
* Configured Traefik instance (with necessary middleware definitions if used)
* Host directories for config & media data directory.
* DNS entries for the defined domains in the `compose.yaml`.
* `.env` file defining `PUID`, `PGID`, `TZ` for proper permissions and timezone setting.

## Action

* **MUST:** Rename the env file and edit the values.
* **MUST:** Ensure host volume paths exist & have correct permissions.

## Run

```bash
# In directory with docker-compose.yml and .env
docker-compose up -d
```

## Notes

* Deploys Sonarr, Radarr, Prowlarr, and Bazarr.
* Exposed via Traefik HTTPS at respective hostnames.
* Uses **Authentik** for auth by default.
* Watchtower enabled for automatic updates.
