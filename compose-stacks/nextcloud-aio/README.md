# Nextcloud AIO Docker Compose

## Overview
Working Nextcloud All-In-One (AIO) server configuration using Docker.

## Prerequisites
* Docker + Docker Compose
* External network: `nextcloud-aio`
* Storage mount for Nextcloud data at `/mnt/Mirrors/nextcloud-aio`

## Configuration

### Files
* `compose.yaml`: Main configuration 

### Volumes
* Nextcloud AIO master container data: Docker volume `nextcloud_aio_mastercontainer`
* Nextcloud data: Host mount
  - `/mnt/Mirrors/nextcloud-aio/data`
  - `/mnt/Mirrors/nextcloud-aio`

### Network
Uses external `nextcloud-aio` network

## Containers
* `nextcloud-aio-mastercontainer`: Initial container that orchestrates the deployment
* Additional containers automatically created by the mastercontainer:
  - Nextcloud application
  - Database (MariaDB/PostgreSQL)
  - Redis cache
  - Collabora Office/OnlyOffice
  - Talk (video conferencing)
  - Backup solution

## Network Integration
* Server exposed directly on port 8080
* Apache runs on port 11000 for the nextcloud application 
* Access the master container at: `http://your-server-ip:8080`

## Deployment
```bash
docker compose up -d
```

## Notes
* Memory limit set to 4096MB
* Uses the official Nextcloud All-in-One image
* Container auto-restarts on failure