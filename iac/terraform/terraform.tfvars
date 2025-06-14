# Proxmox API Configuration
pm_api_url      = "https://YOUR_PROXMOX_IP:8006/api2/json"
pm_tls_insecure = true  # Set to true if you are using a self-signed certificate

# VM Configuration
num_vms          = 3
start_vmid       = 9000
vm_name_prefix   = "tf-vm"
vm_node          = "your-proxmox-node-name"
vm_template      = 9400  # VMID of your template

# VM Resources
vm_memory        = 4096  # RAM in MB
vm_cores         = 2     # CPU cores per socket
vm_sockets       = 1     # Number of CPU sockets

# Storage Configuration  
vm_disk_storage  = "local-zfs"  # Your storage identifier
vm_disk_size_gb  = 20           # Disk size in GB

# Network Configuration
vm_network_bridge = "vmbr0"     # Your network bridge
vm_network_model = "virtio"     # Network card model
vm_network_vlan_tag = 20        # VLAN tag (set to null if no VLAN)

# SSH Access - Replace with your public SSH key
vm_ssh_keys = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"