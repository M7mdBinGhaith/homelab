# Grafana Monitoring Stack

A Docker Compose configuration for Grafana and its associated monitoring services.

## Execution Context

This stack is managed via Docker Compose and includes the following services:

* **Source:** Configuration is stored in this repository and deployed via Docker Compose.
* **Services:**
  * **Grafana:** Visualization and analytics platform for metrics and logs.
  * **Prometheus:** Time-series database and monitoring system.
  * **InfluxDB:** High-performance time-series database for metrics storage.
  * **Loki:** Log aggregation system designed for storing and querying logs.
  * **Promtail:** Log collector that ships logs to Loki.
  * **Node Exporter:** Exports hardware and OS metrics for Prometheus.
  * **cAdvisor:** Container metrics exporter for resource usage and performance.
  * **Telegraf:** Plugin-driven server agent for collecting and reporting metrics.

## Configuration

The stack uses environment variables for configuration. A template file `.env.example` is provided with default values. Before deployment:

1. Copy `.env.example` to `.env`
2. Update the values in `.env` with your secure credentials

Required environment variables:

* **Grafana:**
  * `GRAFANA_ADMIN_USER` - Admin username (default: admin)
  * `GRAFANA_ADMIN_PASSWORD` - Admin password (default: admin)
  * `DOMAIN_GRAFANA` - Domain for Grafana access

* **InfluxDB:**
  * `INFLUXDB_ADMIN_USER` - Admin username (default: admin)
  * `INFLUXDB_ADMIN_PASSWORD` - Admin password (default: adminpassword)
  * `INFLUXDB_ORG` - Organization name (default: monitoring)
  * `INFLUXDB_BUCKET` - Bucket name (default: metrics)
  * `INFLUXDB_ADMIN_TOKEN` - Admin token (default: mytoken)

* **Docker:**
  * `DOCKER_GID` - Docker group ID for Telegraf service

## Service Configurations

> **Note:** These config files are supposed to be in the bindmount directory

Sample configurations for each service are provided in the `config/` directory:
* Prometheus scrape configurations
* InfluxDB setup scripts
* Loki and Promtail configurations
* Telegraf input/output plugins


## Requires
* Docker + Docker Compose
* Network: `proxy` (external) and `monitoring` (internal)