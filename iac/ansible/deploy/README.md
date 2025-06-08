# Deploy

This directory contains playbooks for deploying complete solutions and services.

# Playbooks

### pelican-node-setup.yml

#### Requirements:
- Pelican Panel already setup ansible scripts exists in install folder.
- Generate an API key with sufficient permissions.
- Ansible & SSH (Ofcourse) 
- Common tasks available: `../common/system-update.yml` and `../common/install-docker.yml`


### Features:
- Creates a node via pelican API
- Retrieves Wings authentication token
- Checks for existing Wings configuration (safety feature)
- Installs Wings daemon on target server
- Configures Wings to connect to Panel
- Starts Wings service

Creates a new Pelican Panel node and installs Wings daemon on target server.

#### Usage

```bash
ansible-playbook deploy/pelican-node-setup.yml \
  -e "pelican_url=http://10.30.30.122" \
  -e "pelican_api_key=peli_YOUR_API_KEY" \
  -e "node_name=GameServer01" \
  -e "node_fqdn=10.30.30.123" \
  -e "node_memory=8192" \
  -e "node_disk=50000" \
  -e "wings_target_host=10.30.30.123" \
  --ask-become-pass
```

#### Required Variables

- `pelican_url` - Panel server URL
- `pelican_api_key` - API key from Panel admin (starts with `peli_`)
- `node_name` - Display name for the node
- `node_fqdn` - Game server IP/domain
- `node_memory` - Memory allocation in MB
- `node_disk` - Disk allocation in MB

#### Optional Variables

- `wings_target_host` - Target server for Wings (defaults to `node_fqdn`)
- `wings_ansible_user` - SSH user (defaults to `debian`)
- `node_scheme` - `http` or `https` (defaults to `http`)
- `node_cpu` - CPU allocation (defaults to `0`)
- `node_location_id` - Panel location ID (defaults to `1`)
- `wings_force_reconfigure` - **Override existing Wings config (defaults to `false`)**

#### Safety Features

**Configuration Protection:** The playbook automatically detects existing Wings configurations and prevents accidental overwrites.

**First time installation:**
```bash
ansible-playbook deploy/pelican-node-setup.yml \
  -e "pelican_url=http://10.30.30.122" \
  -e "pelican_api_key=peli_YOUR_API_KEY" \
  -e "node_name=GameServer01" \
  -e "node_fqdn=10.30.30.123" \
  -e "node_memory=8192" \
  -e "node_disk=50000" \
  -e "wings_target_host=10.30.30.123"
```

**Reconfigure existing Wings installation with wings_force_reconfigure=true:**
```bash
ansible-playbook deploy/pelican-node-setup.yml \
  -e "pelican_url=http://10.30.30.122" \
  -e "pelican_api_key=peli_YOUR_API_KEY" \
  -e "node_name=GameServer01" \
  -e "node_fqdn=10.30.30.123" \
  -e "node_memory=8192" \
  -e "node_disk=50000" \
  -e "wings_target_host=10.30.30.123" \
  -e "wings_force_reconfigure=true"
```

**If Wings configuration exists and `wings_force_reconfigure=true` is not set**, the playbook will fail with instructions.


#### Multiple Servers

**New installations:**
```bash
for host in 10.30.30.123 10.30.30.124 10.30.30.125; do
  ansible-playbook deploy/pelican-node-setup.yml \
    -e "pelican_url=http://10.30.30.122" \
    -e "pelican_api_key=peli_YOUR_API_KEY" \
    -e "node_name=GameServer-${host##*.}" \
    -e "node_fqdn=${host}" \
    -e "node_memory=8192" \
    -e "node_disk=50000" \
    -e "wings_target_host=${host}"
done
```

**Reconfigure existing installations with wings_force_reconfigure=true:**
```bash
for host in 10.30.30.123 10.30.30.124 10.30.30.125; do
  ansible-playbook deploy/pelican-node-setup.yml \
    -e "pelican_url=http://10.30.30.122" \
    -e "pelican_api_key=peli_YOUR_API_KEY" \
    -e "node_name=GameServer-${host##*.}" \
    -e "node_fqdn=${host}" \
    -e "node_memory=8192" \
    -e "node_disk=50000" \
    -e "wings_target_host=${host}" \
    -e "wings_force_reconfigure=true"
done
```

#### Output

```
Node created successfully
Name: GameServer01
ID: 2
FQDN: 10.30.30.123
Wings Token: H2ef0OHINj51NkFvQ5Xjw7o7.......

Wings installation completed
Panel: http://10.30.30.122
Node ID: 2
Status: active
```
---

## TODO 
-  Move documentation to documentation website
-  Make node name optional and add a name generator  
-  Implement some kind of iterator for deploying wings with FQDN e.g(node-01.domain.com)