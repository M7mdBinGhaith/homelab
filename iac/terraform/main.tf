terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "~> 0.66"
    }
  }

backend "http" {
    address        = "https://gitlab.local.domain.com/api/v4/projects/3/terraform/state/proxmox-github-demo-state"
    lock_address   = "https://gitlab.local.domain.com/api/v4/projects/3/terraform/state/proxmox-github-demo-state/lock"
    unlock_address = "https://gitlab.local.domain.com/api/v4/projects/3/terraform/state/proxmox-github-demo-state/lock"
    lock_method    = "POST"
    unlock_method  = "DELETE"
    retry_wait_min = 5
  
}
}

provider "proxmox" {
  endpoint = var.pm_api_url
  api_token = "${var.pm_api_token_id}=${var.pm_api_token}"
  insecure = var.pm_tls_insecure
}

resource "proxmox_virtual_environment_vm" "vm" {
  count = var.num_vms

  vm_id     = var.start_vmid + count.index
  name      = "${var.vm_name_prefix}-${var.start_vmid + count.index}"
  node_name = var.vm_node

  clone {
    vm_id = var.vm_template
  }

  memory {
    dedicated = var.vm_memory
  }
  
  cpu {
    cores   = var.vm_cores
    sockets = var.vm_sockets
  }

  disk {
    datastore_id = var.vm_disk_storage
    interface    = "scsi0"
    size         = var.vm_disk_size_gb
  }

  network_device {
    bridge      = var.vm_network_bridge
    model       = var.vm_network_model
    vlan_id     = var.vm_network_vlan_tag
  }

  agent {
    enabled = true
  }

  initialization {
    datastore_id = "local-lvm"
    user_account {
      keys     = [trimspace(var.vm_ssh_keys)]
      username = "debian"
    }
  }

  stop_on_destroy = true
  timeout_stop_vm = 60
}

output "vm_info" {
  description = "Details of the created VM(s)"
  value = {
    for i in range(var.num_vms) :
    "${var.vm_name_prefix}-${var.start_vmid + i}" => {
      vm_id = proxmox_virtual_environment_vm.vm[i].vm_id
      name  = proxmox_virtual_environment_vm.vm[i].name
      node  = proxmox_virtual_environment_vm.vm[i].node_name
    }
  }
}