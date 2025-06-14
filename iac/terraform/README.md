# Terraform Proxmox VM Configuration

Terraform configuration for creating Proxmox VMs using the **BPG Proxmox provider** Utilizing self-managed gitlab state management.

## Overview

This configuration creates multiple Proxmox VMs by cloning from a template **built with packer**. Each VM includes:
- Cloud init configuration with SSH key access
- Configurable CPU, memory, and disk resources
- Network configuration with VLAN tag
- Qemu guest agent enabled


## Configuration

### Required Variables

* **Proxmox API:**
    * `pm_api_url`: Proxmox API URL (e.g., `https://your-proxmox:8006/api2/json`)
    * `pm_api_token_id`: API Token ID (e.g., `terraform-user@pve!my-token`)
    * `pm_api_token`: API Token Secret
    * `pm_tls_insecure`: Allow insecure TLS connections

* **VM Settings:**
    * `num_vms`: Number of VMs to create
    * `start_vmid`: Starting VMID (VMs get sequential IDs)
    * `vm_name_prefix`: VM name prefix (final name: `{prefix}-{vmid}`)
    * `vm_node`: Target Proxmox node
    * `vm_template`: Template VMID to clone
    * `vm_memory`: RAM in MB
    * `vm_cores`: CPU cores 
    * `vm_sockets`: Number of CPU sockets
    * `vm_ssh_keys`: Public SSH key for the user specified 

* **Storage & Network:**
    * `vm_disk_storage`: Storage identifier (e.g., `local-lvm`)
    * `vm_disk_size_gb`: Disk size in GB (e.g., `20`)
    * `vm_network_model`: Network card model (`virtio`)
    * `vm_network_bridge`: Network bridge (e.g., `vmbr0`)
    * `vm_network_vlan_tag`: VLAN tag (set to `null` if no VLAN is used)

### Template Requirements
Built with packer with all these requirements met check [packer](../packer)

## Setup
- Edit `terraform.tfvars` with required values
- Export Required environment variables
- Edit the `main.tf` with (backend url, project id, state name)

```bash
# Gitlab Authentication (state backend)
export TF_HTTP_USERNAME="your-gitlab-username"
export TF_HTTP_PASSWORD="your-gitlab-token"
# Proxmox Authentication 
export TF_VAR_pm_api_token_id="terraform@pam!terraform"
export TF_VAR_pm_api_token="Your-Secret-Key"
```


```bash
terraform init    # Initialize 
terraform plan    # Review planned changes
terraform apply   # Create/update VMs
```

## Cloud-Init User

The configuration creates a user account with:
- Username: `debian` (configurable in `main.tf`)
- SSH key authentication only (no password login)
- Sudo access enabled
