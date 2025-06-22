# Packer Proxmox Templates
Packer configuration for creating VM templates in Proxmox.

## Overview
This configuration creates VM templates in Proxmox by:
- Automated installation using preseed, kickstart configuration
- Cloud-init support for VM customization on clone
- Qemu guest agent enabled 
- Template conversion for easy VM cloning

## Configuration
### Required Variables
* Proxmox API:
    * pm_api_url: Proxmox API URL (e.g., https://your-proxmox:8006/api2/json)
    * pm_api_token_id: API Token ID 
    * pm_api_token_secret: API Token Secret
    * storage_pool: Storage pool for VM disk and cloud-init
    * iso_file: Path to Template ISO in Proxmox (e.g., local:iso/debian-12.11.0-amd64-netinst.iso)
* VM Settings:
    * vm_name
    * vm_id
    * memory
    * cores
    * sockets
    * ssh_password
* Network & Storage:
    * network_bridge
    * vlan_tag
    * disk_size
    * disk_format

### ISO Requirements
- Match the ISO name defined in templates
- Upload ISO to proxmox


## Setup
1. Change Variables in [Common](./common/)
1. Navigate into the template Folder.
1. Edit *.auto.pkrvars.hcl with your environment values
2. Initialize and build:
```bash
# Proxmox Authentication 
export PKR_VAR_pm_api_token_id="packer@pam!packer"
export PKR_VAR_pm_api_token="Your-Secret-Key"
```
```bash
packer init .     # Initialize plugins
packer validate . # Validate configuration
packer build .    # Build template
```
 