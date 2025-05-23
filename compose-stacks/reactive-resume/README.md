# Reactive Resume Docker Compose

## Overview
Working Reactive Resume configuration behind Traefik with PostgreSQL database and Chrome PDF generation.

## Prerequisites
* Docker + Docker Compose
* External network: `proxy`
* DNS record for `reactive-resume.local.domain.com` pointing to host
* External MinIO instance (TrueNAS or standalone)

## Configuration

### Files
* `compose.yaml`: Main configuration
* `.env.example`: Example environment file (rename to `.env` and update with your values)

### Generate Secrets
```bash
# Generate secure tokens (run these commands)
openssl rand -hex 32  # For ACCESS_TOKEN_SECRET
openssl rand -hex 32  # For REFRESH_TOKEN_SECRET  
openssl rand -hex 16  # For CHROME_TOKEN
```

### Volumes
* PostgreSQL data: Docker volume `reactive_resume_db_data`

### Network
* External `proxy` network for Traefik integration
* Internal `reactive-resume-internal` network for service communication

## Traefik Integration
* App exposed via Traefik on HTTPS
* Configured for automatic SSL/TLS through Traefik
* Access at: `https://reactive-resume.local.domain.com`

## Deployment
```bash
docker compose up -d
```

## Notes
* Healthchecks configured for database service
* Chrome service provides PDF generation capabilities
* Uses **external** MinIO for file storage (not included in stack)
* Requires SMTP configuration for email functionality
* This is a tested, working configuration serving as reference