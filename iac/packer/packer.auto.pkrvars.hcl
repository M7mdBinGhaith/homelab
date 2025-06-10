# Example configuration file for Packer build

# Proxmox Configuration
proxmox_api_url = "https://your-proxmox-host:8006/api2/json"
proxmox_node = "your-proxmox-node"
storage_pool = "local-lvm"
proxmox_api_token_id = "your-token-id@pam!token-name"
proxmox_api_token_secret = "your-api-token-secret"

# VM Configuration
vm_name = "debian12-template"
template_description = "Debian 12 Template"
vm_id = 9400
memory = 2048
cores = 2
sockets = 1
cpu_type = "host"
os = "l26"

# SSH Configuration
ssh_username = "debian"
ssh_password = "your-ssh-password"
ssh_timeout = "30m"
ssh_handshake_attempts = 100
ssh_wait_timeout = "30m"

# Network Configuration
network_bridge = "vmbr0"
network_model = "virtio"
vlan_tag = null  # Set to null for no VLAN, or "100" for VLAN 100

# Disk Configuration
disk_size = "20G"
disk_format = "raw"  # or "qcow2"

# ISO Configuration
iso_file = "local:iso/debian-12.11.0-amd64-netinst.iso"

# Boot Configuration
boot_wait = "10s"
hostname = "debian12"
domain = "local"