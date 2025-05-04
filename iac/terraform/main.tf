terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.1-rc8"
    }
  }
}

provider "proxmox" {
  pm_api_url         = var.pm_api_url
  pm_api_token_id    = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token
  pm_tls_insecure    = var.pm_tls_insecure
}

resource "proxmox_vm_qemu" "vm" {
  count = var.num_vms

  vmid = var.start_vmid + count.index
  name = "${var.vm_name_prefix}-${var.start_vmid + count.index}"
  target_node = var.vm_node

  clone = "debian12-template"

  memory = var.vm_memory
  cores  = var.vm_cores
  sockets = var.vm_sockets

  disk {
    type = "disk"
    storage = var.vm_disk_storage
    size = var.vm_disk_size
    slot = "scsi0"
  }

  network {
    model = var.vm_network_model
    bridge = var.vm_network_bridge
    tag = var.vm_network_vlan_tag
    id = 0
  }

  # BIOS and boot configuration
  bios = "seabios"
  boot = "order=scsi0;net0"
  bootdisk = "scsi0"
  scsihw = "virtio-scsi-pci"
  
  agent = 1
  sshkeys = var.vm_ssh_keys
}

output "vm_info" {
  description = "Details of the created VM(s)"
  value = {
    for i in range(var.num_vms) :
    "${var.vm_name_prefix}-${var.start_vmid + i}" => {
      vmid = proxmox_vm_qemu.vm[i].vmid
    }
  }
}