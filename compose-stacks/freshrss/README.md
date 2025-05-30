# FreshRSS Docker Compose

## Overview
Working FreshRSS configuration behind Traefik.

## Prerequisites
* Docker + Docker Compose
* External network: `proxy`
* DNS record for `freshrss.local.domain.com` pointing to host

## Configuration

### Files
* `compose.yaml`: Main configuration

### Volumes
* FreshRSS data: (NFS mount)
  - `/nfs/apps/freshrss/config`

### Network
Uses external `proxy` network for Traefik integration

## Traefik Integration
* Server exposed via Traefik on HTTPS
* Configured for automatic SSL/TLS through Traefik
* Access at: `https://freshrss.local.domain.com`

## Deployment
```bash
docker compose up -d
```

## Notes
* This is a tested, working configuration serving as reference