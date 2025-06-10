variable "pm_api_url" {
  description = "Proxmox API URL (e.g., https://your-proxmox-ip:8006/api2/json)"
  type        = string
}

variable "pm_api_token_id" {
  description = "Proxmox API token ID (e.g., terraform-user@pve!terraform-token)"
  type        = string
}

variable "pm_api_token" {
  description = "Proxmox API token secret"
  type        = string
  sensitive   = true
}

variable "pm_tls_insecure" {
  description = "Skip TLS verification. Set to true for testing, false in production."
  type        = bool
  default     = false
}

variable "num_vms" {
  description = "Number of VMs to create."
  type        = number
  default     = 3
}

variable "start_vmid" {
  description = "The starting VMID for the first VM. Subsequent VMs will be +1, +2, etc."
  type        = number
}

variable "vm_name_prefix" {
  description = "Prefix for the VM name (the VMID will be appended)."
  type        = string
  default     = "tf-vm"
}

variable "vm_node" {
  description = "The Proxmox node to create the VM on."
  type        = string
}

variable "vm_template" {
  description = "The name or VMID of the Proxmox template or cloud-init image to clone from."
  type        = string
}

variable "vm_memory" {
  description = "Memory in MB for the VM."
  type        = number
  default     = 2048
}

variable "vm_cores" {
  description = "Number of CPU cores for the VM."
  type        = number
  default     = 1
}

variable "vm_sockets" {
  description = "Number of CPU sockets for the VM."
  type        = number
  default     = 1
}

variable "vm_disk_storage" {
  description = "The storage pool to place the VM disk on (e.g., local-lvm, ceph-pool)."
  type        = string
}

variable "vm_disk_size_gb" {
  description = "The size of the root disk in GB"
  type        = number
  default     = 20
}

variable "vm_network_bridge" {
  description = "The network bridge to attach the VM network interface to (e.g., vmbr0)."
  type        = string
}

variable "vm_network_model" {
  description = "The network card model (e.g., virtio, e1000)."
  type        = string
  default     = "virtio"
}

variable "vm_ssh_keys" {
  description = "Your public SSH key(s) for cloud-init (paste the content here)."
  type        = string
  default     = ""
  sensitive   = true
}

variable "vm_network_vlan_tag" {
  description = "VLAN tag for the VM's network interface (optional). Set to null or omit if no tag is needed."
  type        = number
  default     = 20 # Set to null if no VLAN tag is required
}