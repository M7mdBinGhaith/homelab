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
  default = "rocky9-template-02"
}

variable "template_description" {
  type    = string
  default = "Rocky Linux 9 Template"
}

variable "vm_id" {
  type    = number
  default = 9402
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
  default = "rocky"
}

variable "ssh_password" {
  type      = string
  sensitive = true
  default   = "rocky"
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
  default = "local:iso/Rocky-9.6-x86_64-minimal.iso"
}

# Boot Configuration
variable "boot_wait" {
  type    = string
  default = "10s"
}

variable "hostname" {
  type    = string
  default = "rocky9"
}

variable "domain" {
  type    = string
  default = "local"
}

# Source configuration
source "proxmox-iso" "rocky9" {
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
  
  # Additional CPU configuration
  machine              = "q35"

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
  
  scsi_controller = "virtio-scsi-single"

  # Cloud-Init Drive
  cloud_init              = true
  cloud_init_storage_pool = var.storage_pool

  # ISO configuration
  boot_iso {
    iso_file = var.iso_file
  }

  # Boot configuration for Rocky Linux
  boot_wait = var.boot_wait
  boot_command = ["<tab> ip=dhcp text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/rocky9.ks<enter><wait>"]

  # HTTP server for kickstart file
  http_directory = "."
}

# Build configuration
build {
  name = "rocky9"
  sources = ["source.proxmox-iso.rocky9"]
  
  provisioner "shell" {
    inline = [
      "sudo yum install -y cloud-init cloud-utils-growpart",
      "sudo systemctl enable cloud-init",
      "sudo yum clean all"
    ]
  }
}