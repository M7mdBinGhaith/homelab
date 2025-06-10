variable "proxmox_api_url" {
  type = string
}

variable "storage_pool" {
  type = string
}

variable "proxmox_api_token_id" {
  type = string
}

variable "proxmox_api_token_secret" {
  type      = string
  sensitive = true
}

variable "proxmox_node" {
  type = string
  default = "pve"
}

# VM Configuration Variables
variable "vm_name" {
  type    = string
  default = "debian12-template"
}

variable "template_description" {
  type    = string
  default = "Debian 12 Template"
}

variable "vm_id" {
  type    = number
  default = 9400
}

variable "memory" {
  type    = number
  default = 2048
}

variable "cores" {
  type    = number
  default = 2
}

variable "sockets" {
  type    = number
  default = 1
}

variable "cpu_type" {
  type    = string
  default = "host"
}

variable "os" {
  type    = string
  default = "l26"
}

# SSH Configuration Variables
variable "ssh_username" {
  type    = string
  default = "debian"
}

variable "ssh_password" {
  type      = string
  sensitive = true
}

variable "ssh_timeout" {
  type    = string
  default = "30m"
}

variable "ssh_handshake_attempts" {
  type    = number
  default = 100
}

variable "ssh_wait_timeout" {
  type    = string
  default = "30m"
}

# Network Configuration Variables
variable "network_bridge" {
  type    = string
  default = "vmbr0"
}

variable "network_model" {
  type    = string
  default = "virtio"
}

variable "vlan_tag" {
  type    = string
  default = null 
}

# Disk Configuration Variables
variable "disk_size" {
  type    = string
  default = "20G"
}

variable "disk_format" {
  type    = string
  default = "raw"
}

# ISO Configuration Variables
variable "iso_file" {
  type = string
}

# Boot Configuration Variables
variable "boot_wait" {
  type    = string
  default = "10s"
}

variable "hostname" {
  type    = string
  default = "debian12"
}

variable "domain" {
  type    = string
  default = "local"
} 