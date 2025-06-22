# Media Management Stack with Traefik

## Goal

Deploy Servarr stack behind Traefik.

## What's in the Stack ?

- **Services**:
    - **Radarr**
    - **Sonarr**
    - **Prowlarr**
    - **Bazzarr**
    - **Overseerr**
    - **Sabnzbd**

## Requires

* Docker + Docker Compose
* Configured Traefik instance (with necessary middleware definitions if used)
* Host directories for config & media data directory.
* DNS entries for the defined domains in the `compose.yaml`.
* `.env` file defining `PUID`, `PGID`, `TZ` for proper permissions and timezone setting.

## Action
*  Edit Traefik labels as required.
*  Rename the env file and edit the values.
*  Ensure host path exists and permissions match the UID.

## Run

```bash
# In directory with docker-compose.yml and .env
docker-compose up -d
```

## Notes
* Expose Services Using Traefik.
* Use Authentik for SSO.
* Watchtower enabled for automatic updates.
