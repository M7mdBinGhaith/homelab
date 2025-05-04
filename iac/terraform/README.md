# Terraform Proxmox VM Configuration

Terraform configuration for creating Proxmox QEMU virtual machines.

## Configuration

### Required Variables
* **Proxmox API:**
    * `pm_api_url`: Proxmox API URL (e.g., `https://your-proxmox:8006/api2/json`)
    * `pm_api_token_id`: API Token ID (e.g., `terraform-user@pve!my-token`)
    * `pm_api_token`: API Token Secret
    * `pm_tls_insecure`: Allow insecure TLS connections

* **VM Settings:**
    * `num_vms`: Number of VMs to create
    * `start_vmid`: Starting VMID
    * `vm_name_prefix`: VM name prefix
    * `vm_node`: Target Proxmox node
    * `vm_template`: Template name/ID to clone
    * `vm_memory`: RAM in MB
    * `vm_cores`: CPU cores per socket
    * `vm_sockets`: Number of CPU sockets
    * `vm_ssh_keys`: Public SSH key(s) for Cloud-Init

* **Storage & Network:**
    * `vm_disk_storage`: Storage identifier (e.g., `"local-zfs"`)
    * `vm_network_model`: Network card model (e.g., `"virtio"`)
    * `vm_network_bridge`: Network bridge (e.g., `"vmbr0"`)
    * `vm_network_vlan_tag`: VLAN tag

## Usage

```bash
terraform init    # Initialize
terraform plan    # Review changes
terraform apply   # Create/update VMs
terraform destroy # Remove VMs
```