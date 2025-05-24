# Karakeep (Previously **Hoarder**) Docker Compose

## Overview
Working Hoarder configuration behind Traefik with Chrome and Meilisearch integration.

## Prerequisites
* Docker + Docker Compose
* External network: `proxy`
* NFS mount for persistence
* DNS record for `hoarder.local.domain` pointing to host

## Configuration

### Files
* `compose.yaml`: Main configuration 
* `.env`: Environment file (required for API keys and version)

### Volumes
* Meilisearch data: Docker volume `meilisearch`
* Hoarder data: NFS mount
  - `/nfs/apps/hoarder`

### Network
* Internal `hoarder_net` network for service communication
* External `proxy` network for Traefik integration

## Traefik Integration
* Server exposed via Traefik on HTTPS
* Configured for automatic HTTP to HTTPS redirection
* Access at: `https://hoarder.local.domain`

## Deployment
```bash
docker compose up -d
```

## Notes
* Requires OpenAI API key in .env file
* Chrome instance configured with debugging port on 9222
* Meilisearch provides search functionality on port 7700