# ChangeDetection Docker Compose Setup

## Goal

Deploy ChangeDetection.io with Playwright Chrome for monitoring website changes.

## Requires

* Docker + Docker Compose
* Traefik reverse proxy for SSL

## Run

```bash
# In directory with docker-compose.yml
docker-compose up -d
```

## Access

The ChangeDetection.io interface will be available at:
`https://changedetection.local.domain.com`

## Services

* `changedetection`: Website change monitoring service
* `playwright-chrome`: Headless browser for rendering web pages

## Networks

* `proxy`: External Traefik network for SSL termination
* `internal`: Private network between services

## Notes
* Persistent data in `/nfs/apps/changedetection/datastore`
* Chrome includes ad blocking and stealth mode