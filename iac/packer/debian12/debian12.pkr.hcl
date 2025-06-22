packer {
  required_plugins {
    proxmox = {
      version = "1.2.3"
      source  = "github.com/badsectorlabs/proxmox"
    }
  }
}

variable "pm_api_url" {
  type    = string
  default = "https://10.30.30.98:8006/api2/json"
}

variable "proxmox_node" {
  type    = string
  default = "a2-01"
}

variable "storage_pool" {
  type    = string
  default = "local-lvm"
}

variable "proxmox_api_token_id" {
  type = string
}

variable "proxmox_api_token_secret" {
  type      = string
  sensitive = true
}

# VM Configuration
variable "vm_name" {
  type    = string
  default = "debian12-template"
}

variable "template_description" {
  type    = string
  default = "Debian 12 Template"
}

variable "vm_id" {
  type = number
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

# SSH Configuration
variable "ssh_username" {
  type    = string
  default = "debian"
}

variable "ssh_password" {
  type      = string
  sensitive = true
  default   = "debian"
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

# Network Configuration
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

# Disk Configuration
variable "disk_size" {
  type    = string
  default = "20G"
}

variable "disk_format" {
  type    = string
  default = "raw"
}

# ISO Configuration
variable "iso_file" {
  type    = string
  default = "local:iso/debian-12.11.0-amd64-netinst.iso"
}

# Boot Configuration
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

# Source configuration
source "proxmox-iso" "debian12" {
  proxmox_url              = var.pm_api_url
  username                 = var.proxmox_api_token_id
  token                    = var.proxmox_api_token_secret
  insecure_skip_tls_verify = true
  node                     = var.proxmox_node

  vm_name              = var.vm_name
  template_description = var.template_description
  vm_id                = var.vm_id
  memory               = var.memory
  cores                = var.cores
  sockets              = var.sockets
  cpu_type             = var.cpu_type
  os                   = var.os
  qemu_agent           = true

  # SSH configuration
  ssh_username           = var.ssh_username
  ssh_password           = var.ssh_password
  ssh_timeout            = var.ssh_timeout
  ssh_handshake_attempts = var.ssh_handshake_attempts
  ssh_wait_timeout       = var.ssh_wait_timeout

  network_adapters {
    bridge   = var.network_bridge
    model    = var.network_model
    vlan_tag = var.vlan_tag
  }

  disks {
    type         = "scsi"
    storage_pool = var.storage_pool
    disk_size    = var.disk_size
    format       = var.disk_format
  }

  # Cloud-Init Drive
  cloud_init              = true
  cloud_init_storage_pool = var.storage_pool

  # ISO configuration
  boot_iso {
    iso_file = var.iso_file
  }

  # Boot configuration
  boot_wait = var.boot_wait
  boot_command = [
    "<esc><wait>",
    "auto url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ",
    "hostname=${var.hostname} ",
    "domain=${var.domain} ",
    "interface=auto ",
    "vga=788 noprompt quiet ",
    "<enter>"
  ]

  # HTTP server for preseed file
  http_directory = "."
}

# Build configuration
build {
  name = "debian12"
  sources = ["source.proxmox-iso.debian12"]
}