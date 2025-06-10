packer {
  required_plugins {
    proxmox = {
      version = ">= 1.1.3"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

source "proxmox-iso" "debian12" {
  proxmox_url              = var.proxmox_api_url
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

build {
  sources = ["source.proxmox-iso.debian12"]
} 