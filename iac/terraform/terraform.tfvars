pm_api_url      = "https://your_proxmox:8006/api2/json"
pm_api_token_id = "your_api_token_id"
pm_api_token    = "your_api_token"
pm_tls_insecure = true

num_vms          = 3
start_vmid       = 9000
vm_name_prefix   = "tf-vm"
vm_node          = "pve"
vm_template      = 9400

vm_memory        = 4096
vm_cores         = 2
vm_sockets       = 1

vm_disk_storage  = "local-zfs"
vm_disk_size     = "20G"

vm_network_bridge = "vmbr0"
vm_network_model = "virtio"
vm_network_vlan_tag = 20

vm_ssh_keys = "ssh-ed25519 your_ssh_key"