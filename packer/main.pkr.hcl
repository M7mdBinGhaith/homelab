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

  vm_name                  = "debian12-template"
  template_description     = "Debian 12 Template"
  vm_id                    = 9400
  memory                   = 2048
  cores                    = 2
  sockets                  = 1
  cpu_type                = "host"
  os                      = "l26"
  qemu_agent              = true

  # SSH configuration
  ssh_username            = "debian"
  ssh_password            = "debian"
  ssh_timeout             = "30m"
  ssh_handshake_attempts  = 100
  ssh_wait_timeout        = "30m"

  network_adapters {
    bridge = "vmbr0"
    model  = "virtio"
  }

  disks {
    type         = "scsi"
    storage_pool = "local-zfs"
    disk_size    = "20G"
    format       = "raw"
  }

  # Cloud-Init Drive
  cloud_init           = true
  cloud_init_storage_pool = "local-zfs"

  # ISO configuration
  boot_iso {
    iso_file = "local:iso/debian-12.10.0-amd64-netinst.iso"
  }

  # Boot configuration
  boot_wait = "10s"
  boot_command = [
    "<esc><wait>",
    "auto url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ",
    "hostname=debian12 ",
    "domain=local ",
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