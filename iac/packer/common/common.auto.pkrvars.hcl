# Proxmox Configuration
pm_api_url = "https://your-proxmox:8006/api2/json"
proxmox_node = "a2-01"
storage_pool = "local-lvm"

# VM Configuration
memory = 2048
cores = 2
sockets = 1
cpu_type = "host"
os = "l26"

# SSH Configuration
ssh_timeout = "30m"
ssh_handshake_attempts = 100
ssh_wait_timeout = "30m"
# Network Configuration
network_bridge = "vmbr0"
network_model = "virtio"
vlan_tag = null

# Disk Configuration
disk_size = "20G"
disk_format = "raw"

# Boot Configuration
boot_wait = "10s"
domain = "local"