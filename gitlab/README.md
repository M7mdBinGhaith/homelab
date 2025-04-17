# GitLab with Traefik Docker Compose

## Goal
Deploy a GitLab CE instance accessible via Traefik.

## Requires
* Docker + Docker Compose
* An existing Traefik instance configured.
* Host directories for persistent GitLab data.
* DNS entry for `gitlab.local.domain.com` pointing to the host running Traefik.


## Action
* **MUST:** Ensure the host paths specified in the `volumes` section for the `gitlab` service (`/local/apps/gitlab/...`) exist on your Docker host and have correct permissions. Modify them if your paths are different.


## Run
```bash
# Navigate to the directory containing this docker-compose.yml
docker-compose up -d
```

## Notes
* This service is conflicting with nfs mounts and does not like the **user** specified in the compose file.
* Default ssh port for gitlab changed as it is conflicting with the open-ssh server.