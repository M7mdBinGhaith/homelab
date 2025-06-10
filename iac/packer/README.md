# Packer Proxmox Debian Template
Packer configuration for creating Debian 12 VM templates in Proxmox.

## Overview
This configuration creates a Debian 12 template in Proxmox by:
- Automated installation using preseed configuration
- Cloud-init support for VM customization on clone
- Qemu guest agent enabled 
- Template conversion for easy VM cloning

## Configuration
### Required Variables
* Proxmox API:
    * proxmox_api_url: Proxmox API URL (e.g., https://your-proxmox:8006/api2/json)
    * proxmox_api_token_id: API Token ID (e.g., packer@pam!packer)
    * proxmox_api_token_secret: API Token Secret
    * storage_pool: Storage pool for VM disk and cloud-init
    * iso_file: Path to Debian ISO in Proxmox (e.g., local:iso/debian-12.11.0-amd64-netinst.iso)
* VM Settings:
    * vm_name: Template name (default: debian12-template)
    * vm_id: Template VMID (default: 9400)
    * memory: RAM in MB (default: 2048)
    * cores: CPU cores (default: 2)
    * sockets: CPU sockets (default: 1)
    * ssh_password: SSH password for debian user
* Network & Storage:
    * network_bridge: Network bridge (default: vmbr0)
    * vlan_tag: VLAN tag (default: null for no VLAN)
    * disk_size: Disk size (default: 20G)
    * disk_format: Disk format (default: raw)

### ISO Requirements
- Debian 12 netinstall ISO must be uploaded to Proxmox storage
- ISO path format: storage:iso/filename.iso

## Setup
1. Copy example configuration:
```bash
cp packer.auto.pkrvars.hcl.example packer.auto.pkrvars.hcl
```
2. Edit packer.auto.pkrvars.hcl with your environment values
3. Initialize and build:
```bash
packer init .     # Initialize plugins
packer validate . # Validate configuration
packer build .    # Build template
```

## Template Features
The created template includes:
- Cloud-init ready for customization on clone
- Essential packages: `openssh-server vim curl wget git qemu-guest-agent cloud-init`